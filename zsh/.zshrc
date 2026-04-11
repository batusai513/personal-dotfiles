# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

if [[ $OSTYPE == 'darwin'* ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Set name of the theme to load.
# ZSH_THEME="spaceship"

# Note: fast-syntax-highlighting needs to be the last element of the array
# plugins=(git ruby rails history-substring-search zsh-autosuggestions fast-syntax-highlighting)
plugins=(git ruby history-substring-search zsh-autosuggestions fast-syntax-highlighting)

# Allow [, ],or ?
unsetopt nomatch

ZSH_DISABLE_COMPFIX=true

export LC_ALL=en_US.UTF-8

export PATH=$HOME/bin:/usr/local/bin:$PATH

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="$TMPDIR/runtime-$UID"

zrcl="$HOME/.zshrc.local"
[[ ! -e $zrcl ]] || source $zrcl

source $ZSH/oh-my-zsh.sh
source $HOME/.aliases
