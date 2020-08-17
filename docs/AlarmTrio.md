# Alarm Trio Configuration Environment

Configuration Environment for Alarm Trio at <https://github.com/ControlSystemStudio/phoebus/tree/master/services>

## Alarm Trio

### Requirements

* `procServ` [1] : Major Linux distributions provide it within packaging system.

### alarm-server

* Standard Java Application
* Run within `procServ`
* `telent localhost 4510`

### alarm-logger

* Java SpringBoot Application
* Run within `procServ`
* `telent localhost 4511`

### alarm-config-logger

* Java SpringBoot Application

## Configuration defined in each systemd unit file

For example, there are three options variables defined in `configure/CONFIG_OPTS` such as

```bash
OPTIONS_CONFIG_LOGGER
OPTIONS_LOGGER
OPTIONS_SERVER
```

By using them, the following rule create the corresponding systemd unit file. If one would like to edit it, before installing it to system.

```bash
make sd_config
```

or

```bash
make sd_config.alarm-server
make sd_config.alarm-logger
make sd_config.alarm-config-logger
```

Then please edit `*.service` file according to individual options.

```bash
make install
```

or

```bash
make install.alarm-server
make install.alarm-logger
make install.alarm-config-logger
```

## Typical Setup Rule

```bash
make init
make build
make sd_config
make install
make sd_start
```

For alarm-server

```bash
make init
make build.alarm-server
make sd_config.alarm-server
make install.alarm-server
make sd_start.alarm-server
systemctl status alarm-server
```

## Build

* Download the latest phoebus source

```bash
make init
```

* If the system doesn't have any Phoebus building history,

```bash
make depedencies-build
```

* Remove the downloaded source

```bash
make distclean
```

* Print out makefile variables

```bash
make vars
```

## All Trio

* Build trio

```bash
make build
```

* Install Trio : Should run `make build` first

```bash
make install
```

* Uninstall Trio

```bash
make uninstall
```

* Reinstall Trio

```bash
make reinstall
```

* Check installation path, and systemd unit file (tree is required)

```bash
make exist
```

The default `tree` `LEVEL` is 1, one can explore more with the following option:

```bash
make exist LEVEL=2
```

* Restart everything

```bash
make restart
```

## Individual One

* Build

```bash
make build.alarm-server
make build.alarm-logger
make build.alarm-config-logger
```

* Generate systemd unit files
One can generate it by hand, please look at `site-template/sd.service.in`

```bash
make sd_config.alarm-server
make sd_config.alarm-logger
make sd_config.alarm-config-logger
```

* Install : should run `make build.TARGET` first
This rule contains `sd_install.TARGET`, so the corresponding systemd unit file should be in `site-template` path. We don't generate it automatically by `install` rule in order to give a possiblity to update it before installation.

** Install the systemd unit file

** Run `systemctl daemon-reload`

** Enable that systemd unit

```bash
make install.alarm-server
make install.alarm-logger
make install.alarm-config-logger
```

* Uninstall

** Stop the systemd service

** Disable the systemd service

** Remove the systemd unit file

** Remove the corresponding alarm service

```bash
make uninstall.alarm-server
make uninstall.alarm-logger
make uninstall.alarm-config-logger
```

* Reinstall (uninstall / install)

```bash
make reinstall.alarm-server
make reinstall.alarm-logger
make reinstall.alarm-config-logger
```

* Check installation path, and systemd unit file

```bash
make exist.alarm-server
make exist.alarm-logger
make exist.alarm-config-logger
```

* Start / stop / status / restart service
** `sd_start` can be replaced with `sd_status`, `sd_stop`, `sd_restart`, `sd_disable` and `sd_enable`.

```bash
make sd_start.alarm-server
make sd_start.alarm-logger
make sd_start.alarm-config-logger
```

* Restart everything

```bash
make restart.alarm-server
make restart.alarm-logger
make restart.alarm-config-logger
```

## References

[1] procServ : <https://github.com/ralphlange/procServ>
