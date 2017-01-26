function ssh-add-github-access () {
	if [ $# -eq 0 ]; then
		echo "No arguments supplied"
		exit 1
	fi

	AUTHORIZED_KEYS="$HOME/.ssh/authorized_keys"
	for github_username; do
		echo "Adding Github access for user \"$github_username\" to this local user (\"$USERNAME\")"
		echo "# BEGIN Github account \"$github_username\"" >> "$AUTHORIZED_KEYS"
		curl "https://github.com/$github_username.keys" >> "$AUTHORIZED_KEYS"
		echo -e "# END Github account \"$github_username\"\n" >> "$AUTHORIZED_KEYS"
	done
}

