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

rm -rf "$LOCALDIR/temp"
mkdir -p "$tmpdir"

# Delete erfan's output dir
rm -rf "$LOCALDIR"/erfangsi/output
 
echo "Making ErfanGSI..."
# Only make AB GSI
sudo sed -i '7c AB=true' "$LOCALDIR"/erfangsi/url2GSI.sh
sudo sed -i '8c Aonly=false' "$LOCALDIR"/erfangsi/url2GSI.sh
bash "$LOCALDIR"/erfangsi/url2GSI.sh "$romzip" Generic
echo ""
echo ""
echo "ErfanGSI making finished."
echo "Copy ErfanGSI's GSI."
erfan_product="$(ls "./erfangsi/output/" | grep -i "ErfanGSI" | grep "img" | grep "AB")"
echo "$erfan_product"
cp -fpr "$LOCALDIR"/erfangsi/output/"$erfan_product" "$tmpdir"
# ls "$tmpdir"
mv "$tmpdir"/$erfan_product "$tmpdir"/system.img
# ls "$tmpdir"
systemdir="$tmpdir/system/system"
vendordir="$tmpdir/vendor/vendor"

echo "Unpacking the rom..."
sudo bash "$LOCALDIR"/unpack.sh "$romzip"
echo "Unpacking finished."
echo ""
echo ""

# Detect Source API 
if grep -q ro.build.version.release_or_codename "$systemdir/system"/build.prop; then
    sourcever=`grep ro.build.version.release_or_codename "$systemdir/system"/build.prop | cut -d "=" -f 2`
else
    sourcever=`grep ro.build.version.release "$systemdir/system"/build.prop | cut -d "=" -f 2`
fi
if [ $(echo $sourcever | cut -d "." -f 2) == 0 ]; then
    sourcever=$(echo $sourcever | cut -d "." -f 1)
fi

echo "This rom is Android $sourcever"
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
day=$(date "+%Y%m%d")
packdir="$outdir/$romname-JvlongGSI-AB-SAR-$day"
mkdir -p "$packdir"
cp -fpr "$LOCALDIR/prebuilt/Patch1" "$packdir"
bash "$LOCALDIR"/genpatches.sh "$romname" "$vendordir" "$packdir/Patch1"

# Packing
echo "Packing Started..."
bash "$LOCALDIR"/pack.sh "$romname"
