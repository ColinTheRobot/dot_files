#!/usr/bin/env bash
# rbenv Rubies in RUBY_VERSIONS, plus ruby-lsp for each. Run by install.sh when
# ruby is in ~/.config/dotfiles/langs.
set -euo pipefail

RUBY_VERSIONS=(3.4.4)
RUBY_DEFAULT=3.4.4

eval "$(rbenv init - bash)"
for version in "${RUBY_VERSIONS[@]}"; do
  rbenv install --skip-existing "$version"
  # Neovim runs ruby-lsp through the rbenv shim, so it uses the project's Ruby.
  RBENV_VERSION="$version" gem install --conservative bundler ruby-lsp
done
rbenv global "$RUBY_DEFAULT"
