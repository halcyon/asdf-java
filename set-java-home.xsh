#!/usr/bin/env xonsh

def asdf_update_java_home() -> None:
    import xonsh.platform
    $java_path=$(asdf which java).rstrip('\n')
    if len($java_path) > 0:
        if xonsh.platform.ON_DARWIN:
            if $java_path == '/usr/bin/java':
                $JAVA_HOME=$(/usr/libexec/java_home).rstrip('\n')
            else:
                $JAVA_HOME=$(dirname $(dirname $(realpath $java_path))).rstrip('\n')
        else:
            $JAVA_HOME=$(dirname $(dirname $(realpath $java_path))).rstrip('\n')
    del $java_path

@events.on_chdir
def update_java_home_on_chdir(olddir, newdir, **kw) -> None:
    asdf_update_java_home()

@events.on_post_init
def update_java_home_on_post_init() -> None:
    asdf_update_java_home()
