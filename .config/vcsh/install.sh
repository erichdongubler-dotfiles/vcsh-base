#! /bin/bash

_INSTALL="$HOME/.installed"
_INSTALL_BIN="$_INSTALL/bin"
mkdir "$_INSTALL" && mkdir "$_INSTALL_BIN"
pushd "$_INSTALL_BIN" && export PATH="$PATH:$_INSTALL_BIN" && curl -O "https://raw.githubusercontent.com/RichiH/vcsh/master/vcsh" && cd && vcsh --help
popd

declare -A _BASE_REPOS=(["dotfiles"]="erichdongubler/.dotfiles")
for _repo_name in "${!_BASE_REPOS[@]}"; do
	_repo_path="${_BASE_REPOS[$_repo_name]}"
	echo "Cloning dotfiles repo \"$_repo_name\" from \"$_repo_path\""
	vcsh clone https://github.com/"$_repo_path" "$_repo_name"
	_vcsh='vcsh run "$_repo_name"'
	$_vsch git config status.showUntrackedFiles no # Don't show any untracked files when we do `git status`

echo 'Sourcing ~/.bash_profile...'
. ~/.bash_profile

echo "Installing TPM plugins..."
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins
