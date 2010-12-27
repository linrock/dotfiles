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

# export PATH="$(cope_path):${PATH}:/usr/local/bin"
export PATH="${PATH}:/usr/local/bin"
export PYTHONPATH="${PYTHONPATH}:/usr/local/lib/python"
export NODE_PATH="${NODE_PATH}:/usr/local/lib/node"

export PAGER="less"
export LESS="-R"
export EDITOR="vim"
export BROWSER="firefox"
export TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S'

export MOZ_DISABLE_PANGO=1

zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BNo matches for: %d%b'
zstyle ':completion:*:functions' ignored-patterns '_*'
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:match:*' original only

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' command 'ps --forest -A -o pid,user,cmd'
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:killall:*' menu yes select
zstyle ':completion:*:killall:*' force-list always

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr " %F{220}*"
zstyle ':vcs_info:*' stagedstr " %F{226}*"

setopt prompt_subst
setopt appendhistory
setopt noautomenu
setopt listpacked
setopt listtypes
setopt printexitvalue
setopt histignoredups
setopt histignorespace
setopt globdots

bindkey "\e[A" history-search-backward
bindkey "\e[B" history-search-forward
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

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
        export PS1="%F{26}-%n%F{25}@%F{33}%m- %F{117}%d %F{15}=> %f"
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

if [ "$PS1" ] ; then
    mkdir -p -m 0700 /dev/cgroup/cpu/user/$$ &> /dev/null
    echo $$ > /dev/cgroup/cpu/user/$$/tasks
    echo 1 > /dev/cgroup/cpu/user/$$/notify_on_release
fi
