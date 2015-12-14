#Bumble PI Autoinstallation

This tool autoinstalls the current raspbian on a usb drive

#How to install?

Add to the /etc/rc.local the following:
cd /home/ubuntu
sudo apt-get update
sudo apt-get -y install openssh-server
sudo apt-get -y install git
git clone https://github.com/fabianbaier/bumblepi.git
cd bumblepi
sudo git pull
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