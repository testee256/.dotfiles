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

