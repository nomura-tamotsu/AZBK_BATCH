#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : DBバックアップ処理
#
# FILE      : uy_db_backup.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/01/19 | R.YAMANO      | First Eddition
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
${PRG_NAME}         = "DBバックアップ処理"
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
${ACT_FLAG}         = "${UNYO_TMP_DIR}\${COM_FULLBKUP_FLAG}"

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
# LOAD MODULE
#--------------------------------------------
# BACKUP EXEC 
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "BackupExec制御用モジュールのロード処理を開始します。"
Import-Module BEMCLI
FC_LogWriter ${DEF_RTNCD_NML} "BackupExec制御用モジュールのロード処理が完了しました。"

#--------------------------------------------
# タスクスケジュール制御フラグ (削除)
#--------------------------------------------
if ( Test-Path ${ACT_FLAG} ) {
    # 存在する場合、削除処理
    Remove-Item ${ACT_FLAG} -Recurse 2>&1 > $null
}

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# 運用日付取得 (YYYYMMDD)
if ( ${PRM_ReRunDay} -ne "x" ) {
    if ( ${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
        ${UNYO_DATE} = ${PRM_ReRunDay}
    } else {
        outmsg 54 ${DEF_RTNCD_ERR}
        FC_LogWriter 1 "運用日付の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        EndProcess
    }
} elseif ( Test-Path ${UNYOUDAYS_FILE} ) {
    ${UNYO_DATE} = Get-Content ${UNYOUDAYS_FILE} -totalCount 1
} else {
    ${UNYO_DATE} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
}
# 前日日付取得 (YYYYMMDD)
${LCD_YESTERDAY} = ${UNYO_DATE}.Insert(4,"/").Insert(7,"/")
${BEF_UNYO_DATE} = (Get-Date ${LCD_YESTERDAY}).AddDays(-1).ToString(${COM_DATEFORM08})


#--------------------------------------------
# DBフルバックアップジョブ実行(BackupExec)
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "DBフルバックアップジョブ[${COM_FULLBKUP_JOBS}]を実行します。"
try {
    ${RTN_JOBTMP} = Get-BEJob -Name "${COM_FULLBKUP_JOBS}" | Start-BEJob -Confirm:$False | Wait-BEJob
    ${RTN_JOBRSL} = (Get-BEJob -Name "${COM_FULLBKUP_JOBS}").Status.ToString().ToUpper()
    if ( ${RTN_JOBRSL} -eq "SUCCEEDED" ) {
        # 実行結果：成功
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}に成功しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}に失敗しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}にて異常が発生しました。"
    EndProcess
}

#--------------------------------------------
# タスクスケジュール制御フラグ (作成)
#--------------------------------------------
${UNYO_DATE} | Out-File -FilePath ${ACT_FLAG} -Append -Encoding default

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
