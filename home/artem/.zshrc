# Created by newuser for 5.9

# bluetoothctl power on
# bluetoothctl connect FF:1F:54:58:E0:F7 ORBIT BT5.0
# bluetoothctl connect 12:34:10:29:1A:40 ORBIT BT3.0
# bluetoothctl connect 94:FB:A7:30:31:5A HyperX Cloud Buds (win is paired, chntpw: \ControlSet001\Services\BTHPORT\Parameters\Keys\683421c7a5af> cat 94fba730315a)
# bluetoothctl connect B8:F6:53:9C:F8:DA JBL Flip 5
# bluetoothctl connect DC:AB:CD:50:0A:00 Digio2 BT5.0 Tball (only linux is paired)
#
# to make bluetooth work with windows and linux see: https://wiki.archlinux.org/title/Bluetooth#Dual_boot_pairing


# init node version manager
source /usr/share/nvm/init-nvm.sh


# use CRTL-A and CTRL-E for jumping around shell cli
bindkey -e

# see: https://sw.kovidgoyal.net/kitty/faq/#i-get-errors-about-the-terminal-being-unknown-or-opening-the-terminal-failing-or-functional-keys-like-arrow-keys-don-t-work
alias kitty_ssh="kitten ssh"
alias kitty_keys="kitten show-key -m kitty"

# be aware of magic space after alias, see: https://stackoverflow.com/questions/71920035/zsh-alias-completion-trailing-space-breaks-with-functions

alias ll="ls -la --color"
# alias hh="cat /home/artem/.zsh_history"
alias hh="history -i 0"
alias f="find"
alias vim="nvim"
alias dotfiles="git --git-dir=/home/artem/dotfiles/.git --work-tree=/"
alias k="kubectl"
alias kgetall="kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl -v=6 get --show-kind --ignore-not-found -n"
alias d="docker"
alias g="git"
alias gt="git st"
alias gm="git commit -m"
alias sps="sops --keyservice tcp://127.0.0.1:5000"

alias rmmod_snd_sof_all="sudo rmmod snd_sof_pci_intel_mtl snd_sof_intel_hda_generic snd_sof_intel_hda_common snd_sof_pci snd_sof_intel_hda snd_sof snd_sof_utils snd_soc_hdac_hda snd_soc_dmic snd_sof soundwire_intel snd_sof_intel_hda_mlink snd_sof_xtensa_dsp snd_hda_ext_core" 

# before rsync run "sudo ncdu /" to find and exclude unnecessary large files
alias rsync_arch_to_new_partition="sudo rsync -aAXHv --exclude='/dev/*' --exclude='/proc/*' --exclude='/sys/*' --exclude='/tmp/*' --exclude='/run/*' --exclude='/mnt/*' --exclude='/media/*' --exclude='/boot/*' --exclude='/lost+found/' --exclude='/var/lib/docker/overlay2/*' --exclude='/home/artem/axl*' --exclude='/home/artem/Downloads/*' --exclude='/var/cache/*' / /mnt"

alias j="z"
export _Z_CMD="j"


# see: https://github.com/I60R/page
# export PAGER="page -WfC -q 90000 -z 90000"
# export MANPAGER="page -t man"
export PAGER="cat"
export MANPAGER="cat"
export SYSTEMD_PAGER="cat"

export MOZ_ENABLE_WAYLAND=1
export VISUAL="nvim"
export EDITOR="nvim"
export TERMINAL="terminator"
export ELECTRON_OZONE_PLATFORM_HINT="wayland"
export GDK_BACKEND=wayland
export PATH="$PATH:/home/artem/.local/bin"
export LIBSEAT_BACKEND=logind

# docker always use plain progress
export BUILDKIT_PROGRESS=plain

# To find your country code is, refer to the layout section of:
# /usr/share/X11/xkb/rules/evdev.lst
# If a variant layout is needed, the syntax is layout(variant)
# If multiple layouts are used, specify the toggle-keybind using
# XKB_DEFAULT_OPTIONS as show below.
# For further details, see xkeyboard-config(7)
# the caps keyboard led will indicate keyboard layout
export XKB_DEFAULT_LAYOUT=us,ru(mac)
export XKB_DEFAULT_OPTIONS=grp:ctrl_space_toggle,grp_led:caps

# Bind Up and Down arrows to prefix-based history search
bindkey '^[[A' history-beginning-search-backward  # Up arrow
bindkey '^[[B' history-beginning-search-forward   # Down arrow

# instead of Alt+f and Alt+b, use Ctrl+LeftArrow and Ctrl+RightArrow to jump words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# case insensitive path-completion and highlight current menu entry
autoload -U compinit; compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

# Set history file and size
HISTFILE=~/.zsh_history               # Location of history file
HISTSIZE=1000000                      # Unlimited in-memory history
SAVEHIST=1000000                      # Unlimited saved history

# see zsh options: https://zsh.sourceforge.io/Doc/Release/Options.html#Description-of-Options
# Remove duplicate history entries
setopt HIST_FIND_NO_DUPS        # Avoid showing duplicates during search
setopt INC_APPEND_HISTORY       # Save each command to history immediately
setopt EXTENDED_HISTORY         # Save timestamps in history file
setopt HIST_REDUCE_BLANKS       # Remove unnecessary blank spaces from history
setopt HIST_IGNORE_SPACE        # If command starts with space do not add to hist file
setopt HIST_IGNORE_DUPS         # Do not save consecutive duplicate commands

setopt AUTO_CD                  # change to directory if its name matches and is not a command


# With kitty must set "shell_integration disabled" before experimenting, else can face hard-to-debug shit
# see: https://sw.kovidgoyal.net/kitty/shell-integration/#how-it-works

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
    local venv=$VIRTUAL_ENV

    if [[ -n "$venv" ]]; then
        local myvenv=" (%F{yellow}$venv%F{cyan})"
    else
        local myvenv=""
    fi

    if [[ -n "$branch" ]]; then
        local mybranch=" (%F{green}$branch%F{cyan})"
    else
        local mybranch=""
    fi

    PROMPT="%F{cyan}%~$myvenv$mybranch%f\$ "
}
precmd_functions+=(update_prompt_with_git_branch)

# autojump to frequent directories
# see: https://github.com/rupa/z/blob/master/README
source ~/.z-rupa-autojump.sh
