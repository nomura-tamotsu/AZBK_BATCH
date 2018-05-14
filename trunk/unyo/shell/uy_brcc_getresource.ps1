#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2017
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : BANK*R CC 定例会資料リソース情報取得ツール
#
# FILE      : uy_brcc_getresource.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 17/02/01 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "定例会資料リソース情報取得ツール"
${PRG_EXIT_CODE}    = 0
#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${LOG_FLAG}         = 1
${ACT_TIME}         = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}         = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"

#--------------------------------------------
# 追加変数定義
#--------------------------------------------
${LCDB_ORACLE_SID} = "BRCCAZBK"
${LCSQL_BRCC_GET_RESORCE_TFILES}    = "${UNYO_HOME}\sql\BRCC_GET_RESOURCE.sql"

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# Pre Action
#--------------------------------------------
# Active Node Check (稼働号機のみ実行)
if ( !(Test-Path ${UNYO_DB_FLBKUP_DIR}) ) {
    exit 0
}

#--------------------------------------------
# MAIN
#--------------------------------------------
# 1. Start Main Program
#--------------------------------------------
InitProcess

#--------------------------------------------
# 定例会資料リソース情報取得ツール
#--------------------------------------------
# 2. GET RESORCE
#--------------------------------------------
${LC_SQLMSG} = "定例会資料リソース情報取得ツール"
${LC_SQL001} = "${LCSQL_BRCC_GET_RESORCE_TFILES}"
# 取得対象期間の設定
${LC_TGTMONTH} =  (Get-Date).AddMonths(-1) | %{ $_.ToString("yyyy/MM") }
${LC_NOWMONTH} =  (Get-Date) | %{ $_.ToString("yyyy/MM") }
${LC_TGTFILEN} =  (Get-Date ${LC_TGTMONTH} -format "yyyyMM")
# 定例会資料リソース抽出ファイル名の設定
${LC_GETFILENAME} = "BRCC_GET_RESORCE_${LC_TGTFILEN}.log"


sqlplus /@${LCDB_ORACLE_SID} as sysdba "@${LC_SQL001}" "${LC_TGTMONTH}" "${LC_NOWMONTH}" "${LC_GETFILENAME}" 2>&1 > $null
${RTN_CODE} = $?
if ( ${RTN_CODE} ) {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_SQLMSG}が正常終了しました。"
} else {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "${LC_SQLMSG}にてエラーが発生しました。"
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_SQLMSG}にてエラーが発生しました。"
    EndProcess
}

#--------------------------------------------
# 3. End Main Program
#--------------------------------------------
EndProcess
