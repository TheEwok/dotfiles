alias zaphod='ssh barry.omahony@zaphod.dhcp.beatportcorp.net'
export PATH=$PATH:/usr/local/share/npm/bin/
export PATH=$PATH:/Users/baz/phalcon-tools
export PTOOLSPATH=/Users/baz/phalcon-tools
export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
set -o vi
alias home='ssh home.dogandbonestudios.com'
alias pdev='cd ~/webdev/dev'
alias ll='ls -lGh $@'

platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
       platform='osx'
fi

itunes() {
    state=`osascript -e 'tell application "iTunes" to player state as string'`;
    if [ $state = "playing" ]; then
        artist=`osascript -e 'tell application "iTunes" to artist of current track as string'`;
        track=`osascript -e 'tell application "iTunes" to name of current track as string'`;
        echo "[$artist:  $track]";
    fi
}
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
#PS1="\h \[\033[32m\][\w]\[\033[0m\]\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"  
if [[ $platform == 'osx' ]]; then
    PS1="\[\033[0;33m\][\h]\[\033[32m\][\w]\[\033[0m\]\[\033[\[\033[0;33m\]\[\033[1;\$(branch_color)m\]\$(print_branch_name)\[\033[0;33m\]\$(itunes)\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"
else
    PS1="\[\033[0;33m\][\h]\[\033[32m\][\w]\[\033[0m\]\[\033[\[\033[0;33m\]\[\033[1;\$(branch_color)m\]\$(print_branch_name)\n\[\033[1;36m\]\u\[\033[1;33m\]-> \[\033[0m\]"
fi
