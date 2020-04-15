#!/bin/bash
apt update
apt install cscope ctags cmake tmux dos2unix fonts-powerline git curl
apt install vim vim-gtk libcanberra-gtk-module libcanberra-gtk3-module

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.0.1/ripgrep_12.0.1_amd64.deb
dpkg -i ripgrep_12.0.1_amd64.deb

cd ~/Downloads
wget https://www.scootersoftware.com/bcompare-4.3.4.24657_amd64.deb
apt-get update
apt-get install gdebi-core
gdebi bcompare-4.3.4.24657_amd64.deb

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install local config
cd ~
git clone https://github.com/testee256/.dotfiles

# source ~/.dotfiles/docs/inst_dotfiles.sh

# install powerline
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts

