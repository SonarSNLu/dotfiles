# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

#SSH on startup
#sudo service ssh start
# Automatically start ssh-agent and add key
#if [ -z "$SSH_AUTH_SOCK" ]; then
#    eval "$(ssh-agent -s)" > /dev/null
#    ssh-add ~/.ssh/id_ed25519_SonarSNU 2>/dev/null || ssh-add ~/.ssh/id_rsa 2>/dev/null
#fi

# ---- GitHub account switcher ----
# profile name -> key filename in ~/.ssh   (add a line per account)
export SSH_AUTH_SOCK="$HOME/.ssh/gh-agent.sock"   # one agent shared by all terminals

_gh_agent() {
  ssh-add -l >/dev/null 2>&1
  if [ $? -eq 2 ]; then                            # no agent reachable -> start one
    rm -f "$SSH_AUTH_SOCK"
    ssh-agent -a "$SSH_AUTH_SOCK" >/dev/null
  fi
}                                                  # <- this was missing

# profile name -> key filename in ~/.ssh   (add a line per account)
declare -A GH_KEYS=(
  [sonar]=id_ed25519_SonarSNU
  [portabela]=id_ed25519_Cheeba
# [work]=id_ed25519_work
)

ghs() {
  _gh_agent
  case "$1" in
    "")       ssh-add -l ;;                                  # what's unlocked now
    off|lock) ssh-add -D ;;                                  # lock everything now
    ls)       printf '%s\n' "${!GH_KEYS[@]}" | sort ;;       # list profiles
    *)
      local key="$HOME/.ssh/${GH_KEYS[$1]}"
      if [ -z "${GH_KEYS[$1]}" ] || [ ! -f "$key" ]; then
        echo "unknown profile or missing key file: $1"; return 1
      fi
      ssh-add -D 2>/dev/null                                 # lock all others first
      ssh-add -t "${2:-4h}" "$key" ;;                        # unlock this one
  esac
}
complete -W "ls off lock ${!GH_KEYS[*]}" ghs                 # tab completion

alias llock='ghs off && vlock' # so vlock locking the terminal also off the ssh credential

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

#Starship
eval "$(starship init bash)"

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

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

# Autocompletion
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#vscode path
alias code='code --profile "Minima"'

#Update OS
alias updateos='sudo apt update && sudo apt full-upgrade -y'

#Ver. check 
alias os-ver='cat /etc/os-release'

#Bash setting confing
alias bashrc='nvim ~/.bashrc'

#fd-find
alias fd='fd-find'

#Sonarcove cd from WSL
alias Scove="nvim /mnt/d/SonarCove/"

#Windows User cd from WSL
alias lyto="nvim /mnt/c/Users/4lyto"

#Wezterm config edit
alias wzterm="nvim /mnt/c/Users/4lyto/.wezterm.lua"

#Bread on penguins ytber neovim setting 
alias nvim="NVIM_APPNAME=nvim/neovim nvim"

# Created by `pipx` on 2026-10-09 19:15:34
export PATH="$PATH:/home/Bianfuwu/.local/bin"

# Automatically converts and navigates to a copied Windows path in WSL
cw() {
    # Strip quotes if they exist, then convert using wslpath
    local clean_path=$(echo "$1" | tr -d '"')
    cd "$(wslpath "$clean_path")"
}

# WSL window path helper i.e: w 'insert command'
w() {
    local cmd="$1"
    local win_path=$(echo "$2" | tr -d '"')
    local wsl_path=$(wslpath "$win_path")
    
    # Run the command with the converted path and any remaining arguments
    "$cmd" "$wsl_path" "${@:3}"
}


# fnm
FNM_PATH="/home/Bianfuwu/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "$(fnm env --shell bash)"
fi
