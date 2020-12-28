#!/bin/bash
apt update # Fetches the list of available updates
apt install build-essential linux-headers-$(uname -r) dkms
echo Please select "Device->Insert Guest Addition ISO", and click "Run"
read -rsp 'Press ENTER to continue ...'
lsmod | grep guest
echo ''
usermod -G vboxsf -a $USER
read -rsp 'Installation of Guest Addition is completed; Press ENTER to shutdown ...'
echo ''
shutdown -P now

