# Installation

https://docs.microsoft.com/en-us/windows/wsl/install-win10

(1) power shell 
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
# reboot
(2) windows store, search "linux"

# Home directory on windows
%LOCALAPPDATA%\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc

# change login home directory
sudo vim /etc/passwd

# Powerline

sudo apt-get update
sudo apt-get install fonts-powerline 
# change terminal font to DejaVu Sans Mono for Powerline

# vim

sudo add-apt-repository ppa:x4121/ripgrep
sudo apt-get update
sudo apt-get install cscope ctags ripgrep cmake tmux dos2unix

# tmux configuration
https://github.com/gpakosz/.tmux

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install rg
$ git clone https://github.com/BurntSushi/ripgrep
$ cd ripgrep
$ cargo build --release
$ ./target/release/rg --version
sudo cp ./target/release/rg /usr/bin

