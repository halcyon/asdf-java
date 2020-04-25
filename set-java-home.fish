function asdf_update_java_home --on-event fish_prompt
  set --local java_path (asdf which java)
  if test -n "$java_path"
    set --local full_path (realpath "$java_path")
    set --local full_path_dir (dirname "$full_path")
    set -gx JAVA_HOME (dirname "$full_path_dir")
  end
end
