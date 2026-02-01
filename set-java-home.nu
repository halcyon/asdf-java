def --env asdf_update_java_home [] {
    let result = (do -i { asdf which java } | complete)
    
    match $result {
        { exit_code: 0, stdout: $s } if ($s | str trim | is-not-empty) => {
            let java_home = (
                $s
                | lines | first | str trim
                | path expand
                | path dirname | path dirname
            )
            $env.JAVA_HOME = $java_home
            $env.JDK_HOME = $java_home
        }
        _ => { hide-env -i JAVA_HOME JDK_HOME }
    }
}

$env.config.hooks.pre_prompt = ($env.config.hooks.pre_prompt | default [] | append {
    asdf_update_java_home
})
