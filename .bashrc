# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac


########## SHELL TWEAKS ###########
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi



# this is on by default but force it for safety
shopt -s expand_aliases


# enable color support of ls and also add handy aliases
# Set GNU ls to alias color this is for Linux based (Ubuntu)
# The FreeBSD (and Mac os x) settings are in .bash_profile
alias ll="ls --color=auto -la"

# open current dir in nautilus
alias op='nautilus .'

# allow quick color tagging for files
alias tago="${HOME}/change_icon.sh orange"
alias tagf="${HOME}/change_icon.sh firebrick2"
alias tagb="${HOME}/change_icon.sh RoyalBlue1"
alias tagg="${HOME}/change_icon.sh green2"
alias tagy="${HOME}/change_icon.sh GreenYellow"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


# go read the .bashrc_common file
if [ -f "$HOME/.bashrc_common" ]; then
    source "$HOME/.bashrc_common"
fi

