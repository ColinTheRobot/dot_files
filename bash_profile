export PATH="/usr/local/sbin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"

{ eval `ssh-agent`; ssh-add -K; } &>/dev/null

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1
source ~/.git-prompt.sh

export PROMPT_COMMAND='__git_ps1 "\W" " $ "'
# SET EDITOR
export EDITOR=vim

# PRESERVE HISTORY

# Maximum number of history lines in memory
export HISTSIZE=50000
# Maximum number of history lines on disk
export HISTFILESIZE=50000
# Ignore duplicate lines
export HISTCONTROL=ignoredups:erasedups
# append history file instead of overwrite
shopt -s histappend
# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"


if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# ALIASES 
# =================
alias restart_video='sudo killall VDCAssistant'
alias restart_audio='sudo killall coreaudiod'

man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

desktop() {
  if [[ $@ == "--hide" ]]; then
      command defaults write com.apple.finder CreateDesktop false; killall Finder
  elif
    [[ $@ == "--show" ]]; then
      command defaults write com.apple.finder CreateDesktop true; killall Finder
  else
    printf "\a missing arg: use hide or show flags \n"
  fi
}

function cd {
    builtin cd "$@"
    if [ -d ".git" ]; then
        grep "git secrets --pre_commit_hook" .git/hooks/pre-commit -q 2> /dev/null
        if [ ! $? -eq 0 ]; then
            git secrets --install
        fi
    fi
}

# PSQL
alias pg-start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias pg-stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"

# GIT ALIASES
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '

alias got='git '
alias get='git '

alias bash_profile='vim ~/.bash_profile'
alias vimrc='vim ~/.vimrc'

alias bx='bundle exec'
alias bxr='bundle exec rspec'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

source ~/.sb_profile
