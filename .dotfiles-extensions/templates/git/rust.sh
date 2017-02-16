is_binary=''
while [[ -z $is_binary ]]; do
	read -p "Cargo: [b]inary or [l]ibrary? " is_binary
	case "$is_binary" in
		b )
			cargo init --name "$project_name" --bin
			;;
		l )
			cargo init --name "$project_name"
			;;
		* )
			is_binary=''
			;;
	esac
done

echo 'Cargo.lock' >> .gitignore
