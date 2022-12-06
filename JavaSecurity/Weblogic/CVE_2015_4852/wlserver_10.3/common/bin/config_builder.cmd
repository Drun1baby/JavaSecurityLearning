@ECHO OFF
SETLOCAL

FOR /f %%i in ('cd') do set MYPWD=%%i

SET WL_HOME=E:\Coding\JavaSec\wlserver_10.3
CALL "%WL_HOME%\common\bin\commEnv.cmd"
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

SET CLASSPATH=%FMWCONFIG_CLASSPATH%;%DERBY_CLASSPATH%;%POINTBASE_CLASSPATH%

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
  SET ARGUMENTS=%ARGUMENTS% %ARGNAME%=%ARGVALUE% 
  GOTO :PARSEARGS
)

:RUN
PUSHD %WL_HOME%\common\lib

IF "%ARGUMENTS%" == "" (
  %JAVA_HOME%\bin\javaw %MEM_ARGS% -Dprod.props.file="%WL_HOME%\.product.properties" com.oracle.cie.wizard.WizardController -target=template %ARGUMENTS%
) ELSE (
  %JAVA_HOME%\bin\java %MEM_ARGS% -Dprod.props.file="%WL_HOME%\.product.properties" com.oracle.cie.wizard.WizardController -target=template %ARGUMENTS%
)

POPD

ENDLOCAL
