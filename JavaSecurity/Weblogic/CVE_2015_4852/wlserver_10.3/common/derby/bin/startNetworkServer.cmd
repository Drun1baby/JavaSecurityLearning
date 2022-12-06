set SAVECP=%CLASSPATH%
set CLASSPATH=
start "Derby Server for WLS Examples Server" cmd /c "E:\Coding\JavaSec\wlserver_10.3\common\derby\bin\startNetworkServer.bat %*"
set CLASSPATH=%SAVECP%
     
