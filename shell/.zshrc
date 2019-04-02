#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

# default editor
export EDITOR="vim"# default zone
export TZ=Europe/Paris# ccache
export PATH="/usr/lib/ccache/:$PATH"
export CCACHE_DIR="/dev/shm/ccache"
ccache --max-size=8G >/dev/null 2>/dev/null
bindkey '^[[1;5D' backward-word
bindkey '^[[1;5C' forward-word
bindkey '^[[3;5~' kill-word
bindkey '^H'  backward-kill-word

export HD1="54.38.66.36"
alias hd1="ssh root@${HD1}"
alias hd2="ssh velay@${HD1}"
