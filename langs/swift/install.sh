#!/usr/bin/env bash
# Xcode and the iOS platform. Run by install.sh when swift is in
# ~/.config/dotfiles/langs. The Command Line Tools have Swift but can't build
# iOS apps, so this needs the full Xcode.
set -euo pipefail

XCODE_APP_STORE_ID=497799835
XCODE=/Applications/Xcode.app

if [[ ! -d "$XCODE" ]]; then
  echo "Installing Xcode from the App Store (sign in to the App Store app first)"
  # mas 7 needs root to install apps.
  if ! sudo mas get "$XCODE_APP_STORE_ID"; then
    echo "Couldn't install Xcode. Install it from the App Store and rerun install.sh." >&2
    exit 0
  fi
fi

if [[ "$(xcode-select -p)" != "$XCODE/Contents/Developer" ]]; then
  sudo xcode-select --switch "$XCODE/Contents/Developer"
fi
if ! xcodebuild -license check >/dev/null 2>&1; then
  sudo xcodebuild -license accept
fi
xcodebuild -runFirstLaunch
# Skipped quickly if the iOS platform (SDK and simulator) is already installed.
xcodebuild -downloadPlatform iOS
