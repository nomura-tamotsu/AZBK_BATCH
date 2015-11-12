#============================================================================
#  COPYRIGHT iSiD LTD. 2015
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : ローカルDB起動処理
#
# FILE      : uy_localoracle_start.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 15/11/11 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [Alias("sid")]
    [string]${PRM_TGSID}="x",
    [Parameter(ValueFromRemainingArguments=$true)]
    [string]${PRM_OTHERS}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "ローカルDB起動処理"
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
${ACT_FLAG}         = "H:\DBFiles"
${ACT_CUNT}         = 0
# リトライ処理用変数
${LC_RETRY_MAXCOUNT} = 15
${LC_RETRY_WAITTIME} = 60
# リトライ処理用変数(TEST用)
#${ACT_FLAG}         = "D:\DBFiles"
#${LC_RETRY_MAXCOUNT} = 3
#${LC_RETRY_WAITTIME} = 5

#--------------------------------------------
# Local Env SubSetting
#--------------------------------------------
# 本番環境 追加インスタンス
${LC_SVCNAME_11} = "OracleServiceBRCCAZBK"
# 本番環境 追加インスタンスリスナー
${LC_SVCNAME_12} = "OracleOraDb11g_home1TNSListenerAZBK_LSNR"
#--------------------------------------------
# 研修環境 追加インスタンス
${LC_SVCNAME_21} = "OracleServiceBANKRTRN"
# 研修環境 追加インスタンスリスナー
${LC_SVCNAME_22} = "OracleOraDb11g_home1TNSListenerTRNG_LSNR"

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# サービス制御関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComSeviceManage.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
#--------------------------------------------
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# ORACLEインスタンス種別チェック (SID)
# サービス名取得
#--------------------------------------------
if (${PRM_OTHERS} -ne "x") {
    ${PRG_EXIT_CODE}     = ${DEF_RTNCD_ERR}
    outmsg 53 ${PRG_EXIT_CODE}
    FC_LogWriter ${PRG_EXIT_CODE} "引数の数が正しくありません。指定可能な引数は1つです。"
    EndProcess
}
switch("${PRM_TGSID}") {
    "BANKRAZB" { ${TG_SVCNAME_ORACLE} = "${LC_SVCNAME_11}" ; ${TG_SVCNAME_LISTENER} = "${LC_SVCNAME_12}" ; break }
    "BANKRTRN" { ${TG_SVCNAME_ORACLE} = "${LC_SVCNAME_21}" ; ${TG_SVCNAME_LISTENER} = "${LC_SVCNAME_22}" ; break }
    default    { 
                 ${PRG_EXIT_CODE}     = ${DEF_RTNCD_ERR}
                 outmsg 54 ${PRG_EXIT_CODE}
                 FC_LogWriter ${PRG_EXIT_CODE} "引数の内容が正しくありません。指定可能な引数は[BANKRAZB]と[BANKRTRN]のみです。"
                 EndProcess
               }
}

#--------------------------------------------
# ACTIVE Server Check
#--------------------------------------------
# ローカルDB稼働号機チェック処理
#--------------------------------------------
for ( ${i} = 1 ; ${i} -lt ${LC_RETRY_MAXCOUNT} ; ${i}++ ) {
    if ( !(Test-Path ${ACT_FLAG}) ) {
        FC_LogWriter ${DEF_RTNCD_NML} "稼働号機チェック処理です(${i}回目)。"
        Start-Sleep -s ${LC_RETRY_WAITTIME}
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "稼働号機であることを確認しました。"
        FC_LogWriter ${DEF_RTNCD_NML} "稼働号機チェック処理を終了します。"
        break
    }
}
if ( ${i} -eq ${LC_RETRY_MAXCOUNT} ) {
    FC_LogWriter ${DEF_RTNCD_NML} "稼働号機チェック処理で最大リトライ回数(${i}回)に達しました。"
    FC_LogWriter ${DEF_RTNCD_NML} "稼働号機ではないため${PRG_NAME}を終了します。"
    EndProcess
}

#--------------------------------------------
# Service STOP
#--------------------------------------------
# ローカルDB(Oracleインスタンス)起動処理
#--------------------------------------------
if ( !(FC_SERVICE_MANG ${TG_SVCNAME_ORACLE} START) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    EndProcess
}

#--------------------------------------------
# ローカルDB(Oracleリスナー)起動処理
#--------------------------------------------
if ( !(FC_SERVICE_MANG ${TG_SVCNAME_LISTENER} START) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    EndProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
