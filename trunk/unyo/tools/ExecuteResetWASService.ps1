#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK-R CC
#
# FILE      : Execute Reset WAS brccazbk Servce 
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/06/01 | R.YAMANO      | First Edition
#============================================================================
#
#--------------------------------------------
#  Execute COM definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\ExecuteComEnv.ps1

#--------------------------------------------
# WAS管理ユーザ情報取得
#--------------------------------------------
${ENV:DB_PWD} = "${EX_WAS_PASS}"
${DC_WAS_PWD} = PDECODE ${EX_WAS_MODE} ${EX_WAS_USER}

#----------------------------------------------------------------------
# WAS関連パス
#----------------------------------------------------------------------
${global:BR_WAS_BINSDIR}       = "${COM_WAS_BASE_DIRS}\bin"
${global:BR_BANKRPROF_BASEDIR} = "${COM_WAS_BASE_DIRS}\profiles\${BANKR_PROFNAME}"
${global:BR_BANKRPROF_BINSDIR} = "${BR_BANKRPROF_BASEDIR}\bin"
${global:BR_BANKRPROF_LOGROOT} = "${BR_BANKRPROF_BASEDIR}\logs\server1"

#----------------------------------------------------------------------
# WAS関連コマンド
#----------------------------------------------------------------------
${global:BR_WAS_RESET_SEVICES} = "${BR_WAS_BINSDIR}\WASService.exe"
${global:BR_BANKRPROF_STOPSVR} = "${BR_BANKRPROF_BINSDIR}\stopServer.bat"
