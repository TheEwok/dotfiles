#!/usr/bin/env bash
export PATH=/usr/local/bin:$PATH
cat <<- EOF >> $HOME/.bash_profile
if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi
EOF

# Install Brew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew doctor
brew update

# Brew recipes
brew install git

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

echo "****"
echo "Don't forget to source .bashrc"
