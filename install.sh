#!/usr/bin/env bash

fancy_echo() {
  local fmt="$1"; shift
  printf "\n$fmt\n" "$@"
}

fancy_echo "This script will setup your laptop"
fancy_echo "If you want to reuse your old SSH key, copy your SSH config over before running this script"
fancy_echo "During installation, it will ask for your sudo password a few times"

# Get name and email
fancy_echo "Before we start we need some basic details of you"
read -p "What is your full name? (e.g. Johnny Appleseed): " full_name
read -p "What is your email address? (e.g. johnny.appleseed@dockyard.com): " email_address

fancy_echo "Hello $full_name <$email_address>"

fancy_echo "Press enter to start the installation process, press <CTRL + C> to cancel"
read

if [ -f ~/.ssh/id_rsa ]
then
  fancy_echo "Skipping SSH key generation, you already have one"
else
  fancy_echo "Generating SSH key"
  ssh-keygen -q -t rsa -b 4096 -C "$email_address" -N "" -f ~/.ssh/id_rsa
fi

cat ~/.ssh/id_rsa.pub | pbcopy
fancy_echo "\nCopyied public key to clipboard, please add it to your Github account."

copy_dotfile() {
  if [ -f ~/${1} ]
  then
    diff=$(diff -u ~/${1} ./dotfiles/${1})
    if [[ $(echo "$diff" | wc -l) -gt 1 ]]
    then
      printf "Updating %s\n" "$1"
      printf "Changes:\n"
      printf "\n$diff\n\n"
      mv ~/${1} ~/${1}.backup$(date +%s)
    else
     printf "Copying %s\n" "$1"
    fi
    unset diff
  fi

  cp ./dotfiles/${1} ~/${1}
}

fancy_echo "Copying dotfiles!"
copy_dotfile ".aliases"
copy_dotfile ".agignore"
copy_dotfile ".ackrc"
copy_dotfile ".exports"
copy_dotfile ".editorconfig"
copy_dotfile ".gitconfig"
copy_dotfile ".gitignore"
copy_dotfile ".tmux.conf"
copy_dotfile ".vimrc"
copy_dotfile ".zshrc"
copy_dotfile "Brewfile"

fancy_echo "Do 'rm ~/*.backup*' to cleanup the backed up dotfiles"

fancy_echo "Creating folder ~/Projects"
mkdir -p ~/Projects

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Brew"
  curl -fsS \
    'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby >> out.log 2>&1
else
  fancy_echo "Updating Brew ..."
  brew update >> out.log 2>&1
fi

brew tap Homebrew/bundle >> out.log 2>&1
fancy_echo "Installing Brew packages"
brew bundle --file=~/Brewfile >> out.log 2>&1

yarn_install() {
  yarn global add "$@" >> out.log 2>&1
}

fancy_echo "Installing OH-MY-ZSH"
git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh >> out.log 2>&1

fancy_echo "Installing global Node packages with Yarn"
yarn_install 'bower'
yarn_install 'phantomjs'
yarn_install 'ember-cli'
yarn_install 'nombom'
yarn_install 'jshint'
yarn_install 'eslint'

fancy_echo "Installing Phoenix Framework"
mix local.hex --force >> out.log 2>&1
mix archive.install --force https://github.com/phoenixframework/archives/raw/master/phoenix_new.ez >> out.log 2>&1

fancy_echo "Installing Vim plugins"
mkdir -p ~/.vim/bundle >> out.log 2>&1
git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim
. ~/.vim/bundle/neobundle.vim/bin/neoinstall >> out.log 2>&1

fancy_echo "Configuring name and email in .gitconfig"
git config --global user.name "$full_name"
git config --global user.email "$email_address"

fancy_echo "Turning on ZSH"
chsh -s /bin/zsh

fancy_echo "\n\n\nDone!"

fancy_echo "You might need to restart your terminal"
