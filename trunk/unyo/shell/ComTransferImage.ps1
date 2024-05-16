#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2020
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �{�l�m�F�����o�^�Q�Ə���
#
# FILE      : uy_transfer_image.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 20/07/13 | A.MIYAMOTO      | First Eddition
# %01 | 24/04/17 | A.MIYAMOTO      | NAS�o�^���̃G���[���x����information�ɕύX
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
#[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [string]${PRM_ShoriKbn}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_InstanceName}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_FileName_1}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_FileName_2}="x"
)

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "�{�l�m�F�����o�^�Q�Ə���"
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
# ���g���C��������p�ϐ�
${LC_RETRY_COUNT} = 5
${LC_RETRY_WAIT}  = 1

#--------------------------------------------
# Function
#--------------------------------------------
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# NAS�{�l�m�F�����ۑ���t�H���_���݃`�F�b�N����
#--------------------------------------------
function LFC_NasDirExistCheckProcess
{
	${script:LOCAL_NAS_IMAGE_DIR} = ${COM_NAS_IMAGE_DIRS} -creplace "@@INSTANCENAME@@", ${PRM_InstanceName}
	if (!(Test-Path ${LOCAL_NAS_IMAGE_DIR})) {
		if (${PRM_ShoriKbn} -eq "regist") {
			# NAS�����[�J���ꎞ�t�H���_�o�^��
			# %01 20240417�@�ێ�ۑ�Ή��@START
			#${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			#outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����̕ۑ���NAS[${LOCAL_NAS_IMAGE_DIR}]���Q�Ƃł��Ȃ��������߃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
			outmsg 1 ${PRG_EXIT_CODE} "�{�l�m�F�����̕ۑ���NAS[${LOCAL_NAS_IMAGE_DIR}]���Q�Ƃł��Ȃ��������߃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
			# %01 20240417�@�ێ�ۑ�Ή��@END
			FC_LogWriter 1 "�{�l�m�F�����̕ۑ���NAS[${LOCAL_NAS_IMAGE_DIR}]���Q�Ƃł��Ȃ��������߃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
			# NAS�ւ̓]�����s������
			LFC_NasTransferFailureProcess

		} elseIf(${PRM_ShoriKbn} -eq "reference") {
			# ���[�J���ꎞ�t�H���_��NAS�o�^��}
				${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
				outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����̕ۑ���NAS[${LOCAL_NAS_IMAGE_DIR}]���Q�Ƃł��Ȃ��������߈ُ�I�����܂��B"
				FC_LogWriter 1 "�{�l�m�F�����̕ۑ���NAS[${LOCAL_NAS_IMAGE_DIR}]���Q�Ƃł��Ȃ��������߈ُ�I�����܂��B"
				EndProcess
		}
	} else {
		if (${PRM_ShoriKbn} -eq "regist") {
			# �o�^���̂ݓo�^��̃f�B���N�g�����݃`�F�b�N���s�����݂��Ȃ��ꍇ�͍쐬����
			${script:LOCAL_OUT_DIR} = ${LOCAL_NAS_IMAGE_DIR} + "\" + ${script:LOCAL_RECEIPTDATE}
			if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
				try {
					FC_LogWriter 0 "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]���쐬���܂��B"
					New-Item ${script:LOCAL_OUT_DIR} -ItemType Directory 2>&1 > $null
					${ERR_CODE} = $?
				} catch [Exception] {
					FC_LogWriter 0 "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]�̍쐬�����Ɏ��s���܂����B"
					${ERR_CODE} = ${False}
				}
				if (!(${ERR_CODE})) {
					for ( ${i} = 1 ; ${i} -le ${LC_RETRY_COUNT} ; ${i}++ ) {
						if ( !${ERR_CODE} ) {
							Start-Sleep -s ${LC_RETRY_WAIT}
						} else {
							break
						}
						if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
							FC_LogWriter 0 "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]�̍쐬�����g���C���܂��B"
							New-Item ${script:LOCAL_OUT_DIR} -ItemType Directory 2>&1 > $null
							${ERR_CODE} = $?
						} else {
							FC_LogWriter 0 "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]�͕ʂ̃v���Z�X�ɂč쐬����܂����B"
							${ERR_CODE} = ${True}
						}
					}
				}
				if (!(${ERR_CODE})) {
					# %01 20240417�@�ێ�ۑ�Ή��@START
					#${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
					#outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]�̍쐬�Ɏ��s�����׈ُ�I�����܂��B"
					#FC_LogWriter 1 "�{�l�m�F�����̕ۑ���f�B���N�g��[${script:LOCAL_OUT_DIR}]�̍쐬�Ɏ��s�����׈ُ�I�����܂��B"
					#EndProcess
					outmsg 1 ${PRG_EXIT_CODE} "�{�l�m�F�����̕ۑ���f�B���N�g��[${LOCAL_OUT_DIR}]�̍쐬�Ɏ��s�����ׁA�t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
					FC_LogWriter 1 "�{�l�m�F�����̕ۑ���f�B���N�g��[${LOCAL_OUT_DIR}]�̍쐬�Ɏ��s�����ׁA�t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
					# NAS�ւ̓]�����s������
					LFC_NasTransferFailureProcess
					# %01 20240417�@�ێ�ۑ�Ή��@END
				}
			}
		}
	}
}

