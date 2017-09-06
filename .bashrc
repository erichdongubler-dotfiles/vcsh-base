[[ $- != *i* ]] && return # If not running interactively, don't do anything

# Variables that subscripts can expect to be present
export DOTFILES_DIRECTORY="$HOME/.dotfiles"
export DOTFILES_OS=${OSTYPE//[0-9.]/}

# Hook into the dotfiles management
alias .git='git --git-dir="$DOTFILES_DIRECTORY.git/" --work-tree="$HOME"'

# Some information we may want up front
.login() {
	echo -e "\033[1;37mLogged in as \033[1;32m$(id -un)\033[1;37m@\033[1;32m$(hostname)\033[00m"
}
.login


# Load extension scripts
export DOTFILES_SCRIPTS_DIRECTORY="$DOTFILES_DIRECTORY/scripts/"

if [ -d "$DOTFILES_SCRIPTS_DIRECTORY" ]; then
	echo -e "\033[37mReloading extensions from \033[1;34m\"$DOTFILES_SCRIPTS_DIRECTORY\"\033[00m"
	for file in "$DOTFILES_SCRIPTS_DIRECTORY"/.*.sh; do
		if [ -f "$file" ]; then
			. "$file"
		fi
	done
	for file in "$DOTFILES_SCRIPTS_DIRECTORY"/*.sh; do
		if [ -f "$file" ]; then
			echo -e "  \033[37mLoading \033[1;34m${file##*/}\033[00m"
			. "$file"
		fi
	done
fi

.reload() {
	. ~/.bashrc
}
