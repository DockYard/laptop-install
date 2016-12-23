export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git osx terminalapp)

source $ZSH/oh-my-zsh.sh

for file in ~/.{exports,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
