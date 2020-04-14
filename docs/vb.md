# VM

* Add new VM named ubuntu-18.04.xx

    * Memory 2048MB, create a virtual harddisk now, vdi, dynamic, 30GB

* Settings

    * System, Processor->Process(s)=2

    * Storage->Controller:IDE->Empty->Select ISO

    * HDD: Solid State

    * Sharedfolder: /mnt/shared, automount

* Install ubuntu

    * Normal installation, download updates while installing

    * Restart

    * sudo apt update # Fetches the list of available updates

    * # (optional) sudo apt-get upgrade # Strictly upgrades the current 
    pack(opages

    * # sudo apt-get dist-upgrade # Installs updates (new ones)

    * sudo apt install build-essential linux-headers-$(uname -r) dkms

* Install guest additions

    * Device->Insert Guest Addition ISO, select run
    * sudo usermod -G vboxsf -a $USER
    * sudo shutdown -P now
    * VM Setting
    *   - General->Advanced->bidirectional
    *   - Add shared folder as automount
    * Start VM
    *   - shared folder, clipboard, resize screen should work now
    *   - Verify: lsmod | grep guest

* Troubleshoot
    * If seeing iso9660: sudo depmod -a re-insert CD and select run

# Apps

```bash
sudo apt update
sudo apt install cscope ctags cmake tmux dos2unix fonts-powerline git curl
sudo apt install vim vim-gtk libcanberra-gtk-module libcanberra-gtk3-module

curl -LO curl -LO 
https://github.com/BurntSushi/ripgrep/releases/download/12.0.1/ripgrep_12.0.1_amd64.deb
sudo dpkg -i ripgrep_12.0.1_amd64.deb
```

# powerline

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
sudo apt install rustc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

