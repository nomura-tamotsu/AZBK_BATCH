#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : WAS停止処理
#
# FILE      : uy_was_stop.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "WAS停止処理"
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
# サービス制御関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComSeviceManage.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# WASサービス名取得
#--------------------------------------------
${LC_SERVICE_NAME} = FC_ReplaceString "${COM_SVCNAME_WASV85}"

#--------------------------------------------
# WAS停止処理
#--------------------------------------------
if ( !(FC_SERVICE_MANG ${LC_SERVICE_NAME} STOP) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    EndProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
