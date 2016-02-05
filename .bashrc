#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# alias to rebuild dwm (dynamic window manager)
alias redwm='cd  $HOME/temach-arch-linux/dwm-abs-build-dir; updpkgsums; makepkg -efi --noconfirm; killall dwm'

# set default editor
export VISUAL=vim
export EDITOR=vim

# history dude!
# avoid duplicates
export HISTCONTROL=ignoredups:erasedups
## edit a recalled history line before executing
shopt -s histverify
# set history file size
shopt -s histappend

# enable completion for git (and possibly other) commands
for file in /etc/bash_completion.d/* ; do
    source "$file"
done

# After each command, append to the history file
export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"


