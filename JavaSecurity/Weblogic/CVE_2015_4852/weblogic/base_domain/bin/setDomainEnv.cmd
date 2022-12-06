@ECHO OFF

@REM WARNING: This file is created by the Configuration Wizard.
@REM Any changes to this script may be lost when adding extensions to this configuration.

@REM *************************************************************************
@REM This script is used to setup the needed environment to be able to start Weblogic Server in this domain.
@REM 
@REM This script initializes the following variables before calling commEnv to set other variables:
@REM 
@REM WL_HOME         - The BEA home directory of your WebLogic installation.
@REM JAVA_VM         - The desired Java VM to use. You can set this environment variable before calling
@REM                   this script to switch between Sun or BEA or just have the default be set. 
@REM JAVA_HOME       - Location of the version of Java used to start WebLogic
@REM                   Server. Depends directly on which JAVA_VM value is set by default or by the environment.
@REM USER_MEM_ARGS   - The variable to override the standard memory arguments
@REM                   passed to java.
@REM PRODUCTION_MODE - The variable that determines whether Weblogic Server is started in production mode.
@REM DOMAIN_PRODUCTION_MODE 
@REM                 - The variable that determines whether the workshop related settings like the debugger,
@REM                   testconsole or iterativedev should be enabled. ONLY settable using the 
@REM                   command-line parameter named production
@REM                   NOTE: Specifying the production command-line param will force 
@REM                          the server to start in production mode.
@REM 
@REM Other variables used in this script include:
@REM SERVER_NAME     - Name of the weblogic server.
@REM JAVA_OPTIONS    - Java command-line options for running the server. (These
@REM                   will be tagged on to the end of the JAVA_VM and
@REM                   MEM_ARGS)
@REM 
@REM For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"
@REM (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm).
@REM *************************************************************************

set WL_HOME=E:\Coding\JavaSec\wlserver_10.3
for %%i in ("%WL_HOME%") do set WL_HOME=%%~fsi

set BEA_JAVA_HOME=

set SUN_JAVA_HOME=E:\Coding\Java\jdk1.7.0_21

if "%JAVA_VENDOR%"=="Oracle" (
	set JAVA_HOME=%BEA_JAVA_HOME%
) else (
	if "%JAVA_VENDOR%"=="Sun" (
		set JAVA_HOME=%SUN_JAVA_HOME%
	) else (
		set JAVA_VENDOR=Sun
		set JAVA_HOME=E:\Coding\Java\jdk1.7.0_21
	)
)

@REM We need to reset the value of JAVA_HOME to get it shortened AND 
@REM we can not shorten it above because immediate variable expansion will blank it

set JAVA_HOME=%JAVA_HOME%
for %%i in ("%JAVA_HOME%") do set JAVA_HOME=%%~fsi

set SAMPLES_HOME=%WL_HOME%\samples

set DOMAIN_HOME=E:\Coding\JavaSec\weblogic\base_domain
for %%i in ("%DOMAIN_HOME%") do set DOMAIN_HOME=%%~fsi

set LONG_DOMAIN_HOME=E:\Coding\JavaSec\weblogic\base_domain

if "%DEBUG_PORT%"=="" (
	set DEBUG_PORT=8453
)

if "%SERVER_NAME%"=="" (
	set SERVER_NAME=AdminServer
)

set DERBY_FLAG=false

set enableHotswapFlag=

set PRODUCTION_MODE=

