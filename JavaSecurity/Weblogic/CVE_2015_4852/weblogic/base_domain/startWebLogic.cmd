@ECHO OFF

set JAVA_OPTIONS=-Xdebug -Xnoagent -Djava.compiler=NONE -Xrunjdwp:transport=dt_socket,address=9999,server=y,suspend=n

@REM WARNING: This file is created by the Configuration Wizard.
@REM Any changes to this script may be lost when adding extensions to this configuration.

SETLOCAL

set DOMAIN_HOME=E:\Coding\JavaSec\weblogic\base_domain

call "%DOMAIN_HOME%\bin\startWebLogic.cmd" %*



ENDLOCAL