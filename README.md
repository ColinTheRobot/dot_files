# dot_files

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a package whose contents mirror `$HOME`.

## Setting up a new machine

### 1. Install dependencies

```sh
brew install stow neovim tmux starship ripgrep openjdk tree-sitter-cli
brew install --cask font-jetbrains-mono-nerd-font
curl -s "https://get.sdkman.io" | bash
```

- `openjdk` is put on `PATH` by `.zshrc`, and Mason needs Java to run jdtls.
- SDKMAN is optional. `.zshrc` only loads it if it's installed.
- `tree-sitter-cli` builds the parsers nvim-treesitter installs.
- `ripgrep` backs fzf-lua's `live_grep` (`<C-g>`, `<leader>fg`).
- Set your terminal font to the Nerd Font so `nvim-web-devicons` renders.
- [Claude Code](https://claude.com/claude-code) (`claude` CLI) is needed for
  `claude-chat.nvim` (`<leader>ai`).

### 2. Clone and stow

```sh
git clone git@github.com:ColinTheRobot/dot_files.git ~/prs_dev/dot_files
cd ~/prs_dev/dot_files
stow -t ~ nvim tmux zsh
```

Stow refuses to overwrite existing files. If it reports a conflict (a fresh
Mac usually has a default `~/.zshrc`), move the existing file aside and rerun:

```sh
mv ~/.zshrc ~/.zshrc.orig
```

### 3. Create `~/.zshenv`

`.zshenv` holds secrets (tokens, API keys) and is gitignored, so it isn't in
this repo. Create it by hand and export whatever environment variables you
need there. It's sourced before `.zshrc`.

### 4. First Neovim launch

Open `nvim` and let it bootstrap:

- lazy.nvim installs plugins at the versions pinned in `lazy-lock.json`.
  Run `:Lazy restore` to resync to the lockfile, or `:Lazy update` to upgrade
  and then commit the updated lockfile.
- The `junegunn/fzf` plugin builds the fzf binary and runs `./install --all`,
  which writes `~/.fzf.zsh`. Open a new shell afterwards to get fzf's shell
  keybindings.
- Mason installs `jdtls` and `lemminx`. Check progress with `:Mason`. Java
  buffers won't get LSP features until jdtls (and its bundled `lombok.jar`)
  has finished installing.

## Adding a package

```sh
mkdir -p <pkg>/<path relative to $HOME>
mv ~/<file> <pkg>/<path relative to $HOME>/
stow -t ~ <pkg>
```

Use `stow -t ~ -D <pkg>` to remove a package's symlinks.
