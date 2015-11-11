@echo off
rem ============================================================================
rem  Copyright　Information Services International-Dentsu, Ltd.
rem ============================================================================
rem 
rem  SYSTEM        : BANK・R－CC
rem 
rem  PROGRAM NAME  : 環境変数定義ファイル(AZBK)
rem 
rem  MODULE NAME   : env_azbk.bat
rem 
rem 
rem  Mod   yy/mm/dd   Coder           Comment
rem -----+----------+---------------+-------------------------------------------
rem  %00 | 14/05/14 | ISID          | First Edition.
rem  %01 | 15/03/30 | 土居 康一郎   | 1.0次対応 DB環境、パス名を変更
rem  %02 | 15/06/02 | 土居 康一郎   | 1.0次対応 パスワード暗号化修正
rem  %03 | 15/11/11 | 川島 直樹     | 1.0次対応 DB接続先変更（クラスタ対応）
rem ============================================================================


rem ---------------------------------------
rem  環境変数のセット
rem ---------------------------------------
set DB_NAME=BRCCAZBK
set EMB_HOME=E:\azbk\BANKRAZB
set HOME=E:\azbk\BANKRAZB
set LOG_DIR=E:\azbk\BANKRAZB\log
set MBENV_KOKYAKU_KEY=CIF
set ORACLE_HOME=D:\oracle\product\11.2.0\dbhome_1
set ORACLE_SID=BRCCAZBK
set TBS_NAME_EFF_IDX=EMBIHISTORY
set TBS_NAME_EFF_TBL=EMBTHISTORY
set USER=BATCH
set DB_UID=spv
set DB_PWD=eaux
