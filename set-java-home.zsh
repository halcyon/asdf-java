function absolute_dir_path {
    echo "$(dirname $1:A)"
}

asdf_update_java_home() {
  local java_path
  java_path="$(asdf which java)"
  if [[ -n "${java_path}" ]]; then
    export JAVA_HOME
    JAVA_HOME="$(dirname "$(absolute_dir_path "${java_path}")")"
  fi
}

autoload -U add-zsh-hook
add-zsh-hook precmd asdf_update_java_home
