#!/usr/bin/env bash

set -e

# install developer tools
which gcc || xcode-select --install

# install homebrew
url=https://raw.githubusercontent.com/Homebrew/install/master/install
which brew || ruby -e "$(curl -fsSL "$url")"

readarray -t packages_brew_formula <./packages/brew-formula
brew install "${packages_brew_formula[@]}"

readarray -t packages_brew_cask <./packages/brew-cask
brew install --cask "${packages_brew_cask[@]}"
