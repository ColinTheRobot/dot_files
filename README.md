### To set up:

clone recursively:

  - git clone --recursive https://github.com/username/reponame.git

create symlnks:

  - `ln -sf <absolute path>/dot_files/tmux.conf ~/.tmux.conf`
  - `ln -sf <absolute path>/dot_files/.vim ~/.vim`
  - `ln -sf <absolute path>/dot_files/vimrc ~/.vimrc`

### Removing plugins
To remove `foo`:
```
cd ~/.vim
git submodule deinit pack/plugins/start/foo
git rm -r pack/plugins/start/foo
rm -r .git/modules/pack/plugins/start/foo
```

### Updating plugins
To update `foo`:
```
cd ~/.vim/pack/plugins/start/foo
git pull origin master
```
It is recommended to first `git fetch origin master` a plugin, review changes, and then `git merge`.

To update all the plugins:
```
cd ~/.vim
git submodule foreach git pull origin master
```

Note that new commits to plugins create uncommitted changes in the main repository.
Thus, after any updates in the submodules, you need to commit the main repository as well:
```
cd ~/.vim
git commit -am "Updated plugins."
```

On another machine, if a `git pull` for the main repository leads to uncommitted changes in the submodules (as a few plugins got updated), perform `git submodule update` to change the recorded state of the submodules.

Even though slightly complicated, submodules are a necessary devil when you want to maintain an easily-cloneable `.vim` repository.
The other option is to _not_ version-control submodules at all by adding a line `pack` in `~/.vim/.gitignore`, and manually add plugins on a new machine.
