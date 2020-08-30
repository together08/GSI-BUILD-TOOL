
#/bin/bash

LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
romname="$1"
vendorpath="$2"
patchpath="$3"
updaterscript="$patchpath/META-INF/com/google/android/updater-script"

day=$(date "+%Y%m%d")

echo "Copying vendor patch files..."
cd "$patchpath"

# Nothing to do here
