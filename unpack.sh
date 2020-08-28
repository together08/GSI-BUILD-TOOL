#/bin/bash
 
# Made by together08, <together08@yeah.net>
 
 
usage() {
    echo "Usage: $0 <Path to firmware>"
    echo -e "\tPath to firmware: the zip!"
}
 
if [ "$1" == "" ]; then
    echo "ERROR: Enter all needed parameters"
    usage
    exit 1
fi
 
LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
HOST="$(uname)"
romzip="$(realpath $1)"
outdir="$LOCALDIR/temp"
toolsdir="$LOCALDIR/tools"
imgextractor="$toolsdir/imgextractor/imgextractor.py"
sudo rm -rf "$LOCALDIR/output"
# sudo rm -rf "$LOCALDIR/temp"
mkdir -p "$outdir/system"
mkdir -p "$outdir/vendor"
 
# Unpack the romzip with zip2img.sh
bash "$LOCALDIR"/zip2img.sh "$romzip" "$outdir" vendor
 
# Extract the system/vendor.img with imgextractor
python3 $imgextractor "$outdir"/vendor.img "$outdir/vendor"
python3 $imgextractor "$outdir"/system.img "$outdir/system"

# Delete system/vendor.img
rm "$outdir"/vendor.img
rm "$outdir"/system.img
rm "$outdir"/system.raw.img

