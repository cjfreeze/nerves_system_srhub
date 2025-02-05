#!/bin/sh

set -e

# Create the revert script for manually switching back to the previously active
# firmware.
mkdir -p $TARGET_DIR/usr/share/fwup
$HOST_DIR/usr/bin/fwup -c -f $NERVES_DEFCONFIG_DIR/fwup-revert.conf -o $TARGET_DIR/usr/share/fwup/revert.fw

# Since U-Boot's squashfs support is so slow (sadly), store the Linux
# kernel in the FAT filesystem instead of /boot. Everything else can
# go in /boot since it's so small. See the fwup.conf for how the zImage
# is put in the FAT filesystem. Remove zImage from /boot since we can't
# tell Buildroot to just put the .dtb files there.
rm -f $TARGET_DIR/boot/zImage
