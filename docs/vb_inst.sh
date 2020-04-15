#!/usr/bin/sh
sudo apt update # Fetches the list of available updates
sudo apt install build-essential linux-headers-$(uname -r) dkms
echo Please select "Device->Insert Guest Addition ISO", and click "Run"
read -rsp 'Press <ENTER> to continue ...\n'
lsmod | grep guest
sudo usermod -G vboxsf -a $USER
read -rsp 'Installation of Guest Addition is complete; Press <enter> to shutdown ...\n'
sudo shutdown -P now

