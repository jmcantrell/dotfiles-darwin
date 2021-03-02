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

# screensaver settings
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -float 0.0

# screenshot settings
defaults write com.apple.screencapture location "$HOME"
defaults write com.apple.screencapture disable-shadow -bool true

# trackpad settings
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.AppleMultitouchTrackpad Dragging -int 1
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true

# clock display format
defaults write com.apple.menuextra.clock DateFormat "EEE MMM d  h:mm a"
defaults write com.apple.menuextra.clock IsAnalog -bool false

# show battery percentage free
defaults write com.apple.menuextra.battery ShowPercent -bool true

# show mounted devices on desktop
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# never restore windows after reboot
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# quit printer app after done
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# expanded save/print dialogs by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# save to disk by default (not icloud)
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# this isn't dangerous and done frequently
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# unhide library folder in finder
chflags nohidden ~/Library

# only if allowed to use sudo
if groups | grep -wq admin; then

    # disable boot sound
    sudo nvram SystemAudioVolume=" "

    # power management settings
    sudo pmset -b sleep 1
    sudo pmset -c sleep 15
    sudo pmset -b displaysleep 1
    sudo pmset -c displaysleep 15

    # add brew installed shells to system
    if ! grep -q /usr/local/bin /etc/shells; then
        {
            echo "/usr/local/bin/bash"
            echo "/usr/local/bin/zsh"
        } | sudo tee -a /etc/shells
    fi

fi

# ca certs can be in different places, so link to a common place
mkdir -p ~/.local/etc/ssl/certs
ln -sfv /usr/local/etc/openssl/cert.pem ~/.local/etc/ssl/certs/ca-certificates.crt

# change shell to zsh
[[ ${SHELL##*/} = zsh ]] || chsh -s /usr/local/bin/zsh
