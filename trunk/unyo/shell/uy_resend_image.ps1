#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2020
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �{�l�m�F�����đ�����
#
# FILE      : uy_resend_image.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 20/07/20 A.MIYAMOTO      | First Eddition
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "�{�l�m�F�����đ�����"
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
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# �K�v�t�H���_�̑��݃`�F�b�N����
#--------------------------------------------
function LFC_DirExistCheckProcess
{
	# �����Ώۂ̃t�H���_�̃p�X
	${script:LOCAL_IN_DIR} = ${TMP_FAILURES_DIR} -creplace "@@INSTANCENAME@@", ${script:LOCAL_INSTANCE_DIR_NAME}
	# �����Ώۃt�H���_�̑��݃`�F�b�N
	if (!(Test-Path ${script:LOCAL_IN_DIR})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����̓]���Ώۃt�H���_[${script:LOCAL_IN_DIR}]�����݂��Ȃ��׈ُ�I�����܂��B"
		FC_LogWriter 1 "�{�l�m�F�����̓]���Ώۃt�H���_[${script:LOCAL_IN_DIR}]�����݂��Ȃ��׈ُ�I�����܂��B"
		EndProcess
	}
	
	# �]�����IMAGE�t�H���_�̃p�X
	${script:LOCAL_NAS_IMAGE_DIRS} = ${COM_NAS_IMAGE_DIRS} -creplace "@@INSTANCENAME@@", ${script:LOCAL_INSTANCE_DIR_NAME}
	# �����Ώۃt�H���_�̑��݃`�F�b�N
	if (!(Test-Path ${script:LOCAL_NAS_IMAGE_DIRS})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����̓]����t�H���_[${script:LOCAL_NAS_IMAGE_DIRS}]�����݂��Ȃ��׈ُ�I�����܂��B"
		FC_LogWriter 1 "�{�l�m�F�����̓]����t�H���_[${script:LOCAL_NAS_IMAGE_DIRS}]�����݂��Ȃ��׈ُ�I�����܂��B"
		EndProcess
	}
}

#-------------------------------------------------------
# NAS�{�l�m�F�����ۑ���t�H���_���݃`�F�b�N�y�ѐ�������
#-------------------------------------------------------
function LFC_NasDirExistCheckProcess
{
	if($LOCAL_IN_FILE.PSIsContainer) {
		# �t�H���_�̏ꍇ�̏���(�������Ȃ�)
	} else {
		# �t�@�C���̏ꍇ�̏���
		if(${LOCAL_IN_FILE}.Name.Length -le 9) {
			# �t�@�C�����̕�������9�����ȉ��̏ꍇ�G���[�uXXXXXX.jpg�v�ȉ����Ǝ�t���t���擾����ۂɃG���[�ƂȂ邽��
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			outmsg 55 ${PRG_EXIT_CODE} "�t�@�C��[$LOCAL_IN_FILE]�̖��̂��s���Ȉ׈ُ�I�����܂��B"
			FC_LogWriter 1 "�t�@�C��[$LOCAL_IN_FILE]�̖��̂��s���Ȉ׈ُ�I�����܂��B"
			EndProcess
		} else {
			# ��t���t
			${script:LOCAL_RECEIPTDATE} = ${LOCAL_IN_FILE}.Name.Substring(0, 6)
		}
		# �]����t�H���_�̃p�X
		${script:LOCAL_OUT_DIR} = ${LOCAL_NAS_IMAGE_DIRS} + "\" + ${script:LOCAL_RECEIPTDATE}
		if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
			try {
				# �]����t�H���_�����݂��Ȃ��ꍇ�쐬
				FC_LogWriter 0 "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]���쐬���܂��B"
				New-Item ${script:LOCAL_OUT_DIR} -ItemType Directory 2>&1 > $null
				${ERR_CODE} = $?
			} catch [Exception] {
				${ERR_CODE} = ${False}
			}
			if (!(${ERR_CODE})) {
				${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
				outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]�̍쐬�Ɏ��s�����׈ُ�I�����܂��B"
				FC_LogWriter 1 "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]�̍쐬�Ɏ��s�����׈ُ�I�����܂��B"
				EndProcess
			}
		}
	}
}


#--------------------------------------------
# �Ώۃt�@�C���̃R�s�[����
#--------------------------------------------
function LFC_NasLocalFileCopyProcess
{
		
	# �Ώۃt�@�C���p�X�쐬
	${script:LOCAL_IN_FILE} = ${script:LOCAL_IN_DIR} + "\" + ${LOCAL_IN_FILE}.Name
	# �]����t�@�C���p�X�쐬
	${script:LOCAL_OUT_FILE} = ${script:LOCAL_OUT_DIR} + "\" + ${LOCAL_IN_FILE}.Name
		
	try {
		FC_LogWriter 0 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE}]��NAS�ۑ���[${script:LOCAL_OUT_FILE}]�ɃR�s�[���܂��B"
		Copy-Item ${script:LOCAL_IN_FILE} ${script:LOCAL_OUT_FILE} -Recurse
		${ERR_CODE} = $?
	} catch [Exception] {
		${ERR_CODE} = ${False}
	}
	if (!(${ERR_CODE})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE}]�̃R�s�[�Ɏ��s�����׈ُ�I�����܂��B"
		FC_LogWriter 1 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE}]�̃R�s�[�Ɏ��s�����׈ُ�I�����܂��B"
		EndProcess
	}
}


#--------------------------------------------
# �]���Ώۃt�@�C���폜����
#--------------------------------------------
function LFC_InFileDeleteProcess
{
	try {
		FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE}]���폜���܂��B"
		Remove-Item ${script:LOCAL_IN_FILE} -Recurse 2>&1 > $null
		${ERR_CODE} = $?
	} catch [Exception] {
		${ERR_CODE} = ${False}
	}
	if (!(${ERR_CODE})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE}]�̍폜�Ɏ��s�����׈ُ�I�����܂��B"
		FC_LogWriter 1 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE}]�̍폜�Ɏ��s�����׈ُ�I�����܂��B"
		EndProcess
	}
}


#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
#--------------------------------------------
InitProcess

# �����Ώۃt�H���_���擾�ibrtabazb,brtabtrn�j
${script:LOCAL_INSTANCE_DIR_NAMES} = ${INSTANCE_DIR_NAMES} -split ","

# �����ΏۂƂȂ�t�H���_�����[�v
foreach(${script:LOCAL_INSTANCE_DIR_NAME} in ${script:LOCAL_INSTANCE_DIR_NAMES} ) {
	# �K�v�t�H���_�̑��݃`�F�b�N����
	LFC_DirExistCheckProcess
	
	# �Ώۃt�H���_���t�@�C���E�t�H���_�̃��X�g���擾����B
	${script:LOCAL_IN_FILES}  = Get-ChildItem ${script:LOCAL_IN_DIR}
	
	# �����ΏۂƂȂ�t�@�C�������[�v
	foreach(${script:LOCAL_IN_FILE} in ${script:LOCAL_IN_FILES} ) {
		# NAS�{�l�m�F�����ۑ���t�H���_���݃`�F�b�N�y�ѐ�������
		LFC_NasDirExistCheckProcess
		
		# �Ώۃt�@�C���̃R�s�[����
		LFC_NasLocalFileCopyProcess
		
		# �Ώۃt�@�C���̍폜����
		LFC_InFileDeleteProcess
	}
} 


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
