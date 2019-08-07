# Credit: github.com/trustin
asdf_java_wrapper() {
  if [[ "$(\asdf current java 2>&1)" =~ "(^([-_.a-zA-Z0-9]+)[[:space:]]*\(set by.*$)" ]]; then
    export JAVA_HOME=$(\asdf where java ${BASH_REMATCH[2]})
  else
    export JAVA_HOME=''
  fi
}

asdf_java_wrapper
