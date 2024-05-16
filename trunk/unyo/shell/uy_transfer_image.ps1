#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2020
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �{�l�m�F�����^�X�N�X�P�W���[���N������
#
# FILE      : uy_transfer_image.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 20/10/09 | A.MIYAMOTO      | First Eddition
# %01 | 24/04/17 | A.MIYAMOTO      | �Q�Ǝ��̃^�C���A�E�g�l��20�b����60�b�֕ύX
#============================================================================

#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
#[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [string]${PRM_1}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_2}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_3}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_4}="x"
)

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
# ���g���C��������p�ϐ�
# %01 20240417�@�ێ�ۑ�Ή��@START
#${LC_RETRY_COUNT} = 20
${LC_RETRY_COUNT} = 60
# %01 20240417�@�ێ�ۑ�Ή��@END
${LC_RETRY_WAIT}  = 1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
#--------------------------------------------
# �^�X�N�X�P�W���[���̃T�[�r�X�擾
$TaskService = New-Object -ComObject schedule.service
# �^�X�N�X�P�W���[���̃T�[�r�X�ڑ�
$TaskService.Connect()
# �^�X�N�X�P�W���[���̃W���u�t�H���_�擾
$Folder=$TaskService.GetFolder("\")
# �^�X�N�X�P�W���[���̃W���u�擾
$Task=$Folder.GetTask("�{�l�m�F�����o�^�Q��")
# �^�X�N�X�P�W���[�����N������ۂ̃p�����[�^�ݒ�
[String[]]$Param=${PRM_1},${PRM_2},${PRM_3},${PRM_4}
# �^�X�N�X�P�W���[�����s
$Task.Run($Param)

# �Q�Ə����̏ꍇ�̂ݓ]���t�@�C���̑��݃`�F�b�N���{
if (${PRM_1} -eq "reference" ) {
	# �Q�Ǝ��t�H���_�̃p�X�𐶐�
	${script:LOCAL_OUT_DIR} = ${TMP_REFERENCE_DIR} -creplace "@@INSTANCENAME@@", ${PRM_2}
	# �{�l�m�F�����t�@�C��1�̃p�X
	${script:LOCAL_OUT_FILE1} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_3}
	# �{�l�m�F�����t�@�C��2�̃p�X
	${script:LOCAL_OUT_FILE2} = "x"
	if (${PRM_4} -ne "x") {
		${script:LOCAL_OUT_FILE2} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_4}
	} else {
		${script:LOCAL_OUT_FILE2} = "x"
	}

	# ${LC_RETRY_WAIT}�Ɏw�肵�Ă���Ԋu�œ]�������t�@�C���̑��݃`�F�b�N�����{����
	for ( ${i} = 1 ; ${i} -le ${LC_RETRY_COUNT} ; ${i}++ ) {
		# �X���[�v
		Start-Sleep -s ${LC_RETRY_WAIT}
		if (${script:LOCAL_OUT_FILE2} -eq "x") {
			if ( (Test-Path ${script:LOCAL_OUT_FILE1}) ) {
				# �t�@�C�������݁i�]�������j���Ă�����A1�b�X���[�v�㐳��I��
				Start-Sleep -s ${LC_RETRY_WAIT}
				exit 0
			} else {
				# �t�@�C�������݂��Ȃ��ꍇ�i�]�����j�̏ꍇ�A���������Ƀ��[�v�������s
			}
		} else {
			if ( (Test-Path ${script:LOCAL_OUT_FILE1}) -and (Test-Path ${script:LOCAL_OUT_FILE2}) ) {
				# �t�@�C�������݁i�]�������j���Ă�����A1�b�X���[�v�㐳��I��
				Start-Sleep -s ${LC_RETRY_WAIT}
				exit 0
			} else {
				# �t�@�C�������݂��Ȃ��ꍇ�i�]�����j�̏ꍇ�A���������Ƀ��[�v�������s
			}
		}
	}
	# �t�@�C�������݂��Ȃ��܂܃��[�v�𔲂����i�]�����E�]�����s�Ȃǁj�ꍇ�A�ُ�I��
	exit 9
}
