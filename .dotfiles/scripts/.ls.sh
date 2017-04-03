#! /bin/bash

case "$DOTFILES_OS" in
	"darwin")
		export CLICOLOR=1
		alias ll='ls -l --time-style='"'+%d-%m-%Y %H:%M:%S'"
		alias la='ls -A'
		alias l.='ls .!(|.)'
		;;
	*)
		eval $(dircolors -b)
		alias ls='ls --color=auto'
		alias ll='ls -l --color=auto --time-style='"'+%d-%m-%Y %H:%M:%S'"
		alias la='ls --color=auto -A'
		alias l.='ls --color=auto .!(|.)'
		;;
esac

