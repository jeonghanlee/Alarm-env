# Phoebus with macOS 

This is currently only tested with only `arm64`.


## Commands

The following steps are required to prepare and compile the latest Phoebus in a clone directory.

```bash
make init
make patch
make conf.macos
make build.phoebus
make prop.phoebus
```

### Install it through a Linux way

```bash
make install.phoebus
make exist
source scripts/activate-phoebus
xPhoebus
```

### Install it to Applications

Please check the LaunchPad, one can see the Advanced Light Source Phoebus Icon.

```bash
make macapp
```

### Create the dmg file

`dmg` file will be located in `$(TOP)`


```bash
make dmgapp
```

### Zipped Apple Applications

`zip` file will be located in `$(TOP)`

```bash
make zipapp
```

### tar.gz

`tar.gz` file will be located in `$(TOP)`

```bash
make tarapp
```
