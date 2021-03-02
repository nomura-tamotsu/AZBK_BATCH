@echo off
rem ============================================================================
rem  Copyright�@Information Services International-Dentsu, Ltd.
rem ============================================================================
rem 
rem  SYSTEM        : BANK�ER�|CC
rem 
rem  PROGRAM NAME  : WAS(brtabtrn)�T�[�r�X�ēo�^�N���p�o�b�`
rem 
rem  MODULE NAME   : WasServiceReload_brtabtrn.bat
rem 
rem  INPUT         : ��
rem 
rem  EXIT          : PowerShell�� $LASTEXITCODE
rem                  ����I�� �E�E�E NORMAL(0)
rem                  �ُ�I�� �E�E�E ERROR (9)
rem 
rem  Mod   yy/mm/dd   Coder           Comment
rem -----+----------+---------------+-------------------------------------------
rem  %00 | 20/12/02 | ISID          | First Edition.
rem ============================================================================

rem ============================================================================
rem  ��������
rem ============================================================================

rem ---------------------------------------
rem  ���ϐ��̃��[�J���C�Y�J�n
rem ---------------------------------------
setlocal

rem ---------------------------------------
rem  �N���p���ϐ��Z�b�g
rem ---------------------------------------
rem  PowerShell 64 bit 
rem ---------------------------------------
set POWERSHELL=C:\Windows\syswow64\WindowsPowerShell\v1.0\powershell.exe
set EXIT_PROC=;exit $LASTEXITCODE
set PS_PATH=D:\azbk\unyo\tools\
set SUFFIX=.ps1
set PGM=ResetWASService

rem ---------------------------------------
rem  �v���O�������Z�b�g(��P�����j
rem ---------------------------------------
if "%1"=="" (
 @echo [�x��] �������ɐV�p�X���[�h���w�肳��Ă���܂���B
 exit /B 9
)
set LC_NEWPWD=%1

rem ============================================================================
rem  �R�[�����O�V�[�P���X�쐬
rem ============================================================================
rem ---------------------------------------
rem  �v���O������
rem ---------------------------------------
set PGM_NAME=%PS_PATH%%PGM%%SUFFIX%
set WAS_PROF=brtabtrn
set SPACE= 
set MYPARM=%WAS_PROF%%SPACE%%LC_NEWPWD%

rem ---------------------------------------
rem  POWERSHELL����̋N��
rem ---------------------------------------
set RUN_PGM=%POWERSHELL%%SPACE%%PGM_NAME%%SPACE%%MYPARM%%EXIT_PROC%

rem ============================================================================
rem  �v���O�������s(EXIT�t��)
rem ============================================================================
call %RUN_PGM%

rem ============================================================================
rem  �I��
rem ============================================================================
exit /B %ERRORLEVEL%
