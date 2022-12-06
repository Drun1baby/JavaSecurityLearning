@rem *************************************************************************
@rem This script is used to initialize common environment to start WebLogic
@rem Server, as well as WebLogic development.
@rem
@rem It sets the following variables:
@rem
@rem BEA_HOME   - The home directory of all your BEA installation.
@rem MW_HOME    - The home directory of all your Oracle installation.
@rem WL_HOME    - The root directory of your WebLogic installation.
@rem COHERENCE_HOME    - The root directory of your Coherence installation.
@rem ANT_HOME   - The Ant Home directory.
@rem ANT_CONTRIB
@rem            - The Ant contrib directory
@rem JAVA_HOME  - Location of the version of Java used to start WebLogic
@rem              Server. See the Oracle Fusion Middleware Supported System Configurations page at
@rem              (http://www.oracle.com/technology/software/products/ias/files/fusion_certification.html) for an
@rem              up-to-date list of supported JVMs on your platform.
@rem JAVA_VENDOR
@rem            - Vendor of the JVM (i.e. BEA, HP, IBM, Sun, etc.)
@rem JAVA_USE_64BIT
@rem            - Indicates if JVM uses 64 bit operations
@rem PATH       - JDK and WebLogic directories are added to the system path.
@rem WEBLOGIC_CLASSPATH
@rem            - Classpath required to start WebLogic server.
@rem FMWCONFIG_CLASSPATH
@rem            - Classpath required to start config tools such as config wizard, pack, and unpack..
@rem FMWLAUNCH_CLASSPATH
@rem            - Additional classpath needed for WLST start script
@rem JAVA_VM    - The java arg specifying the JVM to run.  (i.e.
@rem              -server, -hotspot, -jrocket etc.)
@rem MEM_ARGS   - The variable to override the standard memory arguments
@rem              passed to java
@rem
@rem DERBY_HOME
@rem            - Derby home directory.
@rem DERBY_CLASSPATH
@rem            - Classpath needed to start Derby.
@rem DERBY_TOOLS
@rem            - Derby tools jar file.
@rem PRODUCTION_MODE
@rem            - Indicates if WebLogic Server will be started in Production
@rem              mode.
@rem WL_USE_X86DLL
@rem            - To use WebLogic jni native libriaries for x86 cpus (with a
@rem              32 bit JVM for x86 cpus)
@rem              JVM)
@rem WL_USE_IA64DLL
@rem            - To use WebLogic jni native libriaries for ia64 cpus (with 
@rem              64 bit JVM for ia64 cpus)
@rem              JVM)
@rem WL_USE_AMD64DLL
@rem            - To use WebLogic jni native libriaries for amd64 cpus (with
@rem              64 bit JVM for amd64 cpus)
@rem PATCH_CLASSPATH
@rem            - WebLogic Patch system classpath
@rem PATCH_LIBPATH  
@rem            - Library path used for patches
@rem PATCH_PATH     
@rem            - Path used for patches
@rem WEBLOGIC_EXTENSION_DIRS
@rem            - Extension dirs for WebLogic classpath patch
@rem
@rem *************************************************************************

@rem Set BEA Home
set BEA_HOME=E:\Coding\JavaSec
FOR %%i IN ("%BEA_HOME%") DO SET BEA_HOME=%%~fsi
@rem Set Middleware Home
set MW_HOME=E:\Coding\JavaSec
FOR %%i IN ("%MW_HOME%") DO SET MW_HOME=%%~fsi
@rem Set WebLogic Home
set WL_HOME=E:\Coding\JavaSec\wlserver_10.3
FOR %%i IN ("%WL_HOME%") DO SET WL_HOME=%%~fsi
@rem Set Coherence Home
set COHERENCE_HOME=E:\Coding\JavaSec\coherence_3.7
FOR %%i IN ("%COHERENCE_HOME%") DO SET COHERENCE_HOME=%%~fsi
@rem Set Common Modules Directory
set MODULES_DIR=E:\Coding\JavaSec\modules
FOR %%i IN ("%MODULES_DIR%") DO SET MODULES_DIR=%%~fsi
@rem Set Common Features Directory
set FEATURES_DIR=E:\Coding\JavaSec\modules\features
FOR %%i IN ("%FEATURES_DIR%") DO SET FEATURES_DIR=%%~fsi
@rem Set Ant Home
set ANT_HOME=%MODULES_DIR%\org.apache.ant_1.7.1
FOR %%i IN ("%ANT_HOME%") DO SET ANT_HOME=%%~fsi
@rem Set Ant Contrib
set ANT_CONTRIB=%MODULES_DIR%\net.sf.antcontrib_1.1.0.0_1-0b2
FOR %%i IN ("%ANT_CONTRIB%") DO SET ANT_CONTRIB=%%~fsi