#--------------------------------------------
# �K�v�t�@�C���E�t�H���_�̑��݃`�F�b�N����
#--------------------------------------------
function LFC_FileDirExistCheckProcess
{
	if (${PRM_ShoriKbn} -eq "regist") {
		# �]���Ώۃt�@�C���̃t���p�X���쐬
		${script:LOCAL_TMP_SAVING_DIR} = ${TMP_SAVING_DIR} -creplace "@@INSTANCENAME@@", ${PRM_InstanceName}
		${script:LOCAL_IN_FILE1} = ${LOCAL_TMP_SAVING_DIR} + "\" + ${PRM_FileName_1}
		if (${PRM_FileName_2} -ne "x") {
			${script:LOCAL_IN_FILE2} = ${LOCAL_TMP_SAVING_DIR} + "\" + ${PRM_FileName_2}
		} else {
			${script:LOCAL_IN_FILE2} = "x"
		}
		# �]���Ώۃt�@�C���̃`�F�b�N
		if (!(Test-Path ${script:LOCAL_IN_FILE1})) {
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			outmsg 55 ${PRG_EXIT_CODE} "�]���Ώۃt�@�C��[${script:LOCAL_IN_FILE1}]�����݂��Ȃ��׈ُ�I�����܂��B"
			FC_LogWriter 1 "�]���Ώۃt�@�C��[${script:LOCAL_IN_FILE1}]�����݂��Ȃ��׈ُ�I�����܂��B"
			EndProcess
		}
		if (${PRM_FileName_2} -ne "x") {
			if (!(Test-Path ${script:LOCAL_IN_FILE2})) {
				${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
				outmsg 55 ${PRG_EXIT_CODE} "�]���Ώۃt�@�C��[${script:LOCAL_IN_FILE2}]�����݂��Ȃ��׈ُ�I�����܂��B"
				FC_LogWriter 1 "�]���Ώۃt�@�C��[${script:LOCAL_IN_FILE2}]�����݂��Ȃ��׈ُ�I�����܂��B"
				EndProcess
			}
		}
		# �]����t�@�C���̃t���p�X���쐬
		${script:LOCAL_OUT_FILE1} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_FileName_1}
		if (${PRM_FileName_2} -ne "x") {
			${script:LOCAL_OUT_FILE2} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_FileName_2}
		} else {
			${script:LOCAL_OUT_FILE2} = "x"
		}
	
	} elseif (${PRM_ShoriKbn} -eq "reference") {
		# �]����f�B���N�g���̃t���p�X���쐬
		${script:LOCAL_OUT_DIR} = ${TMP_REFERENCE_DIR} -creplace "@@INSTANCENAME@@", ${PRM_InstanceName}
		# �]���Ώۃt�@�C���̃t���p�X���쐬
		${script:LOCAL_IN_FILE1} = ${LOCAL_NAS_IMAGE_DIR}  + "\" + ${script:LOCAL_RECEIPTDATE} + "\" + ${PRM_FileName_1}
		if (${PRM_FileName_2} -ne "x") {
			${script:LOCAL_IN_FILE2} = ${LOCAL_NAS_IMAGE_DIR} + "\" + ${script:LOCAL_RECEIPTDATE} + "\" + ${PRM_FileName_2}
		} else {
			${script:LOCAL_IN_FILE2} = "x"
		}
		# �]����f�B���N�g���̃`�F�b�N
		if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			outmsg 55 ${PRG_EXIT_CODE} "�]����f�B���N�g��[${script:LOCAL_OUT_DIR}]�����݂��Ȃ��׈ُ�I�����܂��B"
			FC_LogWriter 1 "�]����f�B���N�g��[${script:LOCAL_OUT_DIR}]�����݂��Ȃ��׈ُ�I�����܂��B"
			EndProcess
		}
		# �]���Ώۃt�@�C���̃`�F�b�N
		if (!(Test-Path ${script:LOCAL_IN_FILE1})) {
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			outmsg 55 ${PRG_EXIT_CODE} "�]���Ώۃt�@�C��[${script:LOCAL_IN_FILE1}]�����݂��Ȃ��׈ُ�I�����܂��B"
			FC_LogWriter 1 "�]���Ώۃt�@�C��[${script:LOCAL_IN_FILE1}]�����݂��Ȃ��׈ُ�I�����܂��B"
			EndProcess
		}
		if (${PRM_FileName_2} -ne "x") {
			if (!(Test-Path ${script:LOCAL_IN_FILE2})) {
				${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
				outmsg 55 ${PRG_EXIT_CODE} "�]���Ώۃt�@�C��[${script:LOCAL_IN_FILE2}]�����݂��Ȃ��׈ُ�I�����܂��B"
				FC_LogWriter 1 "�]���Ώۃt�@�C��[${script:LOCAL_IN_FILE2}]�����݂��Ȃ��׈ُ�I�����܂��B"
				EndProcess
			}
		}
		# �]����t�@�C���̃t���p�X���쐬
		${script:LOCAL_OUT_FILE1} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_FileName_1}
		if (${PRM_FileName_2} -ne "x") {
			${script:LOCAL_OUT_FILE2} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_FileName_2}
		} else {
			${script:LOCAL_OUT_FILE2} = "x"
		}
	}
}

