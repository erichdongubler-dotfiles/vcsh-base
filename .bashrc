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

# Extract Swiss-Army knife
function extract {
 if [ -z "$1" ]; then
	# display usage if no parameters given
	echo "Usage: extract ."
 else
	if [ -f $1 ] ; then
		# NAME=${1%.*}
		# mkdir $NAME && cd $NAME
		case $1 in
		  *.tar.bz2)   tar xvjf ../$1    ;;
		  *.tar.gz)    tar xvzf ../$1    ;;
		  *.tar.xz)    tar xvJf ../$1    ;;
		  *.lzma)      unlzma ../$1      ;;
		  *.bz2)       bunzip2 ../$1     ;;
		  *.rar)       unrar x -ad ../$1 ;;
		  *.gz)        gunzip ../$1      ;;
		  *.tar)       tar xvf ../$1     ;;
		  *.tbz2)      tar xvjf ../$1    ;;
		  *.tgz)       tar xvzf ../$1    ;;
		  *.zip)       unzip ../$1       ;;
		  *.Z)         uncompress ../$1  ;;
		  *.7z)        7z x ../$1        ;;
		  *.xz)        unxz ../$1        ;;
		  *.exe)       cabextract ../$1  ;;
		  *)           echo "extract: '$1' - unknown archive method" ;;
		esac
	else
		echo "$1 - file does not exist"
	fi
fi
}

# Prompt stuff
function __custom_ps1 () {
	__previous_result="$?";
	__ps1=""

	local git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
	if [[ $git_branch ]]; then
		__ps1="$__ps1 \e[31m$git_branch";
	fi

	local code=" \e[1;35m"
	case "$__previous_result" in
		0) code="$code$>";;
		*) code="$code[$__previous_result]>";;
	esac
	__ps1="$__ps1$code \e[00m";
}
PROMPT_DIRTRIM=3
PROMPT_COMMAND=__custom_ps1
PS1='\[\e[1;34m\]\w $(echo -e $__ps1)'

# Some information we may want up front
initial_login_print() {
	echo -e "Logged in as \e[1;32m$USERNAME\e[1;37m@\e[1;32m$(hostname)\e[00m"
}
initial_login_print
