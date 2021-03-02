#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : PowerShell WASサービス登録
#
# FILE      : ResetWASService.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/08/14 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [Alias("nodename")]
    [string]${global:BANKR_PROFNAME}="x",
    [Parameter(Mandatory=$true)]
    [Alias("password")]
    [string]${NEW_PWD}="x"
)

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "WASサービス再登録処理"
${PRG_EXIT_CODE}    = 0

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
#  WAS Variable definition
#--------------------------------------------
${global:BANKR_NODENAME} = "${HOST_NMLO}_${BANKR_PROFNAME}"
. ${UNYO_HOME}\shell\def\ExecuteResetWASService.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${LOG_FLAG}  = 1
${ACT_TIME}  = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}  = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"

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
# WAS再登録事前処理 既存サービスの停止
#--------------------------------------------
${LC_BANKR_STOPSVR_CMDLINE}    = "${BR_BANKRPROF_STOPSVR} server1 -username ${EX_WAS_USER} -password ${DC_WAS_PWD}"
echo ${LC_BANKR_STOPSVR_CMDLINE}
#--------------------------------------------
# 処理実行
#--------------------------------------------
try {
    ${LC_TEMPMSG} = "既存サービスの停止"
    Invoke-Expression "${LC_BANKR_STOPSVR_CMDLINE}"
    if ( ${LASTEXITCODE} -eq 0 ) {
        # 実行結果：成功
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_TEMPMSG}に成功しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_TEMPMSG}に失敗しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_TEMPMSG}にて異常が発生しました。"
    EndProcess
}


#--------------------------------------------
# WAS再登録処理
#--------------------------------------------
${LC_WAS_RSET_SERVICE_CMDLINE} = "${BR_WAS_RESET_SEVICES} -add `"${BANKR_NODENAME}`" -servername server1 -profilePath ${BR_BANKRPROF_BASEDIR} -logRoot ${BR_BANKRPROF_LOGROOT} -stopArgs `"-username ${EX_WAS_USER} -password ${NEW_PWD}`" -encodeParams"
echo ${LC_WAS_RSET_SERVICE_CMDLINE}
#--------------------------------------------
# 処理実行
#--------------------------------------------
try {
    ${LC_TEMPMSG} = "WAS再登録処理"
    Invoke-Expression "${LC_WAS_RSET_SERVICE_CMDLINE}"
    if ( ${LASTEXITCODE} -eq 0 ) {
        # 実行結果：成功
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_TEMPMSG}に成功しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_TEMPMSG}に失敗しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_TEMPMSG}にて異常が発生しました。"
    EndProcess
}


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
