#! /bin/bash

_INSTALL="$HOME/.local"
_INSTALL_BIN="$_INSTALL/bin"
mkdir -p "$_INSTALL_BIN"
pushd "$_INSTALL_BIN" && export PATH="$PATH:$_INSTALL_BIN" && curl -O "https://raw.githubusercontent.com/RichiH/vcsh/main/vcsh" && chmod +x "$_INSTALL_BIN/vcsh"
popd

vcsh clone git@github.com:erichdongubler-dotfiles/base.git

echo "Done! If you're in bash, the run \`. ~/.bash_profile\`."
