#/bin/bash

systempath=$1
romdir=$2
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# Drop ph and phh dir
rm -rf "$1/ph"
rm -rf "$1/phh"
