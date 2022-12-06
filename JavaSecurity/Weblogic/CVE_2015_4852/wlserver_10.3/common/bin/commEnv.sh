#*****************************************************************************
# This script is used to set up a common environment for starting WebLogic
# Server, as well as WebLogic development.
#
# It sets the following variables:
# BEA_HOME       - The home directory of all your BEA installation.
# MW_HOME        - The home directory of all your Oracle installation.
# WL_HOME        - The root directory of the BEA installation.
# COHERENCE_HOME - The root directory of the COHERENCE installation.
# ANT_HOME       - The Ant Home directory.
# ANT_CONTRIB    - The Ant contrib directory
# JAVA_HOME      - Location of the version of Java used to start WebLogic
#                  Server. See the Oracle Fusion Middleware Supported System Configurations page
#                  (http://www.oracle.com/technology/software/products/ias/files/fusion_certification.html) for an
#                  up-to-date list of supported JVMs on your platform.
# JAVA_VENDOR    - Vendor of the JVM (i.e. BEA, HP, IBM, Sun, etc.)
# JAVA_USE_64BIT - Indicates if JVM uses 64 bit operations
# PATH           - JDK and WebLogic directories will be added to the system
#                  path.
# WEBLOGIC_CLASSPATH - Classpath required to start WebLogic Server.
# FMWCONFIG_CLASSPATH - Classpath required to start config tools such as WLST, config wizard, pack, and unpack..
# FMWLAUNCH_CLASSPATH - Additional classpath needed for WLST start script
# LD_LIBRARY_PATH, LIBPATH and SHLIB_PATH
#                - To locate native libraries.
# JAVA_VM        - The java arg specifying the VM to run.  (e.g.
#                  -server, -hotspot, etc.)
# MEM_ARGS       - The variable to override the standard memory arguments
#                  passed to java.
# CLASSPATHSEP   - CLASSPATH delimiter.
# PATHSEP        - Path delimiter.
# DERBY_HOME - Derby home directory.
# DERBY_TOOLS - Derby tools jar.
# DERBY_CLASSPATH - Classpath needed to start Derby.
# DERBY_CLIENT_CLASSPATH
#                     - Derby client classpath.
# PRODUCTION_MODE     - Indicates if the Server will be started in PRODUCTION_MODE
# PATCH_CLASSPATH     - WebLogic system classpath patch
# PATCH_LIBPATH  - Library path used for patches
# PATCH_PATH     - Path used for patches
# WEBLOGIC_EXTENSION_DIRS - Extension dirs for WebLogic classpath patch
#
# It exports the following function:
# trapSIGINT     - Get actual Derby PID when running in MKSNT environment;
#                  trap SIGINT to make sure Derby will also be stopped.
#
# resetFd        - Reset the number of open file descriptors to 1024.
#
# jDriver for Oracle users: This script assumes that native libraries required
# for jDriver for Oracle have been installed in the proper location and that
# your os specific library path variable (i.e. LD_LIBRARY_PATH/solaris,
# SHLIB_PATH/hpux, etc...) has been set appropriately.  Also note that this
# script defaults to the oci920_8 version of the shared libraries. If this is
# not the version you need, please adjust the library path variable
# accordingly.
#
#*****************************************************************************

#*****************************************************************************
# sub functions
#*****************************************************************************

# limit the number of open file descriptors
resetFd() {
  if [ ! -n "`uname -s |grep -i cygwin || uname -s |grep -i windows_nt || \
       uname -s |grep -i HP-UX`" ]
  then
    ofiles=`ulimit -S -n`
    maxfiles=`ulimit -H -n`
    if [ "$?" = "0" -a  `expr ${maxfiles} : '[0-9][0-9]*$'` -eq 0 -a `expr ${ofiles} : '[0-9][0-9]*$'` -eq 0 ]; then   
      ulimit -n 4096
    else
      if [ "$?" = "0" -a `uname -s` = "SunOS" -a `expr ${maxfiles} : '[0-9][0-9]*$'` -eq 0 ]; then
        if [ ${ofiles} -lt 65536 ]; then
          ulimit -H -n 65536
        else
          ulimit -H -n ${ofiles}
        fi
      fi
    fi
  fi
}

