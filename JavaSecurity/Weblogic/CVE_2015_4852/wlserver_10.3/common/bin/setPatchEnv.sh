# ****************************************************************************
# This script is used to set up the patch environment and should only be called
# from commEnv or after commEnv has already been loaded.
#
# It sets the following variables:
# PATCH_CLASSPATH         - WebLogic system classpath patch
# PATCH_LIBPATH           - Library path used for patches
# PATCH_PATH              - Path used for patches
# WEBLOGIC_EXTENSION_DIRS - Extension dirs for WebLogic classpath patch
#
# For additional information, refer to the WebLogic Server Administration
# Guide (http://e-docs.bea.com/wls/docs70/adminguide/startstop.html).
# ****************************************************************************

OCP371_PATCH_CLASSPATH=${BEA_HOME}/patch_ocp371/profiles/default/sys_manifest_classpath/weblogic_patch.jar

OCP371_PATCH_EXT_DIR=${BEA_HOME}/patch_ocp371/profiles/default/sysext_manifest_classpath

OCP371_PATCH_LIBPATH=${BEA_HOME}/patch_ocp371/profiles/default/native

OCP371_PATCH_PATH=${BEA_HOME}/patch_ocp371/profiles/default/native

WLS1036_PATCH_CLASSPATH=${BEA_HOME}/patch_wls1036/profiles/default/sys_manifest_classpath/weblogic_patch.jar

WLS1036_PATCH_EXT_DIR=${BEA_HOME}/patch_wls1036/profiles/default/sysext_manifest_classpath

WLS1036_PATCH_LIBPATH=${BEA_HOME}/patch_wls1036/profiles/default/native

WLS1036_PATCH_PATH=${BEA_HOME}/patch_wls1036/profiles/default/native


export WLS1036_PATCH_CLASSPATH WLS1036_PATCH_EXT_DIR WLS1036_PATCH_LIBPATH WLS1036_PATCH_PATH

export OCP371_PATCH_CLASSPATH OCP371_PATCH_EXT_DIR OCP371_PATCH_LIBPATH OCP371_PATCH_PATH

if [ "${PATCH_CLASSPATH}" = "" ]; then
    PATCH_CLASSPATH=${WLS1036_PATCH_CLASSPATH}${CLASSPATHSEP}${OCP371_PATCH_CLASSPATH}
fi

if [ "${WEBLOGIC_EXTENSION_DIRS}" = "" ]; then
    WEBLOGIC_EXTENSION_DIRS=${WLS1036_PATCH_EXT_DIR}${PATHSEP}${OCP371_PATCH_EXT_DIR}
fi

if [ "${PATCH_LIBPATH}" = "" ]; then
    PATCH_LIBPATH=${WLS1036_PATCH_LIBPATH}${PATHSEP}${OCP371_PATCH_LIBPATH}
fi

if [ "${PATCH_PATH}" = "" ]; then
    PATCH_PATH=${WLS1036_PATCH_PATH}${PATHSEP}${OCP371_PATCH_PATH}
fi


export PATCH_CLASSPATH WEBLOGIC_EXTENSION_DIRS PATCH_LIBPATH PATCH_PATH
