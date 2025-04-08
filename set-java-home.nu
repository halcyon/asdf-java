def asdf_update_java_home [] {
    let $java_path = (asdf which java)

    if $java_path {
        let $full_path = (realpath $java_path | lines | nth 0 | str trim)

        let $java_home = ($full_path | path dirname | path dirname)
        $env.JAVA_HOME = $java_home
        $env.JDK_HOME = $java_home
    }
}
