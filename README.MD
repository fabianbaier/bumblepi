#Bumble PI Autoinstallation

This tool autoinstalls the current Ubuntu 14.04 (trusty) on a usb drive

#How to install?
Download the image from https://wiki.ubuntu.com/ARM/RaspberryPi

Add to the /etc/rc.local the following for Ubuntu:
cd /home/ubuntu
sudo apt-get -y install git
sudo rm -R -f bumblepi
#export GIT_SSL_NO_VERIFY=1
sudo update-ca-certificates
sudo git clone https://github.com/fabianbaier/bumblepi.git
cd bumblepi
sudo chmod 755 bumblepi.sh
sudo ./bumblepi.sh

Don't forget to change #!/bin/sh -e to #!/bin/sh

#How to create MicroSD
diskutil unmountDisk /dev/disk2

sudo dd if=2015-05-05-raspbian-wheezy.img of=/dev/rdisk2 bs=32m

##Clone from SD Card
sudo dd if=/dev/rdisk2 of=2015-05-05-raspbian-wheezy-bumblepi-image.img bs=32m

##Copy to SD Card
sudo dd if=sd-image.img of=/dev/rdisk2 bs=32m


#Done