# https://shapeshed.com/vim-packages

export PATH="/usr/local/sbin:$PATH"
export PATH="$HOME/go/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATh="$HOME/.rbenv/shims/solargraph:$PATH"

# https://github.com/tmux/tmux/issues/1646
# TMUX errors after a hard restart with sessions
# replace the TMP dir used
export TMUX_TMPDIR=/tmp/foo

{ eval `ssh-agent`; ssh-add -K; } &>/dev/null
# PROMPT
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWCOLORHINTS=1
source ~/.git-prompt.sh
export PROMPT_COMMAND='__git_ps1 "\W" " $ "'
export DISABLE_SPRING=1

# COLOR
export TERM=xterm-256color

# GLOBAL EDITOR
export EDITOR=vim

# HISTORY PERSERVATION

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

# GIT AUTO COMPLETE
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# ALIASES / FUNCTIONS
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

# GIT 
alias gs='git status '
alias ga='git add '
# alias gb='git branch '
# alias gc='git commit'
# alias gd='git diff'
alias gco='git checkout '

alias got='git '
alias get='git '

alias sb_profile='vim ~/.sb_profile'
alias bash_profile='vim ~/.bash_profile'
alias vimrc='vim ~/.vimrc'

alias delete-merged='git branch --merged | egrep -v "(^\*|master|dev)" | xargs git branch -d'

# FZF
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

findbranch() {
  git branch | grep $@
}

fd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

RSPEC_STACKTRACE_EXCLUDE_GEMS=true

export KIBANA_VERSION=7.4.2
export KIBANA_HOME=/usr/local/Cellar/kibana/7.4.2
export KIBANA_CONF_DIR=$KIBANA_HOME/config
export PATH=$PATH:$KIBANA_HOME/bin
alias kibana='./bin/kibana'

source ~/.sb_profile


export PATH="$HOME/.cargo/bin:$PATH"
