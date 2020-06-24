Phoebus Configuration Environment
===

All configurations are based on three source repositories such as pheobus [1], nsls2-phoebus [2], and phoebus-sns [3].


# Build

* Download the latest phoebus source
```
$ make init
```

* Build the community Phoebus
```
$ make phoebus
```

* Generate configuration based `settings.ini` file

```
$ make prop.phoebus
```
Please check site-template/phoebus_settings.ini file to match your environment. This rule is independent one, so any others cannot modify this file, so the local modification is safe. One can put its own settings.ini in `site-template` path. In this case, please don't run this command, but run `install.phoebus` directly.

* Install the community Phoebus
```
$ make install.phoebus
```
Once one install the pheobus, one can find `activate-phoebus.bash` in `scripts` path. 
```
$ souce scripts/activate-phoebus.bash
$ run-pheobus.bash
```
That `activate-phoebus.bash` is also installed in `INSTALL_LOCATION_PHOEBUS`. The installation location of `run-pheobus.bash` is `INSTALL_LOCATION_PHOEBUS/bin`.



## Upcoming feature based on nsls2-phoebus


* Build the ALS products 
```
$ make als
```

* Print out makefile variables
```
$ make vars
```


## References
[1] https://github.com/ControlSystemStudio/phoebus

[2] https://github.com/shroffk/nsls2-phoebus

[3] https://github.com/kasemir/phoebus-sns
