# asdf-java

![travis ci](https://travis-ci.org/skotchpine/asdf-java.svg?branch=master)
[Travis Build](https://travis-ci.org/skotchpine/asdf-java)

[Java](https://www.java.com/en/) plugin for the [asdf](https://github.com/asdf-vm/asdf) version manager.

## Install

After installing [asdf](https://github.com/asdf-vm/asdf),
you can add this plugin like this:

```bash
asdf plugin-add java
```

and install new versions like this:

```bash
asdf install java oracle-10.0.2
```

and switch versions like this:

```bash
asdf global java oracle-10.0.2
```

If you want or need JAVA_HOME set you can add this to your shell initialization (in `.bashrc`, for example):

```bash
asdf_update_java_home() {
  local current
  if current=$(asdf current java); then
    local version=$(echo $current | sed -e 's|\(.*\) \?(.*|\1|g')
    export JAVA_HOME=$(asdf where java $version)
  else
    echo "No java version set. Type `asdf list-all java` for all versions."
  fi
}
asdf_update_java_home
```

If you need Gradle or Maven, you can use asdf plugins for those, too.

```bash
asdf plugin-add maven https://github.com/skotchpine/asdf-maven
asdf plugin-add gradle https://github.com/rfrancis/asdf-gradle
```

## Obey

By using this software you agree to:

- [Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX](http://www.oracle.com/technetwork/java/javase/terms/license/index.html)
- [Oracle Technology Network Early Adopter Development License Agreement](http://www.oracle.com/technetwork/licenses/ea-license-noexhibits-1938914.html) in case of EA releases
- Apple's Software License Agreement in case of "Java for OS X"
- [International License Agreement for Non-Warranted Programs](http://www14.software.ibm.com/cgi-bin/weblap/lap.pl?la_formnum=&li_formnum=L-PMAA-A3Z8P2&l=en) in case of IBM SDK, Java Technology Edition.

## Reading

Read the [asdf readme](https://github.com/asdf-vm/asdf)
for instructions on how to install and manage versions of any language.

If you have trouble with any expected features,
have any feature requests or want to contribute,
please [do an issue](https://github.com/skotchpine/asdf-java/issues).

## Homage

This plugin wouldn't be possible without the current Java version managers.
Here's a list of repos with similar affects that were heavily referenced here:

- [jabba](https://github.com/hsyiko/jabba)
- [sdkman](https://github.com/sdkman/sdkman-cli)
- [Arch's JDK](https://aur.archlinux.org/packages/jdk/)

## Development

- asdf's [creating-plugins.md](https://github.com/asdf-vm/asdf/blob/master/docs/creating-plugins.md)
- [Bash Hackers Wiki](http://wiki.bash-hackers.org/)
