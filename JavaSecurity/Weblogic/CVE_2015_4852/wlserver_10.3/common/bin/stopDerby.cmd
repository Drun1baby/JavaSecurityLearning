@ECHO OFF
@SETLOCAL

SET WL_HOME=E:\Coding\JavaSec\wlserver_10.3
SET DERBY_CMD_LINE_ARGS=
CALL "%WL_HOME%\common\bin\commEnv.cmd"
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

@REM Add PointBase classes to the classpath
SET CLASSPATH=%DERBY_CLASSPATH%;%DERBY_TOOLS%

GOTO :SETDEFAULTS

:SETDEFAULTS
SET SCRIPT_NAME=%0
SET HOST=localhost
SET PORT=9093
SET DBNAME=demo
SET USERNAME=PBSYSADMIN
SET PASSWORD=PBSYSADMIN
GOTO :PARSEARGS


:PARSEARGS
SET VALIDATE=%2
FOR %%I IN (%VALIDATE%) DO SET VALIDATE=%%~I
if NOT {%1}=={} (
  IF "%VALIDATE:~0,1%"=="-" (
    ECHO ERROR! Missing equal^(=^) sign. Arguments must be -name=value!
    GOTO :USAGE
  )
  IF "%VALIDATE%"=="" (
    ECHO ERROR! Missing value! Arguments must be -name=value!
    GOTO :USAGE
  )
  GOTO :SETARG
) ELSE (
  GOTO :RUN
)

:SETARG
SET ARGNAME=%1
SET ARGVALUE=%2
IF NOT DEFINED DERBY_CMD_LINE_ARGS (
   SET DERBY_CMD_LINE_ARGS=%ARGNAME% %ARGVALUE%
) ELSE (
   SET DERBY_CMD_LINE_ARGS=%DERBY_CMD_LINE_ARGS% %ARGNAME% %ARGVALUE%
)
SHIFT
SHIFT
FOR %%I IN (%ARGVALUE%) DO SET ARGVALUE=%%~I
IF /i "%ARGNAME%"=="-p" (
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-h" (
  GOTO :PARSEARGS
) ELSE (
  ECHO UNKNOWN SWITCH %ARGNAME%!
  GOTO :USAGE
)

:RUN
ECHO SHUTDOWN FORCE; | %WL_HOME%\common\derby\bin\stopNetworkServer.cmd %DERBY_CMD_LINE_ARGS%
GOTO :EOF


:USAGE
ECHO ========================================================
ECHO  USAGE:
ECHO    VALID SWITCHES:
ECHO      -p=The port that the Derby Server is running on.^(default=1527^)
ECHO .
ECHO      -h=This host that the Derby server is running on.^(default=localhost^)
ECHO .
ECHO EXAMPLE:
ECHO %SCRIPT_NAME% -p=1527 -h=myhost
ECHO ========================================================

@ENDLOCAL
