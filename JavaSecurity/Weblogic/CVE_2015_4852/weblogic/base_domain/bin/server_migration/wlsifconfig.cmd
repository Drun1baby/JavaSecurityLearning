@ECHO OFF
if defined DEBUG @echo on

@REM
@REM Additional commands to support node manager ip migration.
@REM

@REM Parse command and options
if [%1]==[] CALL :usage_error

set COMMAND=
set INTERFACE=
set ADDRESS=
set NETMASK=
set ERRORLEVEL=

if [%1] == [-addif] (
   set COMMAND=addif
   set INTERFACE=%2%
   set ADDRESS=%3%
   set NETMASK=%4%
   if not defined INTERFACE call :usage_error
   if not defined ADDRESS call :usage_error
   if not defined NETMASK call :usage_error
)


if [%1] == [-removeif] (
   set COMMAND=removeif
   set INTERFACE=%2%
   set ADDRESS=%3%
   if not defined INTERFACE call :usage_error
   if not defined ADDRESS call :usage_error
)

if [%1] == [-listif] (
   set COMMAND=listif
   set INTERFACE=%2%
   if not defined INTERFACE call :usage_error
)

@REM Must have specified at least one command
if not defined COMMAND CALL :usage_error

set NullDevice=nul

@REM *********************************************************************
@REM Set this to true if IP address should not be online before starting
@REM a server.  Otherwise, presence of an IP address in an interface will
@REM cause the script to report success on IP addif
set ENABLESTRICTIPCHECK=N

if not defined ServerName set ServerName=myserver
if not defined ServerDir set ServerDir=%CD%
if not exist "%ServerDir%\data\nodemanager" mkdir "%ServerDir%\data\nodemanager"

set addrFile=
set addrFile=%ServerDir%\data\nodemanager\%ServerName%.addr

call :%COMMAND%
GOTO :EOF

@REM --- Start Functions ---

@REM *********************************************************************
@REM Show an error if the address does not show up in the address file
:address_error
SETLOCAL
ECHO Cannot remove %ADDRESS% - not brought online >&2
exit 1

@REM *********************************************************************
@REM Remove the given address from the interface specified
:removeif
SETLOCAL

@REM Store the contents of the address file as the %addr% var
if exist "%AddrFile%"  (
GREP %ADDRESS% %AddrFile% > null || call :address_error
)
netsh interface ip delete address %INTERFACE% addr=%ADDRESS%
set remExitVal=%ERRORLEVEL%
if not %remExitVal% == 0 (
 echo Unable to remove %ADDRESS% - Check command output for more details >&2
 call :cleanupAddressFile
 exit %remExitVal%
)
echo Successfully removed %ADDRESS% from %INTERFACE%.
call :cleanupAddressFile
GOTO :EOF



@REM *********************************************************************
@REM Show the correct message (info or error) if the given address is already
@REM on the specified interface.  This is normally an informative message
@REM unless ENABLESTRICTIPCHECK is set to something other then the default 'N'.
:already_online
if [%ENABLESTRICTIPCHECK%] == [N] (
echo %ADDRESS% already online on %INTERFACE%.  Please make sure that the IP address specified is not used by other servers/applications.  Continuing...
) ELSE (
echo %ADDRESS% already online on %INTERFACE%.  Please make sure that the IP address specified is not used by other servers/applications >&2
call :cleanupAddressFile
exit 1
)
GOTO :EOF

@REM *********************************************************************
@REM Show that an error occured calling the netsh utility
:add_error
SETLOCAL
echo Failed to bring %ADDRESS% with %NETMASK% online on %INTERFACE% >&2
echo Check command output for more details >&2
exit 1
ENDLOCAL


@REM *********************************************************************
@REM Add the given address to the specified interface
:addif
SETLOCAL
set newif=
netsh interface ip show address %INTERFACE% | grep -e '[^ 	]*IP' > tmp_ip_file
for /F "usebackq tokens=3" %%G in ( tmp_ip_file ) do (
 if %%G == %ADDRESS% set newif=already-online
)
if not defined newif set newif=unmatched
rm tmp_ip_file

if [%newif%] == [unmatched] (
 call :addnew
) ELSE call :already_online

if exist "%AddrFile%" call :cleanupAddressFile
echo %ADDRESS%>> "%AddrFile%"
ENDLOCAL
GOTO :EOF



@REM *********************************************************************
@REM For some reason catching the error value has problems when it is not in
@REM its own subroutine.  Setting addExitVal in the :addif routine leaves the
@REM variable as undefined causing extra error messages in the script output
@REM
:addnew
SETLOCAL
netsh interface ip add address %INTERFACE% %ADDRESS% %NETMASK%
set addExitVal=%ERRORLEVEL%
if not %addExitVal% == 0 call :add_error %addExitVal%
echo Successfully brought %ADDRESS% with %NETMASK% online on %INTERFACE%
ENDLOCAL
GOTO :EOF


@REM *********************************************************************
@REM Check the %AddrFile% for %ADDRESS% and if it is there, then call the 
@REM subroutine to delete it
@REM
:cleanupAddressFile
SETLOCAL
if exist "%AddrFile%" (
GREP -x %ADDRESS% %AddrFile% > nul & CALL :removeAddressFromFile
)
ENDLOCAL
GOTO :EOF


@REM *********************************************************************
@REM Delete %ADDRESS% from the %AddrFile%
@REM
:removeAddressFromFile
SETLOCAL
set tmpAddr=addresses.tmp
for /F "delims=" %%a in (%AddrFile%) DO (
   if not %%a == %ADDRESS% (
	echo %%a>> %tmpAddr%
   )
)
rm -f %AddrFile%
if exist %tmpAddr% (
  mv %tmpAddr% %AddrFile%
  rm -f %tmpAddr%
)

ENDLOCAL
GOTO :EOF



@REM *********************************************************************
@REM List the IP addresses that are currently on the interface
:listif
netsh interface ip show address %INTERFACE% | grep -e '[^ 	]*IP'
GOTO :EOF


@REM *********************************************************************
@REM Show the correct usage of this script in the instance that someone
@REM called the script incorrectly
:usage_error
ECHO Usage: wlsifconfig.cmd >&2
ECHO      -addif {interface-name} {ip-address} {netmask} >&2
ECHO      -removeif {interface-name} {ip-address} >&2
ECHO      -listif {interface-name} >&2
ECHO      'addif' adds {ip-address} to next available sub-interface of {interface-name}. >&2
ECHO      'removeif' removes {ip-address} from sub-interface of {interface-name}. >&2
ECHO      'listif' lists last used sub-interface of {interface-name} and its corresponding {ip-address} >&2
ECHO      To find the list of interfaces, use your following command to list the interface names- >&2
ECHO      netsh interface show interface. >&2
exit -101
GOTO :EOF

:ENDFUNCTIONS

@REM --- End Functions ---
