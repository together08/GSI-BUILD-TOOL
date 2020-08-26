#!/bin/bash

systempath=$1
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

#by:@PdyLZY

rm -rf $1/recovery-from-boot.p
rm -rf $1/priv-app/ZuiXlog
rm -rf $1/priv-app/ZuiCamera
rm -rf $1/preinstall/alipay
rm -rf $1/preinstall/aqiyireader
rm -rf $1/preinstall/baidumap
rm -rf $1/preinstall/douyin
rm -rf $1/preinstall/KuwoPlayer
rm -rf $1/preinstall/lenovoapp
rm -rf $1/preinstall/meituan
rm -rf $1/preinstall/NewsArticle
rm -rf $1/preinstall/pinduoduo
rm -rf $1/preinstall/qqreader_tencentkey
rm -rf $1/preinstall/TencentNew
rm -rf $1/preinstall/TencentVideo
rm -rf $1/preinstall/UCbrowser
rm -rf $1/preinstall/vip
rm -rf $1/preinstall/Weibo
