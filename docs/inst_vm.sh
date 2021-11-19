#!/bin/bash
apt update # Fetches the list of available updates
apt install build-essential linux-headers-$(uname -r) dkms
echo Please select "Device->Insert Guest Addition ISO", and click "Run"
read -rsp 'Press ENTER to continue ...'
echo ''
lsmod | grep guest

if [[ -z "${SUDO_USER}" ]]; then
  USER_REAL=${USER}
else
  USER_REAL=${SUDO_USER}
fi
echo Adding $USER_REAL to group vboxsf ...
usermod -G vboxsf -a $USER_REAL
read -rsp 'Installation of Guest Addition is completed; Press ENTER to shutdown ...'
echo ''
shutdown -P now

