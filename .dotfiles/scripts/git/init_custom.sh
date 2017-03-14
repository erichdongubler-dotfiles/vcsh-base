git_init_custom () {
	local TEMPLATES_DIRECTORY="$DOTFILES_DIRECTORY/templates/git"

	if ! [ -d "$TEMPLATES_DIRECTORY" ]; then
		echo "ERROR: No templates directory found at \"$TEMPLATES_DIRECTORY\""
		exit 1
	fi

	git init
	echo ".tags" >> .gitignore
	read -p "Enter the name of your project: " project_name
	for template in "$@"; do
		local template_directory=`echo "$TEMPLATES_DIRECTORY/$template"| sed 's/\/\//\//'`
		if [ -d "$template_directory" ]; then
			cp -r "$template_directory" .
		fi

		find . \( -path "./.git" \) -prune -o -type f -exec sed -i "s/\$PROJECT/$project_name/g" '{}' \; # Replace $PROJECT placeholders in the template

		local template_script="$template_directory.sh"
		if [ -f "$template_script" ]; then
			. "$template_script"
		fi
	done
	git init-commit
}

git_init_custom "$@"

