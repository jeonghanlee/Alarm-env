Alarm Trio Configuration Environment
===

Configuration Environment for Alarm Trio at https://github.com/ControlSystemStudio/phoebus/tree/master/services

# Alarm Trio

## alarm-server

## alarm-logger

## alarm-config-logger



# Build

* Download the latest phoebus source
```
$ make init
```

* Build trio
```
$ make build
```

* Build an individual one
```
$ make build.alarm-server
$ make build.alarm-logger
$ make build.alarm-config-logger
```

* Remove the downloaded source
```
$ make distclean
```

* Print out makefile variables
```
$ make vars
```
