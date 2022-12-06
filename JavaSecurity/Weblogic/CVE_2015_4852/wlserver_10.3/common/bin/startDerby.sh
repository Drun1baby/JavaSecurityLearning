#!/bin/sh


usage(){
  echo "========================================================"
  echo " USAGE:"
  echo "  VALID SWITCHES:"
  echo "    -p=The port to start the Derby Server on.(default=1527)"
  echo ""
  echo "    -h=This starts the network server on the host specified.(default=localhost)"
  echo ""
  echo "    -maxthreads=This sets the maximum number of threads that can be used for connections."
  echo "           (default=0 or unlimited)"
  echo ""
  echo "    -logconnections=\"true\" or \"false\" This turns logging of connections on or off."
  echo "           Connections are logged to derby.log. (default=off or false)" 
  echo ""
  echo "    -timeslice=This sets the time in milliseconds each session can have using a connection"
  echo "           thread before yielding to a waiting session.(default=0 or no yield)"
  echo ""
  echo "    -tracedirectory=This changes where new trace files will be placed."
  echo "           For sessions with tracing already turned on, trace files remain in the"
  echo "           previous location. Default is derby.system.home, if it is set."
  echo "           Otherwise the default is the current directory."
  echo ""
  echo "    -traceAll=\"true\" or \"false\". This turns drda tracing on or off for all sessions"
  echo "          (Default is false or trace is not enabled)"
  echo ""
  echo "    -ssl=\"off\", \"basic\" or \"peerAuthentication\". (default=off)"
  echo ""
  echo "EXAMPLE:"
  echo "${SCRIPT_NAME} -p=1527 -h=myhost -ssl=basic"
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

unset derby_args

WL_HOME="E:/Coding/JavaSec/wlserver_10.3"

. "${WL_HOME}/common/bin/commEnv.sh"

CLASSPATH="${DERBY_CLASSPATH}${CLASSPATHSEP}${POINTBASE_CLASSPATH}${CLASSPATHSEP}${WEBLOGIC_CLASSPATH}"

if [ "${DOMAIN_HOME}" != "" ] ; then
  CLASSPATH="${CLASSPATH}${CLASSPATHSEP}${DOMAIN_HOME}"
fi

export CLASSPATH
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
     "-p") add_to_derby_command_line ${ARGNAME} ${ARGVALUE};;
     "-h") add_to_derby_command_line ${ARGNAME} ${ARGVALUE};;
     "-maxthreads") export DERBY_OPTS="$DERBY_OPTS -Dderby.drda.maxThreads=${ARGVALUE}";;
     "-timeslice") export DERBY_OPTS="$DERBY_OPTS -Dderby.drda.timeSlice=${ARGVALUE}";;
     "-tracedirectory") export DERBY_OPTS="$DERBY_OPTS -Dderby.drda.traceDirectory=${ARGVALUE}";;
     "-traceAll") 
        if [ "${ARGVALUE}" = "true" ] || [ "${ARGVALUE}" = "false" ]; then
         if [ "${ARGVALUE}" = "true" ]; then
            export DERBY_OPTS="$DERBY_OPTS -Dderby.drda.traceAll=${ARGVALUE}"
         fi
        else
          echo "UNKNOWN -traceAll OPTION $2! Valid options are \"true\" or \"false\"."
          usage
        fi;;
     "-ssl") 
        if [ "${ARGVALUE}" = "off" ] || [ "${ARGVALUE}" = "basic" ] || [ "${ARGVALUE}" = "peerAuthentication" ]; then
          add_to_derby_command_line ${ARGNAME} ${ARGVALUE}
        else
          echo "UNKNOWN -ssl OPTION $2! Valid options are \"off\" or \"basic\" or \"peerAuthentication\"."
          usage
        fi;;
     "-logconnections") 
        if [ "${ARGVALUE}" = "true" ] || [ "${ARGVALUE}" = "false" ] ; then 
         if [ "${ARGVALUE}" = "true" ]; then
            export DERBY_OPTS="$DERBY_OPTS -Dderby.drda.logConnections=${ARGVALUE}"
         fi        
        else        
          echo "UNKNOWN -logconnections OPTION $2! Valid options are \"true\" or \"false\"."
          usage
        fi;;
     *) echo "UNKNOWN SWITCH $1!"
        usage;;
  esac
  shift
done
$WL_HOME/common/derby/bin/startNetworkServer.sh $derby_args
