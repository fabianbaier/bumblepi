#Bumble PI Autoinstallation

This tool autoinstalls the current raspbian on a usb drive

#How to install?

Add to the /etc/rc.local the following:
cd /home/pi
git clone https://github.com/fabianbaier/bumblepi.git
cd bumblepi
chmod 755 bumblepi.sh
./bumblepi.sh

#Done