#!/bin/bash

set -e

# Install dependencies
sudo apt update
sudo apt install -y curl git unzip xz-utils ninja-build libgtk-3-dev libgl1-mesa-dev mesa-utils

# Download Flutter stable
FLUTTER_DIR="$HOME/flutter"
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Downloading Flutter..."
  curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.1-stable.tar.xz
  tar xf flutter_linux_3.22.1-stable.tar.xz -C $HOME
  rm flutter_linux_3.22.1-stable.tar.xz
fi

# Add Flutter to PATH
if ! grep -q 'export PATH="$HOME/flutter/bin:$PATH"' "$HOME/.bashrc"; then
  echo 'export PATH="$HOME/flutter/bin:$PATH"' >> "$HOME/.bashrc"
fi

# Source the updated .bashrc
source "$HOME/.bashrc"

# Enable Linux desktop support
flutter config --enable-linux-desktop

# Run flutter doctor
flutter doctor
