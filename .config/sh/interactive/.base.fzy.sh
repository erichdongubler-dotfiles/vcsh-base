case "$DOTFILES_OS" in
	"msys"*)
		alias vzy='fd --color never | fzy | ifne xargs -d '"'\n'"' cygpath -u | ifne xargs vim; stty sane'
		;;
	*)
		alias vzy='fd --color never | fzy | ifne xargs vim; stty sane'
		;;
esac
