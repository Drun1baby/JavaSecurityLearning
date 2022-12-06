@rem *************************************************************************
@rem This script is used to set up your environment for development with  
@rem WebLogic Server. It sets the following variables: 
@rem
@rem WL_HOME    - The root directory of your WebLogic installation
@rem JAVA_HOME  - Location of the version of Java used to start WebLogic 
@rem              Server. This variable must point to the root directory of a 
@rem              JDK installation and will be set for you by the installer. 
@rem              See the Oracle Fusion Middleware Supported System Configurations page 
@rem              (http://www.oracle.com/technology/software/products/ias/files/fusion_certification.html) 
@rem              for an up-to-date list of supported JVMs.
@rem PATH       - Adds the JDK and WebLogic directories to the system path.  
@rem CLASSPATH  - Adds the JDK and WebLogic jars to the classpath.  
@rem 
@rem Other variables that setWLSEnv takes are:
@rem
@rem PRE_CLASSPATH  - Path style variable to be added to the beginning of the 
@rem                  CLASSPATH 
@rem POST_CLASSPATH - Path style variable to be added to the end of the 
@rem                  CLASSPATH 
@rem PRE_PATH       - Path style variable to be added to the beginning of the 
@rem                  PATH 
@rem POST_PATH      - Path style variable to be added to the end of the PATH 
@rem
@rem When setting these variables below, please use short file names(8.3). 
@rem To display short (MS-DOS) filenames, use "dir /x". File names with 
@rem spaces will break this script.
@rem 
@rem jDriver for Oracle users: This script assumes that native libraries 
@rem required for jDriver for Oracle have been installed in the proper 
@rem location and that your system PATH variable has been set appropriately. 
@rem
@rem For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server" 
@rem (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm).
@rem *************************************************************************
@echo off

@rem Set user-defined variables.
set WL_HOME=E:\Coding\JavaSec\wlserver_10.3
call "%WL_HOME%\common\bin\commEnv.cmd"

@rem Check that the WebLogic classes are where we expect them to be
@if exist "%WL_HOME%\server\lib\weblogic.jar" goto checkJava
@echo.
@echo The WebLogic Server wasn't found in directory %WL_HOME%\server.
@echo Please edit the setWLSEnv.cmd script so that the WL_HOME
@echo variable points to the WebLogic installation directory.
@echo Your environment has not been set.
@goto finish

@rem Check that java is where we expect it to be
:checkJava
@if exist "%JAVA_HOME%\bin\java.exe" goto setWLSEnv
@echo.
@echo The JDK wasn't found in directory %JAVA_HOME%.
@echo Please edit the setWLSEnv.cmd script so that the JAVA_HOME
@echo variable points to the location of your JDK.
@echo Your environment has not been set.
@goto finish

:setWLSEnv
set CLASSPATH=%WEBLOGIC_CLASSPATH%;%CLASSPATH%

@rem Import extended environment

if exist extEnv.cmd call extEnv.cmd
if not "%EXT_PRE_CLASSPATH%" == "" set CLASSPATH=%EXT_PRE_CLASSPATH%;%CLASSPATH%
if not "%EXT_POST_CLASSPATH%" == "" set CLASSPATH=%CLASSPATH%;%EXT_POST_CLASSPATH%
if not "%EXT_PRE_PATH%" == "" set PATH=%EXT_PRE_PATH%;%PATH%
if not "%EXT_POST_PATH%" == "" set PATH=%PATH%;%EXT_POST_PATH%

@rem Get PRE and POST environment
if not "%PRE_CLASSPATH%" == "" set CLASSPATH=%PRE_CLASSPATH%;%CLASSPATH%
if not "%POST_CLASSPATH%" == "" set CLASSPATH=%CLASSPATH%;%POST_CLASSPATH%
if not "%PRE_PATH%" == "" set PATH=%PRE_PATH%;%PATH%
if not "%POST_PATH%" == "" set PATH=%PATH%;%POST_PATH%

if "%WLS_NOT_BRIEF_ENV%"=="" (
@echo.
@echo CLASSPATH="%CLASSPATH%"
@echo.
@echo PATH="%PATH%"
@echo.
@echo Your environment has been set.
)

:finish
