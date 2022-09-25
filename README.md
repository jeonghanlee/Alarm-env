# Phoebus and Alarm Trio Configuration Environment
[![Ubuntu Latest](https://github.com/jeonghanlee/phoebus-env/actions/workflows/ubuntu.yml/badge.svg)](https://github.com/jeonghanlee/phoebus-env/actions/workflows/ubuntu.yml)
[![macOS build](https://github.com/jeonghanlee/phoebus-env/actions/workflows/macOS.yml/badge.svg)](https://github.com/jeonghanlee/phoebus-env/actions/workflows/macOS.yml)

Configuration Environment for Phoebus [1] and Alarm Trio [2].

## Roles

To download, install, setup all relevant components, one should do many steps manually. This repository was designed for the easy-to-reproducible environment for ControlSystemStudio/phoebus and its alarm services (alarm-server, alarm-logger, and alarm-config-logger), because most of their configuration are common, shareable, and consistent.

## Notice
  
* This environment can change a system configuration as small as possible. Thus, all things we can do is to remove installation directory and clean up systemd services properly. It uses an ugly makefile, Linux command line tools, and bash shell scripts.

* There are a plenty of tools around us to do similar jobs. This repository is designed for my working environment and conditions. I do not have available time to learn others automation tools, such as ansible, and so on. And I am enough to be tired by thier own incompatibilities within their release versions.

## Phoebus Building and Installation

See [docs/Phoebus.md](https://github.com/jeonghanlee/phoebus-env/blob/master/docs/Phoebus.md)

If one would like to see the current status of the native support of Phoebus on Apple M1 aarch64, please [docs/PhoebusOnAppleM1.md](https://github.com/jeonghanlee/phoebus-env/blob/master/docs/PhoebusOnAppleM1.md)

## Alarm Trios Building and Installation

See [docs/AlarmTrio.md](https://github.com/jeonghanlee/phoebus-env/blob/master/docs/AlarmTrio.md)

## Reporting issues

If you encounter any bugs you can report them here on Github.

## Known issues

See [docs/KnownIssues.md](https://github.com/jeonghanlee/phoebus-env/blob/master/docs/KnownIssues.md)

## References

[1] <https://github.com/ControlSystemStudio/phoebus>

[2] <https://github.com/ControlSystemStudio/phoebus/tree/master/services>
