#!/bin/bash

set -e

sudo apt update
sudo apt install cscope ctags cmake tmux dos2unix fonts-powerline git curl vim vim-gtk libcanberra-gtk-module libcanberra-gtk3-module gdebi-core terminator socat openssh-server xclip xsel software-properties-common reptyr

(
cd ~/Downloads
sudo curl -LO  https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb

wget https://www.scootersoftware.com/bcompare-4.4.0.25886_amd64.deb
sudo dpkg -i bcompare-4.4.0.25886_amd64.deb

git config --global diff.tool bc3
git config --global difftool.bc3.trustExitCode true 
git config --global merge.tool bc3
git config --global mergetool.bc3.trustExitCode true

# wget https://www.segger.com/downloads/jlink/JLink_Linux_V756_x86_64.deb
# gdebi JLink_Linux_V756_x86_64.deb
# 
# wget https://d1uj6qtbmh3dt5.cloudfront.net/2021.2/Servers/nice-dcv-2021.2-11135-ubuntu1804-x86_64.tgz
# tar -xvzf nice-dcv-2021.2-11135-ubuntu1804-x86_64.tgz && cd nice-dcv-2021.2-11135-ubuntu1804-x86_64
# apt install ./nice-dcv-server_2021.2.11135-1_amd64.ubuntu1804.deb
# usermod -aG video dcv
# apt install ./nice-xdcv_2021.2.408-1_amd64.ubuntu1804.deb
# systemctl start dcvserver
# systemctl enable dcvserver
# dcv create-session --owner labdbf --user labdbf labdbf-session

# install rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# source ~/.dotfiles/docs/inst_dotfiles.sh

# install powerline
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
sudo ./install.sh
cd ..
rm -rf fonts

# install vim8.2
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim

# install vimspector
wget https://github.com/puremourning/vimspector/releases/download/1472261046/vimspector-linux-1472261046.tar.gz
mkdir -p ~/.vim/pack
tar zxf vimspector-linux-1472261046.tar.gz -C ~/.vim/pack

# Install x11vnc

## Preparation
# check current display manager
cat /etc/X11/default-display-manager
# disable Wayland and enable Xorg display server (for gdm3)
# sudo vim /etc/gdm3/custom.conf
#   # uncomment the line #WaylandEnable=false

# sudo apt-get install x11vnc

# ps -ef | grep X
# x11vnc-start.sh

# # set up auto start
# 1.1
#   sudo visudo # add the following to the end of 
#   huangjn ALL=(ALL) NOPASSWD: /etc/x11vnc/x11vnc-gdm.service-kill.sh, /bin/fgconsole, /bin/chvt
# 1.2
#   sudo chmod a+rx /etc/x11vnc/*.sh
#   sudo cp x11vnc/*.service /lib/systemd/system/
#   sudo cp x11vnc/*.sh /etc/x11vnc/
#   sudo chmod a+rx /etc/x11vnc/*.sh

)

# Troubleshoot
## [apt_pkg error]
## sudo apt remove python3-apt
## sudo apt autoremove
## sudo apt autoclean
## sudo apt install python3-apt
## # are the above the same as "sudo apt install python3-apt --reinstall"?
## sudo ln -s apt_pkg.cpython-36m-x86_64-linux-gnu.so apt_pkg.so

