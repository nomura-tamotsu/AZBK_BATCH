@echo off
rem #==========================
rem # Password Change Tools
rem #==========================

if "%1"=="" (
 @echo [�x��] �������Ƀ��[�U���w�肳��Ă���܂���B
 exit /B 9
)

set PRM_USER=%1

net user %PRM_USER% *
