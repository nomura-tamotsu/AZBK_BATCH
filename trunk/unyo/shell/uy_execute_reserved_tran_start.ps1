#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : 予約処理実行
#
# FILE      : uy_execute_reserved_tran_start.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | R.YAMANO      | First Eddition
# %01 | 14/06/04 | H.YAMASHITA   | Java実行部分を変更
# %02 | 14/06/10 | R.YAMANO      | First Eddition Fix
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [string]${LC_KEY}="KEY"
)

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "予約処理実行"
${PRG_EXIT_CODE}    = 0

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
#  Java Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\ExecuteReservedTranEnv.ps1

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

#--------------------------------------------
# 予約処理実行コマンド取得
#--------------------------------------------
${COM_RESERVE_CMDLINE} = "${COM_WAS_CMND_JAVA} "
${LC_CLPATH_00} = "${BR_JAVA_CLPATH01};${BR_JAVA_CLPATH02}"
${LC_CLNAME_00} = "${BR_JAVA_CLFILE01}"
${LC_SECPRP_00} = "`"${BR_JAVA_SECPRP01}`" `"${BR_JAVA_SECPRP02}`" `"${BR_JAVA_SECPRP03}`" `"${BR_JAVA_SECPRP04}`" `"${BR_JAVA_SECPRP05}`""

#--------------------------------------------
# 処理実行
#--------------------------------------------
try {
    Invoke-Expression "${COM_WAS_CMND_JAVA} ${LC_SECPRP_00} -DeMBSV=1 -classpath '${LC_CLPATH_00}' ${LC_CLNAME_00} ${LC_KEY}"
    if ( ${LASTEXITCODE} -eq 0 ) {
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
# End Main Program
#--------------------------------------------
EndProcess