# Get actual Derby process when running in MKS/NT environment;
# Trap SIGINT
# input:
# DERBY_PID -- Derby server process id.
# output:
# DERBY_PID -- Actual Derby pid in MKS/NT environment.
trapSIGINT() {

  # With MKS, the pid of $! dosen't show up correctly.
  # It starts a shell process to launch whatever commands it calls.
  if [ `uname -s` = "Windows_NT" ]; then
    DERBY_PID=`ps -eo pid,ppid |
      awk -v DERBY_PID=${DERBY_PID} '$2 == DERBY_PID {print $1}'`
    POINTBASE_PID=`ps -eo pid,ppid |
      awk -v POINTBASE_PID=${POINTBASE_PID} '$2 == POINTBASE_PID {print $1}'`  
  fi

  # Kill Derby on interrupt from this script (^C)
  trap 'if [ "${DERBY_PID}" != "" ]; then
        kill -9 ${DERBY_PID}
        unset DERBY_PID
        fi' 2
  trap 'if [ "${POINTBASE_PID}" != "" ]; then
        kill -9 ${POINTBASE_PID}
        unset POINTBASE_PID
        fi' 2      
}

#*****************************************************************************
# end of sub functions
#*****************************************************************************

# Set up BEA Home
BEA_HOME="E:/Coding/JavaSec"

# Set up Middleware Home
MW_HOME="E:/Coding/JavaSec"

# Set up WebLogic Home
WL_HOME="E:/Coding/JavaSec/wlserver_10.3"

# Set up COHERENCE Home
COHERENCE_HOME="E:/Coding/JavaSec/coherence_3.7"

# Set up Common Modules Directory
MODULES_DIR="E:/Coding/JavaSec/modules"

# Set up Common Features Directory
FEATURES_DIR="E:/Coding/JavaSec/modules/features"

# Set up Ant Home
ANT_HOME="${MODULES_DIR}/org.apache.ant_1.7.1"

# Set up Ant contrib
ANT_CONTRIB="${MODULES_DIR}/net.sf.antcontrib_1.1.0.0_1-0b2"

# Setup SUN_ARCH_DATA_MODEL
SUN_ARCH_DATA_MODEL="64"

#JAVA_USE_64BIT, true if JVM uses 64 bit operations
JAVA_USE_64BIT=true

# Reset JAVA_HOME, JAVA_VENDOR and PRODUCTION_MODE unless JAVA_HOME
# and JAVA_VENDOR are pre-defined.
if [ -z "${JAVA_HOME}" -o -z "${JAVA_VENDOR}" ]; then
  # Set up JAVA HOME
  JAVA_HOME="E:/Coding/Java/jdk1.7.0_21"
  # Set up JAVA VENDOR, possible values are
  #Oracle, HP, IBM, Sun ...
  JAVA_VENDOR=Oracle
  # PRODUCTION_MODE, default to the development mode
  PRODUCTION_MODE=""
fi

