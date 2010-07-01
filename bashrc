fortune -a | COWPATH=~/.cows cowsay -f $(ls -1 ~/.cows | shuf | tail -1)

# Orange/yellow
# export PS1='\[\e[1;38;5;208m\]-\u@\[\e[0;38;5;184m\]\h \[\e[0;38;5;215m\]\w \[\e[0;0m\]-> \[$NC\]'

# Blue/light blue
# export PS1='\[\e[1;38;5;14m\]-\u@\[\e[0;38;5;45m\]\h \[\e[0;38;5;31m\]\w \[\e[0;0m\]-> \[$NC\]'

# Green/Light green
# export PS1='\[\033[1;38;5;82m\]-\u@\[\033[0;38;5;34m\]\h \[\033[0;38;5;76m\]\w \[\033[0m\]=> '

export PS1='\[$(tput setaf 82)\]-\u-$(tput setaf 191)($(date +%H:%M))\[$(tput setaf 10)\]$(parse_git_branch)\[$(tput sgr0)\] => '

export GREP_COLORS='mt=01;32:fn=01;34'
export PYTHONPATH=/srv/http/nginx/django/:
export PATH=$PATH:/usr/local/bin
export EDITOR=vim
export TERM=xterm-256color
export SDL_VIDEO_FULLSCREEN_HEAD=1      # for fullscreen games using one screen
export _JAVA_AWT_WM_NONREPARENTING=1    # for java apps running correctly with xmonad

eval `cat ~/.dir_colors`

function parse_git_branch {
    git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
# Automatically set up virtualenv inside metropolis directory
# function venv_cd {
#     cd "$@" && [[ $(git branch --no-color 2> /dev/null) ]] && . /srv/http/env-django/bin/activate
# }
# alias cd=venv_cd

set -o vi

. $HOME/.bash_aliases
