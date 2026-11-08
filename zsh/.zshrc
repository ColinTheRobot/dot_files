
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

alias gs='git status'
alias gco='git checkout'


# Save and persist history across tabs
export HISTFILE=~/.zsh_history
export HISTSIZE=20000
export SAVEHIST=20000

setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY

awsl() {
  env -u AWS_PROFILE AWS_ACCESS_KEY_ID=test AWS_SECRET_ACCESS_KEY=test AWS_REGION=eu-central-1 \
    aws --endpoint-url http://localhost:4566 "$@"
}

eval "$(starship init zsh)"

# Language setup for this machine: ~/.config/dotfiles/langs lists one language
# per line (written by install.sh --lang). Kept last because SDKMAN must be.
if [[ -r ~/.config/dotfiles/langs ]]; then
  for lang in ${(f)"$(<~/.config/dotfiles/langs)"}; do
    [[ -r ~/.config/zsh/langs/$lang.zsh ]] && source ~/.config/zsh/langs/$lang.zsh
  done
  unset lang
fi
