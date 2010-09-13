fortune -a | cowsay -f $(ls -1 /usr/share/cows | shuf -n 1)

source ~/.aliases
source /etc/profile

autoload -Uz compinit && compinit
autoload -Uz vcs_info
bindkey -v

export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000

export PATH="$(cope_path):${PATH}:/usr/local/bin"
export PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python2.6"

export EDITOR="vim"
export BROWSER="firefox"
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats '%F{3}-[%F{10}%b%a%u%F{3}]-%f '
zstyle ':vcs_info:*' actionformats '%F{3}-[%F{2}%b%F{10}|%F{10}%a%u%F{3}]-%f '
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr " *"
zstyle ':vcs_info:*' stagedstr " +"

setopt correct
setopt appendhistory
setopt noautomenu
setopt listtypes
setopt printexitvalue
setopt histignoredups

#-------------------------
# Term-specific commands
#-------------------------
case $TERM in
    linux)
        export PS1=$'%{\e[1;36m%}-%n- %{\e[0m%}=> '
        ;;

    rxvt*)
        source ~/.dir_colors
        export TERM="rxvt-256color"
        export PS1="%F{202}-%n-%F{220}%t %F{229}=> %F{15}"
        precmd () {
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
            vcs_info
            RPROMPT="${vcs_info_msg_0_}"
        }
        preexec () {
            print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
        }
        ;;
esac
