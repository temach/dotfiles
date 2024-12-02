# Created by newuser for 5.9

# ORBIT BT5.0 FF:1F:54:58:E0:F7
# bluetoothctl power on
# bluetoothctl connect FF:1F:54:58:E0:F7

# use CRTL-A and CTRL-E for jumping around shell cli
bindkey -e

alias ll="ls -la"
alias hh="history -E"
alias f="find "
alias j="z "
alias vim="nvim "
alias dotfiles="git --git-dir=/home/artem/dotfiles/.git --work-tree=/"

export MOZ_ENABLE_WAYLAND=1
export EDITOR="vim"
export TERMINAL="terminator"
export CHROMIUM_USER_DATA_DIR="$HOME/.chromium"

# To find your country code is, refer to the layout section of:
# /usr/share/X11/xkb/rules/evdev.lst
# If a variant layout is needed, the syntax is layout(variant)
# If multiple layouts are used, specify the toggle-keybind using
# XKB_DEFAULT_OPTIONS as show below.
# For further details, see xkeyboard-config(7)
export XKB_DEFAULT_LAYOUT=us,ru(mac)
export XKB_DEFAULT_OPTIONS=grp:ctrl_space_toggle
# export XKB_DEFAULT_OPTIONS=grp:win_space_toggle

# autojump to frequent directories
# see: https://github.com/rupa/z/blob/master/README
source ~/.z.sh

# Bind Up and Down arrows to prefix-based history search
bindkey '^[[A' history-search-backward  # Up arrow
bindkey '^[[B' history-search-forward   # Down arrow


# Set history file and size
HISTFILE=~/.zsh_history         # Location of history file
HISTSIZE=1000000                      # Unlimited in-memory history
SAVEHIST=1000000                      # Unlimited saved history

# Remove duplicate history entries
# setopt HIST_IGNORE_ALL_DUPS   # Remove all duplicates in history
setopt HIST_FIND_NO_DUPS        # Avoid showing duplicates during search

# Additional recommended history options
setopt SHARE_HISTORY            # Share history across all Zsh sessions
setopt APPEND_HISTORY           # Append new history lines to the history file
setopt INC_APPEND_HISTORY       # Save each command to history immediately
setopt EXTENDED_HISTORY         # Save timestamps in history file
setopt HIST_REDUCE_BLANKS       # Remove unnecessary blank spaces from history

# set title of compatiable terminals
function set_terminal_tab_title() {
    local cmd=${1[1,10]}
    # to current working directory and 10 chars of latest command
    print -Pn "\e]0;%~ - $cmd\a"
}
preexec_functions+=(set_terminal_tab_title)

# show git branch in prompt
function update_prompt_with_git_branch() {
    local branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -n "$branch" ]]; then
        PROMPT="%F{cyan}%~ (%F{green}$branch%F{cyan})%f\$ "
    else
        PROMPT="%F{cyan}%~%f\$ "
    fi
}
precmd_functions+=(update_prompt_with_git_branch)
