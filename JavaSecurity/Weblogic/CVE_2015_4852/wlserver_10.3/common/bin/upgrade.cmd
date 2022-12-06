@ECHO OFF
SETLOCAL

SET WL_HOME=E:\Coding\JavaSec\wlserver_10.3
CALL "%WL_HOME%\common\bin\commEnv.cmd"
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

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
    SET ARGUMENTS=%ARGUMENTS% %ARGNAME% %ARGVALUE% 
  ) ELSE (    
    SET ARGUMENTS=%ARGUMENTS% %ARGNAME% %MYPWD%\%ARGVALUE%  
  )  
  GOTO :PARSEARGS
) ELSE (
  SET ARGUMENTS=%ARGUMENTS% %ARGNAME% %ARGVALUE%
  GOTO :PARSEARGS
)

:RUN
SET TYPE=%1
SET LOG=%2
SET PARENTDIR=%BEA_HOME%\user_projects\upgrade_logs
SET DFTLOG=

@REM Validate upgrade type
IF /i "%TYPE%"==""            SET TYPE=domain
IF /i "%TYPE%"=="domain"   SET DFTLOG=%PARENTDIR%\domain
IF /i "%TYPE%"=="cci"         SET DFTLOG=%PARENTDIR%\compatibility
IF /i "%TYPE%"=="nodemanager" SET DFTLOG=%PARENTDIR%\nodemanager
IF /i "%TYPE%"=="securityproviders" SET DFTLOG=%PARENTDIR%\securityproviders

IF NOT "%DFTLOG%"=="" GOTO LABEL1
ECHO "Usage: upgrade.cmd <domain|cci|nodemanager|securityproviders> <log_file>" 
GOTO EOF

:LABEL1
IF NOT "%LOG%"=="" GOTO LABEL2
@REM Generate default log file
SET I1=%DATE%
@REM Remove space I1
FOR /F "tokens=1-3*" %%A in ('echo %I1%') DO SET I1=%%A%%B%%C
FOR /F "tokens=1-3* delims=/" %%A in ('echo %I1%') DO SET I1=%%A%%B%%C

SET I2=%TIME%
FOR /F "tokens=1-3*" %%A in ('echo %I2%') DO SET I2=%%A%%B%%C
FOR /F "tokens=1-4* delims=:" %%A in ('echo %I2%') DO SET I2=%%A%%B%%C%%D
FOR /F "tokens=1-4* delims=." %%A in ('echo %I2%') DO SET I2=%%A%%B%%C%%D

@REM Create parent directories for the log file
IF NOT EXIST %PARENTDIR% MKDIR %PARENTDIR%

@REM To avoid write into an existing log file
FOR %%I IN (
  001 002 003 004 005 006 007 008 009 010 
  011 012 013 014 015 016 017 018 019 020 
  021 022 023 024 025 026 027 028 029 030 
  031 032 033 034 035 036 037 038 039 040 
  041 042 043 044 045 046 047 048 049 050 
  051 052 053 054 055 056 057 058 059 060 
  061 062 063 064 065 066 067 068 069 070 
  071 072 073 074 075 076 077 078 079 080 
  081 082 083 084 085 086 087 088 089 090 
  091 092 093 094 095 096 097 098 099     
) DO IF NOT EXIST "%DFTLOG%\%I1%_%I2%_%%I" (
  SET LOG=%DFTLOG%_%I1%_%I2%_%%I
  GOTO LABEL2
)
SET LOG=%DFTLOG%_%I1%_%I2%_100


:LABEL2

ECHO %JAVA_HOME%\bin\javaw.exe -classpath %PRE_CLASSPATH%;%FMWCONFIG_CLASSPATH%;%BEA_HOME%\utils\config\10.3\upgrade-launch.jar;%POST_CLASSPATH%;%DERBY_CLASSPATH%;%POINTBASE_CLASSPATH% weblogic.Upgrade -type %TYPE% %ARGUMENTS% -out %LOG% >> %LOG%

%JAVA_HOME%\bin\javaw.exe -Dprod.props.file="%WL_HOME%\.product.properties" -classpath %PRE_CLASSPATH%;%FMWCONFIG_CLASSPATH%;%BEA_HOME%\utils\config\10.3\upgrade-launch.jar;%POST_CLASSPATH%;%DERBY_CLASSPATH%;%POINTBASE_CLASSPATH% weblogic.Upgrade -type %TYPE% %ARGUMENTS% -out %LOG%


:EOF
ENDLOCAL
