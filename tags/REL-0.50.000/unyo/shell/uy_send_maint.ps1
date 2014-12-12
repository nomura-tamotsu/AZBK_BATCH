#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 送信ファイルメンテナンス処理
#
# FILE      : uy_send_maint.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [Alias("id")]
    [string]${FILE_ID}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "送信ファイルメンテナンス処理"
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

#SENDNM_FILE_DEF

#--------------------------------------------
# DEF FILE CHECK
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${SENDNM_FILE_DEF}]より情報取得します(${PRG_NAME})"
# 定義ファイル存在チェック
if ( !(Test-Path ${SENDNM_FILE_DEF}) ) {
    # 存在しない為、異常終了
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${SENDNM_FILE_DEF}"
    FC_LogWriter ${PRG_EXIT_CODE} "定義ファイル[${SENDNM_FILE_DEF}]が存在しない為異常終了します(${PRG_NAME})"
    EndProcess
}

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# FILE ID 定義確認
if ( ! (Get-Content ${SENDNM_FILE_DEF} | Select-String -Pattern "^${FILE_ID}" -Quiet ) ) {
    # 指定ファイルIDは未登録
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "定義ファイル[${SENDNM_FILE_DEF}]内に未定義のファイルIDが指定された為、処理を異常終了します"
    FC_LogWriter ${PRG_EXIT_CODE} "定義ファイル[${SENDNM_FILE_DEF}]内に未定義のファイルIDが指定された為、処理を異常終了します"
    EndProcess
} else {
    ${LC_GETLINES} = (Get-Content ${SENDNM_FILE_DEF} | Select-String -Pattern "^${FILE_ID}" )
    ${LC_FILENAME} = "${LC_GETLINES}" | %{ $_.Split(",")[1] }
    ${TG_FILEPATH} = "${UNYO_DB_EXTSND_DIR}\${LC_FILENAME}"
}


#--------------------------------------------
# 送信ファイル存在チェック
#--------------------------------------------
if ( !(Test-Path ${TG_FILEPATH}) ) {
    # 存在しない為、異常終了
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "配信ファイル[${TG_FILEPATH}]が存在しない為、処理を異常終了します。"
    FC_LogWriter ${DEF_RTNCD_NML} "配信ファイル[${TG_FILEPATH}]が存在しない為、処理を異常終了します。"
    EndProcess
}

#--------------------------------------------
# バックアップ先フォルダ存在チェック
#--------------------------------------------
if ( !(Test-Path ${UNYO_DB_EXTSND_BKD}) ) {
    # 存在しない為、異常終了
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "バックアップ先フォルダ[${UNYO_DB_EXTSND_BKD}]が存在しない為、処理を異常終了します。"
    FC_LogWriter ${DEF_RTNCD_NML} "バックアップ先フォルダ[${UNYO_DB_EXTSND_BKD}]が存在しない為、処理を異常終了します。"
    EndProcess
}

#--------------------------------------------
# 保存ファイル名
#--------------------------------------------
${BK_DATETIME} = Get-Date -format "${COM_DATEFORM03}"
${BK_FILENAME} = "${LC_FILENAME}.${BK_DATETIME}"
${BK_FILEPATH} = "${UNYO_DB_EXTSND_BKD}\${BK_FILENAME}"

#--------------------------------------------
# 配信ファイルバックアップ処理
#--------------------------------------------
try {
    ${RTN_CPY_TEMP} = Move-Item ${TG_FILEPATH} ${BK_FILEPATH} -Force
    ${RTN_CPY_CODE} = $?

    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "配信ファイル[(${FILE_ID})${TG_FILEPATH}]のバックアップ処理が正常終了しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "配信ファイル[(${FILE_ID})${TG_FILEPATH}]のバックアップ処理にてエラーが発生しました。"
        FC_LogWriter ${PRG_EXIT_CODE} "配信ファイル[(${FILE_ID})${TG_FILEPATH}]のバックアップ処理にてエラーが発生しました。"
        EndProcess
    }

} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "配信ファイル[(${FILE_ID})${TG_FILEPATH}]のバックアップ処理にて異常が発生しました。"
    EndProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
