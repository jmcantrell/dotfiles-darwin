#!/usr/bin/env bash

set -eu

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

# Show battery percentage free.
defaults write com.apple.menuextra.battery ShowPercent -bool true

# Show mounted devices on desktop.
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# Never restore windows after reboot.
defaults write com.apple.systempreferences NSQuitAlwaysKeepsWindows -bool false

# Quit printer app after done.
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Expanded save/print dialogs by default.
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk by default (not icloud).
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# This isn't dangerous and done frequently.
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Unhide library folder in finder.
chflags nohidden ~/Library

if groups | grep -wq admin; then
    # Disable boot sound.
    sudo nvram SystemAudioVolume=%80

    # power management settings
    sudo pmset -b sleep 1
    sudo pmset -c sleep 15
    sudo pmset -b displaysleep 1
    sudo pmset -c displaysleep 15

    # Add brew installed shells to system.
    if ! grep -q /usr/local/bin /etc/shells; then
        printf "%s\n" /usr/local/bin/{bash,zsh} | sudo tee -a /etc/shells >/dev/null
    fi
fi

[[ ${SHELL##*/} = zsh ]] || chsh -s /usr/local/bin/zsh
