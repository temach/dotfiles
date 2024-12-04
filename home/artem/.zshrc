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
alias k="kubectl "

alias rmmod_snd_sof_all="sudo rmmod snd_sof_pci_intel_mtl snd_sof_intel_hda_generic snd_sof_intel_hda_common snd_sof_pci snd_sof_intel_hda snd_sof snd_sof_utils snd_soc_hdac_hda snd_soc_dmic snd_sof soundwire_intel snd_sof_intel_hda_mlink snd_sof_xtensa_dsp snd_hda_ext_core" 

export MOZ_ENABLE_WAYLAND=1
export EDITOR="nvim"
export TERMINAL="terminator"
export ELECTRON_OZONE_PLATFORM_HINT="wayland"
export GDK_BACKEND=wayland
export PATH="$PATH:/home/artem/.local/bin"

# To find your country code is, refer to the layout section of:
# /usr/share/X11/xkb/rules/evdev.lst
# If a variant layout is needed, the syntax is layout(variant)
# If multiple layouts are used, specify the toggle-keybind using
# XKB_DEFAULT_OPTIONS as show below.
# For further details, see xkeyboard-config(7)
# the caps keyboard led will indicate keyboard layout
export XKB_DEFAULT_LAYOUT=us,ru(mac)
export XKB_DEFAULT_OPTIONS=grp:ctrl_space_toggle,grp_led:caps
# export XKB_DEFAULT_OPTIONS=grp:win_space_toggle

# autojump to frequent directories
# see: https://github.com/rupa/z/blob/master/README
source ~/.z-rupa-autojump.sh

# Bind Up and Down arrows to prefix-based history search
bindkey '^[[A' history-search-backward  # Up arrow
bindkey '^[[B' history-search-forward   # Down arrow

# case insensitive path-completion and highlight current menu entry
autoload -Uz +X compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

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

