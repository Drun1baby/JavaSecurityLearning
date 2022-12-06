#!/bin/sh
# This script is used by the NodeManager to start up Managed servers
# on Unix systems under the control of an Admin server. The Admin
# server supplies the arguments to this script.
# The script is invoked with 4 arguments:
# Arg1: is the command line used to start up a Managed server
# Arg2: is the file to which stdout is to be redirected to
# Arg3: is the file to which stderr is to be redirected to
# Arg4: is the file into which the process id of the Managed server
#       is saved.
# This script uses just one variable: 
# JAVA_HOME - which is used to determine the Java version that is
# to be used to start up the WebLogic Managed server.
# 

# set up WL_HOME, the root directory of your WebLogic installation
WL_HOME=E:/Coding/JavaSec/wlserver_10.3

# set up common environment
. ${WL_HOME}/common/bin/commEnv.sh

if [ ! -f $JAVA_HOME/bin/javac ]; then
  echo "The JDK wasn't found in directory $JAVA_HOME." > $3
else
$JAVA_HOME/bin/java $1 >$2 2>$3 &
echo $! > $4
fi




