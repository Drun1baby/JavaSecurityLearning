#!/bin/sh

# Convert the 1st arg to an absolute path.  OS specific
absolutePath() {
  case $OS in
  Windows_NT*)
    # for MKS Toolkit on Windows, an absolute path starts with a drive letter prefix or a UNC path.
    # Assume only forward slashes 
    case $1 in
      [a-zA-Z]:*)
        # Drive prefix
        echo $1
        ;;
      //*)
        # UNC path
        echo $1
        ;;
      /*)
        # path is absolute, but the drive is relative
        p=${mypwd##??}
        echo ${mypwd%%${p}}$1
        ;;
      *)
        # relative path
        echo ${mypwd}/$1
        ;;
    esac
    ;;
  *)
    # for everything else, an initial / indicates an absolute path
    case $1 in
      /*)
        # absolute path
        echo $1
        ;;
      *)
        # relative path
        echo ${mypwd}/$1
        ;;
    esac
    ;;
  esac
}

# set up WL_HOME, the root directory of your WebLogic installation
WL_HOME="E:/Coding/JavaSec/wlserver_10.3"

OS=`uname -s`

# set up common environment
. "${WL_HOME}/common/bin/commEnv.sh"

mypwd="`pwd`"

while [ "$#" -gt "0" ]
do
  ARGNAME=`echo $1 | cut -d'=' -f1`
  ARGVALUE=`echo $1 | cut -d'=' -f2`

  if [ "`echo ${ARGVALUE} | cut -c1`" = "-" ] ; then
    echo "ERROR! Missing equal(=) sign. Arguments must be -name=value!"
    exit 1
  fi

  if [ "${ARGVALUE}" = "" ] ; then
    echo "ERROR! Missing value! Arguments must be -name=value!"
    exit 1
  fi

  case $ARGNAME in
     "-log" | "-silent_script")
        ARGVALUE=`absolutePath "${ARGVALUE}"`
        ARGUMENTS="${ARGUMENTS} ${ARGNAME}='${ARGVALUE}'"
        ;;
     "-useXACML")
        MEM_ARGS="${MEM_ARGS} -DuseXACML='${ARGVALUE}'";;
     *) ARGUMENTS="${ARGUMENTS} ${ARGNAME}='${ARGVALUE}'";; 
  esac
  shift
done
export ARGUMENTS

TYPE=$1
LOG=$2
PARENTDIR=${BEA_HOME}/user_projects/upgrade_logs
DFTLOG=

# Validate upgrade type
if [ "${TYPE}" = "" ]; then
  TYPE=domain
fi
TYPE=`echo ${TYPE} | tr 'A-Z' 'a-z'`

case $TYPE in
domain)
  DFTLOG=${PARENTDIR}/domain
  ;;
cci)
  DFTLOG=${PARENTDIR}/compatibility
  ;;
nodemanager) 
  DFTLOG=${PARENTDIR}/nodemanager
  ;;
securityproviders)
  DFTLOG=${PARENTDIR}/securityproviders
  ;;
*)
  echo "Usage: upgrade.sh <domain|cci|nodemanager|securityproviders> <log_file>" 
  exit 1
  ;;
esac



## Try to create default log file
if [ "${LOG}" = ""  ]; then
  # Generate default log file
  I1=`date +%m%d%Y_%H%M%S`
  mkdir -p "${PARENTDIR}" 2>/dev/null

  i=1
  while [ $i -lt 100 -a -f "${DFTLOG}/${I1}_$i" ]
  do
    i=`expr $i + 1`
  done
  LOG="${DFTLOG}_${I1}_$i"
fi

echo "${JAVA_HOME}/bin/java -Dprod.props.file=${WL_HOME}/.product.properties -classpath ${PRE_CLASSPATH}${CLASSPATHSEP}${FMWCONFIG_CLASSPATH}${CLASSPATHSEP}${BEA_HOME}/utils/config/10.3/upgrade-launch.jar${CLASSPATHSEP}${POST_CLASSPATH}${CLASSPATHSEP}${DERBY_CLASSPATH}${CLASSPATHSEP}${POINTBASE_CLASSPATH} weblogic.Upgrade -type ${TYPE} ${ARGUMENTS} -out ${LOG}" >>${LOG}

eval '"${JAVA_HOME}/bin/java"' -Dprod.props.file='"${WL_HOME}/.product.properties"' -classpath '"${PRE_CLASSPATH}${CLASSPATHSEP}${FMWCONFIG_CLASSPATH}${CLASSPATHSEP}${BEA_HOME}/utils/config/10.3/upgrade-launch.jar${CLASSPATHSEP}${POST_CLASSPATH}${CLASSPATHSEP}${DERBY_CLASSPATH}${CLASSPATHSEP}${POINTBASE_CLASSPATH}"' weblogic.Upgrade -type '"${TYPE}"' ${ARGUMENTS} -out '"${LOG}"'


