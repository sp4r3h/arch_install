#!/bin/bash
mkdir -p ~/android/system
cd ~/android/system
repo init -u git://github.com/CyanogenMod/android.git -b cm-10.2
repo sync -j 32
cd ~/android/system/vendor/cm
./get-prebuilts
source build/envsetup.sh
breakfast m7 #or grouper
##connect m7 to computer (check adb devices)
cd ~/android/system/device/htc/m7
./extract-files.sh
#speed up builds after the first one
export USE_CCACHE=1
#croot goes to build directory as of breakfast being ran
croot
brunch m7
#try lunch if brunch didn't work.
#try breakfast and choose from the menu if lunch doesn't work. them make m7.
cd $OUT

#to rebuild without resync
make clean
#then rebuild

#to rebuild after a sync
make clobber
#then rebuild.
