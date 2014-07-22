#BASHY BASHY GOODNESS!
export PATH=/usr/local/git/bin:$PATH:/usr/local/share/npm/bin/:/Users/Bomahony/dev/scratch/phonegap/android-sdk/platform-tools:/Users/Bomahony/dev/scratch/phonegap/android-sdk/tools:~/dotfiles/bin

export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8

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

alias glog='git log --graph --color'
#A little bit o' silliness
alias sstk="curl -s 'http://download.finance.yahoo.com/d/quotes.csv?s=sstk&f=l1'"

alias dev="cd ~/dev"
alias api="cd ~/dev/shutterstock-audio-api"
alias webapp="cd ~/dev/shutterstock-audio"
alias home="cd ~/dev/home"

alias stash="git stash -a && git stash show -p > /tmp/stash.$(date -u +"%Y-%m-%dT%H:%M:%SZ").diff"

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

alias npmi="npm install"
alias nin=nin
alias ning=ning
alias nind=nind

#Stupid Rock
rock_run() {
    rock --runtime=node010 run "${@}"
}

alias rr=rock_run
#Coz maff iz hurd
NYC_time() {
    echo `env TZ="America/New_York" date "+%H:%M"`
}

#Prompty Goodness
branch_color()  {
    git rev-parse 2>/dev/null;
    if [ $? -eq 0 ]; then
        modifier=`git status | grep clean | wc -l | tr -d ' '`
        color=`expr 31 + $modifier`
        echo $color
    fi
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
