#!/usr/bin/env bash

DOTFILESDIR = "${HOME}/.dotfiles"

pushd $DOTFILESDIR
shopt -s dotglob

for file in *
do
  if [ $file != .git ]; then
    echo "Linking $file to $HOME/$file"
    ln -s $CONFIG_DIR/$file $HOME/$file
  else
    echo "Not linking the .git folder"
  fi
done
popd
