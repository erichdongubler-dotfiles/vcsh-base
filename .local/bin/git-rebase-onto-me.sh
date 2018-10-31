#! /bin/sh

current_branch="$(git rev-parse --abbrev-ref HEAD)"
if [ current_branch == "HEAD" ]; then
	echo "fatal: can't roll up when not on a branch"
fi

for branch in "$@"; do
	git merge-base --is-ancestor "$current_branch" "$branch"
	if [ $? -eq 0 ]; then
		continue
	fi

	git checkout "$branch" && git rebase "$current_branch"
	if [ $? -ne 0 ]; then
		exit $?
	fi
done

git checkout "$current_branch"

if [ $? -ne 0 ]; then
	exit $?
fi
