@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
::ECHO %2
::GOTO end
::SET /P apk=Please Provide APK : 
SET mode=own
SET apk=%~1
IF "%apk%"=="" (
	SET /P apk=Please Provide APK : 
) ELSE SET mode=CMD
::ECHO %mode%
::GOTO end
SET apk=%apk:"=%
::ECHO %apk%
::GOTO end

:demo
::SET apk=Whose Phone Number In Contacts 1.3_4.apk
::SET apk=D:\DK-HP-PA-2000AR\Projects\Apk_Decompiler\Whose Phone Number In Contacts 1.3_4.apk
SET apk_path=%apk%
::ECHO %apk_path%
SET modified_apk_path=%apk_path:\=%
::ECHO %modified_apk_path%
::IF "%apk_path%"=="%modified_apk_path%" (SET apk_name=%apk_path%) ELSE SET apk_name=Extract it
IF "%apk_path%"=="%modified_apk_path%" (SET apk_name=%apk_path%) ELSE GOTO extract
::ECHO %apk_name%
::GOTO end
GOTO generate_src_folder_name

:process_own
ECHO. | tee -a apk_decompiler-results.txt
ECHO Decompiling : %apk_name%  | tee apk_decompiler-results.txt
CALL apktool d "%apk%"
ECHO Decompilation and cleaning finished for : %apk_name% | tee -a apk_decompiler-results.txt 
ECHO It's Source folder is : %apk_src_folder_name% | tee -a apk_decompiler-results.txt
GOTO end

:process_CMD
ECHO. | tee -a %2-results.txt
ECHO Decompiling : %apk_name%  | tee -a %2-results.txt
CALL apktool d "%apk%"
ECHO Decompilation and cleaning finished for : %apk_name% | tee -a %2-results.txt
ECHO It's Source folder is : %apk_src_folder_name% | tee -a %2-results.txt
GOTO end

:extract
::set S=%apk_path%
::ECHO %S%
::GOTO end
set I=0
set L=-1
:l
if "!apk_path:~%I%,1!"=="" goto ld
::if "!S:~%I%,1!"=="/" set L=%I%
if "!apk_path:~%I%,1!"=="\" set L=%I%
set /a I+=1
goto l
:ld
::echo %L%
SET /A L+=1
::SET SUBSTRING=%S:~0,12%
CALL SET apk_name=%%apk_path:~%L%%%
::GOTO generate_src_folder_name

:generate_src_folder_name
DEL apk_decompiler-results.txt
SET apk_src_folder_name=%apk_name:~0,-4%
::ECHO %apk_src_folder_name%
IF "%mode%"=="CMD" (GOTO process_CMD) ELSE GOTO process_own

:end