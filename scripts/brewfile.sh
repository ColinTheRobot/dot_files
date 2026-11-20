#!/usr/bin/env bash
# Writes this machine's Brewfile (the base Brewfile plus langs/<lang>/Brewfile
# for each language in ~/.config/dotfiles/langs) and prints its path, e.g.
#   brew bundle cleanup --file "$(scripts/brewfile.sh)"
set -euo pipefail

DOTFILES="$(cd "$(dirname "$0")/.." && pwd)"
LANGS_FILE=~/.config/dotfiles/langs
OUT=~/.config/dotfiles/Brewfile

mkdir -p "$(dirname "$OUT")"
{
  cat "$DOTFILES/Brewfile"
  if [[ -r "$LANGS_FILE" ]]; then
    while IFS= read -r lang; do
      [[ -r "$DOTFILES/langs/$lang/Brewfile" ]] || continue
      printf '\n# langs/%s\n' "$lang"
      cat "$DOTFILES/langs/$lang/Brewfile"
    done < "$LANGS_FILE"
  fi
} > "$OUT"
echo "$OUT"
