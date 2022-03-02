# personal-dotfiles
========

## Install Brew

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

## Install Neovim
```
https://github.com/neovim/neovim#install-from-package
```

## Clone this Repo

```
git clone git@github.com:batusai513/personal-dotfiles.git
```

## Install Packages

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
