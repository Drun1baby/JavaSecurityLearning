@ECHO OFF
@SETLOCAL

SET WL_HOME="E:\Coding\JavaSec\wlserver_10.3"
SET DERBY_CMD_LINE_ARGS=
CALL "%WL_HOME%\common\bin\commEnv.cmd"
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

@REM Add Derby classes to the classpath
SET CLASSPATH=%DERBY_CLASSPATH%;%WEBLOGIC_CLASSPATH%

IF NOT "%DOMAIN_HOME%"=="" (
  SET CLASSPATH=%CLASSPATH%;%DOMAIN_HOME%
)

GOTO :SETDEFAULTS

:SETDEFAULTS

@REM DERBY DEFAULTS
SET SCRIPT_NAME=%0
SET DERBY_HOME=%WL_HOME%/common/derby
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


  IF /i "%ARGNAME%"=="-maxthreads" (
   SET DERBY_OPTS=%DERBY_OPTS% -Dderby.drda.maxThreads=%ARGVALUE%
  ) ELSE (
    IF /i "%ARGNAME%"=="-timeslice" (
     SET DERBY_OPTS=%DERBY_OPTS% -Dderby.drda.timeSlice=%ARGVALUE%
    ) ELSE (
      IF /i "%ARGNAME%"=="-tracedirectory" (
       SET DERBY_OPTS=%DERBY_OPTS% -Dderby.drda.traceDirectory=%ARGVALUE%
      ) ELSE (
        IF /i "%ARGNAME%"=="-traceAll" (
         SET DERBY_OPTS=%DERBY_OPTS% -Dderby.drda.traceAll=%ARGVALUE%
        ) ELSE (
          IF /i "%ARGNAME%"=="-logconnections" (
           SET DERBY_OPTS=%DERBY_OPTS% -Dderby.drda.logConnections=%ARGVALUE%
          ) ELSE (
             SET DERBY_CMD_LINE_ARGS=%DERBY_CMD_LINE_ARGS% %ARGNAME% %ARGVALUE%
          )
        )
      )
    )
  )

SHIFT
SHIFT
FOR %%I IN (%ARGVALUE%) DO SET ARGVALUE=%%~I
IF /i "%ARGNAME%"=="-p" (
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-h" (
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-maxthreads" (
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-timeslice" (
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-tracedirectory" (
  GOTO :PARSEARGS
) 
IF /i "%ARGNAME%"=="-traceAll" (
  IF /i "%ARGVALUE%"=="true" (
    SET TRACEALL=true
  ) ELSE (
    IF /i "%ARGVALUE%"=="false" (
      ECHO traceALL is false 
    ) ELSE (
      ECHO UNKNOWN -traceAll OPTION %ARGVALUE%! Valid options are "true" or "false".
      GOTO :USAGE
    )
  )
  GOTO :PARSEARGS
)
IF /i "%ARGNAME%"=="-logconnections" (
  IF /i "%ARGVALUE%"=="true" (
    SET logconnections=true
  ) ELSE (
    IF /i "%ARGVALUE%"=="false" (
      ECHO logconnections is off 
    ) ELSE (
      ECHO UNKNOWN -logconnections OPTION %ARGVALUE%! Valid options are "true" or "false".
      GOTO :USAGE
    )
  )
  GOTO :PARSEARGS
)
IF /i "%ARGNAME%"=="-ssl" (
  IF /i "%ARGVALUE%"=="off" (
    ECHO sslmode is off
  ) ELSE (
    IF /i "%ARGVALUE%"=="basic" (
      ECHO sslmode is basic 
    ) ELSE (
      IF /i "%ARGVALUE%"=="peerAuthentication" (
        ECHO sslmode is peerAuthentication 
      ) ELSE (
        ECHO UNKNOWN -ssl OPTION %ARGVALUE%! Valid options are "off", "basic" or "peerAuthentication".
      GOTO :USAGE
      )
    )
  )
  GOTO :PARSEARGS
) ELSE (
  ECHO UNKNOWN SWITCH %ARGNAME%!
  GOTO :USAGE
)


:RUN

%WL_HOME%\common\derby\bin\startNetworkServer.cmd %DERBY_CMD_LINE_ARGS%

GOTO :EOF


:USAGE
ECHO ========================================================
ECHO  USAGE:
ECHO    VALID SWITCHES:
ECHO      -p=The port to start the Derby Server on.^(default=1527^)
ECHO .
ECHO      -h=This starts the network server on the host specified.^(default=localhost^)
ECHO .
ECHO      -maxthreads=This sets the maximum number of threads that can be used for connections.
ECHO             ^(default=0 or unlimited^)
ECHO .
ECHO      -logconnections="on" or "off" This turns logging of connections on or off. 
ECHO              Connections are logged to derby.log. ^(default=off^)
ECHO .
ECHO      -timeslice=This sets the time in milliseconds each session can have using a connection 
ECHO              thread before yielding to a waiting session.^(default=0 or no yield^)
ECHO .
ECHO      -tracedirectory=This changes where new trace files will be placed. 
ECHO              For sessions with tracing already turned on, trace files remain in the 
ECHO              previous location. Default is derby.system.home, if it is set. 
ECHO              Otherwise the default is the current directory.
ECHO .
ECHO      -traceAll="true" or "false". This turns drda tracing on for all sessions 
ECHO             ^(Default is tracing is off^)
ECHO .
ECHO      -ssl="off", "basic" or "peerAuthentication". ^(default=off^)
ECHO .
ECHO .
ECHO EXAMPLE:
ECHO %SCRIPT_NAME% -p=1527 -h=myhost -ssl=basic
ECHO ========================================================

@ENDLOCAL

