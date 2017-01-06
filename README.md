# Laptop Install

This script installs a default development environment


## Quickstart

Clone this repo:

```
git clone https://github.com/dockyard/laptop-install.git
cd laptop-install
```

Run the `install.sh` script:

```
./install.sh
```

You will see the following prompt:

```
This script will setup your laptop

If you want to reuse your old SSH key, copy your SSH config over before running
this script

During installation, it will ask for your sudo password a few times
```

If you have saved your old SSH configuration, now is a good time to copy it to
your home directory.

It continues by asking your name and email address:

```
Before we start we need some basic details of you
What is your full name? (e.g. Johnny Appleseed): Johnny Appleseed
What is your email address? (e.g. johnny.appleseed@dockyard.com): johnny.appleseed@dockyard.com

Hello Johnny Appleseed  <johnny.appleseed@dockyard.com>

Press enter to start the installation process, press <CTRL + C> to cancel
```

After filling out your name, press `enter` to start installation. During the
installation it can ask for your sudo password a few times.

### Optional: `macos.sh`

Optionally run the `macos.sh` script. This will do quite a lot of mac os
configuration. Best to just read the script file if you want to know what it
exactly does.

```
./macos.sh
```

## What does this script do?

This script sets up some boilerplate dotfiles and installs common tools.

The following things are set up:

  * Generates a new SSH key pair if you don't have one yet
  * Copies the following dotfiles to your homefolder
  * Creates a `~/Projects` folder
  * Installs Brew and common Brew packages
  * Installs OH-MY-ZSH
  * Installs some common global Node.js packages
  * Installs the Phoenix Framework
  * Installs the Vim plugins configured in the `.vimrc` file
  * Changes your default shell to ZSH

### Dotfiles

The following dotfiles are set up:
  * `.aliases` for command aliases
  * `.agignore` for folders that the `ag` command can ignore
  * `.ackrc` for folders that the `ack` command can ignore
  * `.exports` for exports
  * `.editorconfig` for editor defaults
  * `.gitconfig` your default git config, complete with your name and email
  * `.gitignore` a global ignore file for git
  * `.tmux.conf` a basic setup for tmux
  * `.vimrc` a basic Vim setup, including basic Vim plugins
  * `.zshrc` a basic ZSH setup, including OH-MY-ZSH

If you want to add more aliases, you can add your own `.aliases.local` file to
your home directory. This will be automatically loaded when your terminal
starts.

The following `.local` files are possible:
  * `.aliases.local` for your own aliases
  * `.exports.local` for your own exports
  * `.gitconfig.local` for your custom git config
  * `.vimrc.bundles.local` put your custom Vim plugins in this file (`NeoBundle 'ctrlpvim/ctrlp.vim'`)
  * `.vimrc.local` for all other Vim customization
  * `.zshrc.oh-my-zsh.local` for all your OH-MY-ZSH customization, before it is loaded
  * `.zshrc.local` for all other ZSH customization


### Brew

During installation some common Brew packages are installed, it includes the
following packages:

  * `ack`
  * `elixir`
  * `git`
  * `hub`
  * `node`
  * `nvm`
  * `postgresql`
  * `redis`
  * `the_silver_searcher`
  * `vim`
  * `watchman`
  * `yarn`
  * `zsh`

And the following desktop apps:

  * Google Chrome
  * ScreenHero
  * Slack
  * Visual Studio Code
