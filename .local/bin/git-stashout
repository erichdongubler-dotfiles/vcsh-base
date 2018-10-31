#! /bin/bash
branch="${1:?missing branch argument}"
shift

git rev-parse "$branch" > /dev/null 2> /dev/null
if [ $? -ne 0 ]; then
	echo "fatal: \"$branch\" does not seem to be a valid tree-ish"
	exit 1
fi

git stash
if [ $? -eq 0 ]; then
	git checkout "$branch" "$@"
	git stash pop
fi
