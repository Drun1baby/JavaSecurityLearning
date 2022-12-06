@rem *************************************************************************
@rem This script is used to install WebLogic Server as a Windows Service.
@rem
@rem To create your own start script for your domain, simply set the 
@rem SERVER_NAME variable to your server name then call this script from your
@rem domain directory.
@rem
@rem This script sets the following variables before installing 
@rem WebLogic Server as a Windows Service:
@rem
@rem WL_HOME    - The root directory of your WebLogic installation
@rem JAVA_HOME  - Location of the version of Java used to start WebLogic 
@rem              Server. This variable must point to the root directory of a 
@rem              JDK installation and will be set for you by the installer. 
@rem              See the Oracle Fusion Middleware Supported System Configurations page 
@rem              (http://www.oracle.com/technology/software/products/ias/files/fusion_certification.html) 
@rem               for an up-to-date list of supported JVMs.
@rem PATH       - Adds the JDK and WebLogic directories to the system path.  
@rem CLASSPATH  - Adds the JDK and WebLogic jars to the classpath.  
@rem
@rem Other variables that installSvc takes are:
@rem
@rem WLS_USER     - admin username for server startup
@rem WLS_PW       - cleartext password for server startup
@rem ADMIN_URL    - if this variable is set, the server started will be a 
@rem                managed server, and will look to the url specified (i.e. 
@rem                http://localhost:7001) as the admin server.
@rem PRODUCTION_MODE    - set to true for production mode servers, false for 
@rem                development mode
@rem JAVA_OPTIONS - Java command-line options for running the server. (These
@rem                will be tagged on to the end of the JAVA_VM and MEM_ARGS)
@rem JAVA_VM      - The java arg specifying the VM to run.  (i.e. -server, 
@rem                -client, etc.)
@rem MEM_ARGS     - The variable to override the standard memory arguments
@rem                passed to java
@rem
@rem
@rem MAX_CONNECT_RETRIES - Number of attempts the Windows Service will make to check 
@rem                if the Weblogic Server is started. If this variable 
@rem                is specified along with HOST and PORT, the Windows Service will 
@rem                wait until the Weblogic Server is started.
@rem HOST         - IP address of the Weblogic Server  
@rem PORT         - Port number where the WebLogic Server is listening for requests 
@rem               
@rem jDriver for Oracle users: This script assumes that native libraries
@rem required for jDriver for Oracle have been installed in the proper
@rem location and that your system PATH variable has been set appropriately.
@rem 
@rem For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"  
@rem (http://download.oracle.com/docs/cd/E23943_01/web.1111/e13708/overview.htm).
@rem *************************************************************************

@echo off
SETLOCAL


set WL_HOME=E:\Coding\JavaSec\wlserver_10.3
call "%WL_HOME%\common\bin\commEnv.cmd"

@rem Check that the WebLogic classes are where we expect them to be
:checkWLS
if exist "%WL_HOME%\server\lib\weblogic.jar" goto checkJava
echo The WebLogic Server wasn't found in directory %WL_HOME%\server.
echo Please edit your script so that the WL_HOME variable points 
echo to the WebLogic installation directory.
goto finish

@rem Check that java is where we expect it to be
:checkJava
if exist "%JAVA_HOME%\bin\java.exe" goto runWebLogic
echo The JDK wasn't found in directory %JAVA_HOME%.
echo Please edit your script so that the JAVA_HOME variable 
echo points to the location of your JDK.
goto finish

:runWebLogic

if not "%JAVA_VM%" == "" goto noResetJavaVM
if "%JAVA_VENDOR%" == "BEA" set JAVA_VM=-jrocket
if "%JAVA_VENDOR%" == "HP"  set JAVA_VM=-server
if "%JAVA_VENDOR%" == "Sun" set JAVA_VM=-server

:noResetJavaVM
if not "%MEM_ARGS%" == "" goto noResetMemArgs
set MEM_ARGS=-Xms32m -Xmx200m

:noResetMemArgs

@echo on

set CLASSPATH=%WEBLOGIC_CLASSPATH%;%CLASSPATH%

@echo ***************************************************
@echo *  To start WebLogic Server, use the password     *
@echo *  assigned to the system user.  The system       *
@echo *  username and password must also be used to     *
@echo *  access the WebLogic Server console from a web  *
@echo *  browser.                                       *
@echo ***************************************************

rem *** Set Command Line for service to execute within created JVM

@echo off

if "%ADMIN_URL%" == "" goto runAdmin
@echo on
set CMDLINE="%JAVA_VM% %MEM_ARGS% %JAVA_OPTIONS% -classpath \"%CLASSPATH%\" -Dweblogic.Name=%SERVER_NAME% -Dweblogic.management.username=%WLS_USER% -Dweblogic.management.server=\"%ADMIN_URL%\" -Dweblogic.ProductionModeEnabled=%PRODUCTION_MODE% -Djava.security.policy=\"%WL_HOME%\server\lib\weblogic.policy\" weblogic.Server"
goto finish

:runAdmin
@echo on
set CMDLINE="%JAVA_VM% %MEM_ARGS% %JAVA_OPTIONS% -classpath \"%CLASSPATH%\" -Dweblogic.Name=%SERVER_NAME% -Dweblogic.management.username=%WLS_USER% -Dweblogic.ProductionModeEnabled=%PRODUCTION_MODE% -Djava.security.policy=\"%WL_HOME%\server\lib\weblogic.policy\" weblogic.Server"

:finish
rem *** Set up extrapath for win32 and win64 platform separately
if "%WL_USE_X86DLL%" == "true" set EXTRAPATH=%WL_HOME%\server\native\win\32;%WL_HOME%\server\bin;%JAVA_HOME%\jre\bin;%JAVA_HOME%\bin;%WL_HOME%\server\native\win\32\oci920_8

if "%WL_USE_IA64DLL%" == "true" set EXTRAPATH=%WL_HOME%\server\native\win\64\;%WL_HOME%\server\bin;%JAVA_HOME%\jre\bin;%JAVA_HOME%\bin;%WL_HOME%\server\native\win\64\oci920_8

if "%WL_USE_AMD64DLL%" == "true" set EXTRAPATH=%WL_HOME%\server\native\win\x64\;%WL_HOME%\server\bin;%JAVA_HOME%\jre\bin;%JAVA_HOME%\bin;%WL_HOME%\server\native\win\x64\oci920_8

rem *** Install the service
"%WL_HOME%\server\bin\beasvc" -install -svcname:"beasvc %DOMAIN_NAME%_%SERVER_NAME%" -javahome:"%JAVA_HOME%" -execdir:"%USERDOMAIN_HOME%" -maxconnectretries:"%MAX_CONNECT_RETRIES%" -host:"%HOST%" -port:"%PORT%" -extrapath:"%EXTRAPATH%" -password:"%WLS_PW%" -cmdline:%CMDLINE%

ENDLOCAL
