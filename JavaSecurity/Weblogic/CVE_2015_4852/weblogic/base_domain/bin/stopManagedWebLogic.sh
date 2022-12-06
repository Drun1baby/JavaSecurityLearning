#!/bin/sh

# WARNING: This file is created by the Configuration Wizard.
# Any changes to this script may be lost when adding extensions to this configuration.

# --- Start Functions ---

usage()
{
	echo "You must have a value for SERVER_NAME either set as an environment variable or the first parameter on the command-line."
	echo "ADMIN_URL defaults to t3://LAPTOP-476JT8H0:7001 if not set as an environment variable or the second command-line parameter."
	echo "USER_NAME and PASSWORD are required for shutting the server down when running in production mode:"
	echo "Usage: $1 {SERVER_NAME} {ADMIN_URL} {USER_NAME} {PASSWORD}"
	echo "for example:"
	echo "$1 managedserver1 t3://LAPTOP-476JT8H0:7001 weblogic weblogic"
}

# --- End Functions ---

# *************************************************************************
# This script is used to stop a managed WebLogic Server for the domain in
# the current working directory.  This script reads in the SERVER_NAME and
# ADMIN_URL as positional parameters, sets the SERVER_NAME variable, then
# calls the startWLS.cmd script under ${WL_HOME}/server/bin.
# 
# Other variables that startWLS takes are:
# 
# WLS_USER       - cleartext user for server startup
# WLS_PW         - cleartext password for server startup
# JAVA_OPTIONS   - Java command-line options for running the server. (These
#                  will be tagged on to the end of the JAVA_VM)
# JAVA_VM        - The java arg specifying the VM to run.  (i.e. -server, 
#                  -hotspot, etc.)
# 
# For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"
# 
#  (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm)
# 
# *************************************************************************

#  Set SERVER_NAME and ADMIN_URL, they must by specified before starting

#  a managed server, detailed information can be found at

#  http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm

if [ "$1" = "" ] ; then
	if [ "${SERVER_NAME}" = "" ] ; then
		usage $0
		exit
	fi
else
	SERVER_NAME="$1"
	export SERVER_NAME
	shift
fi

if [ "$1" = "" ] ; then
	if [ "${ADMIN_URL}" = "" ] ; then
		ADMIN_URL="t3://LAPTOP-476JT8H0:7001"
		export ADMIN_URL
	fi
else
	ADMIN_URL="$1"
	export ADMIN_URL
	shift
fi

DOMAIN_HOME="E:/Coding/JavaSec/weblogic/base_domain"

${DOMAIN_HOME}/bin/stopWebLogic.sh $1 $2

