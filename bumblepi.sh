#!/bin/bash
# Autoinstall with Bumble Pi

 function check_usb {
 	USB_DEVICE=`lsblk -r | grep sd | head -1 | awk '{print $1;}'`
 	if lsblk -r | grep sd | head -1 | awk '{print $1;}'; 
	then
	echo "`date -u` USB device found: $USB_DEVICE" >> bumblepi.log
	make_usb

	else
	echo "`date -u` USB sd not existing" >> bumblepi.log
	echo "`date -u` Bumble PI goes back to sleep" >> bumblepi.log
	fi
    }

 function make_usb {
	parted --script "/dev/${USB_DEVICE}"  "mklabel msdos"
	parted --script "/dev/${USB_DEVICE}"  "mkpart primary ext4 1MiB -1s"
	parted --script "/dev/${USB_DEVICE}"  print
	mke2fs -t ext4 -L rootfs /dev/${USB_DEVICE}1
	mount /dev/${USB_DEVICE}1 /mnt
	rsync -axv / /mnt
	cp /boot/cmdline.txt /boot/cmdline.orig
	cd /boot
	wget https://raw.githubusercontent.com/fabianbaier/bumblepi/master/cmdline.txt
	cd /mnt/etc
	rm fstab
	wget https://raw.githubusercontent.com/fabianbaier/bumblepi/master/fstab
 }

echo "`date -u` Bumble Pi started with IP `hostname -I`" >> bumblepi.log

if grep root=/dev/sda1 /boot/cmdline.txt; 
then
echo "`date -u` USB boot in cmdline.txt activated" >> bumblepi.log
echo "`date -u` Bumble PI goes back to sleep" >> bumblepi.log
else
echo "`date -u` USB boot not activated" >> bumblepi.log
check_usb
fi

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