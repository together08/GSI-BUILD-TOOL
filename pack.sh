#!/bin/bash
 
LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
systemdir="$LOCALDIR/temp/system/system"
dirsize="$(du -sm "$systemdir" | awk '{print $1}' | sed 's/$/& (MB)/')"
size=$(($dirsize+130))
outdir="$LOCALDIR/output"
romname="$1"
HOST="$(uname)"
bindir="$LOCALDIR/tools/$HOST/bin"
cd "$LOCALDIR"
day=$(date "+%Y%m%d")

packimg="$romname"-JvlongGSI-AB&SAR-$day.img
"$bindir"/mke2fs -t ext4 -b 4096 "$outdir"/$packimg $size
"$bindir"/e2fsdroid -e -T 0 -S "$systemdir"/../config/system_file_contexts -C "$systemdir"/../config/system_fs_config  -a /system -f "$systemdir" "$outdir"/$packimg
echo "GSI Packing Finished."
echo "Path: $outdir/$packimg"
 