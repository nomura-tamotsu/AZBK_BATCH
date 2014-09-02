#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 日次メンテナンス
#
# MODNAME   : uy_daily_batch.ps1
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
    [Parameter(Mandatory=$false)]
    [Alias("m")]
    [string]${PRM_PGMODE}="x",
    [Parameter(Mandatory=$false)]
    [Alias("d")]
    [string]${PRM_ReRunDay}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "日次メンテナンス"
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
${LCOPTION}         = ""

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# 異常終了処理
#--------------------------------------------
function LFC_AbnormalEndProcess
{
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "${LC_EXECUTE_MSG}処理が異常終了しました。処理を中止します。"
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_EXECUTE_MSG}処理が異常終了しました。処理を中止します。"
    EndProcess
}

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
if ( ${PRM_ReRunDay} -ne "x" ) {
    if ( ${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
        ${LCOPTION} = "-m rerun -d ${PRM_ReRunDay} "
    } else {
        outmsg 55 ${DEF_RTNCD_ERR} "再実行日時の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        FC_LogWriter 1 "再実行日時の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        EndProcess
    }
}

#--------------------------------------------
# 処理1.運用日付取得
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "運用日付取得処理を実施します。"
${RTN_GET_UNYOFILE} = MakeUnyoudaysFile ${PRM_ReRunDay}
FC_LogWriter ${DEF_RTNCD_NML} "運用日付取得処理を終了します。"


#--------------------------------------------
# 処理2.ログファイルリネーム
#--------------------------------------------
${LC_EXECUTE_MSG} = "ログファイルリネーム"
${LC_EXECUTE_PGM} = "uy_rename_log.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を実施します。"
${RTN_COMMAND01} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
Wait-Process -Id (${RTN_COMMAND01}.id)
${RTN_CD01} = ${RTN_COMMAND01}.ExitCode
${RTN_COMMAND01}.Close()
if ( ${RTN_CD01} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を終了します。"
}

#--------------------------------------------
# 処理3.イベントログ収集
#--------------------------------------------
${LC_EXECUTE_MSG} = "イベントログ収集"
${LC_EXECUTE_PGM} = "uy_collect_event_log.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を実施します。"
${RTN_COMMAND01} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
Wait-Process -Id (${RTN_COMMAND01}.id)
${RTN_CD01} = ${RTN_COMMAND01}.ExitCode
${RTN_COMMAND01}.Close()
if ( ${RTN_CD01} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を終了します。"
}

#--------------------------------------------
# 処理4.不要ファイル削除
#--------------------------------------------
# uy_delete_old_file.ps1
${LC_EXECUTE_MSG} = "不要ファイル削除"
${LC_EXECUTE_PGM} = "uy_delete_old_file.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を実施します。"
${RTN_COMMAND01} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
Wait-Process -Id (${RTN_COMMAND01}.id)
${RTN_CD01} = ${RTN_COMMAND01}.ExitCode
${RTN_COMMAND01}.Close()
if ( ${RTN_CD01} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を終了します。"
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
