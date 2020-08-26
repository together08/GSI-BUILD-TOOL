#/bin/bash

# Workaround for SetupWizard Problem
# Remove ZUI's SetupWizard.
# Then disable SetupWizard with prop.
# ZUI's SetupWizard out of screen on 16:9 devices.
# These devices cannot finish setupwizard and gets stuck.
rm -rf $1/priv-app/ZuiSetupWizard

# remove phh qtiaudio
rm -rf $1/priv-app/QtiAudio
rm -rf $1/app/NQNfcNci

# fix notch
# sed -i "s/M -50,0 L -50,90 L 50,90 L 50,0 Z/000000000000000000000000000000000/" $1/framework/framework-res.apk