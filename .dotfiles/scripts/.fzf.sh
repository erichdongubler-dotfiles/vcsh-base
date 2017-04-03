#! /bin/bash

case "$DOTFILES_OS" in
	"msys") ;&
	"cygwin")
		export FZF_DEFAULT_OPTS='--reverse'
		;;
	*)
		export FZF_DEFAULT_OPTS='--height 40% --reverse'
		;;
esac

