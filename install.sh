#!/usr/bin/env bash

set -euo pipefail

which gcc &>/dev/null || xcode-select --install

url=https://raw.githubusercontent.com/Homebrew/install/master/install
which brew &>/dev/null || ruby -e "$(curl -fsSL "$url")"

readarray -t packages_brew_formula <./packages/brew-formula
brew install "${packages_brew_formula[@]}"

readarray -t packages_brew_cask <./packages/brew-cask
brew install --cask "${packages_brew_cask[@]}"
