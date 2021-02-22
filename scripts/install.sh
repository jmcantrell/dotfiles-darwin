#!/usr/bin/env bash

set -e

# only if allowed to use sudo
if groups | grep -wq admin; then

	# install developer tools
	which gcc || xcode-select --install

	# install homebrew
	url=https://raw.githubusercontent.com/Homebrew/install/master/install
	which brew || ruby -e "$(curl -fsSL "$url")"

	readarray -t formula <./brew/formula
	brew install "${formula[@]}"

	readarray -t cask <./brew/cask
	brew install --cask "${cask[@]}"
fi
