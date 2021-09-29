#!/usr/bin/env xonsh

def asdf_update_java_home() -> None:
    $java_path=$(asdf which java)
    if len($java_path) > 0:
        $JAVA_HOME=$(dirname $(dirname $(realpath $java_path))).rstrip('\n')
        $JDK_HOME=$JAVA_HOME
    del $java_path

@events.on_chdir
def update_java_home_on_chdir(olddir, newdir, **kw) -> None:
    asdf_update_java_home()

@events.on_post_init
def update_java_home_on_post_init() -> None:
    asdf_update_java_home()
