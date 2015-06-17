@echo off
rem ============================================================================
rem  Copyright　Information Services International-Dentsu, Ltd.
rem ============================================================================
rem 
rem  SYSTEM        : BANK・R−CC
rem 
rem  PROGRAM NAME  : PowerShell プログラム起動(TRAINING)
rem 
rem  MODULE NAME   : ps_trng.bat
rem 
rem  INPUT         : 可変
rem 
rem  EXIT          : PowerShellの $LASTEXITCODE
rem                  正常終了 ・・・ NORMAL(0)　
rem                  異常終了 ・・・ ERROR (9)
rem 
rem  Mod   yy/mm/dd   Coder           Comment
rem -----+----------+---------------+-------------------------------------------
rem  %00 | 14/05/14 | ISID          | First Edition.
rem  %01 | 15/06/02 | 土居 康一郎   | 1.0次対応 パス名を変更
rem ============================================================================

rem ============================================================================
rem  初期処理
rem ============================================================================

rem ---------------------------------------
rem  環境変数のローカライズ開始
rem ---------------------------------------
setlocal

rem ---------------------------------------
rem  環境変数のセット
rem ---------------------------------------
call E:\azbk\BANKRAZB\env\env_trng.bat


rem ---------------------------------------
rem  起動用環境変数セット
rem ---------------------------------------
set POWERSHELL=C:\Windows\SysWOW64\WindowsPowerShell\v1.0\powershell.exe
set EXIT_PROC=;exit $LASTEXITCODE
set PS_PATH=E:\azbk\BANKRAZB\ps\
set SUFFIX=.ps1

rem ---------------------------------------
rem  プログラム名セット(第１引数）
rem ---------------------------------------
set PGM=%1
shift

rem ============================================================================
rem  プログラム引数取得
rem ============================================================================
set MYPARM=
set SPACE= 

:check
	if "%1"=="" goto final
	set MYPARM=%MYPARM%%SPACE%%1 
	shift
	goto check
:final


rem ============================================================================
rem  コーリングシーケンス作成
rem ============================================================================
rem ---------------------------------------
rem  プログラム名
rem ---------------------------------------
set PGM_NAME=%PS_PATH%%PGM%%SUFFIX%

rem ---------------------------------------
rem  POWERSHELLからの起動
rem ---------------------------------------
set RUN_PGM=%POWERSHELL%%SPACE%%PGM_NAME%%SPACE%%MYPARM%%EXIT_PROC%

rem echo %RUN_PGM%


rem ============================================================================
rem  プログラム実行(EXIT付き)
rem ============================================================================
call %RUN_PGM%

rem ============================================================================
rem  終了
rem ============================================================================
exit  /B %ERRORLEVEL%