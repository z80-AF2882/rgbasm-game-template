@ECHO OFF
REM Make and start in BGB
REM
REM Settings
REM ... change these
SET BGB_EXE=C:\GB\bgb\bgb.exe
REM Comma separated list breakpoints
SET BR=

CALL make.cmd
IF ERRORLEVEL 1 (
    GOTO :eof
)

ECHO START 

SETLOCAL ENABLEDELAYEDEXPANSION
SET GB_FILE=
FOR /F "delims==" %%i in ('dir /b /on out\*.gb') DO (
    SET GB_FILE=out\%%i
)
SET CMD=%BGB_EXE% -rom %GB_FILE% -br %BR%
ECHO   %CMD%
%CMD%
