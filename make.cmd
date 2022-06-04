@ECHO OFF
REM This file is used to compile entire project. Many things are "HARD CODED" so feel free to change it to suite your need.

REM Settings
REM ... change these
SET GB_OUTPUT_FILE=Sample.gb
SET GB_SYM_FILE=Sample.sym
SET GB_OUTPUT_TITLE=SAMPLE
REM ... no need to change these
SET PATH=%PATH%;%CD%\bin

REM Clean out
REM
ECHO CLEAN
DEL /q out\*.*
IF ERRORLEVEL 1 (		
    GOTO Fail
)	    

REM Complile all from src
REM
ECHO COMPILE
FOR /F "delims==" %%i in ('dir /b /on src\*.asm') DO (
	ECHO   src\%%i ^> out\%%~ni.o
REM
REM RGBASM
REM    
	rgbasm -i .\inc\ -i .\gfx\ -o .\out\%%~ni.o src\%%i
	IF ERRORLEVEL 1 (
		GOTO Fail
	)	    
)

REM Link 
REM
ECHO LINK

SETLOCAL ENABLEDELAYEDEXPANSION
SET OBJ_FILES=
FOR /F "delims==" %%i in ('dir /b /on out\*.o') DO SET OBJ_FILES=out\%%i !OBJ_FILES!
ECHO   %OBJ_FILES%^> out\%GB_OUTPUT_FILE% %GB_SYM_FILE%

REM
REM RGBLINK
REM
rgblink -o out\%GB_OUTPUT_FILE% -n out\%GB_SYM_FILE% %OBJ_FILES%
IF ERRORLEVEL 1 (		
		GOTO Fail
)

REM Fix 
REM
ECHO FIX
ECHO   Title: "%GB_OUTPUT_TITLE%"
REM
REM RGBFIX 
REM
rgbfix -p 0 -r 0 -t %GB_OUTPUT_TITLE% -v out\%GB_OUTPUT_FILE%
IF ERRORLEVEL 1 (		
		GOTO Fail
)

ECHO.
ECHO =================
ECHO ==   SUCCESS   ==
ECHO =================
ECHO.
GOTO :eof

:Fail
ECHO.
ECHO ================
ECHO ==   FAILED   ==
ECHO ================
ECHO.
EXIT -1