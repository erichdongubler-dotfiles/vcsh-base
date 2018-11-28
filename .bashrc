export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

. "$XDG_CONFIG_HOME/erichdongubler/sh/common.sh"

if [[ $- == *l* ]]; then
	.login
	.reload_login_extensions sh bash
fi

[[ $- != *i* ]] && return

.reload_interactive_extensions sh bash
