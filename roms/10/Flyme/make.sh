#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# build.prop
echo "ro.bootprof.disable=1" >> $1/build.prop

# Remove com.wolfsonmicro.ez2control:ez2control_service for a moment
# It is crashing from systemserver booted which has triggered RescueParty
# It hurts performance very much and make device very hot
# cpufreq is running at a high freq
rm -rf $1/app/com.wolfsonmicro.ez2control

