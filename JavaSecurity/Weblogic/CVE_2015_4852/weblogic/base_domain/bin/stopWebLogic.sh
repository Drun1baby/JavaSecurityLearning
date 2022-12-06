#!/bin/sh

# WARNING: This file is created by the Configuration Wizard.
# Any changes to this script may be lost when adding extensions to this configuration.

if [ "$1" != "" ] ; then
	wlsUserID="$1"
	export wlsUserID
	userID="username=wlsUserID,"
	shift
else
	if [ "${userID}" != "" ] ; then
		wlsUserID="${userID}"
		export wlsUserID
		userID="username=wlsUserID,"
	fi
fi

if [ "$1" != "" ] ; then
	wlsPassword="$1"
	export wlsPassword
	password="password=wlsPassword,"
	shift
else
	if [ "${password}" != "" ] ; then
		wlsPassword="${password}"
		export wlsPassword
		password="password=wlsPassword,"
	fi
fi

# set ADMIN_URL

if [ "$1" != "" ] ; then
	ADMIN_URL="$1"
	shift
else
	if [ "${ADMIN_URL}" = "" ] ; then
		ADMIN_URL="t3://LAPTOP-476JT8H0:7001"
	fi
fi

# Call setDomainEnv here because we want to have shifted out the environment vars above

DOMAIN_HOME="E:/Coding/JavaSec/weblogic/base_domain"

# Read the environment variable from the console.

if [ "${doExit}" = "true" ] ; then
	exitFlag="doExit"
else
	exitFlag="noExit"
fi

. ${DOMAIN_HOME}/bin/setDomainEnv.sh ${exitFlag}

umask 026


echo "wlsUserID = java.lang.System.getenv('wlsUserID')" >"shutdown.py" 
echo "wlsPassword = java.lang.System.getenv('wlsPassword')" >>"shutdown.py" 
echo "connect(${userID} ${password} url='${ADMIN_URL}', adminServerName='${SERVER_NAME}')" >>"shutdown.py" 
echo "shutdown('${SERVER_NAME}','Server', ignoreSessions='true')" >>"shutdown.py" 
echo "exit()" >>"shutdown.py" 

echo "Stopping Weblogic Server..."

${JAVA_HOME}/bin/java -classpath ${FMWCONFIG_CLASSPATH} ${MEM_ARGS} ${JVM_D64} ${JAVA_OPTIONS} weblogic.WLST shutdown.py  2>&1 

echo "Done"

echo "Stopping Derby Server..."

if [ "${DERBY_FLAG}" = "true" ] ; then
	. ${WL_HOME}/common/derby/bin/stopNetworkServer.sh  >"${DOMAIN_HOME}/derbyShutdown.log" 2>&1 
	echo "Derby server stopped."
fi

# Exit this script only if we have been told to exit.

if [ "${doExitFlag}" = "true" ] ; then
	exit
fi

