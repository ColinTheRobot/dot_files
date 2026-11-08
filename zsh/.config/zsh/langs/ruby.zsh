eval "$(rbenv init - zsh)"

# Selenium-driven rspec runs exceed macOS's default open file limit
ulimit -Sn 10240

# libpq's GSSAPI probe crashes forked Ruby processes on macOS
export PGGSSENCMODE=disable

# Run the specs changed on this branch vs. origin/<base> (default master).
run_modified_specs() {
  local base=${1:-master}
  local -a specs
  specs=(${(f)"$(git diff --name-only --diff-filter=ACMR "origin/$base...HEAD" -- 'spec/**/*_spec.rb')"})
  if (( ${#specs[@]} == 0 )); then
    echo "run_modified_specs: no changed specs vs origin/$base"
    return 1
  fi
  bundle exec rspec "${specs[@]}"
}