#--------------------------------------------
# NAS�����ꎞ�t�H���_�Ԃ̃t�@�C���R�s�[����
#--------------------------------------------
function LFC_NasLocalFileCopyProcess  ( [boolean] ${LOCAL_EVACUATION_FLG} )
{
	try {
		FC_LogWriter 0 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]��[${script:LOCAL_OUT_FILE1}]�ɃR�s�[���܂��B"
		Copy-Item ${script:LOCAL_IN_FILE1} ${script:LOCAL_OUT_FILE1} -Recurse
		${ERR_CODE} = $?
		if ((${ERR_CODE}) -and (${script:LOCAL_IN_FILE2} -ne "x")) {
			FC_LogWriter 0 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE2}]��[${script:LOCAL_OUT_FILE2}]�ɃR�s�[���܂��B"
			Copy-Item ${script:LOCAL_IN_FILE2} ${script:LOCAL_OUT_FILE2} -Recurse
			${ERR_CODE} = $?
		}
	} catch [Exception] {
		FC_LogWriter 0 "�{�l�m�F�����t�@�C���̃R�s�[�����Ɏ��s���܂����B"
		${ERR_CODE} = ${False}
	}
	if (!(${ERR_CODE})) {
		for ( ${i} = 1 ; ${i} -le ${LC_RETRY_COUNT} ; ${i}++ ) {
			if ( !${ERR_CODE} ) {
				Start-Sleep -s ${LC_RETRY_WAIT}
			} else {
				break
			}
			FC_LogWriter 0 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]��[${script:LOCAL_OUT_FILE1}]�ւ̃R�s�[���������g���C���܂��B"
			Copy-Item ${script:LOCAL_IN_FILE1} ${script:LOCAL_OUT_FILE1} -Recurse
			${ERR_CODE} = $?
			if ((${ERR_CODE}) -and (${script:LOCAL_IN_FILE2} -ne "x")) {
				FC_LogWriter 0 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE2}]��[${script:LOCAL_OUT_FILE2}]�ւ̃R�s�[���������g���C���܂��B"
				Copy-Item ${script:LOCAL_IN_FILE2} ${script:LOCAL_OUT_FILE2} -Recurse
				${ERR_CODE} = $?
			}
		}
	}
	if (!(${ERR_CODE})) {
		if (${PRM_ShoriKbn} -eq "regist" -and ${LOCAL_EVACUATION_FLG} ) {
			# %01 20240417�@�ێ�ۑ�Ή��@START
			#${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			# %01 20240417�@�ێ�ۑ�Ή��@END
			if (${PRM_FileName_2} -ne "x") {
				# %01 20240417�@�ێ�ۑ�Ή��@START
				#outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
				outmsg 1 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
				# %01 20240417�@�ێ�ۑ�Ή��@END
				FC_LogWriter 1 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
			} else {
				# %01 20240417�@�ێ�ۑ�Ή��@START
				#outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
				outmsg 1 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
				# %01 20240417�@�ێ�ۑ�Ή��@END
				FC_LogWriter 1 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_�֑ޔ����܂��B"
			}
			# NAS�ւ̓]�����s������
			LFC_NasTransferFailureProcess
			
		} elseif (${PRM_ShoriKbn} -eq "reference" -or !(${LOCAL_EVACUATION_FLG}) ) {
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			if (${PRM_FileName_2} -ne "x") {
				outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]�̃R�s�[�Ɏ��s�����׈ُ�I�����܂��B"
				FC_LogWriter 1 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]�̃R�s�[�Ɏ��s�����׈ُ�I�����܂��B"
			} else {
				outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]�̃R�s�[�Ɏ��s�����׈ُ�I�����܂��B"
				FC_LogWriter 1 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]�̃R�s�[�Ɏ��s�����׈ُ�I�����܂��B"
			}
			EndProcess
		}
	}
}

