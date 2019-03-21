#! /bin/sh

# TODO: Check if the state is dirty

current_branch="$(git rev-parse --abbrev-ref HEAD)"
if [ current_branch == "HEAD" ]; then
	echo "fatal: can't roll up when not on a branch"
fi

current_branch_rollup="$current_branch-rollup"
git rev-parse --abbrev-ref HEAD
if [ $? -eq 0 ]; then
	echo "fatal: branch \"$current_branch_rollup\" already exists"
fi

git checkout -B "$current_branch_rollup"
if [ $? -eq 0 ]; then
	for branch in "$@"; do
		rollup_branch="$current_branch_rollup-$branch"
		git checkout -B "$rollup_branch" "$branch"
		if [ $? -eq 0 ]; then
			git rebase "$current_branch_rollup"
			if [ $? -ne 0 ]; then
				exit 1
			fi
			git checkout "$current_branch_rollup"
			git merge "$rollup_branch"
			git branch -D "$rollup_branch"
		fi
	done
fi

git checkout "$current_branch" && git merge "$current_branch_rollup" && git branch -D "$current_branch_rollup"
if [ $? -ne 0 ]; then
	exit 1
fi
