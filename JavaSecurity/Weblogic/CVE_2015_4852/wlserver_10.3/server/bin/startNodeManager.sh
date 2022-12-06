#!/bin/sh
# *************************************************************************
# This script can be used to start the WebLogic NodeManager
#
# To start the NodeManager on <host> and <port>, set the LISTEN_ADDRESS 
# variable to <host> and LISTEN_PORT variable to <port> before calling this 
# script.
#
# This script sets the following variables before starting the NodeManager:
# 
# BEA_HOME       - The BEA root installation directory.
# WL_HOME        - The root directory of your WebLogic installation.
# NODEMGR_HOME   - The root directory for this NodeManagerInstance.
# JAVA_HOME      - Location of the version of Java used to start WebLogic 
#                  Server. This variable must point to the root directory of a 
#                  JDK installation and will be set for you by the installer. 
#                  See the Oracle Fusion Middleware Supported System Configurations page 
#                  (http://www.oracle.com/technology/software/products/ias/files/fusion_certification.html) 
#                  for an up-to-date list of supported JVMs.
# PATH           - Adds the JDK and WebLogic directories to the system path.  
# CLASSPATH      - Adds the JDK and WebLogic jars to the classpath.  
# JAVA_OPTIONS   - Java command-line options for running the server. (These
#                  will be tagged on to the end of the JAVA_VM and MEM_ARGS)
# JAVA_VM        - The java arg specifying the VM to run.  (i.e. -server, 
#                  -hotspot, etc.)
# MEM_ARGS       - The variable to override the standard memory arguments
#                  passed to java
#
# Alternately, this script will take the first two positional parameters and 
# set them to LISTEN_ADDRESS and LISTEN_PORT. For instance, you could call this
# script: "sh startNodeManager.sh holly 7777" to start the NodeManager
# on host holly and port 7777, or just "sh startNodeManager.sh holly" 
# to start the node manager on host holly.
# *************************************************************************

# Set user-defined variables.
unset JAVA_VM MEM_ARGS

umask 027

WL_HOME="E:/Coding/JavaSec/wlserver_10.3"
. "${WL_HOME}/common/bin/commEnv.sh"

NODEMGR_HOME="${WL_HOME}/common/nodemanager"

# If NODEMGR_HOME does not exist, create it
if [ ! -d "${NODEMGR_HOME}" ]; then
  echo ""
  echo "NODEMGR_HOME ${NODEMGR_HOME} does not exist, creating it.."
  mkdir -p "${NODEMGR_HOME}"
fi

# Set first two positional parameters to LISTEN_ADDRESS and LISTEN_PORT
if [ "${1}" != "" ]; then
  LISTEN_ADDRESS="${1}"
fi

if [ "${2}" != "" ]; then
  LISTEN_PORT="${2}"
fi

# Check for JDK
if [ ! -d "${JAVA_HOME}/bin" ]; then
  echo "The JDK wasn't found in directory ${JAVA_HOME}."
  echo "Please edit the startNodeManager.sh script so that the JAVA_HOME"
  echo "variable points to the location of your JDK."
  exit 1

else

if [ "${MEM_ARGS}" = "" ]
then
MEM_ARGS="-Xms32m -Xmx200m"
fi

if [ -n "${BEA_HOME}" ] ; then 
  JAVA_OPTIONS="-Dbea.home=${BEA_HOME} ${JAVA_OPTIONS}"
fi
if [ -n "${COHERENCE_HOME}" ] ; then 
  JAVA_OPTIONS="-Dcoherence.home=${COHERENCE_HOME} ${JAVA_OPTIONS}"
fi

set -x
CLASSPATH="${WEBLOGIC_CLASSPATH}${CLASSPATHSEP}${CLASSPATH}${CLASSPATHSEP}${BEA_HOME}"

# Get PRE and POST environment
if [ ! -z "${PRE_CLASSPATH}" ]; then
  CLASSPATH="${PRE_CLASSPATH}${CLASSPATHSEP}${CLASSPATH}"
fi
if [ ! -z "${POST_CLASSPATH}" ]; then
  CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${POST_CLASSPATH}"
fi

export CLASSPATH
export PATH

cd "${NODEMGR_HOME}"
set -x
if [ "$LISTEN_PORT" != "" ]
 then
   if [ "$LISTEN_ADDRESS" != "" ]
    then
     "${JAVA_HOME}/bin/java" ${JAVA_VM} ${MEM_ARGS} ${JAVA_OPTIONS} -Djava.security.policy="${WL_HOME}/server/lib/weblogic.policy" -Dweblogic.nodemanager.javaHome="${JAVA_HOME}" -DListenAddress="${LISTEN_ADDRESS}" -DListenPort="${LISTEN_PORT}" weblogic.NodeManager -v
    else
     "${JAVA_HOME}/bin/java" ${JAVA_VM} ${MEM_ARGS} ${JAVA_OPTIONS} -Djava.security.policy="${WL_HOME}/server/lib/weblogic.policy" -Dweblogic.nodemanager.javaHome="${JAVA_HOME}" -DListenPort="${LISTEN_PORT}" weblogic.NodeManager -v
   fi
 else
   if [ "$LISTEN_ADDRESS" != "" ]
    then
     "${JAVA_HOME}/bin/java" ${JAVA_VM} ${MEM_ARGS} ${JAVA_OPTIONS} -Djava.security.policy="${WL_HOME}/server/lib/weblogic.policy" -Dweblogic.nodemanager.javaHome="${JAVA_HOME}" -DListenAddress="${LISTEN_ADDRESS}" weblogic.NodeManager -v
    else
     "${JAVA_HOME}/bin/java" ${JAVA_VM} ${MEM_ARGS} ${JAVA_OPTIONS} -Djava.security.policy="${WL_HOME}/server/lib/weblogic.policy" -Dweblogic.nodemanager.javaHome="${JAVA_HOME}" weblogic.NodeManager -v
   fi
fi
set +x
fi
