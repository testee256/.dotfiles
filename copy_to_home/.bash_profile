# step 1: /etc/profile
# step 2: the following files are checked for existence in this order
#          (whichever found first, the rest of files are ignored)
#    ~/.bash_profile
#    ~/.bashrc
#    ~/.bash_login
#    ~/.profile

if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi

