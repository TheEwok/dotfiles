#!/usr/bin/env bash
export PATH=/usr/local/bin:$PATH
cat <<- EOF >> $HOME/.bash_profile
# Set CLICOLOR if you want Ansi Colors in iTerm2 
export CLICOLOR=1

# Set colors to match iTerm2 Terminal Colors
export TERM=xterm-256color

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
