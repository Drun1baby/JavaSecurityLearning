@rem *************************************************************************
@rem This script is used to uninstall a NodeManager Windows Service.
@rem
@rem This script sets the following variables before uninstalling 
@rem the Windows Service:
@rem
@rem WL_HOME    - The root directory of your WebLogic installation
@rem *************************************************************************

@echo off
SETLOCAL

set WL_HOME=E:\Coding\JavaSec\wlserver_10.3
set PROD_NAME=Oracle WebLogic
set BAR_WL_HOME=E_Coding_JavaSec_wlserver_10.3

rem *** Uninstall the service
"%WL_HOME%\server\bin\beasvc" -remove -svcname:"%PROD_NAME% NodeManager (%BAR_WL_HOME%)"

ENDLOCAL

