export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(git osx)

[[ -f ~/.zshrc.oh-my-zsh.local ]] && source ~/.zshrc.oh-my-zsh.local

source $ZSH/oh-my-zsh.sh

for file in ~/.{zshrc.local,exports,aliases}; do
  [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
