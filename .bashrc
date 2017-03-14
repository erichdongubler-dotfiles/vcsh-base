# .bashrc settings I want everywhere!

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

os=${OSTYPE//[0-9.]/}

alias bashrc='vim $HOME/.bashrc'

#Editor setting, this is important for meee
export EDITOR=vim
alias :q='exit'
alias vimrc='vim $HOME/.vimrc'

#ls colors
case $os in
	"darwin")
		export CLICOLOR=1
		alias ll='ls -l --time-style='"'+%d-%m-%Y %H:%M:%S'"
	;;
	*)
		eval $(dircolors -b)
		alias ls='ls --color=auto'
		alias ll='ls -l --color=auto --time-style='"'+%d-%m-%Y %H:%M:%S'"
	;;
esac

#Basic rm safety
case $os in
        "darwin") ;;
        *)
		alias rm=' timeout 3 rm -Iv --one-file-system'
        ;;
esac

#Allows us to complete some commands that use...well, other commands
complete -cf sudo
complete -cf man

#Grep colors
alias grep='grep --color=auto'

# Hook into the dotfiles management
alias dotfiles='git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME'

#Nice binds for history shortcuts
bind '"\033[A": history-search-backward'
bind '"\033[B": history-search-forward'

# Prompt stuff
DEFAULT_COLOR="\[\033[00m\]"
RED_BOLD="\[\033[1;31m\]"
YELLOW_BOLD="\[\033[1;33m\]"
GREEN_BOLD="\[\033[1;32m\]"
BLUE_BOLD="\[\033[1;34m\]"
function __custom_ps1 () {
	__previous_result="$?";

	# git branch name
	local git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
	local git_color=${RED_BOLD}
	local git_prompt=""
	if [[ $git_branch ]]; then
		git_prompt=" $git_color$git_branch";
	fi

	# Colored $ depending on error code
	local dollar=""
	case "$__previous_result" in
		0) dollar="${GREEN_BOLD}";;
		*) dollar="${YELLOW_BOLD}";;
	esac
	dollar="$dollar\$"

	local path="${BLUE_BOLD}\w"
	PS1="\n$path$git_prompt$dollar${DEFAULT_COLOR} "
}
PROMPT_DIRTRIM=3
PROMPT_COMMAND=__custom_ps1

# Some information we may want up front
initial_login_print() {
	echo -e "\033[1;37mLogged in as \033[1;32m$(id -un)\033[1;37m@\033[1;32m$(hostname)\033[00m"
}
initial_login_print

DOTFILES_DIRECTORY="$HOME/.dotfiles"
export DOTFILES_DIRECTORY

# Load extension scripts
DOTFILES_SCRIPTS_DIRECTORY="$DOTFILES_DIRECTORY/scripts/"
export DOTFILES_SCRIPTS_DIRECTORY
reload_dotfiles_extension_scripts () {
	if [ -d "$DOTFILES_SCRIPTS_DIRECTORY" ]; then
		echo -e "\033[37mReloading extensions from \033[1;34m\"$DOTFILES_SCRIPTS_DIRECTORY\"\033[00m"
		for file in "$DOTFILES_SCRIPTS_DIRECTORY"/*.sh; do
			echo -e "  \033[37mLoading \033[1;34m${file##*/}\033[00m"
			. "$file"
		done
	fi
}
reload_dotfiles_extension_scripts

