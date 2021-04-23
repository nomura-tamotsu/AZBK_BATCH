@echo off

if [%1]==[] GOTO usage

Rem ���������̐ݒ�
set _CURRENT_YYYY/MM/DD=%date%
set _CURRENT_YYYYMMDD=%_CURRENT_YYYY/MM/DD:~0,4%%_CURRENT_YYYY/MM/DD:~5,2%%_CURRENT_YYYY/MM/DD:~8,2%
set _CURRENT_HH_MM_SS=%time%
set _CURRENT_HH=%_CURRENT_HH_MM_SS:~0,2%
rem ���Ԃ̕�������v�Z���܂��B�P���̎��ԁi0�`9���j�������猅�������s���܂��B
if %_CURRENT_HH% LSS 10 (
  set _CURRENT_HH=0%_CURRENT_HH:~-1%
)
set _CURRENT_HHMMSS=%_CURRENT_HH%%_CURRENT_HH_MM_SS:~3,2%%_CURRENT_HH_MM_SS:~6,2%

Rem ���O�t�@�C�����ݒ�
Rem �K�v�ɉ����ă��O�̏o�͐�f�B���N�g���A���O�t�@�C�����̏C�����s���Ă��������B
set _LOGPATH="D:\logfile\unyo\azbk\
set _LOGNAME=%_LOGPATH%Servicestop_%_CURRENT_YYYYMMDD%.txt"

Rem �^�C���A�E�g�p�̃J�E���^
set i=0
set b=120

Goto ResolveInitialState

:ResolveInitialState
echo %date% %time% %1 �T�[�r�X��~�����J�n >> %_LOGNAME%
sc query %1 | FIND "STATE" | FIND "RUNNING" >> %_LOGNAME%
echo errorlevel = %errorlevel% >> %_LOGNAME%
IF errorlevel 0 IF NOT errorlevel 1 GOTO StopService
sc query %1 | Find "STATE" >> %_LOGNAME%
GOTO JobEnd

Rem �T�[�r�X���~
:StopService
echo %1 �T�[�r�X��~���s >> %_LOGNAME%
sc stop %1 >> %_LOGNAME%
echo errorlevel =  %errorlevel%�@>> %_LOGNAME%

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
echo %date% %time% �w�肵��%1�͒�~�̂��߃T�[�r�X��~�������I�����܂� >> %_LOGNAME%
GOTO ServiceEnd

:JobEnd2
echo %date% %time% �w�肵��%1�͎��ԓ��ɒ�~���ł��Ȃ����ߏ������I�����܂� >> %_LOGNAME%
GOTO ServiceEnd

:usage
echo �T�[�r�X��~�o�b�`
echo.
echo %0 [Service Name]
echo ��: %0 "Interaction Center"
echo.

:ServiceEnd
