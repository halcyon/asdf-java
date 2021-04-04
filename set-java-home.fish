function asdf_update_java_home --on-event fish_prompt
  set --local java_path (asdf which java)
  if test -n "$java_path"
    set --local full_path (builtin realpath "$java_path")

    switch (uname)
        case Darwin
            if test "$java_path" == "/usr/bin/java"
                set -gx JAVA_HOME /usr/libexec/java_home
            else
                # `builtin realpath` returns $JAVA_HOME/bin/java, so we need two `dirname` calls
                # in order to get the correct JAVA_HOME directory
                set -gx JAVA_HOME (dirname (dirname "$full_path"))
            end
        case '*'
            # `builtin realpath` returns $JAVA_HOME/bin/java, so we need two `dirname` calls
            # in order to get the correct JAVA_HOME directory
            set -gx JAVA_HOME (dirname (dirname "$full_path"))
        end
    end
  end
end
