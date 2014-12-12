#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : ログメンテナンス
#
# FILE      : uy_log_maint.ps1
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
    [Alias("d")]
    [string]${PRM_ReRunDay}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "ログメンテナンス"
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
        outmsg 54 ${DEF_RTNCD_ERR}
        FC_LogWriter 1 "再実行日時の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        EndProcess
    }
}

#--------------------------------------------
# 処理1.日次メンテナンス処理
#--------------------------------------------
${LC_EXECUTE_MSG} = "日次メンテナンス処理"
${LC_EXECUTE_PGM} = "uy_daily_batch.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を実施します。"
${RTN_COMMAND00} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
${RTN_CD00} = ${RTN_COMMAND00}.ExitCode
${RTN_COMMAND00}.Close()
if ( ${RTN_CD00} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を終了します。"
}

#--------------------------------------------
# 処理2.各種ログバックアップ処理
#--------------------------------------------
${LC_EXECUTE_MSG} = "各種ログバックアップ処理"
${LC_EXECUTE_PGM} = "uy_log_backup.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を実施します。"
${RTN_COMMAND00} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
${RTN_CD00} = ${RTN_COMMAND00}.ExitCode
${RTN_COMMAND00}.Close()
if ( ${RTN_CD00} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を終了します。"
}

#--------------------------------------------
# 処理3.監査ログバックアップ処理
#--------------------------------------------
${LC_EXECUTE_MSG} = "監査ログバックアップ処理"
${LC_EXECUTE_PGM} = "uy_audit_log_backup.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を実施します。"
${RTN_COMMAND00} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
${RTN_CD00} = ${RTN_COMMAND00}.ExitCode
${RTN_COMMAND00}.Close()
if ( ${RTN_CD00} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}処理を終了します。"
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
