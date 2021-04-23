@echo off

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
set _LOGNAME=%_LOGPATH%Maintenance_%_CURRENT_YYYYMMDD%.txt"


Rem VW MRCP Server サービス停止
echo %date% %time% VW MRCP Server サービス停止処理開始 >> %_LOGNAME%
call D:\azbk\unyo\bat\ServiceStop.bat "VW MRCP Server"
echo %date% %time% VW MRCP Server サービス停止処理終了 >> %_LOGNAME%

Rem VWAdmin Server サービス停止
echo %date% %time% VWAdmin Server サービス停止処理開始 >> %_LOGNAME%
call D:\azbk\unyo\bat\ServiceStop.bat "VWAdmin Server"
echo %date% %time% VWAdmin Server サービス停止処理終了 >> %_LOGNAME%


Rem サーバ再起動
echo %date% %time% サーバ再起動処理開始 >> %_LOGNAME%
call D:\azbk\unyo\bat\Reboot.bat
echo %date% %time% サーバ再起動処理終了 >> %_LOGNAME%
