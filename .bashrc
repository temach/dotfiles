#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# so that after you cd into a link the cd ../ and pwd work as usual
set -o physical

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

# alias to exit cleanly
alias poweroff='killall -s SIGTERM fluxbox && systemctl poweroff'

alias ll='ls -la'


# enable autojump
source /etc/profile.d/autojump.sh


# remember the Do The Right Extraction dtrx command
