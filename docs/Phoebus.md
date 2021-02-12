# Phoebus

All configurations are based on three source repositories such as pheobus [1], nsls2-phoebus [2], and phoebus-sns [3].

## Requirements

Java SDK and Maven are required. One can use the following individual distribution packages if exist.
Or Pleaes check <https://github.com/jeonghanlee/java-env>, where you can configure some predefined Java packages. If OS is MacOS Big Sur, the above repository will be useful, because it supports the native Jave environment. However, at this moment, we cannot use it, because OpenJFX is not ready for it.

### Apache Tomcat Native Library and Maven

* Debian 10

```bash
apt install maven openjfx libopenjfx-java
```

* CentOS 7

```bash
yum install maven
```

* CentOS 8 & Fedora 31

One can use `yum` instead of `dnf`. `epel-release` is needed.

```bash
dnf install maven
```

### JDK 8 or newer

* Debian 10

```bash
openjdk version "11.0.6" 2020-01-14
OpenJDK Runtime Environment (build 11.0.6+10-post-Debian-1deb10u1)
OpenJDK 64-Bit Server VM (build 11.0.6+10-post-Debian-1deb10u1, mixed mode, sharing)
```

* Fedora 31

```bash
openjdk version "1.8.0_242"
OpenJDK Runtime Environment (build 1.8.0_242-b08)
OpenJDK 654-Bit Server VM (build 25.242-b08, mixed mode)
```

* MacOS Big Sur (11.2.1)

```bash
JAVA : /opt/java-env/JDK15/bin/java 
openjdk 15.0.2 2021-01-19
OpenJDK Runtime Environment Zulu15.29+15-CA (build 15.0.2+7)
OpenJDK 64-Bit Server VM Zulu15.29+15-CA (build 15.0.2+7, mixed mode, sharing)
```

## A typical example to build and run the Phoebus

The following rules work in most Linux distribution and MacOS Big Sur (x86_64). In addtion, there is an additional rule for the Mac below. Note that for Window, please see the below.

```bash
make init
make patch
make build.phoebus
make prop.phoebus
make install.phoebus
source scripts/activate-phoebus
xPhoebus
```

## Makefile Rules

### `make init`

* Download the lastest phoebus source

* Switch to a specific version defined in `$(SRC_TAG)` in `configure/RELEASE`

```bash
make init
```

### `make patch`

* Apply patch files if patch files exist in `patch`

* Each patch file is an unique `SRC_TAG` prefix.

### `make patchrevert`

* Revert applied patch files if patch files exist in `patch`

* Each patch file is an unique `SRC_TAG` prefix.

### `make build.phoebus`

* Build the default community phoebus, located in `phoebus-src/phoebus-product/target`.

* This rule builds everything in `phoebus-src` include all alarm services.

### `make prop.phoebus`

* Generate phoebus setting file `phoebus_settings.ini` locate in `site-template` path based on repository configuration. One can check the most important configuration variables via

```bash
make vars
make vars FILTER=PS_
```

Please check site-template/phoebus_settings.ini file to match your environment. This rule is independent one, so any others cannot modify this file, so the local modification is safe. One can put its own settings.ini in `site-template` path. In this case, please don't run this command, but run `install.phoebus` directly.

### `make install.phoebus`

* `sudo` permission may be required.

* Install all phoebus files into `INSTALL_LOCATION_PHOEBUS` defined in `configure/CONTIG_SITE` and `configure/CONFIG_TARGET`

* one can check after execute this rule, what they are in, `make exist` or `make exist.phoebus`

```bash
tree -aL 1 /opt/phoebus-products/phoebus
/opt/phoebus-products/phoebus
├── activate-phoebus
├── bin
├── lib
├── phoebus.jar
├── phoebus_logback.xml
├── phoebus_logging.properties
├── phoebus_settings.ini
├── phoebus.sh
├── product-phoebus.jar -> /opt/phoebus-products/phoebus/phoebus.jar
└── .versions
```

* Expand its `tree` level with `make exist.phoebus LEVEL=2`
* Prerequirement of this rule is `make sh.phoebus` which generates two files
* If the exist `phoebus` path is found, the exist one will be renamed to `phoebus_backup_YYMMDD-HHMMSS`.

### `make sh.phoebus`

* `PHOEBUS_SHELL` and `PHOEBUS_ACTIVATE` in `configure/CONFIG_OPTS_PHOEBUS`.
* With `make install.phoebus`, this rule generate two files : `activate-phoebus` and `xphoebus` in `scripts` path.

```bash
souce scripts/activate-phoebus
xPhoebus
```

That `activate-phoebus` is also installed in `INSTALL_LOCATION_PHOEBUS`. The installation location of `xpheobus` is `INSTALL_LOCATION_PHOEBUS/bin`. In addtion. the genric `phoebus.sh` is installed in `INSTALL_LOCATION_PHOEBUS`, however we don't add the path to `PATH` in `activate-phoebus`.

## For Mac and Windows Builds

Phoebus is very easy to build cross platform. See [4].

To build a Phoebus windows product and create a zip file in $(TOP), run this command:

```bash
make windows
```

To build a tarball Phoebus product for Mac in $(TOP), run this command:

```bash
make mac
```

## Upcoming feature based on nsls2-phoebus

* Build the ALS Windows products

```bash
make windows.als
```

* Build the ALS home Linux edition

```bash
make linux.als.home
```

* Install the ALS accelerator edition

```bash
make init
make patch
make build.phoebus
make prop.phoebus
make install.phoebus.als 
```

## References

[1] <https://github.com/ControlSystemStudio/phoebus>

[2] <https://github.com/shroffk/nsls2-phoebus>

[3] <https://github.com/kasemir/phoebus-sns>

[4] <https://github.com/controlSystemStudio/phoebus#cross-platform-build>
