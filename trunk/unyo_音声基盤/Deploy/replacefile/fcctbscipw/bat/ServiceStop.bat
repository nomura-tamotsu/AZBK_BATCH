@echo off

if [%1]==[] GOTO usage

Rem 現時時刻の設定
set _CURRENT_YYYY/MM/DD=%date%
set _CURRENT_YYYYMMDD=%_CURRENT_YYYY/MM/DD:~0,4%%_CURRENT_YYYY/MM/DD:~5,2%%_CURRENT_YYYY/MM/DD:~8,2%
set _CURRENT_HH_MM_SS=%time%
set _CURRENT_HH=%_CURRENT_HH_MM_SS:~0,2%
rem 時間の文字列を計算します。１桁の時間（0～9時）だったら桁調整を行います。
if %_CURRENT_HH% LSS 10 (
  set _CURRENT_HH=0%_CURRENT_HH:~-1%
)
set _CURRENT_HHMMSS=%_CURRENT_HH%%_CURRENT_HH_MM_SS:~3,2%%_CURRENT_HH_MM_SS:~6,2%

Rem ログファイル名設定
Rem 必要に応じてログの出力先ディレクトリ、ログファイル名の修正を行ってください。
set _LOGPATH="D:\logfile\unyo\azbk\
set _LOGNAME=%_LOGPATH%Servicestop_%_CURRENT_YYYYMMDD%.txt"

Rem タイムアウト用のカウンタ
set i=0
set b=120

Goto ResolveInitialState

:ResolveInitialState
echo %date% %time% %1 サービス停止処理開始 >> %_LOGNAME%
sc query %1 | FIND "STATE" | FIND "RUNNING" >> %_LOGNAME%
echo errorlevel = %errorlevel% >> %_LOGNAME%
IF errorlevel 0 IF NOT errorlevel 1 GOTO StopService
sc query %1 | Find "STATE" >> %_LOGNAME%
GOTO JobEnd

Rem サービスを停止
:StopService
echo %1 サービス停止実行 >> %_LOGNAME%
sc stop %1 >> %_LOGNAME%
echo errorlevel =  %errorlevel%　>> %_LOGNAME%

:ResolveInitialState2
timeout /t 5 /nobreak >NUL
sc query %1 | FIND "STATE" | FIND "STOPPED" >> %_LOGNAME%
echo errorlevel = %errorlevel% >> %_LOGNAME%
IF errorlevel 0 IF NOT errorlevel 1 GOTO JobEnd
sc query %1 | Find "STATE" >> %_LOGNAME%
set /a i+=1
IF %i% == %b% GOTO JobEnd2
GOTO ResolveInitialState2

:JobEnd
echo %date% %time% 指定した%1は停止のためサービス停止処理を終了します >> %_LOGNAME%
GOTO ServiceEnd

:JobEnd2
echo %date% %time% 指定した%1は時間内に停止ができないため処理を終了します >> %_LOGNAME%
GOTO ServiceEnd

:usage
echo サービス停止バッチ
echo.
echo %0 [Service Name]
echo 例: %0 "Interaction Center"
echo.

:ServiceEnd
