# dot_files

Managed with [GNU Stow](https://www.gnu.org/software/stow/). Each top-level
directory is a package whose contents mirror `$HOME`.

## Setup

```sh
brew install stow
git clone git@github.com:ColinTheRobot/dot_files.git ~/prs_dev/dot_files
cd ~/prs_dev/dot_files
stow -t ~ nvim tmux zsh
```

## Adding a package

```sh
mkdir -p <pkg>/<path relative to $HOME>
mv ~/<file> <pkg>/<path relative to $HOME>/
stow -t ~ <pkg>
```

Use `stow -t ~ -D <pkg>` to remove a package's symlinks.
