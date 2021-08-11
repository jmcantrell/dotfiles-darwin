#!/usr/bin/env bash

set -eu

which gcc &>/dev/null || xcode-select --install

url=https://raw.githubusercontent.com/Homebrew/install/master/install
which brew &>/dev/null || ruby -e "$(curl -fsSL "$url")"

xargs -r brew install <./packages/brew-formula
xargs -r brew install --cask <./packages/brew-cask
