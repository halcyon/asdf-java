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

`asdf list-all java`

Install a candidate listed from the previous command like this:

`asdf install java adopt-openjdk-12.0.2+10.2`

Select an installed candidate for use like this:

`asdf global java adopt-openjdk-12.0.2+10.2`

## JAVA_HOME
To set JAVA_HOME in your shell's initialization add the following:

`. ~/.asdf/plugins/java/set-java-home.bash`

For zsh shell, instead use:

`. ~/.asdf/plugins/java/set-java-home.zsh`

For fish shell, instead use:

`. ~/.asdf/plugins/java/set-java-home.fish`

For xonsh shell, instead use:

`source ~/.asdf/plugins/java/set-java-home.xsh`

## macOS Integration
Some applications in macOS use `/usr/libexec/java_home` to set java home.

Setting java_macos_integration_enable to yes on `.asdfrc` file enables this integration.

```
java_macos_integration_enable = yes
```

### Liberica
The Liberica distributions this plugin uses [do not contain the needed files for the macOS integration](https://github.com/bell-sw/Liberica/issues/42).
The plugin will try to download the `.pkg` distribution for the same version, but this does not always exist. 
If it doesn't exist this plugin cannot provide the macOS Integration for that version. It will log a warning when that happens.
