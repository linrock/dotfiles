fortune -a | COWPATH=~/.cows cowsay -f $(ls -1 ~/.cows | shuf | head -1)

autoload -Uz compinit && compinit
bindkey -v

export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000

export PATH="${PATH}:/usr/local/bin"
export BROWSER="firefox"
export TERM="xterm-256color"
export EDITOR="vim"
export PS1=$'%{\e[1;38;5;82m%}-%n-%{\e[1;38;5;191m%}%t %{\e[1;38;5;194m%}=> %{\e[0m%}'

eval `cat ~/.dir_colors`

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

setopt correct
setopt appendhistory
setopt noautomenu
setopt listtypes
setopt printexitvalue

. ~/.aliases
