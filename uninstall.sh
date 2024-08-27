brew uninstall pulseaudio
brew uninstall xquartz
brew uninstall --cask docker --force
brew cleanup
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/uninstall.sh)"
