#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 監査ログバックアップ処理
#
# FILE      : uy_audit_log_backup.ps1
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
    [string]${PRM_ReRunDay}="x",
    [Parameter(Mandatory=$false)]
    [Alias("f")]
    [string]${PRM_FilePATH}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "監査ログバックアップ処理"
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
# ログバックアップ処理関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComLogBackup.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# 運用日付取得 (YYYYMMDD)
if ( ${PRM_ReRunDay} -ne "x" ) {
    if ( ! (${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet) ) {
        outmsg 55 ${DEF_RTNCD_ERR} "運用日付の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        FC_LogWriter 1 "運用日付の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        EndProcess
    }
}
# 定義ファイル指定取得 (指定の場合のみ)
if ( ${PRM_FilePATH} -ne "x" ) {
    ${BACKUP_AUDIT_LOG_DEF} = ${PRM_FilePATH}
}

#--------------------------------------------
# 監査ログバックアップ処理(Phase.01-COPY処理)
#--------------------------------------------
${LC_STEPMSG} = "Phase.01-COPY処理"
FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${LC_STEPMSG})を実施します。"
try {
    #FC_BACKUP_COPY ${BACKUP_AUDIT_LOG_DEF} "COPY" 2>&1 > $null
    #${RTN_FCBACKUP_CODE} = $?
    ${RTN_FCBACKUP_CODE} = FC_BACKUP_COPY ${BACKUP_AUDIT_LOG_DEF} "COPY" "${PRM_ReRunDay}"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${LC_STEPMSG})は終了しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
    EndProcess
}

#--------------------------------------------
# 監査ログバックアップ処理(Phase.02-MOVE処理)
#--------------------------------------------
${LC_STEPMSG} = "Phase.02-MOVE処理"
FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${LC_STEPMSG})を実施します。"
try {
    #FC_BACKUP_COPY ${BACKUP_AUDIT_LOG_DEF} "MOVE" 2>&1 > $null
    #${RTN_FCBACKUP_CODE} = $?
    ${RTN_FCBACKUP_CODE} = FC_BACKUP_COPY ${BACKUP_AUDIT_LOG_DEF} "MOVE" "${PRM_ReRunDay}"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${LC_STEPMSG})は終了しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
    EndProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
