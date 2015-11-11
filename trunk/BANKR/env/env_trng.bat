@echo off
rem ============================================================================
rem  Copyright　Information Services International-Dentsu, Ltd.
rem ============================================================================
rem 
rem  SYSTEM        : BANK・R－CC
rem 
rem  PROGRAM NAME  : 環境変数定義ファイル(TRAINING)
rem 
rem  MODULE NAME   : env_trng.bat
rem 
rem 
rem  Mod   yy/mm/dd   Coder           Comment
rem -----+----------+---------------+-------------------------------------------
rem  %00 | 14/05/14 | ISID          | First Edition.
rem  %01 | 15/06/18 | 土居 康一郎   | 1.0次対応 研修用に修正
rem  %02 | 15/11/11 | 川島 直樹     | 1.0次対応 DB接続先変更（クラスタ対応）
rem ============================================================================


rem ---------------------------------------
rem  環境変数のセット
rem ---------------------------------------
set DB_NAME=BRCCTRNG
set EMB_HOME=E:\azbk\BANKRAZB
set HOME=E:\azbk\BANKRAZB
set LOG_DIR=E:\azbk\BANKRAZB\log
set MBENV_KOKYAKU_KEY=CIF
set ORACLE_HOME=D:\oracle\product\11.2.0\dbhome_1
set ORACLE_SID=BRCCTRNG
set TBS_NAME_EFF_IDX=EMBIDX
set TBS_NAME_EFF_TBL=EMBDATA
set USER=TRAINING
set DB_UID=training
set DB_PWD=ipwrwrjac
