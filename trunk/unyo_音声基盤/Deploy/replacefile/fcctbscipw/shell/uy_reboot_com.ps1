#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 定期リブート起動処理（共通用）
#
# FILE      : uy_reboot_com.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | R.YAMANO      | First Eddition
# %01 | 21/04/22 | A.MIYAMOTO    | リブート前にスイッチオーバー処理を追加
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "定期リブート起動処理"
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
${FCCTBSCIPW11}     = "fcctbscipw11"
${FCCTBSCIPW12}     = "fcctbscipw12"
${WAIT_SEC}         = 120


#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# サーバ起動制御関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComSystemManage.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# サーバスイッチオーバー処理
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "サーバリブート前のスイッチオーバー処理を実行します。"
try {
	if ( ${global:HOST_NAME} -eq ${FCCTBSCIPW11} ) {
		# スイッチオーバー処理実行
		SwitchoverCtrlU.exe /Notifier=${FCCTBSCIPW12} /Immediate
	} else {
		# スイッチオーバー処理実行
		SwitchoverCtrlU.exe /Notifier=${FCCTBSCIPW11} /Immediate
	}
	${ERR_CODE} = $?
} catch [Exception] {
	${ERR_CODE} = ${False}
}
if (!(${ERR_CODE})) {
	# 処理失敗時はメッセージのみ出力
	FC_LogWriter ${DEF_RTNCD_NML} "サーバのスイッチオーバー処理に失敗しました。"
}

#--------------------------------------------
# サーバ再起動前のスリープ処理
#--------------------------------------------
Start-Sleep -s ${WAIT_SEC}

#--------------------------------------------
# サーバ再起動処理
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "サーバ再起動処理を行います。"
FC_SvrReboot

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
