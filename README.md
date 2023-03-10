# personal-dotfiles
========

## Install Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install Neovim
https://github.com/neovim/neovim#install-from-package


## Clone this Repo

```
git clone git@github.com:batusai513/personal-dotfiles.git
```

## Install Packages
Go into the cloned folder with

```
cd personal-dotfiles
```

then run

```
brew bundle
```

### Symlink dotfiles

#### Everything
```
stow -S */ -t ~/
```

#### Cherry picking
```
stow -S neovim tmux -t ~/
```

### Tmux plugins

Make sure that you close current tmux sessions before continue.

#### Install tmux plugin manager (TPM)
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

#### Install default plugins
```
~/.tmux/plugins/tpm/bin/install_plugins
```

### Neovim LSP servers
Right now the instalation of servers is manual and can be performed by running the following command inside neovim
```
:LspInstall [name]
```

you can get the list of server names supported at:
https://github.com/williamboman/mason-lspconfig.nvim

