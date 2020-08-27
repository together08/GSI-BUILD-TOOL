#/bin/bash

# Workaround for SetupWizard Problem
# Remove ZUI's SetupWizard.
# Then disable SetupWizard with prop.
# ZUI's SetupWizard out of screen on 16:9 devices.
# These devices cannot finish setupwizard and gets stuck.
rm -rf $1/priv-app/ZuiSetupWizard
