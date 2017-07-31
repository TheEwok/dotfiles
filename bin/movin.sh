#!/usr/bin/env bash

# Get teh dotfiles
git clone git@github.com:TheEwok/dotfiles.git
cd dotfiles

# Run correct target
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  make movein_osx; 
else
  make movein;
fi

