
#/bin/bash

LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
romname="$1"
vendorpath="$2"
patchpath="$3"
oemname="meizu"
updaterscript="$patchpath/META-INF/com/google/android/updater-script"

day=$(date "+%Y%m%d")

cd "$patchpath"
cd vendor

cd bin
cp -fpr "$vendorpath/bin/*$oemname*" .
cd hw
cp -fpr "$vendorpath/bin/hw/*$oemname*" .
cd ../..

cd etc
cp -fpr "$vendorpath/etc/*$oemname*" .
cd permissions
cp -fpr "$vendorpath/etc/permissions/*$oemname*" .
cd ../..

cd lib
cp -fpr "$vendorpath/lib/*$oemname*" .
cd ..

cd lib64
cp -fpr "$vendorpath/lib64/*$oemname*" .
cd ...
