@ECHO OFF

@REM WARNING: This file is created by the Configuration Wizard.
@REM Any changes to this script may be lost when adding extensions to this configuration.

SETLOCAL

@REM --- Start Functions ---

GOTO :ENDFUNCTIONS

:stopAll
	@REM We separate the stop commands into a function so we are able to use the trap command in Unix (calling a function) to stop these services
	if NOT "X%ALREADY_STOPPED%"=="X" (
		GOTO :EOF
	)
	@REM STOP DERBY (only if we started it)
	if "%DERBY_FLAG%"=="true" (
		echo Stopping Derby server...
		call "%WL_HOME%\common\derby\bin\stopNetworkServer.cmd"  >"%DOMAIN_HOME%\derbyShutdown.log" 2>&1 

		echo Derby server stopped.
	)

	set ALREADY_STOPPED=true
GOTO :EOF

:classCaching
	echo Class caching enabled...
	set JAVA_OPTIONS=%JAVA_OPTIONS% -Dlaunch.main.class=%SERVER_CLASS% -Dlaunch.class.path="%CLASSPATH%" -Dlaunch.complete=weblogic.store.internal.LockManagerImpl -cp %WL_HOME%\server\lib\pcl2.jar
	set SERVER_CLASS=com.oracle.classloader.launch.Launcher
GOTO :EOF


:ENDFUNCTIONS

@REM --- End Functions ---

@REM *************************************************************************
@REM This script is used to start WebLogic Server for this domain.
@REM 
@REM To create your own start script for your domain, you can initialize the
@REM environment by calling @USERDOMAINHOME\setDomainEnv.
@REM 
@REM setDomainEnv initializes or calls commEnv to initialize the following variables:
@REM 
@REM BEA_HOME       - The BEA home directory of your WebLogic installation.
@REM JAVA_HOME      - Location of the version of Java used to start WebLogic
@REM                  Server.
@REM JAVA_VENDOR    - Vendor of the JVM (i.e. BEA, HP, IBM, Sun, etc.)
@REM PATH           - JDK and WebLogic directories are added to system path.
@REM WEBLOGIC_CLASSPATH
@REM                - Classpath needed to start WebLogic Server.
@REM PATCH_CLASSPATH - Classpath used for patches
@REM PATCH_LIBPATH  - Library path used for patches
@REM PATCH_PATH     - Path used for patches
@REM WEBLOGIC_EXTENSION_DIRS - Extension dirs for WebLogic classpath patch
@REM JAVA_VM        - The java arg specifying the VM to run.  (i.e.
@REM                - server, -hotspot, etc.)
@REM USER_MEM_ARGS  - The variable to override the standard memory arguments
@REM                  passed to java.
@REM PRODUCTION_MODE - The variable that determines whether Weblogic Server is started in production mode.
@REM DERBY_HOME - Derby home directory.
@REM DERBY_CLASSPATH
@REM                - Classpath needed to start Derby.
@REM 
@REM Other variables used in this script include:
@REM SERVER_NAME    - Name of the weblogic server.
@REM JAVA_OPTIONS   - Java command-line options for running the server. (These
@REM                  will be tagged on to the end of the JAVA_VM and
@REM                  MEM_ARGS)
@REM CLASS_CACHE    - Enable class caching of system classpath.
@REM 
@REM For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"
@REM  (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm).
@REM *************************************************************************

@REM Call setDomainEnv here.

set DOMAIN_HOME=E:\Coding\JavaSec\weblogic\base_domain
for %%i in ("%DOMAIN_HOME%") do set DOMAIN_HOME=%%~fsi

call "%DOMAIN_HOME%\bin\setDomainEnv.cmd" %*

set SAVE_JAVA_OPTIONS=%JAVA_OPTIONS%

set SAVE_CLASSPATH=%CLASSPATH%

@REM Start Derby

set DERBY_DEBUG_LEVEL=0

if "%DERBY_FLAG%"=="true" (
	call "%WL_HOME%\common\derby\bin\startNetworkServer.cmd"  >"%DOMAIN_HOME%\derby.log" 2>&1 

)

set JAVA_OPTIONS=%SAVE_JAVA_OPTIONS%

set SAVE_JAVA_OPTIONS=

set CLASSPATH=%SAVE_CLASSPATH%

set SAVE_CLASSPATH=

if "%PRODUCTION_MODE%"=="true" (
	set WLS_DISPLAY_MODE=Production
) else (
	set WLS_DISPLAY_MODE=Development
)

if NOT "%WLS_USER%"=="" (
	set JAVA_OPTIONS=%JAVA_OPTIONS% -Dweblogic.management.username=%WLS_USER%
)

if NOT "%WLS_PW%"=="" (
	set JAVA_OPTIONS=%JAVA_OPTIONS% -Dweblogic.management.password=%WLS_PW%
)

if NOT "%MEDREC_WEBLOGIC_CLASSPATH%"=="" (
	if NOT "%CLASSPATH%"=="" (
		set CLASSPATH=%CLASSPATH%;%MEDREC_WEBLOGIC_CLASSPATH%
	) else (
		set CLASSPATH=%MEDREC_WEBLOGIC_CLASSPATH%
	)
)

echo .

echo .

echo JAVA Memory arguments: %MEM_ARGS%

echo .

echo WLS Start Mode=%WLS_DISPLAY_MODE%

echo .

echo CLASSPATH=%CLASSPATH%

echo .

echo PATH=%PATH%

echo .

echo ***************************************************

echo *  To start WebLogic Server, use a username and   *

echo *  password assigned to an admin-level user.  For *

echo *  server administration, use the WebLogic Server *

echo *  console at http:\\hostname:port\console        *

echo ***************************************************

@REM CLASS CACHING

if "%CLASS_CACHE%"=="true" (
	CALL :classCaching
)

@REM START WEBLOGIC

echo starting weblogic with Java version:

%JAVA_HOME%\bin\java %JAVA_VM% -version

if "%WLS_REDIRECT_LOG%"=="" (
	echo Starting WLS with line:
	echo %JAVA_HOME%\bin\java %JAVA_VM% %MEM_ARGS% -Dweblogic.Name=%SERVER_NAME% -Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy %JAVA_OPTIONS% %PROXY_SETTINGS% %SERVER_CLASS%
	%JAVA_HOME%\bin\java %JAVA_VM% %MEM_ARGS% -Dweblogic.Name=%SERVER_NAME% -Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy %JAVA_OPTIONS% %PROXY_SETTINGS% %SERVER_CLASS%
) else (
	echo Redirecting output from WLS window to %WLS_REDIRECT_LOG%
	%JAVA_HOME%\bin\java %JAVA_VM% %MEM_ARGS% -Dweblogic.Name=%SERVER_NAME% -Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy %JAVA_OPTIONS% %PROXY_SETTINGS% %SERVER_CLASS%  >"%WLS_REDIRECT_LOG%" 2>&1 
)

CALL :stopAll

popd

@REM Exit this script only if we have been told to exit.

if "%doExitFlag%"=="true" (
	exit
)



ENDLOCAL