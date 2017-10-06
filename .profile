function .reload_scripts_from_config() {
	local script_type=${1:?no script type specified}
	shift

	echo -e "  \033[37mReloading $script_type shell extensions...\033[00m"
	for shell_type in $@; do
		local scripts_directory="$XDG_CONFIG_HOME/$shell_type/$script_type"
		if [ -d "$scripts_directory" ]; then
			echo -e "    from \033[1;34m\"$scripts_directory\"\033[00m"
			for file in $(ls "$scripts_directory/."*".$shell_type" 2> /dev/null); do
				if [ -f "$file" ]; then
					. "$file"
				fi
			done
			for file in $(ls "$scripts_directory/"*".$shell_type"  2> /dev/null); do
				if [ -f "$file" ]; then
					echo -e "      \033[37mLoading \033[1;34m${file##*/}\033[00m"
					. "$file"
				fi
			done
		fi
	done
}

function .reload_login_extensions() {
	.reload_scripts_from_config login "$@"
}

function .reload_interactive_extensions() {
	.reload_scripts_from_config interactive "$@"
}

# Some information we may want up front
function .login() {
	echo -e "\033[1;37mLogged in as \033[1;32m$(id -un)\033[1;37m@\033[1;32m$(hostname)\033[00m"
}

export DOTFILES_OS=${OSTYPE//[0-9.]/}
export EDITOR=vim
export HISTFILE="$HOME/.histfile"
export HISTSIZE=1000
export SAVEHIST=1000
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"

export LESSHISTFILE="$XDG_CONFIG_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/keys"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export VISUAL="$EDITOR"

.login
