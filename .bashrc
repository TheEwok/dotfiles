#BASHY BASHY GOODNESS!
export PATH=/usr/local/bin:$PATH:/usr/local/share/npm/bin/:~/dotfiles/bin:~/dev/home/pebble/sdk/bin:/Users/Bomahony/.tmuxifier/bin
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export EDITOR=vim
export HOME_NODE_ENV=dev
export LPASS_DISABLE_PINENTRY=1
set -o vi

#Are we on OS X?
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
       platform='osx'
fi

#Git aliases
alias clean_sub='git submodule foreach --recursive git checkout .'

alias ll='ls -lGh $@'

function gpull() {
	git pull origin $1
}

alias glog='git log --graph --color'

#A little bit o' silliness
alias sstk="curl -s 'http://download.finance.yahoo.com/d/quotes.csv?s=sstk&f=l1'"

alias stash="git stash -a && git stash show -p > /tmp/stash.$(date -u +"%Y-%m-%dT%H:%M:%SZ").diff"

tunnel_home() {
    ssh -p 2222 -N -L $1:127.0.0.1:$2 baz@aslan.pwnz.org
}

#Aliases for Node
nin() {
    npm install --save $*
}

ning() {
    npm install -g $*
}

nind() {
    npm install --save-dev $*
}

NYC_time() {
    echo `env TZ="America/New_York" date "+%H:%M"`
}

#Prompty Goodness
branch_color()  {
    git rev-parse 2>/dev/null;
    if [ $? -eq 0 ]; then
        modifier=`git status | grep clean$ | wc -l | tr -d ' '`
        color=`expr 31 + $modifier`
        echo $color
    fi
}

ttfb() {
  curl -s -o /dev/null -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" $1
}

print_branch_name() {
    if [ -z "$1" ]
    then
        curdir=`pwd`
    else
        curdir=$1
    fi

    if [ -d "$curdir/.hg" ]
    then
        echo -n "[Branch:"
        if [ -f  "$curdir/.hg/branch" ]
        then
            branch=`cat "$curdir/.hg/branch"`
            echo "$branch]"
        else
            echo "default"
        fi
        return 0
    elif [ -d "$curdir/.git" ]
    then
        branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
        echo -n "[$branch]"
    fi
    # Recurse upwards
    if [ "$curdir" == '/' ]
    then
        return 1
    else
        print_branch_name `dirname "$curdir"`
    fi
}

if [[ "$platform" == "osx" ]]; then
    if [ -f $(/usr/local/bin/brew --prefix)/share/bash-completion/bash_completion ]; then
        . $(/usr/local/bin/brew --prefix)/share/bash-completion/bash_completion
    fi
fi

PS1="\[\033[0;33m\][\h]\[\033[0;32m\][\w]\[\033[0m\]\[\033[\[\033[0;33m\]\[\033[0;\$(branch_color)m\]\$(print_branch_name)\[\033[0;37m\][NYC - \$(NYC_time)]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"

function mdless {
    if [ ! -f "$1" ]; then
        echo "File not found!"
    else
        pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
    fi
}

function weather() {
  curl "http://wttr.in"
}

source ~/.git-completion.bash
alias supa="lpass show --password github.shuttercorp.net | pbcopy"
