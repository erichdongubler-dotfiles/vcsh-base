#! /bin/bash

_INSTALL="$HOME/.local"
_INSTALL_BIN="$_INSTALL/bin"
mkdir "$_INSTALL" && mkdir "$_INSTALL_BIN"
pushd "$_INSTALL_BIN" && export PATH="$PATH:$_INSTALL_BIN" && curl -O "https://raw.githubusercontent.com/RichiH/vcsh/master/vcsh" && cd && vcsh --help
popd

vcsh clone git@github.com:erichdongubler-dotfiles/base.git

echo 'Done! If you're in bash, the run \`. ~/.bash_profile\`.'
