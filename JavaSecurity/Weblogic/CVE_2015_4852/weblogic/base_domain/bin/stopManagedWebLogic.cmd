@ECHO OFF

@REM WARNING: This file is created by the Configuration Wizard.
@REM Any changes to this script may be lost when adding extensions to this configuration.

SETLOCAL

@REM --- Start Functions ---

GOTO :ENDFUNCTIONS

:usage
	echo You must have a value for SERVER_NAME either set as an environment variable or the first parameter on the command-line.
	echo ADMIN_URL defaults to t3:\\LAPTOP-476JT8H0:7001 if not set as an environment variable or the second command-line parameter.
	echo USER_NAME and PASSWORD are required for shutting the server down when running in production mode:
	echo Usage: %1 {SERVER_NAME} {ADMIN_URL} {USER_NAME} {PASSWORD}
	echo for example:
	echo %1 managedserver1 t3://LAPTOP-476JT8H0:7001 weblogic weblogic
GOTO :EOF


:ENDFUNCTIONS

@REM --- End Functions ---

@REM *************************************************************************
@REM This script is used to stop a managed WebLogic Server for the domain in
@REM the current working directory.  This script reads in the SERVER_NAME and
@REM ADMIN_URL as positional parameters, sets the SERVER_NAME variable, then
@REM calls the startWLS.cmd script under %WL_HOME%\server\bin.
@REM 
@REM Other variables that startWLS takes are:
@REM 
@REM WLS_USER       - cleartext user for server startup
@REM WLS_PW         - cleartext password for server startup
@REM JAVA_OPTIONS   - Java command-line options for running the server. (These
@REM                  will be tagged on to the end of the JAVA_VM)
@REM JAVA_VM        - The java arg specifying the VM to run.  (i.e. -server, 
@REM                  -hotspot, etc.)
@REM 
@REM For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"
@REM 
@REM  (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm)
@REM 
@REM *************************************************************************

@REM  Set SERVER_NAME and ADMIN_URL, they must by specified before starting

@REM  a managed server, detailed information can be found at

@REM  http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm

if "%1"=="" (
	if "%SERVER_NAME%"=="" (
		CALL :usage %0
		GOTO :EOF
	)
) else (
	set SERVER_NAME=%1
	shift
)

if "%1"=="" (
	if "%ADMIN_URL%"=="" (
		set ADMIN_URL=t3://LAPTOP-476JT8H0:7001
	)
) else (
	set ADMIN_URL=%1
	shift
)

set DOMAIN_HOME=E:\Coding\JavaSec\weblogic\base_domain

call "%DOMAIN_HOME%\bin\stopWebLogic.cmd" %1 %2



ENDLOCAL