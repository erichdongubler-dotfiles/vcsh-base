. "$XDG_CONFIG_HOME/sh/common.sh"

if [[ $- == *l* ]]; then
    .login
	.reload_login_extensions sh bash
fi

[[ $- != *i* ]] && return

.reload_interactive_extensions sh bash
