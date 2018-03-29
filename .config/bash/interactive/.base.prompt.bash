__custom_ps1 () {
	local DEFAULT_COLOR="\[\033[00m\]"
	local RED_BOLD="\[\033[1;31m\]"
	local YELLOW_BOLD="\[\033[1;33m\]"
	local GREEN_BOLD="\[\033[1;32m\]"
	local BLUE_BOLD="\[\033[1;34m\]"

	__previous_result="$?";

	# git branch name
	local git_branch="$(git rev-parse --abbrev-ref HEAD 2> /dev/null)"
	local git_color=${RED_BOLD}
	local git_prompt=""
	if [[ $git_branch ]]; then
		git_prompt=" $git_color$git_branch";
        if [[ $VCSH_REPO_NAME ]]; then
        	git_prompt="$git_prompt (vcsh: $VCSH_REPO_NAME)"
        fi
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

export PROMPT_COMMAND=__custom_ps1
export PROMPT_DIRTRIM=3
