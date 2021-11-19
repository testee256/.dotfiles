# Install ubuntu

* Normal installation, download updates while installing

* Restart

```bash
* sudo apt update # Fetches the list of available updates
* sudo apt-get upgrade # (optional) Strictly upgrades the current pack(opages
* sudo apt-get dist-upgrade # (optional) update dependencies as well
* sudo apt install build-essential linux-headers-$(uname -r) dkms
```

# Apps

```bash
sudo apt update
sudo apt install cscope ctags cmake tmux dos2unix fonts-powerline git curl openssh-server
sudo apt install vim vim-gtk libcanberra-gtk-module libcanberra-gtk3-module

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/12.1.1/ripgrep_12.1.1_amd64.deb
sudo dpkg -i ripgrep_12.1.1_amd64.deb
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

``` bash
wget https://www.scootersoftware.com/bcompare-4.4.0.25886_amd64.deb
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.3.5.24893_amd64.deb
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

# Python

(https://tech.serhatteker.com/post/2019-09/upgrade-python37-on-ubuntu18/)

```bash
# Step 1: Install python3.7
sudo apt update -y
sudo apt install python3.7

# Step 2: Add python 3.6 & python 3.7 to update-alternatives
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.6 1
sudo update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.7 2

# Step 3 Update python 3 to point to python 3.7
sudo update-alternatives --config python3

python3 -V

# if you see error "No module named apt_pkg"
# https://unix.stackexchange.com/questions/588066/modulenotfounderror-no-module-named-apt-pkg-appears-in-various-commands

sudo apt install python3-apt --fix-missing

# or

sudo apt remove python3-apt
sudo apt autoremove
sudo apt autoclean
sudo apt install python3-apt


# some ubuntu applications (such as gnome-tweaks) may not like 3.7, e.g., 
# $ gnome-tweaks
# ImportError: cannot import name '_gi' from 'gi' (/usr/lib/python3/dist-packages/gi/__init__.py)
sudo ln -s /usr/lib/python3/dist-packages/gi/_gi.cpython-{36m,37m}-x86_64-linux-gnu.so

```

# Error: Python.h: No such file or directory
# https://stackoverflow.com/questions/21530577/fatal-error-python-h-no-such-file-or-directory
sudo apt-get install python-dev   # for python2.x installs
sudo apt-get install python3-dev  # for python3.x installs
sudo apt-get install python3.7-dev  # for python3.x installs

