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
CONTENTS="$( cd "$(dirname "$0")" || exit ; pwd -P )"
BASE=${CONTENTS%/*/*}

# Phoebus TOP
TOP="${BASE}/phoebus"

if [ -d "${TOP}/update" ]
then
  echo "Installing update..."
  cd "${TOP}" || exit
  rm -rf doc lib p*.jar
  mv update/* .
  rmdir update
  echo "Updated."
fi

export JAVA_HOME="$BASE/jdk"

export PATH="$JAVA_HOME/bin:$PATH"

export HOSTNAME=$(/bin/hostname)

JAR="${TOP}/product-phoebus.jar"

# To get one instance, use server mode
# OPT="-server 4918"

java -jar "$JAR" "$OPT" "$@" 
