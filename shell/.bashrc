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

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
force_color_prompt=yes

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



export GIT_PS1_SHOWDIRTYSTATE=1 GIT_PS1_SHOWSTASHSTATE=1 GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM=verbose GIT_PS1_DESCRIBE_STYLE=branch

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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

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


export GIT_PS1_SHOWDIRTYSTATE=1

if [ "$color_prompt" = yes ]; then
 PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;31m\]$(__git_ps1)\[\033[00m\]\$ '
else
 PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w$(__git_ps1)\$ '
fi

if test -n "$VIRTUAL_ENV"; then
    PS1="(`basename ${VIRTUAL_ENV}`)$PS1"
fi

unset color_prompt force_color_prompt

alias d_src7='docker exec -it docker_fullsync-source-centos7_1 bash'
alias d_src6='docker exec -it docker_fullsync-source-centos6_1 bash'
alias d_target6='docker exec -it docker_fullsync-target-centos6_1 bash'
alias d_target7='docker exec -it docker_fullsync-target-centos7_1 bash'
alias d_test6='docker exec -it docker_fullsync-testrunner-centos6_1 bash'
alias d_test7='docker exec -it docker_fullsync-testrunner-centos7_1 bash'

export GIT_EDITOR=vim
alias odr='ODR_DEBUG=1 ARTIFACT_CREDS=developer:jakTafAtId ./eve/workers/odr/run_tests.sh'
alias odr_pre='ODR_DEBUG=1 ARTIFACT_CREDS=developer:jakTafAtId ./eve/workers/odr/run_tests.sh premerge'
alias ssh='ssh -o StrictHostKeyChecking=no'
alias scp='scp -o StrictHostKeyChecking=no'
alias ssh_odr='ssh -i odr-workdir/odr-key'
alias docker_clean='for d in $(docker ps -q); do  echo "docker stop $d"; docker stop $d; "docker rm $d"; docker rm $d; done'

export PATH=$PATH:"/home/mvelay/workspace:/home/mvelay/workspace/odr:/home/mvelay/workspace/test_tools/testrail/:/home/mvelay/workspace/eve/:/home/mvelay/workspace/eve/tools/"

export ODR1="104.130.159.30"
alias odr1="ssh root@$ODR1"
export PATH="${PATH}:/home/mvelay/workspace/test_tools/testrail"
source <(kubectl completion bash)

alias hd_test="make -j16 install-hyperdrive install-hyperdrive-unit-tests  DESTDIR=/tmp/instX"
alias hd="export LD_LIBRARY_PATH=/tmp/instX/usr/lib/x86_64-linux-gnu/; build/hyperdrive/hyperiod/hyperiod -H localhost:8888 -wdl -c modules/hyperdrive/hyperdrive_template.conf -D /tmp/disks/disk1 -D /tmp/disks/disk10 -D /tmp/disks/disk11 -D /tmp/disks/disk12 -D /tmp/disks/disk2 -D /tmp/disks/disk3 -D /tmp/disks/disk4 -D /tmp/disks/disk5 -D /tmp/disks/disk6 -D /tmp/disks/disk7 -D /tmp/disks/disk8 -D /tmp/disks/disk9"
alias make_hd="make install-bizio-tools install-hyperdrive DESTDIR=/tmp/instX"

# ccache
export PATH="/usr/lib/ccache/:$PATH"
export CCACHE_DIR="/dev/shm/ccache"
ccache --max-size=8G >/dev/null 2>/dev/null
export ARTIFACTS_LOGIN='developer'
export ARTIFACTS_PWD='jakTafAtId'

alias co_hd='git checkout feature/RING-21232-hyperdrive'

ulimit -c unlimited
cd ~/workspace

alias gl="git log --oneline"
alias gc="git checkout"
alias gf="git fetch"
alias gp="git pull"

export HD1="54.38.66.36"
alias hd1="ssh root@${HD1}"
alias grafana="ssh -f -L 3000:127.0.0.1:3000 root@54.38.66.36 bash"