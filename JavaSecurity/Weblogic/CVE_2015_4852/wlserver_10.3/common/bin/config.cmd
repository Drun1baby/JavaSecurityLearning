@ECHO OFF
SET RETURN_CODE=
SETLOCAL

FOR /f %%i in ('cd') do set MYPWD=%%i

SET WL_HOME=E:\Coding\JavaSec\wlserver_10.3
CALL "%WL_HOME%\common\bin\commEnv.cmd"
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

SET CLASSPATH=%FMWCONFIG_CLASSPATH%;%DERBY_CLASSPATH%

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
FOR %%I IN (%ARGVALUE%) DO SET ARGVALUE=%%~I
IF /i "%ARGNAME%"=="-log" (
  IF "%ARGVALUE:~1,1%"==":" (
    SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%ARGVALUE% 
  ) ELSE (    
    SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%MYPWD%\%ARGVALUE%  
  )  
  GOTO :PARSEARGS
) ELSE (
  IF  /i "%ARGNAME%"=="-silent_script" (
    IF "%ARGVALUE:~1,1%"==":" (
        SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%ARGVALUE% 
    ) ELSE (    
        SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%MYPWD%\%ARGVALUE%  
    )  
    GOTO :PARSEARGS
  ) ELSE (
    IF /i "%ARGNAME%"=="-useXACML" (
        SET MEM_ARGS=%MEM_ARGS% -DuseXACML=%ARGVALUE%
    ) ELSE (
        SET ARGUMENTS=%ARGUMENTS% %ARGNAME%="%ARGVALUE%"
    )
    GOTO :PARSEARGS
  )
)

:RUN
PUSHD %WL_HOME%\common\lib

SET JVM_ARGS=-Dprod.props.file="%WL_HOME%\.product.properties" -Dpython.cachedir="%TEMP%\cachedir" %MEM_ARGS% %CONFIG_JVM_ARGS%

IF "%ARGUMENTS%" == "" (
  %JAVA_HOME%\bin\javaw %JVM_ARGS% com.oracle.cie.wizard.WizardController %ARGUMENTS%
) ELSE (
  %JAVA_HOME%\bin\java %JVM_ARGS% -Djdbc=true com.oracle.cie.wizard.WizardController %ARGUMENTS%
)

SET RETURN_CODE=%ERRORLEVEL%
POPD

ENDLOCAL & SET RETURN_CODE=%RETURN_CODE%

SET CMD_EXIT=%USE_CMD_EXIT%
IF DEFINED CMD_EXIT (
  EXIT %RETURN_CODE%
) ELSE (
  EXIT /B %RETURN_CODE%
)
