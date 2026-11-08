#!/usr/bin/env bash
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
LANGS_FILE=~/.config/dotfiles/langs
TPM_VERSION=v3.1.0

usage() {
  echo "usage: $0 [--lang <name>]..." >&2
  echo "languages: $(ls "$DOTFILES/langs" | tr '\n' ' ')" >&2
  exit 1
}

step() { printf '\n==> %s\n' "$1"; }

# --lang adds a language to this machine's langs file. Without it, the
# languages already in the file are used, so reruns stay the same.
new_langs=()
while (( $# )); do
  case "$1" in
    --lang)
      [[ -n "${2:-}" && -d "$DOTFILES/langs/$2" ]] || usage
      new_langs+=("$2")
      shift 2
      ;;
    *) usage ;;
  esac
done

mkdir -p "$(dirname "$LANGS_FILE")"
touch "$LANGS_FILE"
for lang in ${new_langs[@]+"${new_langs[@]}"}; do
  grep -qx "$lang" "$LANGS_FILE" || echo "$lang" >> "$LANGS_FILE"
done
langs=()
while IFS= read -r lang; do
  [[ -n "$lang" ]] && langs+=("$lang")
done < "$LANGS_FILE"
echo "Languages: ${langs[*]:-none}"

step "Homebrew"
if ! command -v brew >/dev/null 2>&1 && [[ ! -x /opt/homebrew/bin/brew ]]; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv bash)"
if ! grep -qs 'brew shellenv' ~/.zprofile; then
  echo 'eval "$(/opt/homebrew/bin/brew shellenv zsh)"' >> ~/.zprofile
fi

step "Brewfile"
brew bundle --file "$("$DOTFILES/scripts/brewfile.sh")"

step "Stow"
for target in ~/.zshrc ~/.tmux.conf ~/.config/nvim ~/.config/zsh; do
  if [[ -e "$target" && ! -L "$target" ]]; then
    echo "Moving existing $target to $target.orig"
    mv "$target" "$target.orig"
  fi
done
mkdir -p ~/.config
stow -d "$DOTFILES" -t ~ nvim tmux zsh

for lang in ${langs[@]+"${langs[@]}"}; do
  if [[ -x "$DOTFILES/langs/$lang/install.sh" ]]; then
    step "Language: $lang"
    "$DOTFILES/langs/$lang/install.sh"
  fi
done

step "tmux plugins"
if [[ ! -d ~/.tmux/plugins/tpm ]]; then
  git clone --depth 1 --branch "$TPM_VERSION" https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi
# TPM installs through a tmux server that has loaded .tmux.conf, so use a
# throwaway one rather than any server (and sessions) already running.
tpm_tmp="$(mktemp -d)"
env -u TMUX TMUX_TMPDIR="$tpm_tmp" tmux new-session -d
env -u TMUX TMUX_TMPDIR="$tpm_tmp" ~/.tmux/plugins/tpm/bin/install_plugins
env -u TMUX TMUX_TMPDIR="$tpm_tmp" tmux kill-server
rm -rf "$tpm_tmp"

step "Neovim plugins"
nvim --headless "+Lazy! restore" +qa

step "Done"
cat <<'EOF'
Remaining manual steps:
  - Create ~/.zshenv with your secrets and private environment variables.
  - Set your terminal font to "JetBrainsMono Nerd Font".
  - Open a new shell, then open nvim and let Mason install this machine's
    language servers (check with :Mason).
EOF