set doExitFlag=false
set verboseLoggingFlag=false
for %%p in (%*) do call :SET_PARAM %%p
GOTO :CMD_LINE_DONE
	:SET_PARAM
	for %%q in (%1) do set noQuotesParam=%%~q
	if /i "%noQuotesParam%" == "nodebug" (
		set debugFlag=false
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "production" (
		set DOMAIN_PRODUCTION_MODE=true
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "notestconsole" (
		set testConsoleFlag=false
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "noiterativedev" (
		set iterativeDevFlag=false
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "noLogErrorsToConsole" (
		set logErrorsToConsoleFlag=false
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "noderby" (
		set DERBY_FLAG=false
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "doExit" (
		set doExitFlag=true
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "noExit" (
		set doExitFlag=false
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "verbose" (
		set verboseLoggingFlag=true
		GOTO :EOF
	)
	if /i "%noQuotesParam%" == "enableHotswap" (
		set enableHotswapFlag=-javaagent:%WL_HOME%\server\lib\diagnostics-agent.jar
		GOTO :EOF
	) else (
		set PROXY_SETTINGS=%PROXY_SETTINGS% %1
	)
	GOTO :EOF
:CMD_LINE_DONE


set MEM_DEV_ARGS=

if "%DOMAIN_PRODUCTION_MODE%"=="true" (
	set PRODUCTION_MODE=%DOMAIN_PRODUCTION_MODE%
)

if "%PRODUCTION_MODE%"=="true" (
	set debugFlag=false
	set testConsoleFlag=false
	set iterativeDevFlag=false
	set logErrorsToConsoleFlag=false
)

@REM If you want to override the default Patch Classpath, Library Path and Path for this domain,
@REM Please uncomment the following lines and add a valid value for the environment variables
@REM set PATCH_CLASSPATH=[myPatchClasspath] (windows)
@REM set PATCH_LIBPATH=[myPatchLibpath] (windows)
@REM set PATCH_PATH=[myPatchPath] (windows)
@REM PATCH_CLASSPATH=[myPatchClasspath] (unix)
@REM PATCH_LIBPATH=[myPatchLibpath] (unix)
@REM PATCH_PATH=[myPatchPath] (unix)

call "%WL_HOME%\common\bin\commEnv.cmd"

set WLS_HOME=%WL_HOME%\server

if "%JAVA_VENDOR%"=="Sun" (
	set WLS_MEM_ARGS_64BIT=-Xms256m -Xmx512m
	set WLS_MEM_ARGS_32BIT=-Xms256m -Xmx512m
) else (
	set WLS_MEM_ARGS_64BIT=-Xms512m -Xmx512m
	set WLS_MEM_ARGS_32BIT=-Xms512m -Xmx512m
)

set MEM_ARGS_64BIT=%WLS_MEM_ARGS_64BIT%

set MEM_ARGS_32BIT=%WLS_MEM_ARGS_32BIT%

if "%JAVA_USE_64BIT%"=="true" (
	set MEM_ARGS=%MEM_ARGS_64BIT%
) else (
	set MEM_ARGS=%MEM_ARGS_32BIT%
)

set MEM_PERM_SIZE_64BIT=-XX:PermSize=128m

set MEM_PERM_SIZE_32BIT=-XX:PermSize=48m

if "%JAVA_USE_64BIT%"=="true" (
	set MEM_PERM_SIZE=%MEM_PERM_SIZE_64BIT%
) else (
	set MEM_PERM_SIZE=%MEM_PERM_SIZE_32BIT%
)

set MEM_MAX_PERM_SIZE_64BIT=-XX:MaxPermSize=256m

set MEM_MAX_PERM_SIZE_32BIT=-XX:MaxPermSize=128m

if "%JAVA_USE_64BIT%"=="true" (
	set MEM_MAX_PERM_SIZE=%MEM_MAX_PERM_SIZE_64BIT%
) else (
	set MEM_MAX_PERM_SIZE=%MEM_MAX_PERM_SIZE_32BIT%
)

if "%JAVA_VENDOR%"=="Sun" (
	if "%PRODUCTION_MODE%"=="" (
		set MEM_DEV_ARGS=-XX:CompileThreshold=8000 %MEM_PERM_SIZE% 
	)
)

@REM Had to have a separate test here BECAUSE of immediate variable expansion on windows

if "%JAVA_VENDOR%"=="Sun" (
	set MEM_ARGS=%MEM_ARGS% %MEM_DEV_ARGS% %MEM_MAX_PERM_SIZE%
)

if "%JAVA_VENDOR%"=="HP" (
	set MEM_ARGS=%MEM_ARGS% %MEM_MAX_PERM_SIZE%
)

if "%JAVA_VENDOR%"=="Apple" (
	set MEM_ARGS=%MEM_ARGS% %MEM_MAX_PERM_SIZE%
)

@REM IF USER_MEM_ARGS the environment variable is set, use it to override ALL MEM_ARGS values

if NOT "%USER_MEM_ARGS%"=="" (
	set MEM_ARGS=%USER_MEM_ARGS%
)

set JAVA_PROPERTIES=-Dplatform.home=%WL_HOME% -Dwls.home=%WLS_HOME% -Dweblogic.home=%WLS_HOME% 

@REM  To use Java Authorization Contract for Containers (JACC) in this domain, 
@REM  please uncomment the following section. If there are multiple machines in 
@REM  your domain, be sure to edit the setDomainEnv in the associated domain on 
@REM  each machine.
@REM 
@REM -Djava.security.manager
@REM -Djava.security.policy=location of weblogic.policy
@REM -Djavax.security.jacc.policy.provider=weblogic.security.jacc.simpleprovider.SimpleJACCPolicy
@REM -Djavax.security.jacc.PolicyConfigurationFactory.provider=weblogic.security.jacc.simpleprovider.PolicyConfigurationFactoryImpl
@REM -Dweblogic.security.jacc.RoleMapperFactory.provider=weblogic.security.jacc.simpleprovider.RoleMapperFactoryImpl

set JAVA_PROPERTIES=%JAVA_PROPERTIES% %EXTRA_JAVA_PROPERTIES%

set ARDIR=%WL_HOME%\server\lib

pushd %LONG_DOMAIN_HOME%

@REM Clustering support (edit for your cluster!)

if "%ADMIN_URL%"=="" (
	@REM The then part of this block is telling us we are either starting an admin server OR we are non-clustered
	set CLUSTER_PROPERTIES=-Dweblogic.management.discover=true
) else (
	set CLUSTER_PROPERTIES=-Dweblogic.management.discover=false -Dweblogic.management.server=%ADMIN_URL%
)

if NOT "%LOG4J_CONFIG_FILE%"=="" (
	set JAVA_PROPERTIES=%JAVA_PROPERTIES% -Dlog4j.configuration=file:%LOG4J_CONFIG_FILE%
)

set JAVA_PROPERTIES=%JAVA_PROPERTIES% %CLUSTER_PROPERTIES%

set JAVA_DEBUG=

if "%debugFlag%"=="true" (
	set JAVA_DEBUG=-Xdebug -Xnoagent -Xrunjdwp:transport=dt_socket,address=%DEBUG_PORT%,server=y,suspend=n -Djava.compiler=NONE
	set JAVA_OPTIONS=%JAVA_OPTIONS% %enableHotswapFlag% -ea -da:com.bea... -da:javelin... -da:weblogic... -ea:com.bea.wli... -ea:com.bea.broker... -ea:com.bea.sbconsole...
) else (
	set JAVA_OPTIONS=%JAVA_OPTIONS% %enableHotswapFlag% -da
)

if NOT exist %JAVA_HOME%\lib (
	echo The JRE was not found in directory %JAVA_HOME%. ^(JAVA_HOME^)
	echo Please edit your environment and set the JAVA_HOME
	echo variable to point to the root directory of your Java installation.
	popd
	pause
	GOTO :EOF
)

if "%DERBY_FLAG%"=="true" (
	set DATABASE_CLASSPATH=%DERBY_CLASSPATH%
) else (
	set DATABASE_CLASSPATH=%DERBY_CLIENT_CLASSPATH%
)

if NOT "%DATABASE_CLASSPATH%"=="" (
	if NOT "%POST_CLASSPATH%"=="" (
		set POST_CLASSPATH=%POST_CLASSPATH%;%DATABASE_CLASSPATH%
	) else (
		set POST_CLASSPATH=%DATABASE_CLASSPATH%
	)
)

if NOT "%ARDIR%"=="" (
	if NOT "%POST_CLASSPATH%"=="" (
		set POST_CLASSPATH=%POST_CLASSPATH%;%ARDIR%\xqrl.jar
	) else (
		set POST_CLASSPATH=%ARDIR%\xqrl.jar
	)
)

@REM PROFILING SUPPORT

set JAVA_PROFILE=

set SERVER_CLASS=weblogic.Server

set JAVA_PROPERTIES=%JAVA_PROPERTIES% %WLP_JAVA_PROPERTIES%

set JAVA_OPTIONS=%JAVA_OPTIONS% %JAVA_PROPERTIES% -Dwlw.iterativeDev=%iterativeDevFlag% -Dwlw.testConsole=%testConsoleFlag% -Dwlw.logErrorsToConsole=%logErrorsToConsoleFlag%

if "%PRODUCTION_MODE%"=="true" (
	set JAVA_OPTIONS= -Dweblogic.ProductionModeEnabled=true %JAVA_OPTIONS%
)

@REM -- Setup properties so that we can save stdout and stderr to files

if NOT "%WLS_STDOUT_LOG%"=="" (
	echo Logging WLS stdout to %WLS_STDOUT_LOG%
	set JAVA_OPTIONS=%JAVA_OPTIONS% -Dweblogic.Stdout=%WLS_STDOUT_LOG%
)

if NOT "%WLS_STDERR_LOG%"=="" (
	echo Logging WLS stderr to %WLS_STDERR_LOG%
	set JAVA_OPTIONS=%JAVA_OPTIONS% -Dweblogic.Stderr=%WLS_STDERR_LOG%
)

@REM ADD EXTENSIONS TO CLASSPATHS

if NOT "%EXT_PRE_CLASSPATH%"=="" (
	if NOT "%PRE_CLASSPATH%"=="" (
		set PRE_CLASSPATH=%EXT_PRE_CLASSPATH%;%PRE_CLASSPATH%
	) else (
		set PRE_CLASSPATH=%EXT_PRE_CLASSPATH%
	)
)

if NOT "%EXT_POST_CLASSPATH%"=="" (
	if NOT "%POST_CLASSPATH%"=="" (
		set POST_CLASSPATH=%POST_CLASSPATH%;%EXT_POST_CLASSPATH%
	) else (
		set POST_CLASSPATH=%EXT_POST_CLASSPATH%
	)
)

if NOT "%WEBLOGIC_EXTENSION_DIRS%"=="" (
	set JAVA_OPTIONS=%JAVA_OPTIONS% -Dweblogic.ext.dirs=%WEBLOGIC_EXTENSION_DIRS%
)

set JAVA_OPTIONS=%JAVA_OPTIONS%

@REM SET THE CLASSPATH

if NOT "%WLP_POST_CLASSPATH%"=="" (
	if NOT "%CLASSPATH%"=="" (
		set CLASSPATH=%WLP_POST_CLASSPATH%;%CLASSPATH%
	) else (
		set CLASSPATH=%WLP_POST_CLASSPATH%
	)
)

if NOT "%POST_CLASSPATH%"=="" (
	if NOT "%CLASSPATH%"=="" (
		set CLASSPATH=%POST_CLASSPATH%;%CLASSPATH%
	) else (
		set CLASSPATH=%POST_CLASSPATH%
	)
)

if NOT "%WEBLOGIC_CLASSPATH%"=="" (
	if NOT "%CLASSPATH%"=="" (
		set CLASSPATH=%WEBLOGIC_CLASSPATH%;%CLASSPATH%
	) else (
		set CLASSPATH=%WEBLOGIC_CLASSPATH%
	)
)

if NOT "%PRE_CLASSPATH%"=="" (
	set CLASSPATH=%PRE_CLASSPATH%;%CLASSPATH%
)

if NOT "%JAVA_VENDOR%"=="BEA" (
	set JAVA_VM=%JAVA_VM% %JAVA_DEBUG% %JAVA_PROFILE%
) else (
	set JAVA_VM=%JAVA_VM% %JAVA_DEBUG% %JAVA_PROFILE%
)

