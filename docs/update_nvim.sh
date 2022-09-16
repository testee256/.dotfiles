#!/bin/bash

set -e

# Install nvim
(
mkdir -p ~/bin
cd ~/bin
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
mv nvim.appimage nvim
# if see error "requires python3 support":
[ -d ~/.config ] || mkdir ~/.config
cp -rp ~/.dotfiles/.config/* ~/.config/
sudo apt -y install python3-pip
pip3 install neovim
)

