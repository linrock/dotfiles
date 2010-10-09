fortune -a | cowsay -f $(ls -1 /usr/share/cows | shuf -n 1)

source ~/.aliases
source /etc/profile

autoload -U colors && colors
autoload -Uz compinit && compinit
autoload -Uz vcs_info
bindkey -v

export HISTFILE=~/.histfile
export HISTSIZE=1000
export SAVEHIST=1000

export PATH="$(cope_path):${PATH}:/usr/local/bin"
export PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python2.6"

export PAGER="less"
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
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr " %F{220}*"
zstyle ':vcs_info:*' stagedstr " %F{226}*"

setopt prompt_subst
setopt correct
setopt appendhistory
setopt noautomenu
setopt listpacked
setopt listtypes
setopt printexitvalue
setopt histignoredups

alias -s txt=$EDITOR
alias -s sh=$EDITOR
alias -s py=$EDITOR
alias -s rb=$EDITOR
alias -s conf=$EDITOR
alias -s html=$EDITOR

#-------------------------
# Term-specific commands
#-------------------------
case $TERM in
    linux)
        export PS1="%{${fg_bold[blue]}%}-%n- %f=> "
        ;;

    rxvt*|screen*)
        source ~/.dir_colors
        export TERM="rxvt-256color"

        # Blue gradient, no curdir
        # export PS1="%F{21}-%n%F{27}@%F{45}%m- %F{158}=> %f"

        # Orange gradient
        export PS1="%F{208}-%n%F{214}@%F{220}%m- %F{229}%d %F{231}=> %f"

        precmd () {
            print -Pn "\e]0;$TERM - %~\a"
            if [[ -z $(git ls-files --other --exclude-standard 2> /dev/null ) ]] {
                zstyle ':vcs_info:*' formats '%F{3}-[%F{10}%b%a%u%F{3}]-%f '
            } else {
                zstyle ':vcs_info:*' formats '%F{3}-[%F{10}%b%a%u%F{208}+%F{3}]-%f '
            }
            vcs_info
            RPROMPT="${vcs_info_msg_0_}"
        }
        preexec () {
            # print -Pn "\e]0;$TERM - %~ ($1)\a"
        }
        ;;
esac

