#
# ~/.bash_profile
#
# put stuff here which needs to be always present.
# because .bash_profile is always read. 
# and .bashrc is only read for interactive sessions

# set history size
export HISTFILESIZE=100000
export HISTSIZE=100000

# set default config for qt/kde apps
# even when we use non interactive shells like with fbrun
export QT_QPA_PLATFORMTHEME="qt5ct"

