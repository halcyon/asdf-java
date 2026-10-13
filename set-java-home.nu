def --env asdf-update-java-home [] {
    let java_path = asdf which java | complete
    if $java_path.exit_code == 0 {
        let full_path = ($java_path.stdout | str trim | path expand)
        let java_home = ($full_path | path dirname | path dirname)
        if $java_home != ($env.JAVA_HOME? | default "") {
            $env.JAVA_HOME = $java_home
            $env.JDK_HOME = $java_home
        }
    }
}

$env.config.hooks.pre_prompt = (
  $env.config.hooks | get -o pre_prompt | default [] | prepend {|| asdf-update-java-home }
)
