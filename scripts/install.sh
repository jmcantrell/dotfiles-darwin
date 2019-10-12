#!/usr/bin/env sh

set -e

# only if allowed to use sudo
if groups | grep -wq admin; then

    # install developer tools
    which gcc || xcode-select --install

    # install homebrew
    url=https://raw.githubusercontent.com/Homebrew/install/master/install
    which brew || ruby -e "`curl -fsSL $url`"
    brew tap caskroom/cask
    brew update
    brew install `cat depends/macos`

fi
