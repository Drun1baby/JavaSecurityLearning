@ECHO OFF
SETLOCAL

SET WL_HOME=E:\Coding\JavaSec\wlserver_10.3
CALL "%WL_HOME%\common\bin\commEnv.cmd"
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

SET CLASSPATH=%FMWCONFIG_CLASSPATH%;%DERBY_CLASSPATH%;%POINTBASE_CLASSPATH%

if /I "%1"=="-help" (
  GOTO :RUN
)

:PARSEARGS
SET VALIDATE=%2
FOR %%I IN (%VALIDATE%) DO SET VALIDATE=%%~I
if NOT {%1}=={} (
  IF "%VALIDATE:~0,1%"=="-" (
    ECHO ERROR! Missing equal^(=^) sign. Arguments must be -name=value!
    GOTO :EOF
  )
  IF "%VALIDATE%"=="" (
    ECHO ERROR! Missing value! Arguments must be -name=value!
    GOTO :EOF
  )
  GOTO :SETARG
) ELSE (
  GOTO :RUN
)

:SETARG
SET ARGNAME=%1
SET ARGVALUE=%2
SHIFT
SHIFT
@REM Since we must change directories prior to running unpack, convert file
@REM paths to absolute.  Also use short names to avoid problems with spaces
@REM in names
FOR %%I IN (%ARGVALUE%) DO SET FILEARGVALUE=%%~FSI
IF /i "%ARGNAME%"=="-log" (
  SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%FILEARGVALUE% 
  GOTO :PARSEARGS
) 
IF  /i "%ARGNAME%"=="-domain" (
  SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%FILEARGVALUE% 
  GOTO :PARSEARGS
)
IF  /i "%ARGNAME%"=="-template" (
  SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%FILEARGVALUE% 
  GOTO :PARSEARGS
)
IF  /i "%ARGNAME%"=="-app_dir" (
  SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%FILEARGVALUE% 
  GOTO :PARSEARGS
)

FOR %%I IN (%ARGVALUE%) DO SET FILEARGVALUE=%%~I
SET ARGUMENTS=%ARGUMENTS% %ARGNAME%="%ARGVALUE%"
GOTO :PARSEARGS

:RUN
PUSHD %WL_HOME%\common\lib

SET JVM_ARGS=-Dprod.props.file="%WL_HOME%\.product.properties" %MEM_ARGS% %CONFIG_JVM_ARGS%

%JAVA_HOME%\bin\java %JVM_ARGS% com.oracle.cie.domain.script.Unpacker %ARGUMENTS%


POPD

ENDLOCAL
