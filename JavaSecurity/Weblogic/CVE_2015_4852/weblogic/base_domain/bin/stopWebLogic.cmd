@ECHO OFF

@REM WARNING: This file is created by the Configuration Wizard.
@REM Any changes to this script may be lost when adding extensions to this configuration.

SETLOCAL

if NOT "%1"=="" (
	set wlsUserID=%1
	set userID=username=wlsUserID,
	shift
) else (
	if NOT "%userID%"=="" (
		set wlsUserID=%userID%
		set userID=username=wlsUserID,
	)
)

if NOT "%1"=="" (
	set wlsPassword=%1
	set password=password=wlsPassword,
	shift
) else (
	if NOT "%password%"=="" (
		set wlsPassword=%password%
		set password=password=wlsPassword,
	)
)

@REM set ADMIN_URL

if NOT "%1"=="" (
	set ADMIN_URL=%1
	shift
) else (
	if "%ADMIN_URL%"=="" (
		set ADMIN_URL=t3://LAPTOP-476JT8H0:7001
	)
)

@REM Call setDomainEnv here because we want to have shifted out the environment vars above

set DOMAIN_HOME=E:\Coding\JavaSec\weblogic\base_domain
for %%i in ("%DOMAIN_HOME%") do set DOMAIN_HOME=%%~fsi

@REM Read the environment variable from the console.

if "%doExit%"=="true" (
	set exitFlag=doExit
) else (
	set exitFlag=noExit
)

call "%DOMAIN_HOME%\bin\setDomainEnv.cmd" %exitFlag%

echo wlsUserID = java.lang.System.getenv^('wlsUserID'^) >"shutdown.py" 
echo wlsPassword = java.lang.System.getenv^('wlsPassword'^) >>"shutdown.py" 
echo connect^(%userID% %password% url='%ADMIN_URL%', adminServerName='%SERVER_NAME%'^) >>"shutdown.py" 
echo shutdown^('%SERVER_NAME%','Server', ignoreSessions='true'^) >>"shutdown.py" 
echo exit^(^) >>"shutdown.py" 

echo Stopping Weblogic Server...

%JAVA_HOME%\bin\java -classpath %FMWCONFIG_CLASSPATH% %MEM_ARGS% %JVM_D64% %JAVA_OPTIONS% weblogic.WLST shutdown.py  2>&1 

echo Done

echo Stopping Derby Server...

if "%DERBY_FLAG%"=="true" (
	call "%WL_HOME%\common\derby\bin\stopNetworkServer.cmd"  >"%DOMAIN_HOME%\derbyShutdown.log" 2>&1 
	echo Derby server stopped.
)

@REM Exit this script only if we have been told to exit.

if "%doExitFlag%"=="true" (
	exit
)



ENDLOCAL