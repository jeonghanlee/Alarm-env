#!/bin/sh
# Phoebus launcher for Mac OS X
# Original code comes from 
# https://github.com/kasemir/phoebus-sns/blob/master/app_template/Contents/MacOS/main.command
# 
# Modified Version Feb 20, 2021
# Jeong Han Lee JeongLee@lbl.gov
#
# Location of this script
# cd .. pwd determines the full path
# even if called from shell with relative path
# 
MACOS="$( cd "$(dirname "$0")" || exit ; pwd -P )"
BASE=${MACOS%/*/*}

# Phoebus TOP
TOP="${BASE}/phoebus"
CONTENTS="${BASE}/Contents"
JAVA_PATH="${BASE}/jdk"

if [ -d "${TOP}/update" ]
then
  echo "Installing update..."
  cd "${TOP}" || exit
  rm -rf doc lib p*.jar
  mv update/* .
  rmdir update
  echo "Updated."
fi

JAVA_HOME="$JAVA_PATH"
PATH="$JAVA_HOME/bin:$PATH"
HOSTNAME=$(/bin/hostname)

export JAVA_HOME
export PATH
export HOSTNAME

ICNS_FILE="${CONTENTS}/Resources/Phoebus.icns"
DOCK_NAME="ALS CS Studio Phoebus"
JAR_FILE="${TOP}/product-phoebus.jar"
SETTINGS="${TOP}/phoebus_settings.ini"
JAVA_OPTIONS="-Dlogback.configurationFile=${TOP}/phoebus_logback.xml"

java  -Xdock:name="${DOCK_NAME}" -Xdock:icon="${ICNS_FILE}" "${JAVA_OPTIONS}" -jar "${JAR_FILE}" -settings "${SETTINGS}" "$OPT" "$@"
