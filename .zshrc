
export AUTO_TITLE_SCREENS="NO"

export PROMPT="
%{$fg[white]%}(%D %*) <%?> [%~] $program %{$fg[default]%}
%{$fg[cyan]%}%m %#%{$fg[default]%} "

export RPROMPT=

set-title() {
    echo -e "\e]0;$*\007"
}

ssh() {
    set-title $*;
    /usr/bin/ssh -2 $*;
    set-title $HOST;
}

alias e=emacs
alias bb=brazil-build

if [ -f ~/.zshrc-dev-dsk-post ]; then
    source ~/.zshrc-dev-dsk-post
fi

export PATH=$HOME/.toolbox/bin:$PATH

export PATH="/apollo/env/AmazonAwsCli/bin/:$PATH"

##alias vim='/apollo/env/envImprovement/bin/vim'


autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

### history file config
HISTFILE=~/.zsh_history
HISTSIZE=999999999
SAVEHIST=$HISTSIZE
setopt APPEND_HISTORY

### better tab completion
autoload -U compinit
compinit
# case insensitive
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'


### some aliases
alias cl='clear'
alias vi='nvim; reset-cursor && cl'
alias vim='nvim; reset-cursor && cl'
alias ls='ls -GFh'

