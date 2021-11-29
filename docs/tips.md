# Startup

## Types of shell

* Login using terminal (ssh or local), the session is both login and interactive
 
* Invoke by "bash": interactive shell, but not login shell

* Invoke by "bash --login": both login and interactive shell
 
* Shell script: neither a login shell nor an interactive one

## Login shell

```bash
# Search order
# step 1: /etc/profile
# step 2: the following files are checked for existence in this order
#          (whichever found first, the rest of files are ignored)
#    ~/.bash_profile
#    ~/.bashrc
#    ~/.bash_login
#    ~/.profile
```
## Interactive shell

.bashrc file is run every time you request a new interactive shell.

# Shell tips

## History expansion

* [bash-history-expansion](https://www.thegeekstuff.com/2011/08/bash-history-expansion/)

```bash

# Referring to arguments
ls -l !tar:3-5 # arg 3-5 of previous command starts with tar
ls -l !!:3-5   # arg 3-5 of previous command
ls -l !!:3-5   # arg 3-5 of previous command
ls -l !!:3-$   # arg 3 to last one
ls -l !!:3-$   # arg 3 to second last

# Referring to command
find ~ -name "file1"    # original command
!119:0:p / !119:2*:p # by index
!tar:0:p / !tar:2*:p # by start-with
!!:0:p / !!:2*:p # previous command

# Modifiers
# $ ls -l /very/long/path/filename.txt
ls -l !!:$:h  # get path name:  /very/long/path
ls -l !!:$:t  # get file name: filename.txt
ls -l !!:$:r  # remove file extension: /very/long/path/filename

# substitute
!!:s/ls -l/cat/        # replace once
!!:gs/password/passwd/ # replace all

```

## Trap (DEBUG, EXIT)

* [last-failed-command-in-bash](https://unix.stackexchange.com/questions/21930/last-failed-command-in-bash)

## Attach an existing vim process to new terminal
ps -a vim # to find process of vim 
reptyr PID
* in case of ptrace error, execute the following command
```bash
# echo 0 > /proc/sys/kernel/yama/ptrace_scope # not working due to permission error
sudo vim /etc/sysctl.d/10-ptrace.conf # modify ptrace_scope to 0
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

# Install coc.nvim

## 1. install nvm

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
# need to restart terminal

## 2. install node
nvm install node
node --version

## 3. install yarn # note the default yarn comes with cmdtest which is not what we need
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
sudo apt update
sudo apt install yarn
yarn --version
```

## Install dependencies and compile coc 
cd ~/.vim/bundle/coc.nvim/
yarn install

