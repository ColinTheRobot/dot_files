#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
JAVA_VERSIONS=(21.0.12-tem 25.0.4-tem 25.0.4-amzn)
JAVA_DEFAULT=25.0.4-amzn

step() { printf '\n==> %s\n' "$1"; }

step "Homebrew"
if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv bash)"
if ! grep -qs 'brew shellenv' ~/.zprofile; then
  echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
fi

step "Brewfile"
brew bundle --file "$DOTFILES/Brewfile"

step "Stow"
for target in ~/.zshrc ~/.tmux.conf ~/.config/nvim; do
  if [[ -e "$target" && ! -L "$target" ]]; then
    echo "Moving existing $target to $target.orig"
    mv "$target" "$target.orig"
  fi
done
mkdir -p ~/.config
stow -d "$DOTFILES" -t ~ nvim tmux zsh

step "SDKMAN and Java"
if [[ ! -s ~/.sdkman/bin/sdkman-init.sh ]]; then
  curl -s "https://get.sdkman.io?rcupdate=false" | bash
fi
zsh -c '
  source ~/.sdkman/bin/sdkman-init.sh
  default=$1; shift
  for version in "$@"; do
    [[ -d ~/.sdkman/candidates/java/$version ]] || { echo n | sdk install java "$version" }
  done
  sdk default java "$default"
' zsh "$JAVA_DEFAULT" "${JAVA_VERSIONS[@]}"

step "Neovim plugins"
nvim --headless "+Lazy! restore" +qa

step "Docker"
"$DOTFILES/scripts/setup-docker.sh"

step "Done"
cat <<'EOF'
Remaining manual steps:
  - Create ~/.zshenv with your secrets and private environment variables.
  - Set your terminal font to "JetBrainsMono Nerd Font".
  - Open a new shell, then open nvim and let Mason install jdtls and lemminx.
EOF
