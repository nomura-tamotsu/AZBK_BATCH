@echo off

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
set _LOGNAME=%_LOGPATH%Maintenance_%_CURRENT_YYYYMMDD%.txt"


Rem VW MRCP Server �T�[�r�X��~
echo %date% %time% VW MRCP Server �T�[�r�X��~�����J�n >> %_LOGNAME%
call D:\azbk\unyo\bat\ServiceStop.bat "VW MRCP Server"
echo %date% %time% VW MRCP Server �T�[�r�X��~�����I�� >> %_LOGNAME%

Rem VWAdmin Server �T�[�r�X��~
echo %date% %time% VWAdmin Server �T�[�r�X��~�����J�n >> %_LOGNAME%
call D:\azbk\unyo\bat\ServiceStop.bat "VWAdmin Server"
echo %date% %time% VWAdmin Server �T�[�r�X��~�����I�� >> %_LOGNAME%


Rem �T�[�o�ċN��
echo %date% %time% �T�[�o�ċN�������J�n >> %_LOGNAME%
call D:\azbk\unyo\bat\Reboot.bat
echo %date% %time% �T�[�o�ċN�������I�� >> %_LOGNAME%
