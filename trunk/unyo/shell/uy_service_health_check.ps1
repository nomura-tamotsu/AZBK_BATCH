#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2016
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 運用保守 リブート時エラー検知処理
#
# ModName   : uy_service_health_check
#
# Condition : UnyoEnv & ComFunction files inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 17/11/20 | K.TAKEICHI    | First Eddition
#============================================================================
#----------------------------------------------------------------------#
# GetPerfMonitor for BANK*R CC  Ver.1.0.0                              #
#----------------------------------------------------------------------#
#--------------------------------------------
# Get Parameter Information

# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "リブート時エラー検知処理"
${PRG_EXIT_CODE}    = 0
${EVENT_SRC}        = "HealthCheckAP"
${EVENT_ID}         = 100

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${script:LC_TGFILES} = "D:\BANKR_CC\logs\biz\bankrazb\eMBTraceFile"
#----------------------------------------------------------------------#
# Function
#----------------------------------------------------------------------#
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#----------------------------------------------------------------------#
# イベントログ出力処理(共通)
#----------------------------------------------------------------------#
function global:EventLog_Output
{
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    if ([System.Diagnostics.EventLog]::SourceExists(${EVENT_SRC}) -eq $false){
        New-EventLog -LogName Application -Source ${EVENT_SRC} 
    }    
    Write-EventLog -LogName Application -EntryType Error -Source ${EVENT_SRC} -EventId ${EVENT_ID} -Message ${EVENT_MSG} -Category 0
    EndProcess
}
#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess
#----------------------------------------------------------------------#
# 1.確認対象ファイル存在チェック (eMBTraceFile)
#----------------------------------------------------------------------#
if ( !(Test-Path ${LC_TGFILES}) ) {
    # 存在しない為処理を中止します。
    ${EVENT_MSG} = "ログファイル[eMBTraceFile]が存在しません。"
    EventLog_Output
}
#----------------------------------------------------------------------#
# 2.ログ解析（eMBTraceFile）
#----------------------------------------------------------------------#       
if (Get-Content ${LC_TGFILES} | Select-String -Pattern "コネクションプーリングよりコネクションを取得できませんでした" -Encoding default -Quiet ) {
    ${EVENT_MSG} = "コネクションプーリングよりコネクションを取得できませんでした。"
    EventLog_Output
}
#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess