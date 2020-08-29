#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

#by:@PdyLZY

rm -rf $1/recovery-from-boot.p
rm -rf $1/app/Camera
rm -rf $1/app/MzUpdate
rm -rf $1/product/priv-app/FlymeSnapdragonSVA
rm -rf $1/priv-app/wt_logcat
rm -rf $1/MzApp/GameCenter
rm -rf $1/MzApp/Life
rm -rf $1/MzApp/MzStore
rm -rf $1/MzApp/Reader
rm -rf $1/MzApp/VideoClips
