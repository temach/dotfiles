#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# aloas to rebuild dwm (dynamic window manager)
alias redwm='cd  $HOME/temach-arch-linux/dwm-abs-build-dir; updpkgsums; makepkg -efi --noconfirm; killall dwm'

