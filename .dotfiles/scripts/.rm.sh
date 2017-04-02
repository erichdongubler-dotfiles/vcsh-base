#! /bin/bash

case "$DOTFILES_OS" in
	"darwin")
		;;
	*)
		alias rm=' timeout 3 rm -Iv --one-file-system'
		;;
esac

