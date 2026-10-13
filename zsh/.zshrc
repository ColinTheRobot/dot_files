
export PATH=/opt/homebrew/opt/openjdk/bin:$PATH

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

autoload -Uz compinit && compinit
#
# Case-insensitive, partial-word matching
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*'

# Arrow-key navigable menu
zstyle ':completion:*' menu select

# Colorize completion entries like ls
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

z=""
for i in {1..10}; do
  _z+=z
  alias "$_z"='pmset sleepnow'
done
unset _z i


# Save and persist history across tabs
export HISTFILE=~/.zsh_history
export HISTSIZE=20000
export SAVEHIST=20000

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY

spring() {
  local profiles="${(j:,:)@:-local}"
  ./mvnw spring-boot:run -Dactive.profile="$profiles"
}

# Open files modified or added on the current branch (vs. its default branch,
# plus any uncommitted changes) in nvim, one tab per file.
nvb() {
  local root
  root=$(git rev-parse --show-toplevel 2>/dev/null) || { echo "nvb: not inside a git repo" >&2; return 1 }

  local default_branch
  default_branch=$(git -C "$root" symbolic-ref --quiet --short refs/remotes/origin/HEAD 2>/dev/null)
  default_branch=${default_branch:-origin/main}

  local base
  base=$(git -C "$root" merge-base "$default_branch" HEAD 2>/dev/null) \
    || base=$(git -C "$root" merge-base main HEAD 2>/dev/null) \
    || base=$(git -C "$root" merge-base master HEAD 2>/dev/null)

  if [[ -z "$base" ]]; then
    echo "nvb: couldn't determine a base branch (tried $default_branch, main, master)" >&2
    return 1
  fi

  local -a files
  files=(${(f)"$(git -C "$root" diff --name-only --diff-filter=ACMR "$base")"})
  files+=(${(f)"$(git -C "$root" ls-files --others --exclude-standard)"})
  files=(${(u)files})
  files=(${files:#})

  if (( ${#files[@]} == 0 )); then
    echo "nvb: no changed or added files vs $base"
    return 1
  fi

  nvim -p ${files/#/$root/}
}

eval "$(starship init zsh)"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