@rem Choose proper WebLogic jni libraries
set  WL_USE_X86DLL=false
set  WL_USE_IA64DLL=false
set  WL_USE_AMD64DLL=true

@rem JAVA_USE_64BIT, true if JVM uses 64 bit operations
set JAVA_USE_64BIT=true

@rem Reset JAVA_HOME, JAVA_VENDOR and PRODUCTION_MODE unless JAVA_HOME and
@rem JAVA_VENDOR are defined already.
if   DEFINED JAVA_HOME   if  DEFINED JAVA_VENDOR goto noReset

@rem Reset JAVA Home
set  JAVA_HOME=E:\Coding\Java\jdk1.7.0_21
FOR %%i IN ("%JAVA_HOME%") DO SET JAVA_HOME=%%~fsi

@rem JAVA VENDOR, possible values are:
@rem Oracle, HP, IBM, Sun, etc.
set  JAVA_VENDOR=Oracle

@rem PRODUCTION_MODE, default to the development mode
set  PRODUCTION_MODE=

:noReset
set JAVA_VENDOR_TMP=
if "%JAVA_VENDOR%" == "Oracle" (
 set JAVA_VENDOR_TMP=Sun
 if exist %JAVA_HOME%/jre/bin/jrockit (
  set JAVA_VENDOR_TMP=Oracle
 ) else (
  for /d %%I in (%JAVA_HOME%\jre\lib\*) do if exist %%I\jrockit set JAVA_VENDOR_TMP=Oracle
 )    
)
if defined JAVA_VENDOR_TMP set JAVA_VENDOR=%JAVA_VENDOR_TMP%

@rem set up JVM options
if "%JAVA_VENDOR%" == "Oracle" goto oracle
if "%JAVA_VENDOR%" == "Sun" goto sun

goto continue

:oracle
if "%PRODUCTION_MODE%" == "true" goto oracle_prod_mode
set JAVA_VM=-jrockit
set MEM_ARGS=-Xms128m -Xmx256m
set JAVA_OPTIONS=%JAVA_OPTIONS% -Xverify:none
goto continue
:oracle_prod_mode
set JAVA_VM=-jrockit
set MEM_ARGS=-Xms128m -Xmx256m
goto continue


:sun
if "%PRODUCTION_MODE%" == "true" goto sun_prod_mode
set JAVA_VM=-client
set MEM_ARGS=-Xms32m -Xmx200m -XX:MaxPermSize=128m -XX:+UseSpinning
set JAVA_OPTIONS=%JAVA_OPTIONS% -Xverify:none
goto continue
:sun_prod_mode
set JAVA_VM=-server
set MEM_ARGS=-Xms32m -Xmx200m -XX:MaxPermSize=128m -XX:+UseSpinning
goto continue

:continue

@rem setup patch related class path, library path, path and extension dirs options
if exist "%WL_HOME%\common\bin\setPatchEnv.cmd" call "%WL_HOME%\common\bin\setPatchEnv.cmd"

@rem set up WebLogic Server's class path and config tools classpath
set WEBLOGIC_CLASSPATH=%JAVA_HOME%\lib\tools.jar;%WL_HOME%\server\lib\weblogic_sp.jar;%WL_HOME%\server\lib\weblogic.jar;%FEATURES_DIR%\weblogic.server.modules_10.3.6.0.jar;%WL_HOME%\server\lib\webservices.jar;%ANT_HOME%/lib/ant-all.jar;%ANT_CONTRIB%/lib/ant-contrib.jar
set FMWCONFIG_CLASSPATH=%JAVA_HOME%\lib\tools.jar;%BEA_HOME%\utils\config\10.3\config-launch.jar;%WL_HOME%\server\lib\weblogic_sp.jar;%WL_HOME%\server\lib\weblogic.jar;%FEATURES_DIR%\weblogic.server.modules_10.3.6.0.jar;%WL_HOME%\server\lib\webservices.jar;%ANT_HOME%/lib/ant-all.jar;%ANT_CONTRIB%/lib/ant-contrib.jar

