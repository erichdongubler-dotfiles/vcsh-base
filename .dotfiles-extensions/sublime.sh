function subl_create_project() {
	read -p "Enter the name of your project: " project_name
	echo "Project name: \"$project_name\""
	project_file=".sublime/$project_name.sublime-project"
	TEMPLATE_FILE="$HOME/.dotfiles-extensions/templates/Project.sublime-project"
	echo "Project file: $project_file"
	mkdir -p .sublime
	sed "s/Project/$project_name/" $TEMPLATE_FILE > "$project_file"
}
