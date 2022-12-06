@rem ****************************************************************************
@rem This script is used to set up the patch environment and should only be called
@rem from commEnv or after commEnv has already been loaded.
@rem
@rem It sets the following variables:
@rem PATCH_CLASSPATH         - WebLogic system classpath patch
@rem PATCH_LIBPATH           - Library path used for patches
@rem PATCH_PATH              - Path used for patches
@rem WEBLOGIC_EXTENSION_DIRS - Extension dirs for WebLogic classpath patch
@rem
@rem For additional information, refer to the WebLogic Server Administration
@rem Guide (http://e-docs.bea.com/wls/docs70/adminguide/startstop.html).
@rem ****************************************************************************

SET  OCP371_PATCH_CLASSPATH=%BEA_HOME%\patch_ocp371\profiles\default\sys_manifest_classpath\weblogic_patch.jar

SET  OCP371_PATCH_EXT_DIR=%BEA_HOME%\patch_ocp371\profiles\default\sysext_manifest_classpath

SET  OCP371_PATCH_LIBPATH=%BEA_HOME%\patch_ocp371\profiles\default\native

SET  OCP371_PATCH_PATH=%BEA_HOME%\patch_ocp371\profiles\default\native

SET  WLS1036_PATCH_CLASSPATH=%BEA_HOME%\patch_wls1036\profiles\default\sys_manifest_classpath\weblogic_patch.jar

SET  WLS1036_PATCH_EXT_DIR=%BEA_HOME%\patch_wls1036\profiles\default\sysext_manifest_classpath

SET  WLS1036_PATCH_LIBPATH=%BEA_HOME%\patch_wls1036\profiles\default\native

SET  WLS1036_PATCH_PATH=%BEA_HOME%\patch_wls1036\profiles\default\native


if "%PATCH_CLASSPATH%" == "" set PATCH_CLASSPATH=%WLS1036_PATCH_CLASSPATH%;%OCP371_PATCH_CLASSPATH%

if "%WEBLOGIC_EXTENSION_DIRS%" == "" set WEBLOGIC_EXTENSION_DIRS=%WLS1036_PATCH_EXT_DIR%;%OCP371_PATCH_EXT_DIR%

if "%PATCH_LIBPATH%" == "" set PATCH_LIBPATH=%WLS1036_PATCH_LIBPATH%;%OCP371_PATCH_LIBPATH%

if "%PATCH_PATH%" == "" set PATCH_PATH=%WLS1036_PATCH_PATH%;%OCP371_PATCH_PATH%

