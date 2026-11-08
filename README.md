# dot_files

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a package whose contents mirror `$HOME`.

## Setting up a new machine

### 1. Clone and run the installer

```sh
xcode-select --install
git clone git@github.com:ColinTheRobot/dot_files.git ~/prs_dev/dot_files
~/prs_dev/dot_files/install.sh --lang java --lang work   # or --lang ruby, etc.
```

`install.sh` is safe to rerun. It:

1. Adds any `--lang` languages to `~/.config/dotfiles/langs` (see
   [Languages](#languages)). Later runs without `--lang` use what's in that file.
2. Installs Homebrew if it's missing and adds `brew shellenv` to `~/.zprofile`.
3. Runs `brew bundle` on the `Brewfile` plus each enabled language's
   `langs/<lang>/Brewfile`.
4. Stows `nvim`, `tmux` and `zsh`. Any existing non-symlink `~/.zshrc`,
   `~/.tmux.conf`, `~/.config/nvim` or `~/.config/zsh` is moved aside to
   `*.orig` first.
5. Runs `langs/<lang>/install.sh` for each enabled language.
6. Clones [TPM](https://github.com/tmux-plugins/tpm) at `TPM_VERSION` and
   installs the tmux plugins listed in `.tmux.conf` (tmux-pomodoro-plus).
7. Restores Neovim plugins from `lazy-lock.json`.

Notes:

- The `Brewfile` lists the formulae and casks every machine gets; language
  tooling goes in `langs/<lang>/Brewfile`. After installing something new with
  brew, add it to the right one. `scripts/brewfile.sh` combines the base
  Brewfile with this machine's languages and prints the combined file's path,
  so check and clean up against that rather than the base file alone:
  `brew bundle check --file "$(scripts/brewfile.sh)"` reports anything
  missing, and `brew bundle cleanup --file "$(scripts/brewfile.sh)"` lists
  what's installed but not in it.
- `tree-sitter-cli` builds the parsers nvim-treesitter installs.
- `ripgrep` backs fzf-lua's `live_grep` (`<C-g>`, `<leader>fg`).
- Set your terminal font to "JetBrainsMono Nerd Font" so `nvim-web-devicons`
  renders.
- [Claude Code](https://claude.com/claude-code) (`claude` CLI, installed by
  the Brewfile) connects to Neovim through `claudecode.nvim`: run `/ide` in
  Claude Code. Keymaps: `<leader>ab` adds the buffer, `<leader>as` sends the
  selection, `<leader>aa` / `<leader>ad` accept or deny a diff.

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
- With java enabled, Mason installs `jdtls` and `lemminx`. Check progress with
  `:Mason`. Java buffers won't get LSP features until jdtls (and its bundled
  `lombok.jar`) has finished installing.
- Debugging and running Java tests need two more Mason packages that aren't
  installed automatically: `:MasonInstall java-debug-adapter java-test`, then
  reopen the Java buffer so jdtls loads their bundles.

## Languages

Everything for every language lives in this repo, but each machine only
installs and loads the languages listed in `~/.config/dotfiles/langs`, one per
line. That file isn't in the repo, so pulling a commit that changes another
language's setup never installs anything on this machine. `install.sh --lang
<name>` adds a language to the file and installs it.

| Layer | Java | Ruby |
|---|---|---|
| Homebrew | `langs/java/Brewfile`: openjdk, maven, mysql | `langs/ruby/Brewfile`: rbenv, ruby-build, postgres, redis, … |
| Install | `langs/java/install.sh`: SDKMAN and `JAVA_VERSIONS` | `langs/ruby/install.sh`: rbenv `RUBY_VERSIONS`, plus bundler and ruby-lsp for each |
| Shell | `~/.config/zsh/langs/java.zsh`: openjdk `PATH`, SDKMAN, `spring` | `~/.config/zsh/langs/ruby.zsh`: rbenv, `ulimit`, `run_modified_specs` |
| Neovim | `plugins/lang/java.lua` (nvim-jdtls, nvim-dap), `ftplugin/java.lua`; Mason installs jdtls and lemminx | `plugins/lang/ruby.lua` (vim-rails), `ftplugin/ruby.lua`, `after/lsp/ruby_lsp.lua` |

- `.zshrc` sources `~/.config/zsh/langs/<lang>.zsh` for each enabled language.
  All of them are stowed; only enabled ones are sourced.
- In Neovim, `require("config.langs").enabled("<lang>")` reports whether a
  language is on. Language plugins use `cond =` with it rather than
  `enabled =`, so a language that's off isn't installed but keeps its entry in
  `lazy-lock.json`, and committing the lockfile from one machine doesn't drop
  another machine's plugins.
- ruby-lsp isn't installed by Mason. It's a gem in each rbenv Ruby, run through
  the rbenv shim so it uses the project's Ruby and bundle.

To add a language, create `langs/<name>/` with a `Brewfile` and/or an
executable `install.sh`, add `zsh/.config/zsh/langs/<name>.zsh` and
`nvim/.config/nvim/lua/plugins/lang/<name>.lua` as needed, and gate anything
that installs (Mason servers, treesitter parsers) on `langs.enabled("<name>")`.

### `work`

`work` isn't a language but works the same way, for things only the work
machine needs. `langs/work/Brewfile` has the work apps (Slack, Linear,
Outlook, Notion, Bruno, TablePlus) and colima/Docker. `langs/work/install.sh`
registers the `docker compose` plugin, starts the colima VM (4 CPU, 8 GiB
memory, 60 GiB disk, `vz`, `virtiofs`) and switches Docker to the `colima`
context.

## Adding a package

```sh
mkdir -p <pkg>/<path relative to $HOME>
mv ~/<file> <pkg>/<path relative to $HOME>/
stow -t ~ <pkg>
```

Use `stow -t ~ -D <pkg>` to remove a package's symlinks.
