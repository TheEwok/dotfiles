function gpull() {
	git pull origin $1
}

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

ttfb() {
  curl -s -o /dev/null -w "Connect: %{time_connect} TTFB: %{time_starttransfer} Total time: %{time_total} \n" $1
}

mdless() {
    if [ ! -f "$1" ]; then
        echo "File not found!"
    else
        pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
    fi
}

function weather() {
  curl "http://wttr.in"
}

branch_color()  {
    git rev-parse 2>/dev/null;
    if [ $? -eq 0 ]; then
        modifier=`git status | grep clean$ | wc -l | tr -d ' '`
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
