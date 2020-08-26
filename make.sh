#/bin/bash
 
usage() {
    echo "Usage: sudo $0 <Path to firmware> <ROM NAME>"
    echo -e "\tPath to firmware: the zip!"
    echo -e "\tROM NAME: the rom's name!"
}
 
if [ "$1" == "" ]; then
    echo "ERROR: Enter all needed parameters"
    usage
    exit 1
fi
 
mkdir -p output
LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
HOST="$(uname)"
romzip="$(realpath $1)"
romname="$2"
tmpdir="$LOCALDIR/temp"
outdir="$LOCALDIR/output"
toolsdir="$LOCALDIR/tools"
romdir="$LOCALDIR/roms"
precommondir="$LOCALDIR/prebuilt/common"
day=$(date "+%Y%m%d")

mkdir -p "$tmpdir"

# Delete erfan's output dir
rm -rf ./erfangsi/output
 
echo "Making ErfanGSI..."
bash ./erfangsi/url2GSI.sh "$rompath" Generic -ab
echo ""
echo ""
echo "ErfanGSI making finished."
echo "Copy ErfanGSI's GSI."
erfan_product="$(ls "./erfan-tools/output/" | grep -i "ErfanGSI" | grep "img" | grep "AB")"
cp ./erfan-tools/output/$erfan_product "$tmpdir"
cd "$tmpdir"
mv $erfan_product erfangsi.img
cd "$LOCALDIR"
systemdir="$tmpdir/erfangsi/system"

echo "Unpacking the rom..."
sudo bash "$LOCALDIR"/unpack.sh "$romzip"
echo "Unpacking finished."
echo ""
echo ""

# Detect Source API 
if grep -q ro.build.version.release_or_codename $systemdir/build.prop; then
    sourcever=`grep ro.build.version.release_or_codename $systemdir/build.prop | cut -d "=" -f 2`
else
    sourcever=`grep ro.build.version.release $systemdir/build.prop | cut -d "=" -f 2`
fi
if [ $(echo $sourcever | cut -d "." -f 2) == 0 ]; then
    sourcever=$(echo $sourcever | cut -d "." -f 1)
fi

romworkingdir="$romdir/$sourcever/$romname"

# Detect Source ROM Support
if [ ! -d "$romworkingdir" ]; then
    echo "This type of source is not supported."
    exit 1
fi

# Debloat
echo "Debloating Started..."
bash "$romworkingdir"/debloat.sh "$systemdir/system"

# Start Patching
echo "Patching Started..."
bash "$precommondir"/cleanup_erfanthings.sh "$systemdir/system"
bash "$romworkingdir"/make.sh "$systemdir/system"

# Packing
echo "Packing Started..."
bash "$LOCALDIR"/pack.sh 
