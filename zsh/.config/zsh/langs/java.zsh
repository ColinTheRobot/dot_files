export PATH=/opt/homebrew/opt/openjdk/bin:$PATH

spring() {
  local profiles="${(j:,:)@:-local}"
  ./mvnw spring-boot:run -Dactive.profile="$profiles"
}

# SDKMAN must come after anything else that changes PATH
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
