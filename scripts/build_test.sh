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
#  Date    : Friday, May 29 01:01:59 PDT 2020
#
#  version : 0.0.0


declare -gr SC_SCRIPT="$(realpath "$0")"
declare -gr SC_SCRIPTNAME=${0##*/}
declare -gr SC_TOP="${SC_SCRIPT%/*}"
declare -gr SC_LOGDATE="$(date +%y%m%d%H%M)"


function pushd { builtin pushd "$@" > /dev/null; }
function popd  { builtin popd  "$@" > /dev/null; }




function sd_test
{
    local name=${1}; shift;
    pushd ${SC_TOP}/../
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
	make sd_config.${name}
	printf "\n>>>>> Check Systemd unit file \n"
	cat -b site-template/${name}.service
	printf "\n >>>>> Removing files \n"
	make sd_clean.${name}
	ls site-template/${name}.service
	printf "\n >>>>>  Should see No such file or directory \n"
    fi
    popd
}


function build_test
{
    
    local name=${1}; shift;
    pushd ${SC_TOP}/../
    if [ -z "$name" ]; then
	printf "\n\n>>>>> make build \n\n"
	make build
	printf "\n>>>>> make sd_config \n"
	make sd_config
	printf "\n\n>>>>> make install \n\n"
	make install
	printf "\n\n>>>>> make exist \n"	
	make exist
	printf "\n\n>>>>> make uninstall \n"	
	make uninstall
	printf "\n\n>>>>> make exist \n"	
	make exist
	printf ">>>> Should see [error opening dir]\n"
    else
	printf "\n\n >>>>> make build \n"
	make build.${name}
	printf "\n>>>>> make sd_config \n"
	make sd_config.${name}
	printf "\n\n >>>>> make install \n"	
	make install.${name}
	printf "\n\n >>>>> make exist \nn"	
	make exist.${name}
	printf "\n\n >>>>> make uninstall \nn"
	make uninstall.${name}
	printf "\n\n >>>>> make exist \n"
	make exist.${name}
	printf ">>>> Should see [error opening dir]\n"
    fi
    popd
}

function usage
{
    {
	echo " < option > ";
	echo "";
      	echo "           sd0    : ";
      	echo "           sd1    : ";
      	echo "           sd2    : ";
      	echo "           sd3    : ";
	echo "           build0    : ";
      	echo "           build1    : ";
      	echo "           build2    : ";
      	echo "           build3    : ";	
	echo ""           ;
	echo ""    ;
	
	echo "  Examples : ";
	echo ""
	echo "          $0 sd1 ";
	echo "   ";       
	echo "";
	
    } 1>&2;
    exit 1; 
}




case "$1" in
    sd0)    sd_test;;
    sd1)    sd_test alarm-server;;
    sd2)    sd_test alarm-logger;;
    sd3)    sd_test alarm-config-logger;;
    build0) build_test;;
    build1) build_test alarm-server;;
    build2) build_test alarm-logger;;
    build3) build_test alarm-config-logger;;
    *)      usage;;
esac

exit 0; 


