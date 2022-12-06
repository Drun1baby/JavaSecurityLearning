@ECHO OFF

@REM WARNING: This file is created by the Configuration Wizard.
@REM Any changes to this script may be lost when adding extensions to this configuration.

SETLOCAL

@REM --- Start Functions ---

GOTO :ENDFUNCTIONS

:usage
	echo Need to set SERVER_NAME and ADMIN_URL environment variables or specify
	echo them in command line:
	echo Usage: %1 SERVER_NAME {ADMIN_URL}
	echo for example:
	echo %1 managedserver1 http://LAPTOP-476JT8H0:7001
GOTO :EOF


:ENDFUNCTIONS

@REM --- End Functions ---

@REM *************************************************************************
@REM This script is used to start a managed WebLogic Server for the domain in
@REM the current working directory.  This script can either read in the SERVER_NAME and
@REM ADMIN_URL as positional parameters or will read them from environment variables that are 
@REM set before calling this script. If SERVER_NAME is not sent as a parameter or exists with a value
@REM as an environment variable the script will EXIT. If the ADMIN_URL value cannot be determined
@REM by reading a parameter or from the environment a default value will be used.
@REM 
@REM  For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"
@REM  (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm)
@REM *************************************************************************

@REM  Set SERVER_NAME to the name of the server you wish to start up.

set DOMAIN_NAME=base_domain

set ADMIN_URL=http://LAPTOP-476JT8H0:7001

@REM  Set WLS_USER equal to your system username and WLS_PW equal  

@REM  to your system password for no username and password prompt 

@REM  during server startup.  Both are required to bypass the startup

@REM  prompt.

set WLS_USER=

set WLS_PW=

@REM  Set JAVA_OPTIONS to the java flags you want to pass to the vm. i.e.: 

@REM  set JAVA_OPTIONS=-Dweblogic.attribute=value -Djava.attribute=value

set JAVA_OPTIONS=-Dweblogic.security.SSL.trustedCAKeyStore="E:\Coding\JavaSec\wlserver_10.3\server\lib\cacerts" %JAVA_OPTIONS%

@REM  Set JAVA_VM to the java virtual machine you want to run.  For instance:

@REM  set JAVA_VM=-server

set JAVA_VM=

@REM  Set SERVER_NAME and ADMIN_URL, they must by specified before starting

@REM  a managed server, detailed information can be found at

@REM http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm

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
		CALL :usage %0
		GOTO :EOF
	)
) else (
	set ADMIN_URL=%1
	shift
)

@REM Export the admin_url whether the user specified it OR it was sent on the command-line

set ADMIN_URL=%ADMIN_URL%

set SERVER_NAME=%SERVER_NAME%

set DOMAIN_HOME=E:\Coding\JavaSec\weblogic\base_domain

if "%1"=="" (
	@REM  Call Weblogic Server with our default params since the user did not specify any other ones
	call "%DOMAIN_HOME%\bin\startWebLogic.cmd" nodebug noderby noiterativedev notestconsole noLogErrorsToConsole
) else (
	@REM  Call Weblogic Server with the params the user sent in INSTEAD of the defaults
	call "%DOMAIN_HOME%\bin\startWebLogic.cmd" %1 %2 %3 %4 %5 %6 %7 %8 %9
)



ENDLOCAL