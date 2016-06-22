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

function mcd() {
	mkdir -p "$@"
	cd $1	
}

alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


#And finally, the PS1 prompt!
BASIC_GIT_PROMPT="${BASIC_GIT_PROMPT:-$HOME/Scripts/git/git-prompt.sh}"
FANCY_GIT_PROMPT="${FANCY_GIT_PROMPT:-$HOME/.bash-git-prompt/gitprompt.sh}"
FANCY_PS1=false
function set_ps1 {
	if [ $1 ]; then
		if [ $1 = true ] || [ $1 = false ]; then
			echo Setting fanciness to $1
			FANCY_PS1=$1
		else
			echo error: fanciness must be 'true' or 'false'
			return
		fi
	fi
	# Front
	local __user_and_host="\[\e[1;32m\]\u@\h"
	PROMPT_DIRTRIM=3; local __cur_location="\[\e[1;34m\]\w"
	local __ps1_begin="$__user_and_host $__cur_location"

	# End
	local __prompt_tail="\[\e[1;35m\]$"
	local __last_color="\[\e[00m\]"
	local __ps1_end="$__prompt_tail$__last_color "

	# Git stuff
	local __git_color="\[\e[31m\]"
	if [ $FANCY_PS1 = true ] && [ -e $FANCY_GIT_PROMPT ]; then
		[ $@ ] && echo Using fancy prompt!
		GIT_PROMPT_ONLY_IN_REPO=1
		GIT_PROMPT_THEME=Custom
		GIT_PROMPT_START="$__ps1_begin$__last_color"
		GIT_PROMPT_END="$__ps1_end"
		. $FANCY_GIT_PROMPT
	else
		[ $@ ] && echo Using non-fancy prompt!
		# . $BASIC_GIT_PROMPT
		# GIT_PS1_SHOWDIRTYSTATE=true 
		# GIT_PS1_SHOWSTASHSTATE=true
		# GIT_PS1_SHOWUNTRACKEDFILES=true
		# GIT_PS1_SHOWUPSTREAM=auto
		#__ps1_git='$(__git_ps1 " %s")'
		__ps1_git=' $(git rev-parse --abbrev-ref HEAD 2> /dev/null)'
		export PS1="$__ps1_begin$__git_color$__ps1_git $__ps1_end"
	fi
}
set_ps1
