Alarm Trio Configuration Environment
===

Configuration Environment for Alarm Trio at https://github.com/ControlSystemStudio/phoebus/tree/master/services

# Alarm Trio

## alarm-server
* Standard Java Application


## alarm-logger
* Java SpringBoot Application 

## alarm-config-logger
* Java SpringBoot Application


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
$ make sd_config.alarm-server
$ make sd_config.alarm-logger
$ make sd_config.alarm-config-logge
```

Then please edit `*.service` file according to individual options. 

```
$make install 
```
or 
```
$ make install.alarm-server
$ make install.alarm-logger
$ make install.alarm-config-logger
```

# Typical Setup Rule

```
$ make init
$ make build
$ make sd_config
$ make install
$ make sd_start
```
For alarm-server

```
$ make init
$ make build.alarm-server
$ make sd_config.alarm-server
$ make install.alarm-server
$ make sd_start.alarm-server
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
* Install Trio : Should run `make build` first

```
$ make install
```
* Uninstall Trio
```
$ make uninstall
```

* Reinstall Trio
```
$ make Reinstall
```

* Check installation path, and systemd unit file (tree is required)
```
$ make exist
```
The default `tree` `LEVEL` is 1, one can explore more with the following option:
```
$ make exist LEVEL=2
```

* Restart everything

```
$ make restart
```



## Individual One

* Build
```
$ make build.alarm-server
$ make build.alarm-logger
$ make build.alarm-config-logger
```

* Generate systemd unit files
One can generate it by hand, please look at `site-template/sd.service.in`
```
$ make sd_config.alarm-server
$ make sd_config.alarm-logger
$ make sd_config.alarm-config-logger

```

* Install : should run `make build.TARGET` first
This rule contains `sd_install.TARGET`, so the corresponding systemd unit file should be in `site-template` path. We don't generate it automatically by `install` rule in order to give a possiblity to update it before installation. 
** Install the systemd unit file
** Run `systemctl daemon-reload`
** Enable that systemd unit
```
$ make install.alarm-server
$ make install.alarm-logger
$ make install.alarm-config-logger
```

* Uninstall 
** Stop the systemd service
** Disable the systemd service
** Remove the systemd unit file
** Remove the corresponding alarm service

```
$ make uninstall.alarm-server
$ make uninstall.alarm-logger
$ make uninstall.alarm-config-logger
```

* Reinstall (uninstall / install)
```
$ make reinstall.alarm-server
$ make reinstall.alarm-logger
$ make reinstall.alarm-config-logger
```


* Check installation path, and systemd unit file
```
$ make exist.alarm-server
$ make exist.alarm-logger
$ make exist.alarm-config-logger
```




* Start / stop / status / restart service
** `sd_start` can be replaced with `sd_status`, `sd_stop`, `sd_restart`, `sd_disable` and `sd_enable`. 

```
$ make sd_start.alarm-server
$ make sd_start.alarm-logger
$ make sd_start.alarm-config-logger
```

* Restart everything

```
$ make restart.alarm-server
$ make restart.alarm-logger
$ make restart.alarm-config-logger
```

