#!/bin/sh
#*****************************************************************************
# This script is used to set up your environment for development with WebLogic
# Server.  It sets the following variables:
#
# WL_HOME        - The root directory of your WebLogic installation
# JAVA_HOME      - Location of the version of Java used to start WebLogic 
#                  Server. This variable must point to the root directory of a 
#                  JDK installation and will be set for you by the installer. 
#                  See the Oracle Fusion Middleware Supported System Configurations page 
#                  (http://www.oracle.com/technology/software/products/ias/files/fusion_certification.html) 
#                  for an up-to-date list of supported JVMs on your platform.
# PATH           - Adds the JDK and WebLogic directories to the system path.  
# CLASSPATH      - Adds the JDK and WebLogic jars to the classpath.  
#
# Other variables that setWLSEnv takes are:
#
# PRE_CLASSPATH  - Path style variable to be added to the beginning of the 
#                  CLASSPATH 
# POST_CLASSPATH - Path style variable to be added to the end of the 
#                  CLASSPATH 
# PRE_PATH       - Path style variable to be added to the beginning of the 
#                  PATH 
# POST_PATH      - Path style variable to be added to the end of the PATH 
#
# jDriver for Oracle users: This script assumes that native libraries required 
# for jDriver for Oracle have been installed in the proper location and that 
# your os specific library path variable (i.e. LD_LIBRARY_PATH/solaris, 
# SHLIB_PATH/hpux, etc...) has been set appropriately.  Also note that this 
# script defaults to the oci817_8 version of the shared libraries. If this is 
# not the version you need, please adjust the library path variable 
# accordingly.  
#
# For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"
# (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm).
#*****************************************************************************

WL_HOME="E:/Coding/JavaSec/wlserver_10.3"
export WL_HOME

. "${WL_HOME}/common/bin/commEnv.sh"

# Check that the WebLogic classes are where we expect them to be
if [ ! -f "${WL_HOME}/server/lib/weblogic.jar" ]; then
  echo 
  echo "The WebLogic Server wasn't found in directory ${WL_HOME}/server."
  echo "Please edit the startWebLogic.sh script so that the WL_HOME"
  echo "variable points to the WebLogic installation directory."

# Check that java is where we expect it to be
elif [ ! -d "${JAVA_HOME}/bin" ]; then
  echo 
  echo "The JDK wasn't found in directory ${JAVA_HOME}."
  echo "Please edit the startWebLogic.sh script so that the JAVA_HOME"
  echo "variable points to the location of your JDK."

else

CLASSPATH="${WEBLOGIC_CLASSPATH}${CLASSPATHSEP}${CLASSPATH}"
export CLASSPATH

# Import extended environment

if [ -f extEnv.sh ]; then
  . extEnv.sh
fi
if [ ! -z "${EXT_PRE_CLASSPATH}" ]; then
  CLASSPATH="${EXT_PRE_CLASSPATH}${CLASSPATHSEP}${CLASSPATH}"
fi
if [ ! -z "${EXT_POST_CLASSPATH}" ]; then
  CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${EXT_POST_CLASSPATH}"
fi

if [ ! -z "${EXT_PRE_PATH}" ]; then
  PATH="${EXT_PRE_PATH}${PATHSEP}${PATH}"
fi
if [ ! -z "${EXT_POST_PATH}" ]; then
  PATH="${PATH}${PATHSEP}${EXT_POST_PATH}"
fi

# Get PRE and POST environment
if [ ! -z "${PRE_CLASSPATH}" ]; then
  CLASSPATH="${PRE_CLASSPATH}${CLASSPATHSEP}${CLASSPATH}"
fi
if [ ! -z "${POST_CLASSPATH}" ]; then
  CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${POST_CLASSPATH}"
fi

if [ ! -z "${PRE_PATH}" ]; then
  PATH="${PRE_PATH}${PATHSEP}${PATH}"
fi
if [ ! -z "${POST_PATH}" ]; then
  PATH="${PATH}${PATHSEP}${POST_PATH}"
fi

if [ "${WLS_NOT_BRIEF_ENV}" = "" ] ; then
echo CLASSPATH=${CLASSPATH}
echo 
echo PATH=${PATH}
echo
echo "Your environment has been set."
fi

fi
