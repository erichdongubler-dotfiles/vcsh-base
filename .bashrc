# .bashrc settings I want everywhere!

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Editor setting, this is important for meee
export EDITOR=vim

#ls colors
alias ls='ls --color=auto'
eval $(dircolors -b)

#Basic rm safety
alias rm=' timeout 3 rm -Iv --one-file-system'

#Allows us to complete some commands that use...well, other commands
complete -cf sudo
complete -cf man

#Grep colors
alias grep='grep -n --color=auto'

# Hook into the dotfiles management
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

#Nice binds for history shortcuts
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Prompt stuff
function __custom_ps1 () {
	__previous_result="$?";
	__ps1=""

	local git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
	if [[ $git_branch ]]; then
		__ps1="$__ps1 \e[31m$git_branch";
	fi

	local color=""
	case "$__previous_result" in
		0) color="$color\e[32m";;
		*) color="$color\e[31m";;
	esac
	__ps1="$__ps1$color$ \e[00m";
}
PROMPT_DIRTRIM=3
PROMPT_COMMAND=__custom_ps1
PS1='\n\[\e[1;34m\]\w $(echo -e $__ps1)'

# Some information we may want up front
initial_login_print() {
	echo -e "\e[1;37mLogged in as \e[1;32m$USERNAME\e[1;37m@\e[1;32m$(hostname)\e[00m"
}
initial_login_print

# Load extensions
DOTFILES_EXTENSIONS_FOLDER="$HOME/.dotfiles-extensions"
reload_dotfiles_extensions () {
	if [ -d "$DOTFILES_EXTENSIONS_FOLDER" ]; then
		echo -e "\e[1;37mReloading extensions from \e[1;34m\"$DOTFILES_EXTENSIONS_FOLDER\"\e[00m"
		for file in "$DOTFILES_EXTENSIONS_FOLDER"/*.sh; do
			echo -e "\e[1;37mLoading extension \e[1;34m${file##*/}\e[00m"
			. "$file"
		done
	fi
}
reload_dotfiles_extensions
