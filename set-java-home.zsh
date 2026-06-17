asdf_update_java_home() {
  local java_path
  java_path="$(asdf which java 2>/dev/null || which java 2>/dev/null)"
  if [[ -n "${java_path}" ]]; then
    export JAVA_HOME
    JAVA_HOME="$(dirname "$(dirname "${java_path:A}")")"
    export JDK_HOME=${JAVA_HOME}
  fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd asdf_update_java_home
