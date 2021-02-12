# Phoebus on Apple Silicon M1 with Big Sur

## Requirements

### JAVA environment

One should configure the Native (aarch64) Java environment with the maven environment. Please remember this is the native (aarch64, arm64) version.
Please check the following repository <https://github.com/jeonghanlee/java-env> for Darwin (aarch64, x86) and Linux. One can check them through

```bash
$ make vars FILTER=UNAME
UNAME_M = arm64
UNAME_S = Darwin
```

OR

```bash
UNAME_M = x86_64
UNAME_S = Darwin
```

## Build

```bash
echo "JAVA_HOME:=/opt/java-env/JDK15" > configure/RELEASE.local
echo "JAVA_PATH:=/opt/java-env/JDK15/bin" >> configure/RELEASE.local
echo "MAVEN_HOME:=/opt/java-env/MAVEN363" >> configure/RELEASE.local
echo "MAVEN_PATH:=/opt/java-env/MAVEN363/bin" >> configure/RELEASE.local
```

```bash
$ make init
$ make build.phoebus
$ make prop.phoebus
$ make install.phoebus
$ make exist
No /opt/phoebus-products/alarm-server
No alarm-server.service unit file
No /opt/phoebus-products/alarm-logger
No alarm-logger.service unit file
No /opt/phoebus-products/alarm-config-logger
No alarm-config-logger.service unit file
tree -aL 1 /opt/phoebus-products/phoebus
/opt/phoebus-products/phoebus
├── .versions
├── activate-phoebus
├── authorization.conf
├── bin
├── lib
├── phoebus.jar
├── phoebus.sh
├── phoebus_logback.xml
├── phoebus_logging.properties
├── phoebus_settings.ini
└── product-phoebus.jar -> /opt/phoebus-products/phoebus/phoebus.jar

2 directories, 9 files
```

## Notice

The building procedure is quickly done, however, I see the following error messages :

```bash
Loading library prism_es2 from resource failed: java.lang.UnsatisfiedLinkError: /Users/JeongLee/.openjfx/cache/15/libprism_es2.dylib: dlopen(/Users/JeongLee/.openjfx/cache/15/libprism_es2.dylib, 1): no suitable image found.  Did find:
/Users/JeongLee/.openjfx/cache/15/libprism_es2.dylib: mach-o, but wrong architecture
/Users/JeongLee/.openjfx/cache/15/libprism_es2.dylib: mach-o, but wrong architecture
```

This may be fixed by the follwing commit in <https://github.com/openjdk/jfx/commit/e1adfa9179bb05a879b419b6221e8aa980fd6af1>. However, I don't know when they accept this commit, and release new version of jfx.

* Have to fixed `prop.phoebus` rule to use the proper JAVA options for running Phoebus
* Better to check this branch work with Darwin x86_64 environment
