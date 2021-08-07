asdf_update_java_home() {
  local java_path
  java_path="$(asdf which java)"
  if [[ -n "${java_path}" ]]; then
    if [[ "$OSTYPE" == "darwin"* && "${java_path}" == "/usr/bin/java" ]]; then
      export JAVA_HOME
      JAVA_HOME="$(/usr/libexec/java_home)"
    else
      export JAVA_HOME
      JAVA_HOME="$(dirname "$(dirname "${java_path:A}")")"
    fi
  fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd asdf_update_java_home
