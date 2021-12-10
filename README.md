# Laptop Install

This script installs a default development environment

## Quickstart

Clone this repo:

```sh
git clone https://github.com/dockyard/laptop-install.git
cd laptop-install
```

Run the `install.sh` script:

```sh
./install.sh
```

You will see the following prompt:

```text
This script will setup your laptop

If you want to reuse your old SSH key, copy your SSH config over before running
this script

During installation, it may ask for your sudo password.
```

If you have saved your old SSH configuration, now is a good time to copy it to
your home directory.

It continues by asking your name and email address:

```text
Before we start we need some basic details of you
What is your full name? (e.g. Johnny Appleseed): Johnny Appleseed
What is your email address? (e.g. johnny.appleseed@dockyard.com): johnny.appleseed@dockyard.com

Hello Johnny Appleseed  <johnny.appleseed@dockyard.com>

Press enter to start the installation process, press <CTRL + C> to cancel
```

After filling out your name, press `enter` to start installation. During the
installation it can ask for your sudo password.

### Optional: `macos.sh`

Optionally run the `macos.sh` script. This will do quite a lot of mac os
configuration. Best to just read the script file if you want to know what it
exactly does.

```sh
./macos.sh
```

## What does this script do?

This script sets up some boilerplate dotfiles and installs common tools.

The following things are set up:

* Generates a new SSH key pair if you don't have one yet
* Installs Brew and common Brew packages
* Installs Node using [Volta](https://volta.sh/)
* Installs [OH-MY-ZSH](https://ohmyz.sh/)
* Changes your default shell to ZSH
* Copies some configuration files (see below)

### Dotfiles

The following dotfiles are set up:

* `.agignore` for folders that the `ag` command can ignore
* `.ackrc` for folders that the `ack` command can ignore
* `.editorconfig` for editor defaults
* `.gitconfig` your default git config, complete with your name and email
* `.gitignore` a global ignore file for git

To add your own customizations to gitconfig, create a `.gitconfig.local` file in your home directory.

### ZSH Config Files

The following custom zsh config files are set up (in ~/.oh-my-zsh/custom/):

* `asdf.zsh` sets up asdf manager
* `aliases.zsh` for command aliases
* `exports.zsh` for shell exports
* `plugins.zsh` for zsh plugins

If you want to add more aliases, you can add your own `aliases.local.zsh` file to
your `~/.oh-my-zsh/custom/` directory. This will be automatically loaded when your terminal
starts. The filename does not matter. Any `*.zsh` file in this directory will be loaded.

### Brew

During installation some common Brew packages are installed, it includes the
following packages:

* `ack`
* `asdf`
* `coreutils`
* `findutils`
* `git`
* `hub`
* `libyaml`
* `the_silver_searcher`
* `tmux`
* `tree`
* `vim`
* `volta`
* `watchman`
* `wget`
* `zsh`

And the following desktop apps:

* Google Chrome
* iTerm2
* Slack
* Visual Studio Code

Afterwards you may wish to use [asdf](https://asdf-vm.com/) to install additional
languages that you need, such as ruby, erlang, elixir, java, and others.
