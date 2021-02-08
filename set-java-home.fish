function absolute_dir_path -a name
    set --local absolute_path (cd (dirname "$name") && pwd)
    echo "$absolute_path"
end

function asdf_update_java_home --on-event fish_prompt
  set --local java_path (asdf which java)
  if test -n "$java_path"
    set --local full_path (absolute_dir_path "$java_path")
    set -gx JAVA_HOME (dirname "$full_path")
  end
end
