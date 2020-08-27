#!/bin/bash
 
LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
systemdir="$LOCALDIR/temp/erfangsi/system"
dirsize="$(du -sm "$systemdir" | awk '{print $1}')"
ssize=$(($dirsize+130))
size=$(($ssize*1024*1024))
output="$LOCALDIR/output"
# mkdir -p "$outdir"
romname="$1"
HOST="$(uname)"
bindir="$LOCALDIR/erfangsi/tools/$HOST/bin"
cd "$LOCALDIR"
day=$(date "+%Y%m%d")
outdir="$output/$romname-JvlongGSI-AB-SAR-$day"

packimg="$romname"-JvlongGSI-AB-SAR-$day.img
bash "./tools"/mkuserimg_mke2fs.sh "$systemdir" "$outdir"/$packimg ext4 "/erfangsi" $size -j "0" -T "1230768000" -C "$systemdir/../config"/erfangsi_fs_config -L "system" -o "4096" "$systemdir/../config"/erfangsi_file_contexts
echo "GSI Packing Finished."
echo "Path: $outdir"
 
