Alarm Trio Configuration Environment
===

Configuration Environment for Alarm Trio at https://github.com/ControlSystemStudio/phoebus/tree/master/services

# Alarm Trio

## alarm-server

## alarm-logger

## alarm-config-logger

# Configuration defined in each systemd unit file

For example, there are three options variables defined in `configure/CONFIG_OPTS` such as 
```
OPTIONS_CONFIG_LOGGER
OPTIONS_LOGGER
OPTIONS_SERVER
```
By using them, the following rule create the corresponding systemd unit file. If one would like to edit it, before installing it to system. 

```
$make sd_config
```
or
```
$ make TARGET=alarm-server sd_config
$ make TARGET=alarm-logger sd_config
$ make TARGET=alarm-config-logger sd_config
```

Then please edit `*.service` file according to individual options. 

```
$make install 
```
or 

```
$ make TARGET=alarm-server install
$ make TARGET=alarm-logger install
$ make TARGET=alarm-config-logger install
```


# Build

* Download the latest phoebus source
```
$ make init
```

* Remove the downloaded source
```
$ make distclean
```

* Print out makefile variables
```
$ make vars
```


## All Trio

* Build trio
```
$ make build
```
* Install Trio
```
$ make install
```
* Uninstall Trio
```
$ make uninstall
```

* Check installation path, and systemd unit file (tree is required)
```
$ make exist
```

* Reinstall Trio
```
$ make reinstall
```

## Individual One

* Build
```
$ make TARGET=alarm-server build
$ make TARGET=alarm-logger build
$ make TARGET=alarm-config-logger build
```
* Install
```
$ make TARGET=alarm-server install
$ make TARGET=alarm-logger install
$ make TARGET=alarm-config-logger install
```

* Uninstall 
```
$ make TARGET=alarm-server uninstall
$ make TARGET=alarm-logger uninstall
$ make TARGET=alarm-config-logger uninstall
```


* Check installation path, and systemd unit file
```
$ make TARGET=alarm-server exist
$ make TARGET=alarm-logger exist
$ make TARGET=alarm-config-logger exist
```


