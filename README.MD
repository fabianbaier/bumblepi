#Bumble PI Autoinstallation

This tool autoinstalls the current raspbian on a usb drive

#How to install?

Add to the /etc/rc.local the following:
cd /home/pi
git clone https://github.com/fabianbaier/bumblepi.git
cd bumblepi
chmod 755 bumblepi.sh
./bumblepi.sh

#How to create MicroSD
diskutil unmountDisk /dev/disk2

sudo dd if=2015-05-05-raspbian-wheezy.img of=/dev/rdisk2 bs=32m

##Clone from SD Card
sudo dd if=/dev/rdisk2 of=sd-image.img bs=32m

##Copy to SD Card
sudo dd if=sd-image.img of=/dev/rdisk2 bs=32m


#Done