#--------------------------------------------
# �]���Ώۃt�@�C���폜����
#--------------------------------------------
function LFC_InFileDeleteProcess
{
	try {
		FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]���폜���܂��B"
		Remove-Item ${script:LOCAL_IN_FILE1} -Recurse 2>&1 > $null
		${ERR_CODE} = $?
		if ((${ERR_CODE}) -and (${script:LOCAL_IN_FILE2} -ne "x")) {
			FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE2}]���폜���܂��B"
			Remove-Item ${script:LOCAL_IN_FILE2} -Recurse 2>&1 > $null
			${ERR_CODE} = $?
		}
	} catch [Exception] {
		FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C���̍폜�����Ɏ��s���܂����B"
		${ERR_CODE} = ${False}
	}
	if (!(${ERR_CODE})) {
		for ( ${i} = 1 ; ${i} -le ${LC_RETRY_COUNT} ; ${i}++ ) {
			if ( !${ERR_CODE} ) {
				Start-Sleep -s ${LC_RETRY_WAIT}
			} else {
				break
			}
			FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C���̍폜���������g���C���܂��B"
			if ((Test-Path ${script:LOCAL_IN_FILE1})) {
				FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]�̍폜���������g���C���܂��B"
				Remove-Item ${script:LOCAL_IN_FILE1} -Recurse 2>&1 > $null
				${ERR_CODE} = $?
			} else {
				FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]�͕ʂ̃v���Z�X�ɂč폜����܂����B"
				${ERR_CODE} = ${True}
			}
			if ((${ERR_CODE}) -and (${script:LOCAL_IN_FILE2} -ne "x")) {
				if ((Test-Path ${script:LOCAL_IN_FILE2})) {
					FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE2}]�̍폜���������g���C���܂��B"
					Remove-Item ${script:LOCAL_IN_FILE2} -Recurse 2>&1 > $null
					${ERR_CODE} = $?
				} else {
					FC_LogWriter 0 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE2}]�͕ʂ̃v���Z�X�ɂč폜����܂����B"
					${ERR_CODE} = ${True}
				}
			}
		}
	}
	if (!(${ERR_CODE})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		if (${PRM_FileName_2} -ne "x") {
			outmsg 55 ${PRG_EXIT_CODE} "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]�̍폜�Ɏ��s�����׈ُ�I�����܂��B"
			FC_LogWriter 1 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]�̍폜�Ɏ��s�����׈ُ�I�����܂��B"
		} else {
			outmsg 55 ${PRG_EXIT_CODE} "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]�̍폜�Ɏ��s�����׈ُ�I�����܂��B"
			FC_LogWriter 1 "�ꎞ�t�H���_�̖{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]�̍폜�Ɏ��s�����׈ُ�I�����܂��B"
		}
		EndProcess
	}
}


