#!/usr/bin/env sh

set -e

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
chflags nohidden "$HOME/Library"

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
        sudo echo -e "/usr/local/bin/bash\n/usr/local/bin/zsh" >>/etc/shells
    fi

fi

# change shell to zsh
test ${SHELL##*/} = zsh || chsh -s /usr/local/bin/zsh
