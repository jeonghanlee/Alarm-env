#!/usr/bin/env bash
#
#  Author  : Jeong Han Lee
#  email   : jeonghan.lee@gmail.com
#  Date    : Tuesday, June 23 21:39:10 PDT 2020#
#  version : 0.0.1
#
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

    local new_path="";
    new_path=$(echo "$p" | sed -e "s;:${drop}:;:;g" \
                 -e "s;:${drop};;g"   \
                 -e "s;${drop}:;;g"   \
                 -e "s;${drop};;g";)
    echo "${new_path}"
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
	    new_path="${add_path}"
    else
	    system_old_path=$(drop_from_path "${old_path}" "${add_path}")
	    if [ -z "$system_old_path" ]; then
	        new_path="${add_path}"
	    else
	        new_path="${add_path}":"${system_old_path}"
	    fi
    fi

    echo "${new_path}"
}

# If JAVA_HOME exists,
# Skip, export JAVA_HOME
if [ -n "$JAVA_HOME" ]; then
    export JAVA_HOME
else
    JAVAPATH="$1";
    if [ -n "${JAVAPATH}" ]; then
	    JAVA_HOME=$(dirname "$(dirname "$(realpath "$JAVAPATH/javac")")")
	    old_path="$PATH"
	    new_PATH="$JAVA_HOME/bin"
	    PATH=$(set_variable "${old_path}" "${new_PATH}")
	    export PATH
	    export JAVA_HOME
    fi
    
fi
