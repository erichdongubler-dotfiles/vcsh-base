#! /bin/bash

case "$DOTFILES_OS" in
	"msys") ;&
	"cygwin")
		;;
	*)
		function .fzf() {
			pushd "$DOTFILES_SCRIPT_DIRECTORY" > /dev/null
			ls */**.sh | fzf
			popd > /dev/null
		}

		function .source() {
			local script="$(.fzf)"
			if [ -f "$script" ]; then
				echo "Sourcing dotfiles script \"$script\""
				pushd "$DOTFILES_SCRIPT_DIRECTORY" > /dev/null
				. "$script"
				popd "$DOTFILES_SCRIPT_DIRECTORY" > /dev/null
			else
				echo "No script selected (output was \"$script\")"
			fi
		}
		alias ..='.source'

		function .ln() {
			local script="$(.fzf)"
			if [ -f "$script" ]; then
				echo "Linking dotfiles script \"$script\""
				pushd "$DOTFILES_SCRIPT_DIRECTORY" > /dev/null
				ln -s "$script"
				. "$script"
				popd "$DOTFILES_SCRIPT_DIRECTORY" > /dev/null
			else
				echo "No script selected (output was \"$script\")"
			fi

		}
		;;
esac

