# asdf-java

[![travis ci](https://travis-ci.org/halcyon/asdf-java.svg?branch=master)](https://travis-ci.org/halcyon/asdf-java)

[Java](https://www.java.com/en/) plugin for the [asdf](https://github.com/asdf-vm/asdf) version manager.

## Requirements
- [jq](https://stedolan.github.io/jq/)
- [curl](https://curl.haxx.se/)
- [sha256sum](https://www.gnu.org/software/coreutils/)

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

`. ~/.asdf/plugins/java/set-java-home.sh`
