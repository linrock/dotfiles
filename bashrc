fortune -a | cowsay -f $(ls -1 /usr/share/cows | shuf -n 1)

# Orange/yellow
# PS1='\[\e[1;38;5;208m\]-\u@\[\e[0;38;5;184m\]\h \[\e[0;38;5;215m\]\w \[\e[0;0m\]-> \[$NC\]'

# Blue/light blue
# PS1='\[\e[1;38;5;14m\]-\u@\[\e[0;38;5;45m\]\h \[\e[0;38;5;31m\]\w \[\e[0;0m\]-> \[$NC\]'

# Green/Light green
# PS1='\[\033[1;38;5;82m\]-\u@\[\033[0;38;5;34m\]\h \[\033[0;38;5;76m\]\w \[\033[0m\]=> '

export GREP_COLORS='mt=01;32:fn=01;34'
export PATH=$PATH:/usr/local/bin
export BROWSER=firefox
export EDITOR=vim

case $TERM in
    linux)
        PS1='\[\e[1;34m\]-\u@\h \W[\e[0;0m\] -> '
        ;;

    rxvt*)
        TERM=xterm-256color
        PS1='\[$(tput setaf 82)\]-\u-$(tput setaf 191)($(date +%H:%M))\[$(tput setaf 10)\]$(parse_git_branch)\[$(tput sgr0)\] => '
        ;;        
esac

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

set -o vi

source $HOME/.dir_colors
source $HOME/.aliases
