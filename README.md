# dot_files

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a package whose contents mirror `$HOME`.

## Setting up a new machine

### 1. Clone and run the installer

```sh
xcode-select --install
git clone git@github.com:ColinTheRobot/dot_files.git ~/prs_dev/dot_files
~/prs_dev/dot_files/install.sh
```

`install.sh` is safe to rerun. It:

1. Installs Homebrew if it's missing and adds `brew shellenv` to `~/.zprofile`.
2. Runs `brew bundle` on the `Brewfile`.
3. Stows `nvim`, `tmux` and `zsh`. Any existing non-symlink `~/.zshrc`,
   `~/.tmux.conf` or `~/.config/nvim` is moved aside to `*.orig` first.
4. Installs SDKMAN and the Java versions listed in `JAVA_VERSIONS`, and sets
   `JAVA_DEFAULT` as the default.
5. Restores Neovim plugins from `lazy-lock.json`.
6. Runs `scripts/setup-docker.sh`, which registers the `docker compose`
   plugin, starts the colima VM (4 CPU, 8 GiB memory, 60 GiB disk, `vz`,
   `virtiofs`) and switches Docker to the `colima` context.

Notes:

- The `Brewfile` lists every formula and cask. After installing something new
  with brew, add it there. `brew bundle check --file ~/prs_dev/dot_files/Brewfile`
  reports anything missing, and `brew bundle cleanup --file ...` lists what's
  installed but not in the file.
- `openjdk` is put on `PATH` by `.zshrc`, and Mason needs Java to run jdtls.
- `tree-sitter-cli` builds the parsers nvim-treesitter installs.
- `ripgrep` backs fzf-lua's `live_grep` (`<C-g>`, `<leader>fg`).
- Set your terminal font to "JetBrainsMono Nerd Font" so `nvim-web-devicons`
  renders.
- [Claude Code](https://claude.com/claude-code) (`claude` CLI, installed by
  the Brewfile) is needed for `claude-chat.nvim` (`<leader>ai`).

### 2. Create `~/.zshenv`

`.zshenv` holds secrets (tokens, API keys) and is gitignored, so it isn't in
this repo. Create it by hand and export whatever environment variables you
need there. It's sourced before `.zshrc`.

Project-specific environment variables (for example, work Docker or
Testcontainers settings) belong here too, not in the repo.

### 3. First Neovim launch

Open a new shell, then open `nvim` and let it finish bootstrapping:

- `install.sh` already restored plugins from `lazy-lock.json`. Run
  `:Lazy restore` to resync to the lockfile, or `:Lazy update` to upgrade
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
