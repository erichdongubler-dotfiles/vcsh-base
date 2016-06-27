# .bashrc settings I want everywhere!

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

os=${OSTYPE//[0-9.]/}

#Editor setting, this is important for meee
export EDITOR=vim

#ls colors
case $os in
	"darwin")
		export CLICOLOR=1
		alias ll='ls -l'
	;;
	*)
		eval $(dircolors -b)
		alias ls='ls --color=auto'
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
alias grep='grep -n --color=auto'

# Hook into the dotfiles management
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

#Nice binds for history shortcuts
bind '"\033[A": history-search-backward'
bind '"\033[B": history-search-forward'

# Prompt stuff
function __custom_ps1 () {
	__previous_result="$?";
	__ps1=""

	local git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
	if [[ $git_branch ]]; then
		__ps1="$__ps1 \033[31m$git_branch";
	fi

	local color=""
	case "$__previous_result" in
		0) color="$color\033[1;32m";;
		*) color="$color\033[1;31m";;
	esac
	__ps1="$__ps1$color$ \033[1;00m";
}
PROMPT_DIRTRIM=3
PROMPT_COMMAND=__custom_ps1
PS1='\n\[\033[1;34m\]\w $(echo -e $__ps1)'

# Some information we may want up front
initial_login_print() {
	echo -e "\033[1;37mLogged in as \033[1;32m$USERNAME\033[1;37m@\033[1;32m$(hostname)\033[00m"
}
initial_login_print

# Load extensions
DOTFILES_EXTENSIONS_FOLDER="$HOME/.dotfiles-extensions"
reload_dotfiles_extensions () {
	if [ -d "$DOTFILES_EXTENSIONS_FOLDER" ]; then
		echo -e "\033[1;37mReloading extensions from \033[1;34m\"$DOTFILES_EXTENSIONS_FOLDER\"\033[00m"
		for file in "$DOTFILES_EXTENSIONS_FOLDER"/*.sh; do
			echo -e "\033[1;37mLoading extension \033[1;34m${file##*/}\033[00m"
			. "$file"
		done
	fi
}
reload_dotfiles_extensions
