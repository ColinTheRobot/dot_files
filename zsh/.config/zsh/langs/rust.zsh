[[ -r ~/.cargo/env ]] && source ~/.cargo/env

# ESP-IDF builds (esp-idf-sys) run whichever python3 is first on PATH; macOS's
# 3.9 can't install ESP-IDF's requirements, so put Homebrew's 3.12 first.
[[ -d /opt/homebrew/opt/python@3.12/libexec/bin ]] && export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"
