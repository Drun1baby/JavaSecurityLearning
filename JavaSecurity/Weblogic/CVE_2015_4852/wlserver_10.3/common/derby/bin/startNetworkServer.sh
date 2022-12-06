SAVECP=$CLASSPATH
unset CLASSPATH
DERBY_HOME=E:/Coding/JavaSec/wlserver_10.3/common/derby
export DERBY_HOME
E:/Coding/JavaSec/wlserver_10.3/common/derby/bin/startNetworkServer $@ &
CLASSPATH=$SAVECP
export CLASSPATH
     
