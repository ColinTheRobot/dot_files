#!/usr/bin/env bash
# SDKMAN and the JDKs in JAVA_VERSIONS. Run by install.sh when java is in
# ~/.config/dotfiles/langs.
set -euo pipefail

JAVA_VERSIONS=(21.0.12-tem 25.0.4-tem 25.0.4-amzn)
JAVA_DEFAULT=25.0.4-amzn

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
