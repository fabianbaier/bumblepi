#!/bin/bash
# Autoinstall with Bumble Pi

echo "Bumble Pi was here" >> bumblepi.log

#SDCARD_DEVICE="/dev/mmcblk0"
#USB_DEVICE="/dev/sda"
#NEW_SLASHDEV="/dev/mmcblk0p2"
#NEW_BOOTDEV="/dev/mmcblk0p1"
#MOUNTPOINT="/tmp/USB"

#parted --script "${USB_DEVICE}"  "mklabel msdos"
#parted --script "${USB_DEVICE}"  "mkpart primary ext4 1MiB -1s"
#parted --script "${USB_DEVICE}"  print
#mkfs.ext4 -F -j "${USB_DEVICE}2" 
#mkdir -p "${MOUNTPOINT}"
#mount "${USB_DEVICE}1" "${MOUNTPOINT}"
#mkdir -p "${MOUNTPOINT}/boot"
#mount "${SDCARD_DEVICE}1" "${MOUNTPOINT}/boot"
#df -h "${MOUNTPOINT}"
#df -h "${MOUNTPOINT}/boot"
#read -p "Press ENTER To begin image restore"
#tar $@ -xvzf  "${PI_BACKUP_SLASH}" -C "${MOUNTPOINT}"