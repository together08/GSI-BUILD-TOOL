#!/bin/bash

systemdir="$1"
systemupdir="$systemdir/.."

# Add missing libs
cp -frpn ./lib/* $systemdir/lib
cp -frpn ./lib64/* $systemdir/lib64

# Enable adb debuggable
sed -i 's/persist.sys.usb.config=none/persist.sys.usb.config=adb/g' $systemupdir/prop.default
sed -i 's/ro.debuggable=0/ro.debuggable=1/g' $systemupdir/prop.default
sed -i 's/ro.adb.secure=1/ro.adb.secure=0/g' $systemupdir/prop.default
echo "ro.force.debuggable=1" >> $systemupdir/prop.default

# Add logcat service rc & sh
cp -frp ./logcat/bin/* $systemdir/bin/
cp -frp ./logcat/etc/* $systemdir/etc/
