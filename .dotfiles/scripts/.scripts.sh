#! /bin/bash

case "$DOTFILES_OS" in
	"msys") ;&
	"cygwin")
		;;
	*)
		function fuzzy_find_dotfiles_script() {
			pushd "$DOTFILES_SCRIPT_DIRECTORY" > /dev/null
			ls */**.sh | fzf
			popd > /dev/null
		}

		function dotfiles_source() {
			local script="$(fuzzy_find_dotfiles_script)"
			if [ -f "$script" ]; then
				echo "Sourcing dotfiles script \"$script\""
				pushd "$DOTFILES_SCRIPT_DIRECTORY" > /dev/null
				. "$script"
				popd "$DOTFILES_SCRIPT_DIRECTORY" > /dev/null
			else
				echo "No script selected (output was \"$script\")"
			fi
		}

		function dotfiles_link() {
			local script="$(fuzzy_find_dotfiles_script)"
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

		alias .source='dotfiles_source'
		alias .link='dotfiles_link'
		;;
esac