#--------------------------------------------
# NAS�ւ̓]�����s������
#--------------------------------------------
function LFC_NasTransferFailureProcess
{
	# �ۑ���f�B���N�g����NAS�]�����s���̈ꎞ�t�H���_�ɕύX
	${script:LOCAL_OUT_DIR} = ${TMP_FAILURES_DIR}  -creplace "@@INSTANCENAME@@", ${PRM_InstanceName}
	# �]����f�B���N�g���̃`�F�b�N
	if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "�]����f�B���N�g��[${script:LOCAL_OUT_DIR}]�����݂��Ȃ��׈ُ�I�����܂��B"
		FC_LogWriter 1 "�]����f�B���N�g��[${script:LOCAL_OUT_DIR}]�����݂��Ȃ��׈ُ�I�����܂��B"
		EndProcess
	}
	# �K�v�t�@�C���E�t�H���_�̑��݃`�F�b�N�����Ăяo��
	LFC_FileDirExistCheckProcess
	# NAS�����ꎞ�t�H���_�Ԃ̃t�@�C���R�s�[����
	LFC_NasLocalFileCopyProcess ($FALSE)
	# �]���Ώۃt�@�C���폜�����iregist�����̂݁j
	LFC_InFileDeleteProcess
	
	# %01 20240417�@�ێ�ۑ�Ή��@START
	#${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	# %01 20240417�@�ێ�ۑ�Ή��@END
	if (${PRM_FileName_2} -ne "x") {
		# %01 20240417�@�ێ�ۑ�Ή��@START
		#outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_[${script:LOCAL_OUT_DIR}]�֑ޔ����܂����B"
		outmsg 1 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_[${script:LOCAL_OUT_DIR}]�֑ޔ����܂����B"
		# %01 20240417�@�ێ�ۑ�Ή��@END
		FC_LogWriter 1 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_[${script:LOCAL_OUT_DIR}]�֑ޔ����܂����B"
	} else {
		# %01 20240417�@�ێ�ۑ�Ή��@START
		#outmsg 55 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_[${script:LOCAL_OUT_DIR}]�֑ޔ����܂����B"
		outmsg 1 ${PRG_EXIT_CODE} "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_[${script:LOCAL_OUT_DIR}]�֑ޔ����܂����B"
		# %01 20240417�@�ێ�ۑ�Ή��@END
		FC_LogWriter 1 "�{�l�m�F�����t�@�C��[${script:LOCAL_IN_FILE1}]��NAS�]���Ɏ��s�����׃t�@�C�����ꎞ�t�H���_[${script:LOCAL_OUT_DIR}]�֑ޔ����܂����B"
	}
	EndProcess
}

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
#--------------------------------------------
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# �����敪
if (${PRM_ShoriKbn} -ne "regist" -and ${PRM_ShoriKbn} -ne "reference") {
	${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	outmsg 55 ${PRG_EXIT_CODE} "�����敪�Ɍ�肪����׈ُ�I�����܂��B"
	FC_LogWriter 1 "�����敪�Ɍ�肪����׈ُ�I�����܂��B"
	EndProcess
}
# �C���X�^���X��
if (${PRM_InstanceName} -ne "brtabazb" -and ${PRM_InstanceName} -ne "brtabtrn") {
	${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	outmsg 55 ${PRG_EXIT_CODE} "�C���X�^���X���Ɍ�肪����׈ُ�I�����܂��B"
	FC_LogWriter 1 "�C���X�^���X���Ɍ�肪����׈ُ�I�����܂��B"
	EndProcess
}
# �t�@�C����1
if (${PRM_FileName_1} -eq "x") {
	${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	outmsg 55 ${PRG_EXIT_CODE} "�t�@�C�����̎w��Ɍ�肪����׈ُ�I�����܂��B"
	FC_LogWriter 1 "�t�@�C�����̎w��Ɍ�肪����׈ُ�I�����܂��B"
	EndProcess
} elseIf(${PRM_FileName_1}.Length -le 9) {
	${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	outmsg 55 ${PRG_EXIT_CODE} "�t�@�C�����̎w��Ɍ�肪����׈ُ�I�����܂��B"
	FC_LogWriter 1 "�t�@�C�����̎w��Ɍ�肪����׈ُ�I�����܂��B"
	EndProcess
} else {
	# ��t���t
	${script:LOCAL_RECEIPTDATE} = ${PRM_FileName_1}.Substring(0, 6)
}

#--------------------------------------------
# NAS�{�l�m�F�����ۑ���t�H���_���݃`�F�b�N
#--------------------------------------------
LFC_NasDirExistCheckProcess

#--------------------------------------------
# �K�v�t�@�C���E�t�H���_�̑��݃`�F�b�N����
#--------------------------------------------
LFC_FileDirExistCheckProcess

#--------------------------------------------
# NAS�����ꎞ�t�H���_�Ԃ̃t�@�C���R�s�[����
#--------------------------------------------
LFC_NasLocalFileCopyProcess ($TRUE)

#--------------------------------------------
# �]���Ώۃt�@�C���폜�����iregist�����̂݁j
#--------------------------------------------
if (${PRM_ShoriKbn} -eq "regist") {
	LFC_InFileDeleteProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
