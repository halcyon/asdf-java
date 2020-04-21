asdf_update_java_home() {
  local java_path
  java_path="$(asdf which java)"
  if [[ -n "${java_path}" ]]; then
    export JAVA_HOME
   JAVA_HOME="$(dirname "$(dirname "$(realpath "${java_path}")")")"
  fi
}

prompt_command() {
  asdf_update_java_home
}

if [[ -z "$PROMPT_COMMAND" ]]; then
  export PROMPT_COMMAND="prompt_command"
else
  export PROMPT_COMMAND="${PROMPT_COMMAND}; prompt_command"
fi
