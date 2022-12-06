#!/bin/sh

# set up WL_HOME, the root directory of your WebLogic installation
WL_HOME="E:/Coding/JavaSec/wlserver_10.3"

umask 027

# set up common environment
WLS_NOT_BRIEF_ENV=true
. "${WL_HOME}/server/bin/setWLSEnv.sh"

CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${FMWLAUNCH_CLASSPATH}${CLASSPATHSEP}${DERBY_CLASSPATH}${CLASSPATHSEP}${DERBY_TOOLS}${CLASSPATHSEP}${POINTBASE_CLASSPATH}${CLASSPATHSEP}${POINTBASE_TOOLS}"

if [ "${WLST_HOME}" != "" ] ; then
	WLST_PROPERTIES="-Dweblogic.wlstHome='${WLST_HOME}' ${WLST_PROPERTIES}"
	export WLST_PROPERTIES
fi

echo
echo CLASSPATH=${CLASSPATH}

JVM_ARGS="-Dprod.props.file='${WL_HOME}'/.product.properties ${WLST_PROPERTIES} ${JVM_D64} ${MEM_ARGS} ${CONFIG_JVM_ARGS}"

eval '"${JAVA_HOME}/bin/java"' ${JVM_ARGS} weblogic.WLST '"$@"'
