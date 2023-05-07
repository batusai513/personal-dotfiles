
# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# ZSH_THEME="spaceship"

# Note: fast-syntax-highlighting needs to be the last element of the array
plugins=(git ruby rails autojump history-substring-search zsh-autosuggestions fast-syntax-highlighting)

# Allow [, ],or ?
unsetopt nomatch

ZSH_DISABLE_COMPFIX=true

export LC_ALL=en_US.UTF-8

export PATH=$HOME/bin:/usr/local/bin:$PATH

zrcl="$HOME/.zshrc.local"
[[ ! -a $zrcl ]] || source $zrcl

source $HOME/.aliases
source $ZSH/oh-my-zsh.sh

eval "$(zoxide init zsh)"
