#!/bin/bash
# Autoinstall with Bumble Pi

 function check_usb {
 	USB_DEVICE=`lsblk -r | grep sd | head -1 | awk '{print $1;}'`
 	if lsblk -r | grep sd | head -1 | awk '{print $1;}'; 
	then
	echo "`date -u` USB device found: $USB_DEVICE" >> /var/log/bumblepi.log
	make_usb

	else
	echo "`date -u` USB sd not existing" >> /var/log/bumblepi.log
	echo "`date -u` Bumble PI goes back to sleep" >> /var/log/bumblepi.log
	fi
    }

 function make_usb {
	parted --script "/dev/${USB_DEVICE}"  "mklabel msdos"
	parted --script "/dev/${USB_DEVICE}"  "mkpart primary ext4 1MiB -1s"
	parted --script "/dev/${USB_DEVICE}"  print
	mke2fs -t ext4 -L rootfs /dev/${USB_DEVICE}1
	mount /dev/${USB_DEVICE}1 /mnt
	rsync -axv / /mnt
	# cp /boot/cmdline.txt /boot/cmdline.orig
	#cd /boot
	cd /boot/firmware
	cp cmdline.txt cmdline.orig
	rm -f cmdline.txt
	#wget https://raw.githubusercontent.com/fabianbaier/bumblepi/master/cmdline.txt
	wget https://raw.githubusercontent.com/fabianbaier/bumblepi/master/cmdline-ubuntu.txt
	mv cmdline-ubuntu.txt cmdline.txt
	cd /mnt/etc
	cp fstab fstab.orig
	rm -f fstab
	wget https://raw.githubusercontent.com/fabianbaier/bumblepi/master/fstab-ubuntu
	mv fstab-ubuntu fstab
	sudo fallocate -l 1G /swapfile
	sudo chmod 600 /swapfile
	sudo mkswap /swapfile
	echo "`date -u` Bumble Pi installed 1G swapfile" >> /var/log/bumblepi.log
	sudo reboot
	#cd /home/pi/bumblepi
	cd /home/ubuntu/bumblepi
	echo "`date -u` Error: reboot not possible" >> /var/log/bumblepi.log
 }

echo "`date -u` Bumble Pi started with IP `hostname -I`" >> /var/log/bumblepi.log

#if grep root=/dev/sda1 /boot/cmdline.txt; 
if grep root=/dev/sda1 /boot/firmware/cmdline.txt;
then
echo "`date -u` USB boot in cmdline.txt activated" >> /var/log/bumblepi.log
echo "`date -u` Bumble PI goes back to sleep" >> /var/log/bumblepi.log
else
echo "`date -u` USB boot not activated" >> /var/log/bumblepi.log
check_usb
fi

#tar $@ -xvzf  "${PI_BACKUP_SLASH}" -C "${MOUNTPOINT}"