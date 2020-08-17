#!/usr/bin/env bash
#
#  Copyright (c) 2020           Jeong Han Lee
#
#  The program is free software: you can redistribute
#  it and/or modify it under the terms of the GNU General Public License
#  as published by the Free Software Foundation, either version 2 of the
#  License, or any newer version.
#
#  This program is distributed in the hope that it will be useful, but WITHOUT
#  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
#  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
#  more details.
#
#  You should have received a copy of the GNU General Public License along with
#  this program. If not, see https://www.gnu.org/licenses/gpl-2.0.txt
#
#  Author  : Jeong Han Lee
#  email   : jeonghan.lee@gmail.com
#  Date    : 
#
#  version : 0.0.1

declare -g SC_SCRIPT;
#declare -g SC_SCRIPTNAME;
declare -g SC_TOP;
#declare -g LOGDATE;

SC_SCRIPT="$(realpath "$0")";
#SC_SCRIPTNAME=${0##*/};
SC_TOP="${SC_SCRIPT%/*}"
#LOGDATE="$(date +%y%m%d%H%M)"


function pushd { builtin pushd "$@" > /dev/null || exit; }
function popd  { builtin popd  > /dev/null || exit; }


function prop_test
{
    local name=${1}; shift;
    local filter="alarm-server";

    # shellcheck disable=SC2164
    pushd "$SC_TOP/../"
    if [ -z "$name" ]; then
	printf "\\n>>>>> make prop \\n"
	make prop
	printf "\n>>>>> Check Setting files \\n"
	cat -b site-template/*.properties
	cat -b site-template/*.ini
	printf "\\n >>>>> Removing files \\n"
	make prop_clean
	ls site-template/*.ini
	ls site-template/*.properties
	printf "\\n >>>>>  Should see No such file or directory \\n"
    else
	local suffix=properties;
	if test "${name#*$filter}" != "$name"; then
	    suffix=ini
	fi
	printf "\\n>>>>> make prop.%s \\n" "$name"
	make prop."${name}"
	printf "\\n>>>>> Check Setting files \\n"
	cat -b site-template/"${name}.${suffix}"
	printf "\\n >>>>> Removing files \\n"
	make prop_clean."${name}"
	ls site-template/"${name}.${suffix}"
	printf "\\n >>>>>  Should see No such file or directory \\n"
    fi
	# shellcheck disable=SC2164
    popd
}



function sd_test
{
    local name=${1}; shift;
	# shellcheck disable=SC2164	
    pushd "${SC_TOP}/../"
    if [ -z "$name" ]; then
	printf "\n>>>>> make sd_config \n"
	make sd_config
	printf "\n>>>>> Check Systemd unit file \n"
	cat -b site-template/*.service
	printf "\n >>>>> Removing files \n"
	make sd_clean
	ls site-template/*.service
	printf "\n >>>>>  Should see No such file or directory \n"
    else
	printf "\n>>>>> make sd_config \n"
	make sd_config."${name}"
	printf "\n>>>>> Check Systemd unit file \n"
	cat -b site-template/"${name}".service
	printf "\n >>>>> Removing files \n"
	make sd_clean."${name}"
	ls site-template/"${name}".service
	printf "\n >>>>>  Should see No such file or directory \n"
    fi
	# shellcheck disable=SC2164	
    popd
}


function build_test
{
    
    local name=${1}; shift;
	# shellcheck disable=SC2164
    pushd "${SC_TOP}/../"
    if [ -z "$name" ]; then
	printf "\\n\\n>>>>> make build \\n\\n"
	make build
	printf "\\n>>>>> make sd_config \\n"
	make sd_config
	printf "\\n\\n>>>>> make install \\n\\n"
	make install
	printf "\\n\\n>>>>> make exist \\n"	
	make exist
	printf "\\n\\n>>>>> make uninstall \\n"	
	make uninstall
	printf "\\n\\n>>>>> make exist \\n"	
	make exist
	printf ">>>> Should see [error opening dir]\\n"
    else
	printf "\\n\\n >>>>> make build \\n"
	make build."${name}"
	printf "\\n>>>>> make sd_config \\n"
	make sd_config."${name}"
	printf "\\n\\n>>>>> make install \\n"	
	make install."${name}"
	printf "\\n\\n >>>>> make exist \\n"	
	make exist."${name}"
	printf "\\n\\n >>>>> make uninstall \\n"
	make uninstall."${name}"
	printf "\\n\\n >>>>> make exist \\n"
	make exist."${name}"
	printf ">>>> Should see [error opening dir]\n"
    fi
	# shellcheck disable=SC2164
    popd
}


function usage
{
    {
	echo " < option > ";
	echo "";
      	echo "           sd0       : generate all systemd unit files ";
      	echo "           sd1       : generate alarm-server systemd unit file";
      	echo "           sd2       : generate alarm-logger systemd unit file";
      	echo "           sd3       : generate alarm-config-logger systemd unit file";
		echo "           prop0     : generate all properties files";
      	echo "           prop1     : generate alarm-server properties file";
      	echo "           prop2     : generate alarm-logger properties file";
      	echo "           prop3     : generate alarm-config-logger properties file";
		echo "           build0    : build all alarm services";
      	echo "           build1    : build alarm-server";
      	echo "           build2    : build alarm-logger";
      	echo "           build3    : build alarm-config-logger";
		echo "           all       : all";
		echo "";
		echo "";
	
		echo "  Examples : ";
		echo "";
		echo "          $0 sd1 ";
		echo "";       
		echo "";
	
    } 1>&2;
    exit 1; 
}

function test_all
{
    sd_test;
    sd_test alarm-server;
    sd_test alarm-logger;
    sd_test alarm-config-logger;
    prop_test;
    prop_test alarm-server;
    prop_test alarm-logger;
    prop_test alarm-config-logger;
    build_test;
    build_test alarm-server;
    build_test alarm-logger;
    build_test alarm-config-logger;
}



case "$1" in
    sd0)    sd_test;;
    sd1)    sd_test alarm-server;;
    sd2)    sd_test alarm-logger;;
    sd3)    sd_test alarm-config-logger;;
    prop0)  prop_test;;
    prop1)  prop_test alarm-server;;
    prop2)  prop_test alarm-logger;;
    prop3)  prop_test alarm-config-logger;;
    build0) build_test;;
    build1) build_test alarm-server;;
    build2) build_test alarm-logger;;
    build3) build_test alarm-config-logger;;
    all)    test_all;;
    *)      usage;;
esac

exit 0; 


