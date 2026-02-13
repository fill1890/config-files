HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e

zmodload -i zsh/complist
autoload -Uz compinit && compinit
#zstyle :compinstall filename '/Users/kaz/config/zsh/.zshrc'
zstyle ':completion:*' menu select=5

alias ls='ls -Ghl'
alias git-yolo='git commit -am "`curl -s http://whatthecommit.com/index.txt`"'
alias vim='nvim'
alias e='nvim'
alias decolor='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g"'
alias source-idf='source ~/.local/share/esp-idf/export.sh'
alias tnl='sshuttle -r local.friendssmp.net 0/0'

export EDITOR='nvim'
export AWS_PROFILE='KazacosAI-Admin'

export PATH="/opt/local/bin:$PATH"
export PATH="/opt/local/lib/ImageMagick7/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="$HOME/.local/share/flutter/bin/:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export fpath=(~/.local/share/zsh/site-functions/ $fpath)

export DISPLAY=":0"

local BRANCH_FMT='%K{green}\ue0b0%F{black}%b\ue0a0%F{green}'

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats $BRANCH_FMT
zstyle ':vcs_info:*' actionformats $BRANCH_FMT'%K{red}\ue0b0%F{black}%a%F{red}'
setopt prompt_subst

autoload -Uz async && async

_git_info() {
    cd -q $1
    vcs_info
    print $vcs_info_msg_0_
}

_git_info_cb() {
    GITINFO="$(echo $3)"
    zle reset-prompt
}

_git_info_precmd() {
    async_flush_jobs vcs_info
    async_job vcs_info _git_info $PWD
}

pretty_time() {
    if [[ $1 -lt 3 ]]; then
        return;
    elif [[ $1 -lt 60 ]]; then
        printf '%ds' $1
    elif [[ $1 -lt 3600 ]]; then
        printf '%dm%ds' $(($1/60)) $(($1%60))
    else
        printf '%dh%dm' $(($1/3600)) $(($1%3600/60))
    fi
}

async_start_worker vcs_info
async_register_callback vcs_info _git_info_cb

start_time=0
timer=0
function preexec() {
    start_time=$SECONDS
}
function precmd() {
    _git_info_precmd

    RPROMPT=""
    timer="$(pretty_time $(($SECONDS-$start_time)))"
    RPROMPT+=$'%(?..%F{red}\ue0ba%K{red}%F{black}%?%k%F{red}\ue0bc%f)'
    [[ -n $timer ]] && RPROMPT+=$' %F{cyan}\ue0b6%K{cyan}%F{black}${timer}%F{cyan}%k\ue0b4%f'
    export RPROMPT

    PROMPT=''
    if [[ -n $VIRTUAL_ENV ]]; then
        if [[ `pwd` == "${VIRTUAL_ENV%/*}"* ]]; then
            PROMPT+=$'%F{magenta}%K{blue}\ue0b0'
        else
            PROMPT+=$'%F{yellow}%K{blue}\ue0b0'
        fi
    else
        PROMPT+=$'%K{blue} '
    fi
    PROMPT+=$'%K{blue}%F{black}%35<\ue0c7<%~%<<%F{blue}'
    PROMPT+='${GITINFO}'
    PROMPT+=$'%k\ue0b0%f '
    export PROMPT
}

git_branch() {
    git rev-parse --abbrev-ref HEAD 2>/dev/null
}

# export PS1="\[${COL}\][\u@\h \[\e[0m\]\[\e[0;34m\] \w\[\e[0m\]\[${COL}\]\[\e[0m\]\[${COL}\]]\$ \[\e[0m\]"

aws-tunnel() {
    ssh -TND 4711 ec2-user@$1 -i ~/.ssh/msb-pem.pem -o ProxyCommand='aws ec2-instance-connect open-tunnel --instance-id %h'
}

man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

if [[ -f /opt/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    source /opt/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    bindkey '^y' autosuggest-accept
    bindkey '^[^M' autosuggest-execute
fi

[[ -f /opt/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] &&
  source /opt/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export CLICOLOR=1
