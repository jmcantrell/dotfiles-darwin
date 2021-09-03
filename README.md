# dotfiles-darwin

My configuration files and scripts for Mac OS.

## Installation

Clone this repository:

```sh
git clone git@gitlab.com:jmcantrell/dotfiles-darwin.git ~/.dotfiles-darwin
cd ~/.dotfiles-darwin
```

Initialize repository, symlink files, install packages, and configure system:

```sh
./scripts/stow
./scripts/install
./scripts/config
```

Update repository with the latest changes:

```sh
./scripts/update
```

Remove files from home directory:

```sh
./scripts/unstow
```
