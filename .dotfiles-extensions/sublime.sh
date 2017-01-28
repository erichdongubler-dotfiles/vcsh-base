function subl_create_project() {
	read -p "Enter the name of your project: " project_name
	echo "Project name: \"$project_name\""
	project_file=".sublime/$project_name.sublime-project"
	TEMPLATE_FILE="$HOME/.dotfiles-extensions/templates/Project.sublime-project"
	echo "Project file: $project_file"
	mkdir -p .sublime
	sed "s/Project/$project_name/" $TEMPLATE_FILE > "$project_file"
	subl_add_workspaces_to_gitignore
}

function subl_add_workspaces_to_gitignore () {
	local git_ignore_file='.gitignore'
	local workspace_ignore_line='*.sublime-workspace'
	if [ -f .gitignore ] && ! grep -q "$workspace_ignore_line" "$git_ignore_file"; then
		echo "Adding Sublime workspaces to .gitignore"
		echo "$workspace_ignore_line" >> "$git_ignore_file"
	else
		echo ".gitignore didn't exist or Sublime workspace ignore already there"
	fi
}

