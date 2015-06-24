# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples


# To see your most frequent/popular commands:  history | awk '{print $3}' | sort | uniq -c | sort -rn | head
# Erase a history line >>history -d <history line number>



# If not running interactively, don't do anything
#case $- in
#    *i*) ;;
#      *) return;;
#esac

export BASH_ENV="$HOME/.bashrc_aliases"



########## SHELL TWEAKS ###########

## ENV VARIABLES
# set default editor. Better set both, VISUAL and EDITOR. 
export VISUAL=vim
export EDITOR="$VISUAL"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# A colon-separated list of patterns used to decide which command lines should be saved on the history list. Prefix matching is used. 
export HISTIGNORE="&:pwd:ls:ls -l:ls -la:cd /:cd -:cd ..:history:h:ll" 

# Write a timestamp in front of every command. See "man strftime" 
export HISTTIMEFORMAT="%F "

# default colors="exfxcxdxbxegedabagacad", do "man ls" for info. blue=dirs, brown/yellow=sym link, cyan/sky blue = any weird file
# export LSCOLORS="exdxFxFxxxFxFxFxFxFxFx"

# runtime paths manipulations
export PATH="$PATH:/usr/local/include:/usr/local/lib"
export LD_LIBRARY_PATH="/usr/local/lib"

# for use with gcc in -fsanitize=address
export ASAN_SYMBOLIZER_PATH=/usr/bin/llvm-symbolizer-3.5
export ASAN_OPTIONS=symbolize=1

#Setting for python to stop writing byte code (".pyc" files)
export PYTHONDONTWRITEBYTECODE=1

# Warning control, equivalent to specifying the -W option. See python docs for more details.
export PYTHONWARNINGS="all"

# turn off terminal colours. Just in case you ever need this.
# export CLICOLOR=0



# append to the history file, don't overwrite it
shopt -s histappend

# make "!234" copy-paste from history to prompt instead of directly executing.
shopt -s histverify

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar



## ALLOW COLORS
# Tell everybody that we use full color
export TERM=xterm-256color

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# if var is set try to enable color
color_prompt=no;
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt      # we do not need this var anymore

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


## OTHER STUFF
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bashrc_aliases, instead of adding them to bashrc directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f "$HOME/.bashrc_aliases" ]; then
    source "$HOME/.bashrc_aliases"
fi


## FUNCTIONS
# Compress the cd, ls -l series of commands.
function cl () {
   if [ $# = 0 ]; then
      cd && ll
   else
      cd "$*" && ll
   fi
}

# C# development (c-sharp)
function runcs () {
   if [ $# = 0 ]; then
      echo "give me input"
   else
        namefull="$*"
        namecut=$(basename "${namefull%.*}")
        echo $fn
        mcs "$*" -pkg:dotnet && mono ${namecut}".exe"
   fi
}
