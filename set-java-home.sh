asdf current java 2>&1 > /dev/null
if [[ "$?" -eq 0 ]]
then
    export JAVA_HOME=$(asdf where java)
fi
