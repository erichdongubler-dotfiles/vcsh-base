#! /bin/sh

git branch "$@" | awk '/^\*/ { print $2; next } { print $1; }'
