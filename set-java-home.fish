asdf current java 2>&1 > /dev/null
if test $status -eq 0
    set -x JAVA_HOME (asdf where java)
end
