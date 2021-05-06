#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ������u�[�g�N�������i���ʗp�j
#
# FILE      : uy_reboot_com.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | R.YAMANO      | First Eddition
# %01 | 21/04/22 | A.MIYAMOTO    | ���u�[�g�O�ɃX�C�b�`�I�[�o�[������ǉ�
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "������u�[�g�N������"
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
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# �T�[�o�N������֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComSystemManage.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# �T�[�o�X�C�b�`�I�[�o�[����
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "�T�[�o���u�[�g�O�̃X�C�b�`�I�[�o�[���������s���܂��B"
try {
	if ( ${global:HOST_NAME} -eq ${FCCTBSCIPW11} ) {
		# �X�C�b�`�I�[�o�[�������s
		SwitchoverCtrlU.exe /Notifier=${FCCTBSCIPW12} /Immediate
	} else {
		# �X�C�b�`�I�[�o�[�������s
		SwitchoverCtrlU.exe /Notifier=${FCCTBSCIPW11} /Immediate
	}
	${ERR_CODE} = $?
} catch [Exception] {
	${ERR_CODE} = ${False}
}
if (!(${ERR_CODE})) {
	# �������s���̓��b�Z�[�W�̂ݏo��
	FC_LogWriter ${DEF_RTNCD_NML} "�T�[�o�̃X�C�b�`�I�[�o�[�����Ɏ��s���܂����B"
}

#--------------------------------------------
# �T�[�o�ċN���O�̃X���[�v����
#--------------------------------------------
Start-Sleep -s ${WAIT_SEC}

#--------------------------------------------
# �T�[�o�ċN������
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "�T�[�o�ċN���������s���܂��B"
FC_SvrReboot

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
