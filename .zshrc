[[ $- != *i* ]] && return # If not running interactively, don't do anything

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
    . ~/.zplug/init.zsh && zplug update --self
else
    . ~/.zplug/init.zsh
fi

# Make zplug manage itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# `compinit` should be one of the first things here
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit
compinit

.reload_scripts zsh

.reload() {
	. ~/.zshrc
}

# Custom keybinds
#   History search
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
# FIXME: These could maybe use zkbd or terminfo? Is it slow, maybe?
bindkey -e
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char
#   Make Alt-Backspace delete words, as opopsed to Ctrl-W's Words (think Vim)
backward-kill-dir () {
    local WORDCHARS="${WORDCHARS:s#/#}"
    local WORDCHARS="${WORDCHARS:s#\.#}"
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir
#   Enable the emacs mode editor shortcut
autoload -U edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line
#   Do open/close delimiter completion
zplug "hlissner/zsh-autopair", defer:1

# Completions menu and some command validation while typing
zstyle ':completion:*' menu select
zplug "zdharma/fast-syntax-highlighting"

# Nicer file management
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zplug "supercrabtree/k"
alias ll="k"

# tmux integration
zplug "jreese/zsh-titles"

autoload -U colors && colors
export PROMPT_SUBST='yes'
export PROMPT=$'\n'"%{%B%F{blue}%}%(4~|%-1~/…/%2~|%3~)%{%(?.%F{green}.%F{yellow})%}$%{%B$reset_color%} "

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

zplug load
