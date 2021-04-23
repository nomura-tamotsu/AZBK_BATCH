@echo off
rem #==========================
rem # Password Change Tools
rem #==========================

if "%1"=="" (
 @echo [警告] 第一引数にユーザが指定されておりません。
 exit /B 9
)

set PRM_USER=%1

net user %PRM_USER% *
