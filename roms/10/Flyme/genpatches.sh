
#/bin/bash

LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
romname="$1"
vendorpath="$2"
patchpath="$3"
updaterscript="$patchpath/META-INF/com/google/android/updater-script"

day=$(date "+%Y%m%d")

cd "$patchpath"
cd vendor

cd app
cp -fpr "$vendorpath/app"/com.qualcomm.qti.gpudrivers.*.api29 .
cd ..

cd bin
cp -fpr "$vendorpath/bin"/diag_ipclog .
cd hw
cp -fpr "$vendorpath/bin/hw"/vendor.meizu.hardware.* .
cd ../..

cd etc
cp -fpr "$vendorpath/etc"/mixer_paths_meizu.xml "$vendorpath/etc"/qdcm_calib_data_meizu_amoled_cmd_mode_dsi_panel.xml .
