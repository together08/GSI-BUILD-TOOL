#/bin/bash

systempath=$1
romdir=$2
thispath=`cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd`

# Drop ph and phh dir
rm -rf "$1/ph"
rm -rf "$1/phh"

# Drop device spectific overlays
if [ -f $romdir/NODEVICEOVERLAY ]; then
    echo "Using device specific overlays is not supported in this rom. Deleteing..."
    rm -rf "$1/product/overlay"/treble-overlay*
    cp -fpr "$thispath/nondevice_overlay"/* "$1/product/overlay/"
fi
