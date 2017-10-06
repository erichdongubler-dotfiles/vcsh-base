#! /bin/bash

case "$DOTFILES_OS" in
	"darwin")
		;;
	*)
		alias rm='rm -Iv --one-file-system'
		;;
esac

