@echo off
rem ============================================================================
rem  Copyright　Information Services International-Dentsu, Ltd.
rem ============================================================================
rem 
rem  SYSTEM        : BANK・R－CC
rem 
rem  PROGRAM NAME  : WAS(brtabtrn)サービス再登録起動用バッチ
rem 
rem  MODULE NAME   : WasServiceReload_brtabtrn.bat
rem 
rem  INPUT         : 可変
rem 
rem  EXIT          : PowerShellの $LASTEXITCODE
rem                  正常終了 ・・・ NORMAL(0)
rem                  異常終了 ・・・ ERROR (9)
rem 
rem  Mod   yy/mm/dd   Coder           Comment
rem -----+----------+---------------+-------------------------------------------
rem  %00 | 20/12/02 | ISID          | First Edition.
rem ============================================================================

rem ============================================================================
rem  初期処理
rem ============================================================================

rem ---------------------------------------
rem  環境変数のローカライズ開始
rem ---------------------------------------
setlocal

rem ---------------------------------------
rem  起動用環境変数セット
rem ---------------------------------------
rem  PowerShell 64 bit 
rem ---------------------------------------
set POWERSHELL=C:\Windows\syswow64\WindowsPowerShell\v1.0\powershell.exe
set EXIT_PROC=;exit $LASTEXITCODE
set PS_PATH=D:\azbk\unyo\tools\
set SUFFIX=.ps1
set PGM=ResetWASService

rem ---------------------------------------
rem  プログラム名セット(第１引数）
rem ---------------------------------------
if "%1"=="" (
 @echo [警告] 第一引数に新パスワードが指定されておりません。
 exit /B 9
)
set LC_NEWPWD=%1

rem ============================================================================
rem  コーリングシーケンス作成
rem ============================================================================
rem ---------------------------------------
rem  プログラム名
rem ---------------------------------------
set PGM_NAME=%PS_PATH%%PGM%%SUFFIX%
set WAS_PROF=brtabtrn
set SPACE= 
set MYPARM=%WAS_PROF%%SPACE%%LC_NEWPWD%

rem ---------------------------------------
rem  POWERSHELLからの起動
rem ---------------------------------------
set RUN_PGM=%POWERSHELL%%SPACE%%PGM_NAME%%SPACE%%MYPARM%%EXIT_PROC%

rem ============================================================================
rem  プログラム実行(EXIT付き)
rem ============================================================================
call %RUN_PGM%

rem ============================================================================
rem  終了
rem ============================================================================
exit /B %ERRORLEVEL%
