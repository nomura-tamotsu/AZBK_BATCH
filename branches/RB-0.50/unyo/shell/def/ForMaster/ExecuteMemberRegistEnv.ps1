#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK-R CC
#
# FILE      : Execute Member Regist Env
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
# WAS�Ǘ����[�U���擾
#--------------------------------------------
${ENV:DB_PWD} = "${EX_WAS_PASS}"
${DC_WAS_PWD} = PDECODE ${EX_WAS_MODE} ${EX_WAS_USER}

#----------------------------------------------------------------------
# �_��҃t�@�C���捞���� ���s���W���[���p�X
#----------------------------------------------------------------------
# CLASS PATH
${global:BR_JAVA_CLPATH01} = "D:\azbk\unyo\shell\eMBBatch.jar;${COM_WAS_BASE_DIRS}\profiles\brccazbk\installedApps\${HOST_NAME}Node01Cell\eMB.ear\*"
${global:BR_JAVA_CLPATH02} = "${COM_WAS_BASE_DIRS}\lib\j2ee.jar;${COM_WAS_BASE_DIRS}\plugins\*;${COM_WAS_BASE_DIRS}\java_1.7_64\jre\lib\ext\*;${COM_WAS_BASE_DIRS}\lib\*;"
# CLASS FILE
${global:BR_JAVA_CLFILE01} = "com.bankr.cc.tbmember.batch.CallMemberRegist"
# SECURITY PROPERTIES
${global:BR_JAVA_SECPRP01} = "-Dcom.ibm.SSL.ConfigURL=file:${COM_WAS_BASE_URLS}/profiles/brccazbk/properties/ssl.client.props"
${global:BR_JAVA_SECPRP02} = "-Dcom.ibm.CORBA.ConfigURL=file:${COM_WAS_BASE_URLS}/profiles/brccazbk/properties/sas.client.props"
${global:BR_JAVA_SECPRP03} = "-Dcom.ibm.CORBA.loginUserid=${EX_WAS_USER}"
${global:BR_JAVA_SECPRP04} = "-Dcom.ibm.CORBA.loginPassword=${DC_WAS_PWD}"
${global:BR_JAVA_SECPRP05} = "-Dcom.ibm.CORBA.loginSource=properties"


#----------------------------------------------------------------------
# �_��҃t�@�C���֘A���
#----------------------------------------------------------------------
# �t�@�C����̃f�B���N�g��
${global:BR_GET_FILEDIR00} = "\\${COM_DBSV_VHOST}\E$\extdata\rcv"
# �t�@�C���z�u�f�B���N�g��
${global:BR_SET_FILEDIR00} = "D:\azbk\BANKR\file"
# �_��҃t�@�C��,�����t�@�C��,�U���揉���o�^�t�@�C��
${global:BR_TRG_EN_FILE00} = "D_CST.dat","D_CSK.dat","D_FST.dat"
${global:BR_TRG_JP_FILE00} = "�_��҃t�@�C��","�����t�@�C��","�U���揉���o�^�t�@�C��"
${global:BR_SET_EN_FILE00} = "CST.dat","CSK.dat","FST.dat"
