#!/bin/sh

# WARNING: This file is created by the Configuration Wizard.
# Any changes to this script may be lost when adding extensions to this configuration.

# --- Start Functions ---

stopAll()
{
	# We separate the stop commands into a function so we are able to use the trap command in Unix (calling a function) to stop these services
	if [ "X${ALREADY_STOPPED}" != "X" ] ; then
		exit
	fi
	# STOP DERBY (only if we started it)
	if [ "${DERBY_FLAG}" = "true" ] ; then
		echo "Stopping Derby server..."
		${WL_HOME}/common/derby/bin/stopNetworkServer.sh  >"${DOMAIN_HOME}/derbyShutdown.log" 2>&1 

		echo "Derby server stopped."
	fi

	ALREADY_STOPPED="true"
}

classCaching()
{
	echo "Class caching enabled..."
	JAVA_OPTIONS="${JAVA_OPTIONS} -Dlaunch.main.class=${SERVER_CLASS} -Dlaunch.class.path="${CLASSPATH}" -Dlaunch.complete=weblogic.store.internal.LockManagerImpl -cp ${WL_HOME}/server/lib/pcl2.jar"
	export JAVA_OPTIONS
	SERVER_CLASS="com.oracle.classloader.launch.Launcher"
}

# --- End Functions ---

# *************************************************************************
# This script is used to start WebLogic Server for this domain.
# 
# To create your own start script for your domain, you can initialize the
# environment by calling @USERDOMAINHOME/setDomainEnv.
# 
# setDomainEnv initializes or calls commEnv to initialize the following variables:
# 
# BEA_HOME       - The BEA home directory of your WebLogic installation.
# JAVA_HOME      - Location of the version of Java used to start WebLogic
#                  Server.
# JAVA_VENDOR    - Vendor of the JVM (i.e. BEA, HP, IBM, Sun, etc.)
# PATH           - JDK and WebLogic directories are added to system path.
# WEBLOGIC_CLASSPATH
#                - Classpath needed to start WebLogic Server.
# PATCH_CLASSPATH - Classpath used for patches
# PATCH_LIBPATH  - Library path used for patches
# PATCH_PATH     - Path used for patches
# WEBLOGIC_EXTENSION_DIRS - Extension dirs for WebLogic classpath patch
# JAVA_VM        - The java arg specifying the VM to run.  (i.e.
#                - server, -hotspot, etc.)
# USER_MEM_ARGS  - The variable to override the standard memory arguments
#                  passed to java.
# PRODUCTION_MODE - The variable that determines whether Weblogic Server is started in production mode.
# DERBY_HOME - Derby home directory.
# DERBY_CLASSPATH
#                - Classpath needed to start Derby.
# 
# Other variables used in this script include:
# SERVER_NAME    - Name of the weblogic server.
# JAVA_OPTIONS   - Java command-line options for running the server. (These
#                  will be tagged on to the end of the JAVA_VM and
#                  MEM_ARGS)
# CLASS_CACHE    - Enable class caching of system classpath.
# 
# For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"
#  (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm).
# *************************************************************************

umask 037


# Call setDomainEnv here.

DOMAIN_HOME="E:/Coding/JavaSec/weblogic/base_domain"

. ${DOMAIN_HOME}/bin/setDomainEnv.sh $*

SAVE_JAVA_OPTIONS="${JAVA_OPTIONS}"

SAVE_CLASSPATH="${CLASSPATH}"

# Start Derby

DERBY_DEBUG_LEVEL="0"

if [ "${DERBY_FLAG}" = "true" ] ; then
	${WL_HOME}/common/derby/bin/startNetworkServer.sh  >"${DOMAIN_HOME}/derby.log" 2>&1 

fi

JAVA_OPTIONS="${SAVE_JAVA_OPTIONS}"

SAVE_JAVA_OPTIONS=""

CLASSPATH="${SAVE_CLASSPATH}"

SAVE_CLASSPATH=""

trap 'stopAll' 1 2 3 15


if [ "${PRODUCTION_MODE}" = "true" ] ; then
	WLS_DISPLAY_MODE="Production"
else
	WLS_DISPLAY_MODE="Development"
fi

if [ "${WLS_USER}" != "" ] ; then
	JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.management.username=${WLS_USER}"
fi

if [ "${WLS_PW}" != "" ] ; then
	JAVA_OPTIONS="${JAVA_OPTIONS} -Dweblogic.management.password=${WLS_PW}"
fi

if [ "${MEDREC_WEBLOGIC_CLASSPATH}" != "" ] ; then
	if [ "${CLASSPATH}" != "" ] ; then
		CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${MEDREC_WEBLOGIC_CLASSPATH}"
	else
		CLASSPATH="${MEDREC_WEBLOGIC_CLASSPATH}"
	fi
fi

echo "."

echo "."

echo "JAVA Memory arguments: ${MEM_ARGS}"

echo "."

echo "WLS Start Mode=${WLS_DISPLAY_MODE}"

echo "."

echo "CLASSPATH=${CLASSPATH}"

echo "."

echo "PATH=${PATH}"

echo "."

echo "***************************************************"

echo "*  To start WebLogic Server, use a username and   *"

echo "*  password assigned to an admin-level user.  For *"

echo "*  server administration, use the WebLogic Server *"

echo "*  console at http://hostname:port/console        *"

echo "***************************************************"

# CLASS CACHING

if [ "${CLASS_CACHE}" = "true" ] ; then
	classCaching
fi

# START WEBLOGIC

echo "starting weblogic with Java version:"

${JAVA_HOME}/bin/java ${JAVA_VM} -version

if [ "${WLS_REDIRECT_LOG}" = "" ] ; then
	echo "Starting WLS with line:"
	echo "${JAVA_HOME}/bin/java ${JAVA_VM} ${MEM_ARGS} -Dweblogic.Name=${SERVER_NAME} -Djava.security.policy=${WL_HOME}/server/lib/weblogic.policy ${JAVA_OPTIONS} ${PROXY_SETTINGS} ${SERVER_CLASS}"
	${JAVA_HOME}/bin/java ${JAVA_VM} ${MEM_ARGS} -Dweblogic.Name=${SERVER_NAME} -Djava.security.policy=${WL_HOME}/server/lib/weblogic.policy ${JAVA_OPTIONS} ${PROXY_SETTINGS} ${SERVER_CLASS}
else
	echo "Redirecting output from WLS window to ${WLS_REDIRECT_LOG}"
	${JAVA_HOME}/bin/java ${JAVA_VM} ${MEM_ARGS} -Dweblogic.Name=${SERVER_NAME} -Djava.security.policy=${WL_HOME}/server/lib/weblogic.policy ${JAVA_OPTIONS} ${PROXY_SETTINGS} ${SERVER_CLASS}  >"${WLS_REDIRECT_LOG}" 2>&1 
fi

stopAll

popd

# Exit this script only if we have been told to exit.

if [ "${doExitFlag}" = "true" ] ; then
	exit
fi

