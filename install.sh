#!/usr/bin/env bash

fancy_echo() {
  printf "\n%s\n" "$1"
}

fancy_echo "This script will setup your laptop"
fancy_echo "If you want to reuse your old SSH key, copy your SSH config over before running this script"
fancy_echo "During installation, it may ask for your sudo password."

# Get name and email
fancy_echo "Before we start we need some basic details of you"
read -r -p "What is your full name? (e.g. Johnny Appleseed): " full_name
read -r -p "What is your email address? (e.g. johnny.appleseed@dockyard.com): " email_address

fancy_echo "Hello $full_name <$email_address>"

fancy_echo "Press enter to start the installation process, press <CTRL + C> to cancel"
read -r

if [ -f ~/.ssh/id_ed25519 ]
then
  fancy_echo "Skipping SSH key generation, you already have one"
else
  fancy_echo "Generating SSH key"
  ssh-keygen -q -t ed25519 -C "$email_address" -N "" -f ~/.ssh/id_ed25519
fi

< ~/.ssh/id_ed25519.pub pbcopy
fancy_echo "Copyied public key to clipboard, please add it to your Github account."

copy_dotfile() {
  if [ -f ~/"${1}" ]
  then
    diff=$(diff -u ~/"${1}" ./dotfiles/"${1}")
    if [[ $(echo "$diff" | wc -l) -gt 1 ]]
    then
      printf "Updating %s\n" "$1"
      printf "Changes:\n"
      printf "\n%s\n\n" "$diff"
      mv ~/"${1}" ~/"${1}".backup"$(date +%s)"
    else
      printf "Copying %s\n" "$1"
    fi
    unset diff
  fi

  cp ./dotfiles/"${1}" ~/"${1}"
}

copy_zshfile() {
  if [ -f ~/.oh-my-zsh/custom/"${1}" ]
  then
    if [[ $(echo "$diff" | wc -l) -gt 1 ]]
    then
      printf "Updating %s\n" "$1"
      printf "Changes:\n"
      printf "\n%s\n\n" "$diff"
      mv ~/.oh-my-zsh/custom/"${1}" ~/.oh-my-zsh/custom/"${1}".backup"$(date +%s)"
    else
      printf "Copying %s\n" "$1"
    fi
    unset diff
  fi

  cp ./zshfiles/"${1}" ~/.oh-my-zsh/custom/"${1}"
}

fancy_echo "Copying dotfiles!"
copy_dotfile ".ackrc"
copy_dotfile ".agignore"
copy_dotfile ".editorconfig"
copy_dotfile ".gitconfig"
copy_dotfile ".gitignore"
copy_dotfile "Brewfile"

if ! command -v brew >/dev/null; then
  fancy_echo "Installing Brew"
  xcode-select --install
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
else
  fancy_echo "Updating Brew ..."
  brew update >> out.log 2>&1
fi

fancy_echo "Installing Brew packages"
brew bundle --file=~/Brewfile >> out.log 2>&1

fancy_echo "Installing Node"
volta install node

fancy_echo "Installing OH-MY-ZSH"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >> out.log 2>&1

copy_zshfile "asdf.zsh"
copy_zshfile "aliases.zsh"
copy_zshfile "exports.zsh"
copy_zshfile "plugins.zsh"

fancy_echo "Configuring name and email in .gitconfig"
git config --global user.name "$full_name"
git config --global user.email "$email_address"

fancy_echo "Done!"
fancy_echo "You might need to restart your terminal"
