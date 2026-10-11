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

def is-asdf-mutating []: string -> bool {
    let s = ($in | str trim)

    if not ($s like '^\^?asdf(\s|$)') { return false }
    if ($s like '^\^?asdf\s+(which|where)(\s|$)') { return false }
    
    true
}

def --env pre_execution_hook [] {
    let line = (commandline)

    if ($line | is-asdf-mutating) {
        $env._ASDF_REFRESH_NEEDED = true
    } else {
        hide-env -i _ASDF_REFRESH_NEEDED
    }
}

def --env pre_prompt_hook [] {
    if ($env._ASDF_REFRESH_NEEDED? | default false) {
        asdf_update_java_home
        hide-env -i _ASDF_REFRESH_NEEDED
    }
}

$env.config.hooks = $env.config.hooks
    | upsert pre_execution { $in | default [] | append { pre_execution_hook } }
    | upsert pre_prompt { $in | default [] | append { pre_prompt_hook } }
    | upsert env_change.PWD { $in | default [] | append { asdf_update_java_home } }
