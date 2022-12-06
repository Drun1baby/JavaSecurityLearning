#!/bin/sh
# ****************************************************************************
# This script is used to start a managed WebLogic Server for the domain in the 
# current working directory.  This script reads in the SERVER_NAME and 
# ADMIN_URL as positional parameters, sets the SERVER_NAME variable, then 
# starts the server.
#
# Other variables that startWLS takes are:
#
# WLS_USER       - cleartext user for server startup
# WLS_PW         - cleartext password for server startup
# PRODUCTION_MODE      - Set to true for production mode servers, false for 
#                  development mode
# JAVA_OPTIONS   - Java command-line options for running the server. (These
#                  will be tagged on to the end of the JAVA_VM and MEM_ARGS)
# JAVA_VM        - The java arg specifying the VM to run.  (i.e. -server, 
#                  -hotspot, etc.)
# MEM_ARGS       - The variable to override the standard memory arguments
#                  passed to java
#
# For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server" 
# (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm).
# ****************************************************************************


# set up WL_HOME, the root directory of your WebLogic installation
WL_HOME="E:/Coding/JavaSec/wlserver_10.3"

# set up common environment
. "${WL_HOME}/common/bin/commEnv.sh"

# Set SERVER_NAME to the name of the server you wish to start up. 
ADMIN_URL=
SERVER_NAME=

# Set WLS_USER equal to your system username and WLS_PW equal  
# to your system password for no username and password prompt 
# during server startup.  Both are required to bypass the startup
# prompt.
WLS_USER=
WLS_PW=

# Set JAVA_VM to java virtual machine you want to run on server side.
# JAVA_VM=

# Set JAVA_OPTIONS to the java flags you want to pass to the vm.  If there 
# are more than one, include quotes around them.  For instance: 
# JAVA_OPTIONS="-Dweblogic.attribute=value -Djava.attribute=value"

usage()
{
  echo "Need to set SERVER_NAME and ADMIN_URL environment variables or specify"
  echo "them in command line:"
  echo 'Usage: ./startManagedWebLogic.sh [SERVER_NAME] [ADMIN_URL]'
  echo "for example:"
  echo './startManagedWebLogic.sh managedserver1 http://localhost:7001'
  exit 1
}

# Check for variables SERVER_NAME and ADMIN_URL
# SERVER_NAME and ADMIN_URL must by specified before starting a managed server,
# detailed information can be found at http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm.
if [ ${#} = 0 ]; then
  if [ "x${SERVER_NAME}" = "x" -o "x${ADMIN_URL}" = "x" ]; then
    usage
  fi
elif [ ${#} = 1 ]; then
  SERVER_NAME=${1}
  if [ "x${ADMIN_URL}" = "x" ]; then
    usage
  fi
elif [ ${#} = 2 ]; then
  SERVER_NAME=${1}
  ADMIN_URL=${2}
else
    usage
fi

# Start WebLogic server
# Reset number of open file descriptors in the current process
# This function is defined in commEnv.sh
resetFd

CLASSPATH="${WEBLOGIC_CLASSPATH}${CLASSPATHSEP}${DERBY_CLASSPATH}${CLASSPATHSEP}${POINTBASE_CLASSPATH}${CLASSPATHSEP}${JAVA_HOME}/jre/lib/rt.jar${CLASSPATHSEP}${WL_HOME}/server/lib/webservices.jar${CLASSPATHSEP}${CLASSPATH}"
export CLASSPATH

# Start WebLogic server
echo CLASSPATH="${CLASSPATH}"
echo
echo PATH="${PATH}"
echo
echo "***************************************************"
echo "*  To start WebLogic Server, use a username and   *"
echo "*  password assigned to an admin-level user.  For *"
echo "*  server administration, use the WebLogic Server *"
echo "*  console at http://<hostname>:<port>/console    *"
echo "***************************************************"

"$JAVA_HOME/bin/java" ${JAVA_VM} ${MEM_ARGS} ${JAVA_OPTIONS}     \
  -Dweblogic.Name=${SERVER_NAME}                                 \
  -Dweblogic.management.username=${WLS_USER}                     \
  -Dweblogic.management.password=${WLS_PW}                       \
  -Dweblogic.management.server=${ADMIN_URL}                      \
  -Djava.security.policy="${WL_HOME}/server/lib/weblogic.policy" \
   weblogic.Server 
