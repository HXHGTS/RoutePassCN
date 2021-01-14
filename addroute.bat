@echo off

CLS

:init

setlocal DisableDelayedExpansion

set "batchPath=%~0"

for %%k in (%0) do set batchName=%%~nk

set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"

setlocal EnableDelayedExpansion

:checkPrivileges

NET FILE 1>NUL 2>NUL

if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges

if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)

ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"

ECHO args = "ELEV " >> "%vbsGetPrivileges%"

ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"

ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"

ECHO Next >> "%vbsGetPrivileges%"

ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"

"%SystemRoot%\System32\WScript.exe" "%vbsGetPrivileges%" %*

exit /B

:gotPrivileges

setlocal & pushd .

cd /d %~dp0

if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

rundll32.exe cmroute.dll,SetRoutes /STATIC_FILE_NAME addroute.txt /DONT_REQUIRE_URL /IPHLPAPI_ACCESS_DENIED_OK

