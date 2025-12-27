@echo off
setlocal enableextensions

set "SRC=C:\Users\jason\OneDrive\Documents\GitHub\EU5_KB\Authority Ledger"
set "DST=C:\Users\jason\OneDrive\Documents\Paradox Interactive\Europa Universalis V\mod\Authority Ledger"

if not exist "%SRC%" (
  echo SOURCE not found: "%SRC%"
  exit /b 1
)

if not exist "%DST%" (
  mkdir "%DST%" || exit /b 1
)

REM Empty destination (delete everything inside, keep folder)
del /f /q "%DST%\*" >nul 2>&1
for /d %%D in ("%DST%\*") do rmdir /s /q "%%D" >nul 2>&1

REM Copy everything from SRC to DST (mirror-like after wipe)
robocopy "%SRC%" "%DST%" /E /COPY:DAT /DCOPY:DAT /R:0 /W:0 /NFL /NDL /NP
set "RC=%ERRORLEVEL%"

REM Robocopy returns 0-7 for success conditions
if %RC% GEQ 8 (
  echo ROBOCOPY FAILED with code %RC%
  exit /b %RC%
)

echo OK: Synced "%SRC%" ^> "%DST%" (destination was emptied first).
exit /b 0
