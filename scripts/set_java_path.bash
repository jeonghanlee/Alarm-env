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
#  Date    : Tuesday, June 23 21:39:10 PDT 2020#
#  version : 0.0.1
#
# 

set -e

# the following function drop_from_path was copied from
# the ROOT build system in ${ROOTSYS}/bin/, and modified
# a little to return its result
function drop_from_path
{
    #
    # Assert that we got enough arguments
    if test $# -ne 2 ; then
	echo "drop_from_path: needs 2 arguments"
	return 1
    fi

    local p=$1
    local drop=$2

    local new_path=`echo $p | sed -e "s;:${drop}:;:;g" \
                 -e "s;:${drop};;g"   \
                 -e "s;${drop}:;;g"   \
                 -e "s;${drop};;g";`
    echo ${new_path}
}


function set_variable
{
    if test $# -ne 2 ; then
	echo "set_variable: needs 2 arguments"
	return 1
    fi

    local old_path="$1"
    local add_path="$2"

    local new_path=""
    local system_old_path=""

    if [ -z "$old_path" ]; then
	new_path=${add_path}
    else
	system_old_path=$(drop_from_path ${old_path} ${add_path})
	if [ -z "$system_old_path" ]; then
	    new_path=${add_path}
	else
	    new_path=${add_path}:${system_old_path}
	fi
   
    fi

    echo "${new_path}"
    
}


if [ -z "$2" ]; then
    JAVA_HOME=$(dirname $(dirname $(realpath `which javac`)))
else
    JAVA_HOME=$(dirname $(dirname $(realpath $2/javac)))
fi


if [ "$1" = "set" ]; then
    old_path=${PATH}
    new_PATH="${JAVA_HOME}/bin"
    PATH=$(set_variable "${old_path}" "${new_PATH}")
    export PATH
    export JAVA_HOME
    
elif [ "$1" = "unset" ]; then
    system_path=${PATH};
    drop_path="${JAVA_HOME}/bin"
    PATH=$(drop_from_path "${system_path}" "${drop_path}")
    export PATH
    unset JAVA_HOME
fi
