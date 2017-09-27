# asdf-java

[Java](https://www.java.com/en/) plugin for the [asdf](https://github.com/asdf-vm/asdf) version manager

## Obey

By using this software you agree to:

- [Oracle Binary Code License Agreement for the Java SE Platform Products and JavaFX](http://www.oracle.com/technetwork/java/javase/terms/license/index.html)
- [Oracle Technology Network Early Adopter Development License Agreement](http://www.oracle.com/technetwork/licenses/ea-license-noexhibits-1938914.html) in case of EA releases
- Apple's Software License Agreement in case of "Java for OS X"
- [International License Agreement for Non-Warranted Programs](http://www14.software.ibm.com/cgi-bin/weblap/lap.pl?la_formnum=&li_formnum=L-PMAA-A3Z8P2&l=en) in case of IBM SDK, Java Technology Edition.

## Disclaimer

This plugin is at a very early stage in development.
You may find bugs. You may find catasrophic and irreversible bugs.
If you aren't comfortable losing all the things and building from scratch,
then please wait for a beta release.

## Install

After installing [asdf](https://github.com/asdf-vm/asdf),
you can add this plugin like this:

```bash
asdf plugin-add java https://github.com/skotchpine/asdf-java
```

and install new versions like this:

```bash
asdf install java jdk-8u141
```

and switch versions like this:

```bash
asdf global java jdk-8u141
```

## Reading

Read the [asdf readme](https://github.com/asdf-vm/asdf)
for instructions on how to install and manage versions of any language.

If you have trouble with any expected features,
have any feature requests or want to contribute,
please [do an issue](https://github.com/skotchpine/asdf-java/issues).

## Upcoming

Probable next steps are:

1. JDK 9 support
2. JDK 7 and 6 support
3. Gradle and Maven support
4. Test
5. Release

## Homage

This plugin wouldn't be possible without the current Java version managers.
Here's a list of repos with similar affects that were heavily referenced here:

- [jabba](https://github.com/hsyiko/jabba)
- [sdkman](https://github.com/sdkman/sdkman-cli)
- [Arch's JDK](https://aur.archlinux.org/packages/jdk/)

## Development

Here are a few resources for better coding:

- asdf's [creating-plugins.md](https://github.com/asdf-vm/asdf/blob/master/docs/creating-plugins.md)
- [Bash Hackers Wiki](http://wiki.bash-hackers.org/)
