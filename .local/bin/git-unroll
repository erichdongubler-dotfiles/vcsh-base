#! /bin/sh

# TODO: Check if the state is dirty

base="${1:?expected invocation of the form <command> <base> <rev-list>...}"
shift

for rev_list in "$@"; do
	rev_list="$(git rev-list "$rev_list" --ancestry-path  --reverse --abbrev-commit)"
	if [ $? -ne 0 ]; then
		exit 1
	fi

	for rev in $rev_list; do
		git checkout -B "explode-$rev" "$base"
		if [ $? -ne 0 ]; then
			exit 1
		fi

		git cherry-pick "$rev"
		if [ $? -ne 0 ]; then
			exit 1
		fi
	done
done
