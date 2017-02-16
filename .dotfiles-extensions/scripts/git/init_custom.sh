git_init_custom () {
	local TEMPLATES_DIRECTORY="$HOME/.dotfiles-extensions/templates/git"

	if ! [ -d "$TEMPLATES_DIRECTORY" ]; then
		echo "No templates directory found at \"$TEMPLATES_DIRECTORY\""
		exit 1
	fi
	for template in "$@"; do
		local template_directory="$TEMPLATES_DIRECTORY/$1"
		if ! [ -d "$template_directory" ]; then
			echo "ERROR: unable to find template directory \"$template_directory\""
			continue
		fi
	done

	function replace_project_template() {
		find . \( -path "./.git" \) -prune -o -type f -exec sed -i "s/\$PROJECT/$project_name/g" '{}' \;
	}

	git init
	read -p "Enter the name of your project: " project_name
	for template in "$@"; do
		local template_directory=`echo "$TEMPLATES_DIRECTORY/$template"| sed 's/\/\//\//'`
		cp -r "$template_directory"/. .
		replace_project_template

		local template_script="$template_directory.sh"
		if [ -f "$template_script" ]; then
			. "$template_script"
		fi
	done
	git init-commit

	unset git_init_template
	unset replace_project_template
}

git_init_custom "$@"

