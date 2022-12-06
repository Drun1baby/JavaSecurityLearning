#!/bin/sh

usage(){
  echo "========================================================"
  echo " USAGE:"
  echo "  VALID SWITCHES:"
  echo "    -p=The Derby Server's port.(default=1527)"
  echo ""
  echo "    -h=The Derby Server's host name.(default=localhost)"
  echo ""
  echo "EXAMPLE:"
  echo "${SCRIPT_NAME} -p=1527 -h=localhost"
  echo "========================================================"
  exit
}

add_to_derby_command_line()
{
  if [ "${derby_args}" != "" ]; then
     export derby_args="$derby_args $1 $2"
  else
     export derby_args="$1 $2"
  fi
}

derby_args=


WL_HOME="E:/Coding/JavaSec/wlserver_10.3"
. "${WL_HOME}/common/bin/commEnv.sh"

#CLASSPATH="${DERBY_CLASSPATH}${CLASSPATHSEP}${DERBY_TOOLS}${CLASSPATHSEP}${CLASSPATH}"
#export CLASSPATH

SCRIPT_NAME=$0

while [ "$#" -gt "0" ]
do
  ARGNAME=`echo $1 | cut -d'=' -f1`
  ARGVALUE=`echo $1 | cut -d'=' -f2`
  
  if [ "`echo ${ARGVALUE} | cut -c1`" = "-" ] ; then
    echo "ERROR! Missing equal(=) sign. Arguments must be -name=value!"
    usage
  fi

  if [ "${ARGVALUE}" = "" ] ; then
    echo "ERROR! Missing value! Arguments must be -name=value!"
    usage
  fi
  
  case $ARGNAME in
     "-h") add_to_derby_command_line ${ARGNAME} ${ARGVALUE};;
     "-p") add_to_derby_command_line ${ARGNAME} ${ARGVALUE};;
     *) echo "UNKNOWN SWITCH $1!"
        usage;;
  esac
  shift
done

echo "SHUTDOWN FORCE;" | $WL_HOME/common/derby/bin/stopNetworkServer.sh $derby_args
