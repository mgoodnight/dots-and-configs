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
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

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

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

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

alias audres='sudo killall coreaudiod && sleep 3 && sudo kextunload /System/Library/Extensions/AppleHDA.kext && sleep 3 && sudo kextload /System/Library/Extensions/AppleHDA.kext'

. ~/.do-not-commit.sh

# MySQL
alias ms='mysql -h localhost -u root -proot'

# Caveman API
alias caveman='MOJO_MODE=development perl -Mlocal::lib=/Users/mgoodnight/teelicious/caveman-api/local /Users/mgoodnight/teelicious/caveman-api/local/bin/plackup -R /Users/mgoodnight/teelicious/caveman-api/lib,/Users/mgoodnight/teelicious/caveman-api/local -s Starman -p 5000 --workers=2 /Users/mgoodnight/teelicious/caveman-api/script/caveman'
alias cmworker='MOJO_MODE=development perl -Mlocal::lib=/Users/mgoodnight/teelicious/caveman-api/local /Users/mgoodnight/teelicious/caveman-api/script/caveman minion worker'

# WebAPI
alias webapi='PYTHONPATH=/Users/mgoodnight/teelicious/tee-webapi ENVIRONMENT=development python /Users/mgoodnight/teelicious/tee-webapi/webapi/app.py'

# Git
alias gd='git diff'
alias gs='git status'
alias gf='git fetch'
alias gm='git checkout master && git pull origin master'

parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
export PS1="\u@\h \[\033[32m\]\w\[\033[33m\]\$(parse_git_branch)\[\033[00m\] $ "

# Node.js
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
export WORKON_HOME=~/pythonenvs
. /usr/local/bin/virtualenvwrapper.sh

alias pyt='ENVIRONMENT=development pytest --capture=sys '

# Perl
export PERLBREW_HOME=~/.perlbrew
source ~/perl5/perlbrew/etc/bashrc

export PERL_CPANM_OPT=' --mirror http://cpan.metacpan.org/ --mirror http://mirror.cc.columbia.edu/pub/software/cpan/ --mirror http://cpan.cse.msu.edu/ --mirror http://www.cpan.org/ --mirror http://cpan.perlnow.com/ --mirror http://cpan.mirror.facebook.net/ --mirror-only --cascade-search'

alias pp='prove -Ilib -Mlocal::lib=local -vr '
alias pt='find lib -type f -name '*.pm' | xargs perltidy -b'

# Golang
export PATH=$PATH:/usr/local/go/bin

# Redis
alias redis='redis-server /usr/local/etc/redis.conf'