if [ "${JAVA_VENDOR}" = "Oracle" ]; then
 JAVA_VENDOR_TMP=Sun
 if [ -d "${JAVA_HOME}/jre/bin/jrockit" ]; then
  JAVA_VENDOR_TMP=Oracle
 else
  for jrpath in "${JAVA_HOME}"/jre/lib/*
   do
    if [ -d "${jrpath}/jrockit" ]; then
     JAVA_VENDOR_TMP=Oracle
    fi
   done
 fi
 JAVA_VENDOR=${JAVA_VENDOR_TMP}
fi

export BEA_HOME MW_HOME WL_HOME MODULES_DIR FEATURES_DIR COHERENCE_HOME ANT_HOME ANT_CONTRIB JAVA_HOME JAVA_VENDOR PRODUCTION_MODE JAVA_USE_64BIT

# Set up JVM options base on value of JAVA_VENDOR
if [ "$PRODUCTION_MODE" = "true" ]; then
  case $JAVA_VENDOR in
  Oracle)
    JAVA_VM=-jrockit
    MEM_ARGS="-Xms128m -Xmx256m"
  ;;
  HP)
    JAVA_VM=-server
    MEM_ARGS="-Xms32m -Xmx200m -XX:MaxPermSize=128m"
  ;;
  IBM)
    JAVA_VM=
    MEM_ARGS="-Xms32m -Xmx200m"
  ;;
  Sun)
    JAVA_VM=-server
    MEM_ARGS="-Xms32m -Xmx200m -XX:MaxPermSize=128m"
  ;;
  Apple)
    JAVA_VM=-server
    MEM_ARGS="-Xms32m -Xmx200m -XX:MaxPermSize=128m"
  ;;
  *)
    JAVA_VM=
    MEM_ARGS="-Xms32m -Xmx200m"
  ;;
  esac
else
  case $JAVA_VENDOR in
  Oracle)
    JAVA_VM=-jrockit
    MEM_ARGS="-Xms128m -Xmx256m"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Xverify:none"
  ;;
  HP)
    JAVA_VM=-client
    MEM_ARGS="-Xms32m -Xmx200m -XX:MaxPermSize=128m"
  ;;
  IBM)
    JAVA_VM=
    MEM_ARGS="-Xms32m -Xmx200m"
  ;;
  Sun)
    JAVA_VM=-client
    MEM_ARGS="-Xms32m -Xmx200m -XX:MaxPermSize=128m"
    JAVA_OPTIONS="${JAVA_OPTIONS} -Xverify:none"
  ;;
  Apple)
    JAVA_VM=-client
    MEM_ARGS="-Xms32m -Xmx200m -XX:MaxPermSize=128m"
  ;;
  *)
    JAVA_VM=
    MEM_ARGS="-Xms32m -Xmx200m"
  ;;
  esac
fi
export JAVA_VM MEM_ARGS JAVA_OPTIONS

# Set the classpath separator
case `uname -s` in
Windows_NT*)
  CLASSPATHSEP=\;
  PATHSEP=\;
;;
CYGWIN*)
  CLASSPATHSEP=\;
;;
esac

if [ "${CLASSPATHSEP}" = "" ]; then
  CLASSPATHSEP=:
fi
if [ "${PATHSEP}" = "" ]; then
  PATHSEP=:
fi
export PATHSEP CLASSPATHSEP


# Set-up patch related class path, extension dirs, library path and path options
if [ -f "${WL_HOME}/common/bin/setPatchEnv.sh" ]; then
  . "${WL_HOME}"/common/bin/setPatchEnv.sh
fi

# Figure out how to load java native libraries, also add -d64 for hpux and solaris 64 bit arch.
case `uname -s` in
AIX)
  if [ -n "${LIBPATH}" ]; then
    if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
      LIBPATH=${LIBPATH}:${WL_HOME}/server/native/aix/ppc64
    else
      LIBPATH=${LIBPATH}:${WL_HOME}/server/native/aix/ppc
    fi
  else
    if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
      LIBPATH=${WL_HOME}/server/native/aix/ppc64
    else
      LIBPATH=${WL_HOME}/server/native/aix/ppc
    fi
  fi
  LIBPATH=${PATCH_LIBPATH}:${LIBPATH}
  export LIBPATH
;;
HP-UX)
  arch=`uname -m`
  if [ "${arch}" = "ia64" ]; then
    if [ -n "${SHLIB_PATH}" ]; then
      if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        SHLIB_PATH=${SHLIB_PATH}:${WL_HOME}/server/native/hpux11/IPF64:${WL_HOME}/server/native/hpux11/IPF64/oci920_8
      else
        SHLIB_PATH=${SHLIB_PATH}:${WL_HOME}/server/native/hpux11/IPF32:${WL_HOME}/server/native/hpux11/IPF32/oci920_8
      fi
    else
      if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        SHLIB_PATH=${WL_HOME}/server/native/hpux11/IPF64:${WL_HOME}/server/native/hpux11/IPF64/oci920_8
      else
        SHLIB_PATH=${WL_HOME}/server/native/hpux11/IPF32:${WL_HOME}/server/native/hpux11/IPF32/oci920_8
      fi
    fi
  else
    if [ -n "${SHLIB_PATH}" ]; then
      if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        SHLIB_PATH=${SHLIB_PATH}:${WL_HOME}/server/native/hpux11/PA_RISC64:${WL_HOME}/server/native/hpux11/PA_RISC64/oci920_8
      else
        SHLIB_PATH=${SHLIB_PATH}:${WL_HOME}/server/native/hpux11/PA_RISC:${WL_HOME}/server/native/hpux11/PA_RISC/oci920_8
      fi
    else
      if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        SHLIB_PATH=${WL_HOME}/server/native/hpux11/PA_RISC64:${WL_HOME}/server/native/hpux11/PA_RISC64/oci920_8
      else
        SHLIB_PATH=${WL_HOME}/server/native/hpux11/PA_RISC:${WL_HOME}/server/native/hpux11/PA_RISC/oci920_8
      fi
    fi
  fi
  SHLIB_PATH=${PATCH_LIBPATH}:${SHLIB_PATH}
  export SHLIB_PATH
  if [ "${JAVA_USE_64BIT}" = "true" ] && [ "${JAVA_VENDOR}" != "Oracle" ]
  then
     JVM_D64="-d64"
     export JVM_D64
     JAVA_VM="${JAVA_VM} ${JVM_D64}"
     export JAVA_VM
  fi
;;
LINUX|Linux)
  arch=`uname -m`
  if [ -n "${LD_LIBRARY_PATH}" ]; then
    if [ "${arch}" = "ia64" ]; then
      LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/linux/ia64:${WL_HOME}/server/native/linux/ia64/oci920_8
    else
      if [ "${arch}" = "x86_64" -a "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/linux/${arch}:${WL_HOME}/server/native/linux/${arch}/oci920_8
        if [ "$SIP_ENABLED" = "true" ]; then
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WLSS_HOME}/server/native/linux/${arch}:${WLSS_HOME}/server/native/linux/${arch}/oci920_8
        fi
      else  
        if [ "${arch}" = "s390x" ]; then 
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/linux/s390x
        else
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/linux/i686:${WL_HOME}/server/native/linux/i686/oci920_8
        fi
        if [ "$SIP_ENABLED" = "true" ]; then
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WLSS_HOME}/server/native/linux/i686:${WLSS_HOME}/server/native/linux/i686/oci920_8
        fi
      fi
    fi
  else
    if [ "${arch}" = "ia64" ]; then
      LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/linux/ia64:${WL_HOME}/server/native/linux/ia64/oci920_8
    else
      if [ "${arch}" = "x86_64" -a "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        LD_LIBRARY_PATH=${WL_HOME}/server/native/linux/${arch}:${WL_HOME}/server/native/linux/${arch}/oci920_8
        if [ "$SIP_ENABLED" = "true" ]; then
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WLSS_HOME}/server/native/linux/${arch}:${WLSS_HOME}/server/native/linux/${arch}/oci920_8
        fi
      else
        if [ "${arch}" = "s390x" ]; then
          LD_LIBRARY_PATH=${WL_HOME}/server/native/linux/s390x
        else
          LD_LIBRARY_PATH=${WL_HOME}/server/native/linux/i686:${WL_HOME}/server/native/linux/i686/oci920_8
        fi
        if [ "$SIP_ENABLED" = "true" ]; then
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WLSS_HOME}/server/native/linux/i686:${WLSS_HOME}/server/native/linux/i686/oci920_8
        fi
      fi
    fi
  fi
  LD_LIBRARY_PATH=${PATCH_LIBPATH}:${LD_LIBRARY_PATH}
  export LD_LIBRARY_PATH
;;
OSF1)
  if [ -n "${LD_LIBRARY_PATH}" ]; then
    LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/tru64unix
  else
    LD_LIBRARY_PATH=${WL_HOME}/server/native/tru64unix
  fi
  LD_LIBRARY_PATH=${PATCH_LIBPATH}:${LD_LIBRARY_PATH}
  export LD_LIBRARY_PATH
;;
SunOS)
  arch=`uname -m`
  if [ -n "${LD_LIBRARY_PATH}" ]; then
    if [ "${arch}" = "i86pc" ]; then
      if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/solaris/x64
      else
        LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/solaris/x86
      fi
    else
      if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/solaris/sparc64:${WL_HOME}/server/native/solaris/sparc64/oci920_8
        if [ "$SIP_ENABLED" = "true" ]; then
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WLSS_HOME}/server/native/solaris/sparc64:${WLSS_HOME}/server/native/solaris/sparc64/oci920_8
        fi
      else
        LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WL_HOME}/server/native/solaris/sparc:${WL_HOME}/server/native/solaris/sparc/oci920_8
        if [ "$SIP_ENABLED" = "true" ]; then
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WLSS_HOME}/server/native/solaris/sparc:${WLSS_HOME}/server/native/solaris/sparc/oci920_8
        fi
      fi
    fi
  else
    if [ "${arch}" = "i86pc" ]; then
      if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        LD_LIBRARY_PATH=${WL_HOME}/server/native/solaris/x64
      else
        LD_LIBRARY_PATH=${WL_HOME}/server/native/solaris/x86
      fi
    else
      if [ "${SUN_ARCH_DATA_MODEL}" = "64" ]; then
        LD_LIBRARY_PATH=${WL_HOME}/server/native/solaris/sparc64:${WL_HOME}/server/native/solaris/sparc64/oci920_8
        if [ "$SIP_ENABLED" = "true" ]; then
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WLSS_HOME}/server/native/solaris/sparc64:${WLSS_HOME}/server/native/solaris/sparc64/oci920_8
        fi
      else
        LD_LIBRARY_PATH=${WL_HOME}/server/native/solaris/sparc:${WL_HOME}/server/native/solaris/sparc/oci920_8
        if [ "$SIP_ENABLED" = "true" ]; then
          LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${WLSS_HOME}/server/native/solaris/sparc:${WLSS_HOME}/server/native/solaris/sparc/oci920_8
        fi
      fi
    fi
  fi
  LD_LIBRARY_PATH=${PATCH_LIBPATH}:${LD_LIBRARY_PATH}
  export LD_LIBRARY_PATH
  if [ "${JAVA_USE_64BIT}" = "true" ] && [ "${JAVA_VENDOR}" != "Oracle" ]
  then
     JVM_D64="-d64"
     export JVM_D64
     JAVA_VM="${JAVA_VM} ${JVM_D64}"
     export JAVA_VM
  fi
;;
Darwin)
  if [ -n "${DYLD_LIBRARY_PATH}" ]; then
    DYLD_LIBRARY_PATH=${DYLD_LIBRARY_PATH}:${WL_HOME}/server/native/macosx
  else
    DYLD_LIBRARY_PATH=${WL_HOME}/server/native/macosx
  fi
  DYLD_LIBRARY_PATH=${PATCH_LIBPATH}:${DYLD_LIBRARY_PATH}
  export DYLD_LIBRARY_PATH
;;
Windows_NT*) ;;
CYGWIN*) ;;
*)
  echo "$0: Don't know how to set the shared library path for `uname -s`.  "
esac

# set up WebLogic Server's class path 
WEBLOGIC_CLASSPATH="${JAVA_HOME}/lib/tools.jar${CLASSPATHSEP}${WL_HOME}/server/lib/weblogic_sp.jar${CLASSPATHSEP}${WL_HOME}/server/lib/weblogic.jar${CLASSPATHSEP}${FEATURES_DIR}/weblogic.server.modules_10.3.6.0.jar${CLASSPATHSEP}${WL_HOME}/server/lib/webservices.jar${CLASSPATHSEP}${ANT_HOME}/lib/ant-all.jar${CLASSPATHSEP}${ANT_CONTRIB}/lib/ant-contrib.jar"
export WEBLOGIC_CLASSPATH

# set up config tools class path 
FMWCONFIG_CLASSPATH="${JAVA_HOME}/lib/tools.jar${CLASSPATHSEP}${BEA_HOME}/utils/config/10.3/config-launch.jar${CLASSPATHSEP}${WL_HOME}/server/lib/weblogic_sp.jar${CLASSPATHSEP}${WL_HOME}/server/lib/weblogic.jar${CLASSPATHSEP}${FEATURES_DIR}/weblogic.server.modules_10.3.6.0.jar${CLASSPATHSEP}${WL_HOME}/server/lib/webservices.jar${CLASSPATHSEP}${ANT_HOME}/lib/ant-all.jar${CLASSPATHSEP}${ANT_CONTRIB}/lib/ant-contrib.jar"
export FMWCONFIG_CLASSPATH
FMWLAUNCH_CLASSPATH="${BEA_HOME}/utils/config/10.3/config-launch.jar"
export FMWLAUNCH_CLASSPATH

if [ "${PATCH_CLASSPATH}" != "" ] ; then
    WEBLOGIC_CLASSPATH="${PATCH_CLASSPATH}${CLASSPATHSEP}${WEBLOGIC_CLASSPATH}"
    export WEBLOGIC_CLASSPATH
    FMWCONFIG_CLASSPATH="${PATCH_CLASSPATH}${CLASSPATHSEP}${FMWCONFIG_CLASSPATH}"
    export FMWCONFIG_CLASSPATH
fi

if [ "$SIP_ENABLED" = "true" ]; then
  # set up SIP classpath
  SIP_CLASSPATH="${WLSS_HOME}/server/lib/weblogic_sip.jar"
  # add to WLS class path
  WEBLOGIC_CLASSPATH="${WEBLOGIC_CLASSPATH}${CLASSPATHSEP}${SIP_CLASSPATH}"
  export WEBLOGIC_CLASSPATH
  FMWCONFIG_CLASSPATH="${FMWCONFIG_CLASSPATH}${CLASSPATHSEP}${SIP_CLASSPATH}"
  export FMWCONFIG_CLASSPATH
fi

# DERBY configuration
DERBY_HOME="${WL_HOME}/common/derby"
DERBY_CLIENT_CLASSPATH="${DERBY_HOME}/lib/derbyclient.jar"
DERBY_CLASSPATH="${CLASSPATHSEP}${DERBY_HOME}/lib/derbynet.jar${CLASSPATHSEP}${DERBY_CLIENT_CLASSPATH}"
DERBY_TOOLS="${DERBY_HOME}/lib/derbytools.jar"
DERBY_SYSTEM_HOME=${WL_HOME}/common/derby/demo/databases
DERBY_OPTS="-Dderby.system.home=$DERBY_SYSTEM_HOME"

if [ "${DERBY_PRE_CLASSPATH}" != "" ] ; then
  DERBY_CLASSPATH="${DERBY_PRE_CLASSPATH}${CLASSPATHSEP}${DERBY_CLASSPATH}"
fi

if [ "${DERBY_POST_CLASSPATH}" != "" ] ; then
  DERBY_CLASSPATH="${DERBY_CLASSPATH}${CLASSPATHSEP}${DERBY_POST_CLASSPATH}"
fi

export DERBY_HOME DERBY_CLASSPATH DERBY_TOOLS DERBY_SYSTEM_HOME DERBY_OPTS 

if [ -d "${WL_HOME}/common/eval/pointbase" ]
then
  # PointBase configuration
  POINTBASE_HOME="${WL_HOME}/common/eval/pointbase"
  POINTBASE_CLIENT_CLASSPATH="${POINTBASE_HOME}/lib/pbclient57.jar"
  POINTBASE_CLASSPATH="${CLASSPATHSEP}${POINTBASE_HOME}/lib/pbembedded57.jar${CLASSPATHSEP}${POINTBASE_CLIENT_CLASSPATH}"
  POINTBASE_TOOLS="${POINTBASE_HOME}/lib/pbtools57.jar"

  if [ "${POINTBASE_PRE_CLASSPATH}" != "" ] ; then
    POINTBASE_CLASSPATH="${POINTBASE_PRE_CLASSPATH}${CLASSPATHSEP}${POINTBASE_CLASSPATH}"
  fi

  if [ "${POINTBASE_POST_CLASSPATH}" != "" ] ; then
    POINTBASE_CLASSPATH="${POINTBASE_CLASSPATH}${CLASSPATHSEP}${POINTBASE_POST_CLASSPATH}"
  fi

  export POINTBASE_HOME POINTBASE_CLASSPATH POINTBASE_TOOLS
fi


# Set up PATH
if [ `uname -s` = "CYGWIN32/NT" ]; then
# If we are on an old version of Cygnus we need to turn <letter>:/ in the path
# to //<letter>/
  WL_HOME_CYGWIN=`echo $WL_HOME | sed 's#\([a-zA-Z]\):#//\1#g'`
  ANT_HOME_CYGWIN=`echo $ANT_HOME | sed 's#\([a-zA-Z]\):#//\1#g'`
  ANT_CONTRIB_CYGWIN=`echo $ANT_CONTRIB | sed 's#\([a-zA-Z]\):#//\1#g'`
  JAVA_HOME_CYGWIN=`echo $JAVA_HOME | sed 's#\([a-zA-Z]\):#//\1#g'`
  PATCH_PATH_CYGWIN=`echo $PATCH_PATH | sed 's#\([a-zA-Z]\):#//\1#g'`
  WL_USE_X86DLL=false
  WL_USE_IA64DLL=false
  WL_USE_AMD64DLL=true
  if [ "${WL_USE_IA64DLL}" = "true" ]; then
    PATH="${PATCH_PATH_CYGWIN}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/64${PATHSEP}${WL_HOME_CYGWIN}/server/bin${PATHSEP}${ANT_HOME_CYGWIN}/bin${PATHSEP}${JAVA_HOME_CYGWIN}/jre/bin${PATHSEP}${JAVA_HOME_CYGWIN}/bin${PATHSEP}${PATH}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/64/oci920_8"
  fi
  if [ "${WL_USE_X86DLL}" = "true" ]; then
    PATH="${PATCH_PATH_CYGWIN}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/32${PATHSEP}${WL_HOME_CYGWIN}/server/bin${PATHSEP}${ANT_HOME_CYGWIN}/bin${PATHSEP}${JAVA_HOME_CYGWIN}/jre/bin${PATHSEP}${JAVA_HOME_CYGWIN}/bin${PATHSEP}${PATH}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/32/oci920_8"
  fi
  if [ "${WL_USE_AMD64DLL}" = "true" ]; then
    PATH="${PATCH_PATH_CYGWIN}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/x64${PATHSEP}${WL_HOME_CYGWIN}/server/bin${PATHSEP}${ANT_HOME_CYGWIN}/bin${PATHSEP}${JAVA_HOME_CYGWIN}/jre/bin${PATHSEP}${JAVA_HOME_CYGWIN}/bin${PATHSEP}${PATH}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/x64/oci920_8"
  fi
else
  if [ -n "`uname -s |grep -i cygwin_`" ]; then
  # If we are on an new version of Cygnus we need to turn <letter>:/ in
  # the path to /cygdrive/<letter>/
    CYGDRIVE=`mount -ps | tail -1 | awk '{print $1}' | sed -e 's%/$%%'`
    WL_HOME_CYGWIN=`echo $WL_HOME | sed "s#\([a-zA-Z]\):#${CYGDRIVE}/\1#g"`
    ANT_HOME_CYGWIN=`echo $ANT_HOME | sed "s#\([a-zA-Z]\):#${CYGDRIVE}/\1#g"`
    PATCH_PATH_CYGWIN=`echo $PATCH_PATH | sed "s#\([a-zA-Z]\):#${CYGDRIVE}/\1#g"`
    JAVA_HOME_CYGWIN=`echo $JAVA_HOME | sed "s#\([a-zA-Z]\):#${CYGDRIVE}/\1#g"`
    WL_USE_X86DLL=false
    WL_USE_IA64DLL=false
    WL_USE_AMD64DLL=true
    if [ "${WL_USE_IA64DLL}" = "true" ]; then
      PATH="${PATCH_PATH_CYGWIN}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/64${PATHSEP}${WL_HOME_CYGWIN}/server/bin${PATHSEP}${ANT_HOME_CYGWIN}/bin${PATHSEP}${JAVA_HOME_CYGWIN}/jre/bin${PATHSEP}${JAVA_HOME_CYGWIN}/bin${PATHSEP}${PATH}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/64/oci920_8"
    fi
    if [ "${WL_USE_X86DLL}" = "true" ]; then
      PATH="${PATCH_PATH_CYGWIN}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/32${PATHSEP}${WL_HOME_CYGWIN}/server/bin${PATHSEP}${ANT_HOME_CYGWIN}/bin${PATHSEP}${JAVA_HOME_CYGWIN}/jre/bin${PATHSEP}${JAVA_HOME_CYGWIN}/bin${PATHSEP}${PATH}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/32/oci920_8"
    fi
    if [ "${WL_USE_AMD64DLL}" = "true" ]; then
      PATH="${PATCH_PATH_CYGWIN}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/x64${PATHSEP}${WL_HOME_CYGWIN}/server/bin${PATHSEP}${ANT_HOME_CYGWIN}/bin${PATHSEP}${JAVA_HOME_CYGWIN}/jre/bin${PATHSEP}${JAVA_HOME_CYGWIN}/bin${PATHSEP}${PATH}${PATHSEP}${WL_HOME_CYGWIN}/server/native/win/x64/oci920_8"
    fi
  else
  # set PATH for other shell environments
    PATH="${WL_HOME}/server/bin${PATHSEP}${ANT_HOME}/bin${PATHSEP}${JAVA_HOME}/jre/bin${PATHSEP}${JAVA_HOME}/bin${PATHSEP}${PATH}"
    # On Windows, include WebLogic jDriver in PATH
    if [ -n "`uname -s |grep -i windows_nt`" ]; then
      WL_USE_X86DLL=false
      WL_USE_IA64DLL=false
      WL_USE_AMD64DLL=true
      if [ "${WL_USE_IA64DLL}" = "true" ]; then
        PATH="${PATCH_PATH}${PATHSEP}${WL_HOME}/server/native/win/64${PATHSEP}${PATH}${PATHSEP}${WL_HOME}/server/native/win/64/oci920_8"
      fi
      if [ "${WL_USE_AMD64DLL}" = "true" ]; then
        PATH="${PATCH_PATH}${PATHSEP}${WL_HOME}/server/native/win/x64${PATHSEP}${PATH}${PATHSEP}${WL_HOME}/server/native/win/x64/oci920_8"
      fi
      if [ "${WL_USE_X86DLL}" = "true" ]; then
        PATH="${PATCH_PATH}${PATHSEP}${WL_HOME}/server/native/win/32${PATHSEP}${PATH}${PATHSEP}${WL_HOME}/server/native/win/32/oci920_8"
      fi
    fi
  fi
fi
export PATH

resetFd

