#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK-R CC
#
# FILE      : Execute Reserved Tran Env for Shinagawa Dev
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
#. ${UNYO_HOME}\shell\def\ExecuteComEnv.ps1
. ${UNYO_HOME}\shell\def\ExecuteComEnv_ForDev.ps1

#--------------------------------------------
# WAS管理ユーザ情報取得
#--------------------------------------------
${ENV:DB_PWD} = "${EX_WAS_PASS}"
#${DC_WAS_PWD} = PDECODE ${EX_WAS_MODE} ${EX_WAS_USER}
${DC_WAS_PWD} = "wasadmin"

#----------------------------------------------------------------------
# 予約処理 実行モジュールパス
#----------------------------------------------------------------------
# CLASS PATH
#${global:BR_JAVA_CLPATH01} = "${COM_WAS_BASE_DIRS}\profiles\brccazbk\installedApps\${HOST_NAME}Node01Cell\eMB.ear\*"
#${global:BR_JAVA_CLPATH02} = "${COM_WAS_BASE_DIRS}\lib\j2ee.jar;${COM_WAS_BASE_DIRS}\plugins\*;${COM_WAS_BASE_DIRS}\java_1.7_64\jre\lib\ext\*;${COM_WAS_BASE_DIRS}\lib\*;"
${global:BR_JAVA_CLPATH01} = "${COM_WAS_BASE_DIRS}\profiles\bankrazb\installedApps\isidg49582Node02Cell\eMB.ear\*"
${global:BR_JAVA_CLPATH02} = "${COM_WAS_BASE_DIRS}\lib\j2ee.jar;${COM_WAS_BASE_DIRS}\plugins\*;${COM_WAS_BASE_DIRS}\java_1.7_64\jre\lib\ext\*;${COM_WAS_BASE_DIRS}\lib\*;"
# CLASS FILE
${global:BR_JAVA_CLFILE01} = "com.brainyworks.marketbrain.tb.ejb.tbbatch.executereservedtrans.ExecuteReservedTransStartBatch"
# SECURITY PROPERTIES
#${global:BR_JAVA_SECPRP01} = "-Dcom.ibm.SSL.ConfigURL=file:${COM_WAS_BASE_URLS}/profiles/brccazbk/properties/ssl.client.props"
#${global:BR_JAVA_SECPRP02} = "-Dcom.ibm.CORBA.ConfigURL=file:${COM_WAS_BASE_URLS}/profiles/brccazbk/properties/sas.client.props"
${global:BR_JAVA_SECPRP01} = "-Dcom.ibm.SSL.ConfigURL=file:${COM_WAS_BASE_URLS}/profiles/bankrazb/properties/ssl.client.props"
${global:BR_JAVA_SECPRP02} = "-Dcom.ibm.CORBA.ConfigURL=file:${COM_WAS_BASE_URLS}/profiles/bankrazb/properties/sas.client.props"
${global:BR_JAVA_SECPRP03} = "-Dcom.ibm.CORBA.loginUserid=${EX_WAS_USER}"
${global:BR_JAVA_SECPRP04} = "-Dcom.ibm.CORBA.loginPassword=${DC_WAS_PWD}"
${global:BR_JAVA_SECPRP05} = "-Dcom.ibm.CORBA.loginSource=properties"
