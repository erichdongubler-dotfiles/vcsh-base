repo_url="${1:?error: expected invocation of the form '<command> <repo_url> [<clone_directory> <other options for `git clone`>]'}"
shift
target_dir="${1:-${repo_url##*/}}"
shift
repo_trunk="$repo_url/trunk"
echo "Making a shallow clone of $repo_trunk into folder $target_dir..."
revision="$(svn info "$repo_trunk" | awk '/^Last Changed Rev:/ { print $4 }')"
echo "  Cloning last changed revision $revision"
git svn clone --stdlayout -r"$revision:HEAD" "$repo_url" "$target_dir" "$@" && pushd "$target_dir" > /dev/null && git reset --hard && popd > /dev/null
