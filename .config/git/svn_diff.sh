 git diff --no-prefix "$@" | awk '

/^diff --git/ {
	print "Index: " $3
	current_file=$3
	next
}

/^index/ {
	print "==================================================================="
	next
}

/^new file mode/ {
	next
 }

/^--- [^/]/ {
	cmd = "git svn find-rev $(git branch -r --merged HEAD)"
	cmd | getline latest_revision
	printf ("%s\t(revision %s)\n", $0, latest_revision)
	next
}

/^\\+\\+\\+/ {
	printf("%s\t(working copy)\n", $0)
	next
}

/^--- [/]/ {
	printf("--- %s\t(revision 0)\n", current_file)
	next
}

{
	print
}
 '
