
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

echo 'set_metadata("/vendor/bin/hw/vendor.meizu.hardware.fido@1.0-service", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:hal_fido_default_exec:s0");' >> $updaterscript
echo 'set_metadata("/vendor/bin/hw/vendor.meizu.hardware.ifaa@1.0-service", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:hal_ifaa_default_exec:s0");' >> $updaterscript
echo 'set_metadata("/vendor/bin/hw/vendor.meizu.sensor_aux@1.0-default-service", "uid", 0, "gid", 2000, "mode", 0755, "capabilities", 0x0, "selabel", "u:object_r:hal_meizu_sensor_aux_default_exec:s0");' >> $updaterscript
