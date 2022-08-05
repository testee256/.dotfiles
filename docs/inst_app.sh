#!/bin/bash

set -e

sudo apt update
sudo apt install -y cscope ctags cmake tmux dos2unix fonts-powerline git curl vim vim-gtk libcanberra-gtk-module libcanberra-gtk3-module gdebi-core terminator socat openssh-server xclip xsel software-properties-common reptyr fonts-powerline
sudo apt install -y minicom gtkterm

export INST_DIR=~/Downloads

(
cd ${INST_DIR}
if [[ $(which rg) ]]; then echo [INFO] rg already installed && exit 0 ; fi
sudo curl -LO  https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
sudo dpkg -i ripgrep_13.0.0_amd64.deb
)

(
cd ${INST_DIR}
if [[ $(which bcompare) ]]; then echo [INFO] bcompare already installed && exit 0 ; fi
wget https://www.scootersoftware.com/bcompare-4.4.0.25886_amd64.deb
sudo dpkg -i bcompare-4.4.0.25886_amd64.deb

git config --global diff.tool bc3
git config --global difftool.bc3.trustExitCode true 
git config --global merge.tool bc3
git config --global mergetool.bc3.trustExitCode true
)

# source ~/.dotfiles/docs/inst_dotfiles.sh

# (
# if there is no fonts-powerline
# cd ${INST_DIR}
# # install powerline
# git clone https://github.com/powerline/fonts.git --depth=1
# cd fonts
# sudo ./install.sh
# cd ..
# rm -rf fonts
# )

(
if [[ $(vim --version | head -1 | grep 8.2) ]]; then echo [INFO] vim 8.2 already installed && exit 0 ; fi
# install vim8.2
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt -y install vim
)

(
[ -d ~/.vim/pack/vimspector/ ] && echo [INFO] vimspector already installed && exit 0
# install vimspector
wget https://github.com/puremourning/vimspector/releases/download/1472261046/vimspector-linux-1472261046.tar.gz
mkdir -p ~/.vim/pack
tar zxf vimspector-linux-1472261046.tar.gz -C ~/.vim/pack
)

# Install nvim
(
if [[ $(which nvim) ]]; then echo [INFO] nvim already installed && exit 0 ; fi
[ -d ~/bin ] || mkdir ~/bin
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

(
if [[ $(which fzf) ]]; then echo [INFO] fzf already installed && exit 0 ; fi
cd ~/Downloads
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
)

(
if [[ $(which bat) ]]; then echo [INFO] bat already installed && exit 0 ; fi
cd ${INST_DIR}
wget https://github.com/sharkdp/bat/releases/download/v0.18.3/bat_0.18.3_amd64.deb
sudo dpkg -i bat_0.18.3_amd64.deb
)

(
if [[ $(which lazygit) ]]; then echo [INFO] lazygit already installed && exit 0 ; fi
sudo add-apt-repository ppa:lazygit-team/release
sudo apt update
sudo apt install -y lazygit
)
# Troubleshoot
## [apt_pkg error]
## sudo apt remove python3-apt
## sudo apt autoremove
## sudo apt autoclean
## sudo apt install python3-apt
## # are the above the same as "sudo apt install python3-apt --reinstall"?
## sudo ln -s apt_pkg.cpython-36m-x86_64-linux-gnu.so apt_pkg.so

