REM TODO: Accept CMD Args

@ECHO OFF

SET choice=A
ECHO Automatic Mode>apk_folder_decompiler-results.txt
SET /P choice=Interactive execution(press I) or automated exection(default - just press Enter) : 
::ECHO %choice%
IF "%choice%"=="I" (ECHO Interactive Mode | tee apk_folder_decompiler-results.txt) ELSE ECHO Automatic Mode
::GOTO end
::ECHO %CD%
::GOTO end
SET folder=%CD%
SET /P folder=Use Current Folder(default - just press Enter) or Enter Another : 
ECHO APK Folder : %folder% | tee -a apk_folder_decompiler-results.txt
::GOTO end
ECHO Generating file list... | tee -a apk_folder_decompiler-results.txt
DIR %folder% /B /S | FINDSTR /E .apk > project-files.list
ECHO File list generated successfully... | tee -a apk_folder_decompiler-results.txt
IF "%choice%"=="I" ( PAUSE )
FOR /F "TOKENS=*" %%a IN ('TYPE project-files.list') DO (
	::ECHO %%a
	CALL apk_decompiler "%%a" apk_folder_decompiler
	IF "%choice%"=="I" ( PAUSE )
)
ECHO.
ECHO Cleaning... | tee -a apk_folder_decompiler-results.txt
DEL project-files.list

:end