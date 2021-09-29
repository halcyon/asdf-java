function _asdf_java_absolute_dir_path {
    local absolute_path
    absolute_path="$( cd -P "$( dirname "$1" )" && pwd )"
    echo "$absolute_path"
}

function _asdf_java_update_java_home() {
  local java_path
  java_path="$(asdf which java)"
  if [[ -n "${java_path}" ]]; then
    export JAVA_HOME
    JAVA_HOME="$(dirname "$(_asdf_java_absolute_dir_path "${java_path}")")"
    export JDK_HOME=${JAVA_HOME}
  fi
}

function _asdf_java_prompt_command() {
  if [[ "${PWD}" == "${LAST_PWD}" ]]; then
    return
  fi
  LAST_PWD="${PWD}"
  _asdf_java_update_java_home
}

if ! [[ "${PROMPT_COMMAND:-}" =~ _asdf_java_prompt_command ]]; then
  PROMPT_COMMAND="_asdf_java_prompt_command${PROMPT_COMMAND:+;$PROMPT_COMMAND}"
fi
