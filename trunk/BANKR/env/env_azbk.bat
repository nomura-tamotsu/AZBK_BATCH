@echo off
rem ============================================================================
rem  Copyright�@Information Services International-Dentsu, Ltd.
rem ============================================================================
rem 
rem  SYSTEM        : BANK�ER�|CC
rem 
rem  PROGRAM NAME  : ���ϐ���`�t�@�C��(AZBK)
rem 
rem  MODULE NAME   : env_azbk.bat
rem 
rem 
rem  Mod   yy/mm/dd   Coder           Comment
rem -----+----------+---------------+-------------------------------------------
rem  %00 | 14/05/14 | ISID          | First Edition.
rem  %01 | 15/03/30 | �y�� �N��Y   | 1.0���Ή� DB���A�p�X����ύX
rem  %02 | 15/06/02 | �y�� �N��Y   | 1.0���Ή� �p�X���[�h�Í����C��
rem  %03 | 15/11/11 | �쓇 ����     | 1.0���Ή� DB�ڑ���ύX�i�N���X�^�Ή��j
rem  %04 | 23/06/27 | ISIDIT �y��   | �A�v����ՍX�� ORACLE_HOME�ύX
rem ============================================================================


rem ---------------------------------------
rem  ���ϐ��̃Z�b�g
rem ---------------------------------------
set DB_NAME=BRCCAZBK
set EMB_HOME=E:\azbk\BANKRAZB
set HOME=E:\azbk\BANKRAZB
set LOG_DIR=E:\azbk\BANKRAZB\log
set MBENV_KOKYAKU_KEY=CIF
rem %04 Del set ORACLE_HOME=D:\oracle\product\11.2.0\dbhome_1
set ORACLE_HOME=F:\oracle\product\19.3.0\dbhome_1
set ORACLE_SID=BRCCAZBK
set TBS_NAME_EFF_IDX=EMBIHISTORY
set TBS_NAME_EFF_TBL=EMBTHISTORY
set USER=BATCH
set DB_UID=spv
set DB_PWD=eaux
