asdf_update_java_home() {
  local java_path
  java_path="$(asdf where java)"
  if [[ -n "${java_path}" ]]; then
    export JAVA_HOME
    JAVA_HOME="${java_path}"
  fi
}

preexec () {
  asdf_update_java_home
}

preexec_invoke_exec () {
    [ -n "${COMP_LINE}" ] && return  # do nothing if completing
    [ "${BASH_COMMAND}" = "${PROMPT_COMMAND}" ] && return # don't cause a preexec for $PROMPT_COMMAND
    preexec
}

trap 'preexec_invoke_exec' DEBUG
