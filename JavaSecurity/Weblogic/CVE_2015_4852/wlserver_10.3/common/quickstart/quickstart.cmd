@ECHO OFF
SETLOCAL

"E:\Coding\JavaSec\utils\quickstart\quickstart.cmd" install.dir="E:\Coding\JavaSec\wlserver_10.3" product.alias.id="WebLogic Platform" product.alias.version="10.3.6.0" %*

EXIT /B %ERRORLEVEL%

ENDLOCAL  
