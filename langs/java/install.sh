#!/usr/bin/env bash
# SDKMAN and this machine's JDKs. Run by install.sh when java is in
# ~/.config/dotfiles/langs.
#
# The JDKs are listed in ~/.config/dotfiles/java-versions (not in the repo), one
# SDKMAN identifier per line (e.g. 21.0.12-tem); the first is the default.
# `latest` means the newest Corretto, looked up on each run. If the file is
# missing, this asks for the versions, or uses `latest` without a terminal.
set -euo pipefail

VERSIONS_FILE=~/.config/dotfiles/java-versions

if [[ ! -s "$VERSIONS_FILE" ]]; then
  answer=()
  if [[ -t 0 ]]; then
    read -rp "Java versions to install (SDKMAN identifiers, first is the default) [latest]: " -a answer
  fi
  (( ${#answer[@]} )) || answer=(latest)
  printf '%s\n' "${answer[@]}" > "$VERSIONS_FILE"
fi

latest_corretto() {
  local platform
  platform="$(uname -s | tr '[:upper:]' '[:lower:]')$(uname -m | sed 's/x86_64/x64/; s/aarch64/arm64/')"
  # SDKMAN lists each vendor's builds newest first, with the identifier last.
  curl -fsS "https://api.sdkman.io/2/candidates/java/$platform/versions/list?installed=" |
    awk -F'|' '$NF ~ /-amzn[[:space:]]*$/ { gsub(/[[:space:]]/, "", $NF); print $NF; exit }'
}

versions=()
while IFS= read -r version; do
  [[ -n "$version" ]] || continue
  if [[ "$version" == latest ]]; then
    version="$(latest_corretto)"
    [[ -n "$version" ]] || { echo "Couldn't find the latest Corretto on SDKMAN" >&2; exit 1; }
    echo "latest Java: $version"
  fi
  versions+=("$version")
done < "$VERSIONS_FILE"
(( ${#versions[@]} )) || { echo "No Java versions in $VERSIONS_FILE" >&2; exit 1; }
echo "Java versions: ${versions[*]} (default ${versions[0]})"

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
' zsh "${versions[0]}" "${versions[@]}"
