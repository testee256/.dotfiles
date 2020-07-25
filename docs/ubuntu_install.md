# Install ubuntu

* Normal installation, download updates while installing

* Restart

* sudo apt update # Fetches the list of available updates

* # (optional) sudo apt-get upgrade # Strictly upgrades the current 
pack(opages

* # (optional) sudo apt-get dist-upgrade # update dependencies as well

* sudo apt install build-essential linux-headers-$(uname -r) dkms

# Apps

```bash
sudo apt update
sudo apt install cscope ctags cmake tmux dos2unix fonts-powerline git curl
sudo apt install vim vim-gtk libcanberra-gtk-module libcanberra-gtk3-module

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.0.1/ripgrep_12.0.1_amd64.deb
sudo dpkg -i ripgrep_12.0.1_amd64.deb
```

# Powerline

```bash
git clone https://github.com/powerline/fonts.git --depth=1
cd fonts
./install.sh
cd ..
rm -rf fonts
```

# bcompare

```
wget https://www.scootersoftware.com/bcompare-4.3.4.24657_amd64.deb
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.3.4.24657_amd64.deb
```

# Configuration
```bash
git clone https://github.com/testee256/.dotfiles
```

# Install rust
```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# source ~/.cargo/env
```

