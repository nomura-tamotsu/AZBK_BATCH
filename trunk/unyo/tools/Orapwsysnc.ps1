#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : ファイル同期プログラム(サンプル)
#
# FILE      : uy_sample_file_sysnc.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/06/28 | R.YAMANO      | First Eddition
#============================================================================
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "ファイル同期プログラム(サンプル)"
${PRG_EXIT_CODE}    = 0

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${LOG_FLAG}          = 1
${ACT_TIME}          = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}          = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"
#--------------------------------------------
# 同期情報
#--------------------------------------------
# 同期先サーバ名
${LC_SYNC_HOST}      = "fcctbsappw02"
# 同期元ディレクトリパス
${LC_SYNC_SRCE_DIR} = "D:\BANKR_CC\temp"
# 同期先ディレクトリパス(UNCパス表記)
${LC_SYNC_DEST_DIR} = "\\${LC_SYNC_HOST}\D$\BANKR_CC\temp"

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# 取得先サーバ生存チェック (ICMPレベル)
#--------------------------------------------
if ( !(Test-Connection ${LC_SYNC_HOST} -quiet) ) {
    # 接続不能の為、処理を中止します。
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "ファイル同期サーバ[${LC_SYNC_HOST}]に接続できない為、処理を中止します。"
    FC_LogWriter ${PRG_EXIT_CODE} "ファイル同期先サーバ[${LC_SYNC_HOST}]に接続できない為、処理を中止します。"
    EndProcess
}

#--------------------------------------------
# 1. 事前確認
#--------------------------------------------
#--------------------------------------------
# 1.1 同期元ディレクトリ存在チェック
#--------------------------------------------
FC_LogWriter ${LC_SYNC_DEST_DIR} "ファイル同期元ディレクトリの存在チェック処理を開始します。"
if ( !(Test-Path ${LC_SYNC_SRCE_DIR}) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "ファイル同期元ディレクトリ[${LC_SYNC_SRCE_DIR}]が存在しない為、処理を中止します。"
    FC_LogWriter ${PRG_EXIT_CODE} "ファイル同期元ディレクトリ[${LC_SYNC_SRCE_DIR}]が存在しない為、処理を中止します。"
    EndProcess
}
FC_LogWriter ${LC_SYNC_DEST_DIR} "ファイル同期元ディレクトリの存在チェック処理が正常終了しました。"
#--------------------------------------------
# 1.2 同期先ディレクトリ状況チェック
#--------------------------------------------
FC_LogWriter ${LC_SYNC_DEST_DIR} "ファイル同期先ディレクトリへのアクセス状況確認処理を開始します。"
if ( !(Test-Path ${LC_SYNC_DEST_DIR}) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "ファイル同期先ディレクトリ[${LC_SYNC_DEST_DIR}]へのアクセスが行えない為、処理を中止します。"
    FC_LogWriter ${PRG_EXIT_CODE} "ファイル同期先ディレクトリ[${LC_SYNC_DEST_DIR}]へのアクセスが行えない為、処理を中止します。"
    EndProcess
}
FC_LogWriter ${LC_SYNC_DEST_DIR} "ファイル同期先ディレクトリへのアクセス状況確認処理が正常終了しました。

#--------------------------------------------
# 2.ファイル同期処理
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "ファイル同期処理を開始します。"
${TG_FIND_FILES} = @(Get-ChildItem ${LC_SYNC_SRCE_DIR})
if ( ${TG_FIND_FILES}.length -gt 0 ) {

    foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {
        if ( ${FINDFILE}.PsISContainer -eq ${False} ) {
            ${COPY_FILEDIFI_S} = ${FINDFILE}.fullname
            FC_LogWriter ${DEF_RTNCD_NML} "[${COPY_FILEDIFI_S}]のコピー処理を開始します。"
            ${RTN_CPY_TEMP} = Copy-Item ${COPY_FILEDIFI_S} ${LC_SYNC_DEST_DIR} -Recurse
            ${RTN_CPY_CODE} = $?
            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${COPY_FILEDIFI_S}]のコピー処理が正常終了しました。"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "[${COPY_FILEDIFI_S}]のコピー処理にてエラーが発生しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "[${COPY_FILEDIFI_S}]のコピー処理にてエラーが発生しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "ファイル同期処理が異常終了しました。"
                EndProcess
            }
        }
    }
}
FC_LogWriter ${PRG_EXIT_CODE} "ファイル同期処理が終了しました。"

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