@rem set up launch classpath for use by WLST
set FMWLAUNCH_CLASSPATH=%BEA_HOME%\utils\config\10.3\config-launch.jar

if NOT "%PATCH_CLASSPATH%"=="" (
  set WEBLOGIC_CLASSPATH=%PATCH_CLASSPATH%;%WEBLOGIC_CLASSPATH%
  set FMWCONFIG_CLASSPATH=%PATCH_CLASSPATH%;%FMWCONFIG_CLASSPATH%
)

if /I "%SIP_ENABLED%"=="true" goto set_sip_classpath
goto no_sip

:set_sip_classpath
@rem set up SIP classpath
set SIP_CLASSPATH=%WLSS_HOME%\server\lib\weblogic_sip.jar
@rem add to WLS classpath
set WEBLOGIC_CLASSPATH=%WEBLOGIC_CLASSPATH%;%SIP_CLASSPATH%
set FMWCONFIG_CLASSPATH=%FMWCONFIG_CLASSPATH%;%SIP_CLASSPATH%
:no_sip

@rem add jvm and WebLogic directory in path
if "%WL_USE_X86DLL%" == "true" set PATH=%PATCH_PATH%;%WL_HOME%\server\native\win\32;%WL_HOME%\server\bin;%ANT_HOME%\bin;%JAVA_HOME%\jre\bin;%JAVA_HOME%\bin;%PATH%;%WL_HOME%\server\native\win\32\oci920_8

if "%WL_USE_IA64DLL%" == "true" set PATH=%PATCH_PATH%;%WL_HOME%\server\native\win\64;%WL_HOME%\server\bin;%ANT_HOME%\bin;%JAVA_HOME%\jre\bin;%JAVA_HOME%\bin;%PATH%;%WL_HOME%\server\native\win\64\oci920_8

if "%WL_USE_AMD64DLL%" == "true" set PATH=%PATCH_PATH%;%WL_HOME%\server\native\win\x64;%WL_HOME%\server\bin;%ANT_HOME%\bin;%JAVA_HOME%\jre\bin;%JAVA_HOME%\bin;%PATH%;%WL_HOME%\server\native\win\x64\oci920_8

@rem set up DERBY configuration
set DERBY_HOME=%WL_HOME%\common\derby
set DERBY_CLIENT_CLASSPATH=%DERBY_HOME%\lib\derbyclient.jar
set DERBY_CLASSPATH=%DERBY_HOME%\lib\derbynet.jar;%DERBY_CLIENT_CLASSPATH%
set DERBY_TOOLS=%DERBY_HOME%\lib\derbytools.jar
set DERBY_SYSTEM_HOME=%WL_HOME%\common\derby\demo\databases
set DERBY_OPTS="-Dderby.system.home=%DERBY_SYSTEM_HOME%"

IF NOT "%DERBY_PRE_CLASSPATH%"=="" (
  set DERBY_CLASSPATH=%DERBY_PRE_CLASSPATH%;%DERBY_CLASSPATH%
)
IF NOT "%DERBY_POST_CLASSPATH%"=="" (
  set DERBY_CLASSPATH=%DERBY_CLASSPATH%;%DERBY_POST_CLASSPATH%
)

IF NOT EXIST %WL_HOME%\common\eval\pointbase goto endpointbase
@rem set up Point Base configuration

set POINTBASE_HOME=%WL_HOME%\common\eval\pointbase
set POINTBASE_CLIENT_CLASSPATH=%POINTBASE_HOME%\lib\pbclient57.jar
set POINTBASE_CLASSPATH=%POINTBASE_HOME%\lib\pbembedded57.jar;%POINTBASE_CLIENT_CLASSPATH%
set POINTBASE_TOOLS=%POINTBASE_HOME%\lib\pbtools57.jar

IF NOT "%POINTBASE_PRE_CLASSPATH%"=="" (
  set POINTBASE_CLASSPATH=%POINTBASE_PRE_CLASSPATH%;%POINTBASE_CLASSPATH%
)
IF NOT "%POINTBASE_POST_CLASSPATH%"=="" (
  set POINTBASE_CLASSPATH=%POINTBASE_CLASSPATH%;%POINTBASE_POST_CLASSPATH%
)
:endpointbase
