#!/usr/bin/env bash
# rustup, the stable and nightly toolchains, and cargo tools. Run by install.sh
# when rust is in ~/.config/dotfiles/langs.
set -euo pipefail

# Nightly with rust-src builds std for the ESP32-C3 (riscv32imc-esp-espidf).
TOOLCHAINS=(stable nightly)
COMPONENTS=(rust-analyzer rust-src clippy rustfmt)
# ldproxy is the linker wrapper esp-idf-sys projects use; not in Homebrew.
CARGO_TOOLS=(ldproxy)

if [[ ! -x ~/.cargo/bin/rustup ]]; then
  # The zsh setup is in ~/.config/zsh/langs/rust.zsh, so don't touch rc files.
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs |
    sh -s -- -y --no-modify-path --default-toolchain none
fi
source ~/.cargo/env

for toolchain in "${TOOLCHAINS[@]}"; do
  rustup toolchain install "$toolchain" --profile minimal --component "$(IFS=,; echo "${COMPONENTS[*]}")"
done
rustup default stable

for tool in "${CARGO_TOOLS[@]}"; do
  command -v "$tool" >/dev/null || cargo install --locked "$tool"
done
