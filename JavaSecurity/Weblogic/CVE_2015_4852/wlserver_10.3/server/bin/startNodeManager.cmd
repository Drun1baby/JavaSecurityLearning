@echo off
@rem *************************************************************************
@rem This script can be used to start the WebLogic NodeManager
@rem
@rem To start the NodeManager on <host> and <port>, set the LISTEN_ADDRESS 
@rem variable to <host> and LISTEN_PORT variable to <port> before calling this 
@rem script.
@rem
@rem This script sets the following variables before starting the NodeManager:
@rem 
@rem WL_HOME    - The root directory of your WebLogic installation.
@rem NODEMGR_HOME - The home directory for this NodeManager instance.
@rem JAVA_HOME    - Location of the version of Java used to start WebLogic 
@rem                Server. This variable must point to the root directory of 
@rem                a JDK installation and will be set for you by the 
@rem		    installer.  See the Oracle Fusion Middleware Supported System Configurations page 
@rem                (http://www.oracle.com/technology/software/products/ias/files/fusion_certification.html) 
@rem                for an up-to-date list of supported JVMs.
@rem PATH         - Adds the JDK and WebLogic directories to the system path.  
@rem CLASSPATH    - Adds the JDK and WebLogic jars to the classpath.
@rem JAVA_OPTIONS - Java command-line options for running the server. (These
@rem                will be tagged on to the end of the JAVA_VM and MEM_ARGS)
@rem JAVA_VM      - The java arg specifying the VM to run.  (i.e. -server, 
@rem                -client, etc.)
@rem MEM_ARGS     - The variable to override the standard memory arguments
@rem                passed to java
@rem
@rem Alternately, this script will take the first two positional parameters and
@rem set them to LISTEN_ADDRESS and LISTEN_PORT. For instance, you could call 
@rem this script: "startNodeManager.cmd holly 7777" to start the NodeManager
@rem on host holly and port 7777, or just "startNodeManager.cmd holly" 
@rem to start the node manager on host holly.
@rem *************************************************************************

SETLOCAL

set JAVA_VM=
set MEM_ARGS=

set WL_HOME=E:\Coding\JavaSec\wlserver_10.3
call "%WL_HOME%\common\bin\commEnv.cmd"

set NODEMGR_HOME=%WL_HOME%\common\nodemanager

for %%i in ("%WL_HOME%") do set WL_HOME=%%~fsi
for %%i in ("%JAVA_HOME%") do set JAVA_HOME=%%~fsi
for %%i in ("%NODEMGR_HOME%") do set NODEMGR_HOME=%%~fsi

@rem Set first two positional parameters to LISTEN_ADDRESS and LISTEN_PORT
if not "%1" == "" set LISTEN_ADDRESS=%1
if not "%2" == "" set LISTEN_PORT=%2

@rem If NODEMGR_HOME does not exist, create it
:checkNodeManagerHome
if exist %NODEMGR_HOME% goto checkJava
echo.
echo NODEMGR_HOME %NODEMGR_HOME% does not exist, creating it..
mkdir %NODEMGR_HOME%

@rem Check that java is where we expect it to be
:checkJava
if exist %JAVA_HOME%\bin\java.exe goto runNodeManager
echo The JDK wasn't found in directory %JAVA_HOME%.
echo Please edit this script so that the JAVA_HOME
echo variable points to the location of your JDK.
goto finish

:runNodeManager

if not "%JAVA_VM%" == "" goto noResetJavaVM
if "%JAVA_VENDOR%"=="BEA" set JAVA_VM=-client
if "%JAVA_VENDOR%"=="Sun" set JAVA_VM=-client

:noResetJavaVM
if not "%MEM_ARGS%" == "" goto noResetMemArgs
set MEM_ARGS=-Xms32m -Xmx200m

:noResetMemArgs

if not "%BEA_HOME%" == "" set JAVA_OPTIONS=-Dbea.home=%BEA_HOME% %JAVA_OPTIONS%
if not "%COHERENCE_HOME%" == "" set JAVA_OPTIONS=-Dcoherence.home=%COHERENCE_HOME% %JAVA_OPTIONS%

@echo on

set CLASSPATH=.;%WEBLOGIC_CLASSPATH%;%CLASSPATH%

@rem Get PRE and POST environment
if not "%PRE_CLASSPATH%" == "" set CLASSPATH=%PRE_CLASSPATH%;%CLASSPATH%
if not "%POST_CLASSPATH%" == "" set CLASSPATH=%CLASSPATH%;%POST_CLASSPATH%

cd %NODEMGR_HOME%

if not "%LISTEN_PORT%" == "" if not "%LISTEN_ADDRESS%" == "" goto runNMWithListenAddressAndPort
if not "%LISTEN_ADDRESS%" == "" goto runNMWithListenAddress
if not "%LISTEN_PORT%" == "" goto runNMWithListenPort

:runNMWithoutAnyArgs
"%JAVA_HOME%\bin\java.exe" %JAVA_VM% %MEM_ARGS% %JAVA_OPTIONS% "-Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy" "-Dweblogic.nodemanager.javaHome=%JAVA_HOME%" weblogic.NodeManager -v

goto finish

:runNMWithListenAddress
"%JAVA_HOME%\bin\java.exe" %JAVA_VM% %MEM_ARGS% %JAVA_OPTIONS% "-Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy" "-Dweblogic.nodemanager.javaHome=%JAVA_HOME%" -DListenAddress="%LISTEN_ADDRESS%" weblogic.NodeManager -v

goto finish

:runNMWithListenPort
"%JAVA_HOME%\bin\java.exe" %JAVA_VM% %MEM_ARGS% %JAVA_OPTIONS% "-Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy" "-Dweblogic.nodemanager.javaHome=%JAVA_HOME%" -DListenPort="%LISTEN_PORT%" weblogic.NodeManager -v

goto finish

:runNMWithListenAddressAndPort
"%JAVA_HOME%\bin\java.exe" %JAVA_VM% %MEM_ARGS% %JAVA_OPTIONS% "-Djava.security.policy=%WL_HOME%\server\lib\weblogic.policy" "-Dweblogic.nodemanager.javaHome=%JAVA_HOME%" -DListenAddress="%LISTEN_ADDRESS%" -DListenPort="%LISTEN_PORT%" weblogic.NodeManager -v

goto finish

:finish

ENDLOCAL
