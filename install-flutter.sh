#!/bin/bash

set -euo pipefail

echo "🔧 Setting up Flutter in Codespaces..."

# 1. Update system and install dependencies
sudo apt-get update
sudo apt-get install -y \
  git curl unzip xz-utils zip \
  ninja-build cmake build-essential \
  libgtk-3-dev liblzma-dev \
  clang libclang-dev \
  libgl1-mesa-dev libstdc++-12-dev \
  xdg-utils libsecret-1-dev \
  libjsoncpp-dev xvfb mesa-utils \
  chromium-browser

# 2. Install Flutter
if [ ! -d "$HOME/flutter" ]; then
  echo "📦 Cloning Flutter SDK..."
  git clone https://github.com/flutter/flutter.git -b stable "$HOME/flutter"
else
  echo "🔄 Flutter SDK already exists. Skipping clone."
fi

# 3. Add Flutter to PATH (if not already added)
if ! grep -q 'flutter/bin' ~/.bashrc; then
  echo 'export PATH="$HOME/flutter/bin:$PATH"' >> ~/.bashrc
  export PATH="$HOME/flutter/bin:$PATH"
else
  export PATH="$HOME/flutter/bin:$PATH"
fi

# 4. Source Bash config to apply PATH
source ~/.bashrc

# 5. Run Flutter setup
echo "🔍 Running flutter doctor..."
flutter doctor

# 6. Enable Linux and Web support
flutter config --enable-linux-desktop
flutter config --enable-web

# 7. Set Chromium as web browser for Flutter
export CHROME_EXECUTABLE=/usr/bin/chromium-browser

# 8. Precache dependencies
flutter precache

# 9. Accept Android licenses (optional step — will skip in Codespaces)
yes | flutter doctor --android-licenses || true

# 10. Final check
flutter doctor -v

echo "✅ Flutter is fully installed and configured!"

# 11. Optionally start your app (uncomment to run automatically)
flutter run -d web-server
