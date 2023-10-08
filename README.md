# asdf-java

[![Build status](https://github.com/halcyon/asdf-java/workflows/asdf-java%20Tests/badge.svg?branch=master)](https://github.com/halcyon/asdf-java/actions?query=workflow%3A%22asdf-java+Tests%22+branch%3Amaster) [![travis ci](https://travis-ci.org/halcyon/asdf-java.svg?branch=master)](https://travis-ci.org/halcyon/asdf-java) [![Join the chat at https://gitter.im/asdf-java/community](https://badges.gitter.im/asdf-java/community.svg)](https://gitter.im/asdf-java/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

[Java](https://www.java.com/en/) plugin for the [asdf](https://github.com/asdf-vm/asdf) version manager.

## Requirements
- [bash v5.0](https://www.gnu.org/software/bash/)
- [curl](https://curl.haxx.se/)
- [sha256sum](https://www.gnu.org/software/coreutils/) (only on Linux)
- [unzip](http://infozip.sourceforge.net/UnZip.html)
- [jq](https://stedolan.github.io/jq/) (only for updating the release data)

## Install

```
asdf plugin-add java https://github.com/halcyon/asdf-java.git
```

## Use

Check [asdf](https://asdf-vm.github.io/asdf/) for instructions on how to install & manage versions of Java.

## Install

List candidate JDKs:

```
asdf list-all java
```

Install a candidate listed from the previous command like this:

```
asdf install java adoptopenjdk-11.0.16+8
```

### Setting a version

Select an installed candidate for use like this:

```
asdf global java adoptopenjdk-11.0.16+8
```
or just for the local directory
```
asdf local java adoptopenjdk-11.0.16+8
```

### Latest

If you just want the latest of a major version (without worrying about the patch number), install it like this:

```
asdf install java latest:adoptopenjdk-11
```

Similarly, you can set the global/local version. The latest tag will resolve to the most recent version.

Running `asdf local java latest:adoptopenjdk-11` will result in the following:

```shell
$ cat .tool-versions
java adoptopenjdk-11.0.16+8
```

## JAVA_HOME
To set `JAVA_HOME` in your shell's initialization add the following:

`. ~/.asdf/plugins/java/set-java-home.bash`

For zsh shell, instead use:

`. ~/.asdf/plugins/java/set-java-home.zsh`

For fish shell, instead use:

`. ~/.asdf/plugins/java/set-java-home.fish`

For nushell shell, instead use:

`source ~/.asdf/plugins/java/set-java-home.nu`

For xonsh shell, instead use:

`source ~/.asdf/plugins/java/set-java-home.xsh`

## macOS

### `JAVA_HOME` integration

Some applications in macOS use `/usr/libexec/java_home` to set java home.

Setting `java_macos_integration_enable` to yes on `.asdfrc` file enables this integration.

```
java_macos_integration_enable=yes
```

_Note: Not all distributions of Java JDK packages offer this integration (e.g. liberica). This option only works for packages that **do offer** that integration._

### Apple Silicon integration

If you have an Apple Silicon mac, then you can choose to run either an `arm64` JVM natively, or an `x86_64` JVM under Rosetta translation. If you run the command `arch`, it will print either `arm64` (which means you are running natively) or `x86_64` (which means you are running under Rosetta translation).

When you run `asdf list all java`, it lists only the VMs which are available for the architecture you are currently running under. To switch your terminal from native ARM to Rosetta use `arch -x86_64 /bin/zsh`.
