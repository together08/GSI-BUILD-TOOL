
#/bin/bash

LOCALDIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
romname="$1"
vendorpath="$2"
patchpath="$3"
updaterscript="$patchpath/META-INF/com/google/android/updater-script"

day=$(date "+%Y%m%d")

echo "Copying vendor patch files..."
cd "$patchpath"
mkdir vendor
cd vendor

mkdir -p app
mkdir -p bin
mkdir -p bin/hw
mkdir -p etc
mkdir -p lib
mkdir -p lib64
mkdir -p overlay

cd app
cp -fpr "$vendorpath/app/CneApp" "$vendorpath/app/IWlanService" "$vendorpath/app/QDMA" "$vendorpath/app/QDMA-UI" "$vendorpath/app/QwesAndroidService" "$vendorpath/app/TimeService" "$vendorpath/app/TrustZoneAccessService" .
cd ..

cd bin/hw
cp -fpr "$vendorpath/bin/hw/hostapd" "$vendorpath/bin/hw"/wpa_supplicant .
cd ../..

cd etc
cp -fpr "$vendorpath/etc/hostapd" "$vendorpath/etc/init" "$vendorpath/etc/permissions" "$vendorpath/etc"/bluetooth_qti_audio_policy_configuration.xml "$vendorpath/etc"/bluetooth_qti_hearing_aid_audio_policy_configuration.xml "$vendorpath/etc"/media_profiles.xml "$vendorpath/etc"/media_profiles_V1_0.xml "$vendorpath/etc"/media_profiles_vendor.xml .
cd ..

cd lib
cp -fpr "$vendorpath/lib/soundfx" "$vendorpath"/lib/libcert_parse.wpa_s.so "$vendorpath"/lib/liblowi_wifihal.so "$vendorpath"/lib/vendor.qti.hardware.wifidisplaysession@1.0.so "$vendorpath"/lib/vendor.qti.hardware.wifidisplaysessionl@1.0-halimpl.so .
cd ..

cd lib64
cp -fpr "$vendorpath/lib64/soundfx" "$vendorpath/lib64"/libcert_parse.wpa_s.so "$vendorpath/lib64"/libkeystore-engine-wifi-hidl.so "$vendorpath/lib64"/libkeystore-wifi-hidl.so "$vendorpath/lib64"/liblowi_wifihal.so .
cd ..

cd overlay
cp -fpr "$vendorpath/overlay"/CarrierConfigResCommon.apk "$vendorpath/overlay"/CellBroadcastReceiverResCommon.apk "$vendorpath/overlay"/FrameworksResCommon.apk "$vendorpath/overlay"/FrameworksResTarget.apk "$vendorpath/overlay"/SystemUIResCommon.apk "$vendorpath/overlay"/TelecommResCommon.apk "$vendorpath/overlay"/TelephonyResCommon.apk .

cd "$LOCALDIR"


echo "Generating updater-script..."

echo "ui_print("$romname Vendor Patch");" >> $updaterscript
echo "ui_print("Made with GSI-BUILD-TOOL");" >> $updaterscript
echo "ui_print("Generated on $day");" >> $updaterscript
echo 'delete_recursive(“/vendor/overlay”);' >> $updaterscript
echo 'ui_print("Some recoveries does not supprted auto-mounted, if mount failed, please mount manully and flash this patch again.");' >> $updaterscript
echo 'run_program("/sbin/busybox", "mount", "/vendor");' >> $updaterscript
echo 'package_extract_dir("vendor", "/vendor");' >> $updaterscript
echo 'set_metadata_recursive("/vendor/etc", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:vendor_configs_file:s0");' >> $updaterscript
echo 'set_metadata_recursive("/vendor/overlay", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:vendor_overlay_file:s0");' >> $updaterscript
echo 'set_metadata_recursive("/vendor/lib", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:same_process_hal_file:s0");' >> $updaterscript
echo 'set_metadata_recursive("/vendor/lib64", "uid", 0, "gid", 0, "dmode", 0755, "fmode", 0644, "capabilities", 0x0, "selabel", "u:object_r:same_process_hal_file:s0");' >> $updaterscript
echo 'ui_print("Installation complete!");' >> $updaterscript
echo ''
