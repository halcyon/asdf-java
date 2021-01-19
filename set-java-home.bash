function absolute_dir_path {
    local absolute_path
    absolute_path="$( cd -P "$( dirname "$1" )" && pwd )"
    echo "$absolute_path"
}

asdf_update_java_home() {
  local java_path
  java_path="$(asdf which java)"
  if [[ -n "${java_path}" ]]; then
    export JAVA_HOME
    JAVA_HOME="$(dirname "$(absolute_dir_path "${java_path}")")"
  fi
}

asdf_java_prompt_command() {
  if [[ "${PWD}" == "${LAST_PWD}" ]]; then
    return
  fi
  LAST_PWD="${PWD}"
  asdf_update_java_home
}

PROMPT_COMMAND="${PROMPT_COMMAND:+${PROMPT_COMMAND} asdf_java_prompt_command;}"
PROMPT_COMMAND="${PROMPT_COMMAND:-asdf_java_prompt_command;}"
