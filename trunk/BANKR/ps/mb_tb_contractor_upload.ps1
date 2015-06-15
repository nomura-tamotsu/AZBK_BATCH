#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : �e���o���_��ҏ��A�b�v���[�h
#
# MODULE NAME   : mb_tb_contractor_upload
#
# INPUT         : None
#
# EXIT          : ����I�� �E�E�E NORMAL(0)
#                 �ُ�I�� �E�E�E ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 15/02/05 | �y�� �N��Y   | First Edition.                            
# %01 | 15/06/10 | �y�� �N��Y   | ���s�t�@�C�����ύX                        
#============================================================================
#============================================================================
# �֐���        mb_tb_contractor_info_upload-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_tb_contractor_info_upload-End-Function () {
	
	#
	# ����PS��EXITCODE���Z�[�u
	#
	$local_exit_code = $exit_code

	if ( $exit_code -eq $RC_OK ) {

		. $OUTMSG_CMD $NORMAL_END_MSG $exit_code $JOB_NAME
	}
	else {

		. $OUTMSG_CMD $ERROR_END_MSG $exit_code $JOB_NAME
	}

	exit $local_exit_code	
}

#
# ���ʃt�@�C���ݒ�
#
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$DefFile   = $scriptDir + "\def\EMB_DEF.ps1"
# ���ʃt�@�C�����s�iEMB_DEF.ps1�����s�j
. $DefFile

# �R�}���h���Z�b�g
$OUTMSG_CMD    = $SCRIPT_DIR + "\outmsg.ps1"


# �������Z�b�g
$BATNAME  = "mb_tb_contractor_upload"
$JOB_NAME = "�e���o���_��ҏ��A�b�v���[�h"

# exit�R�[�h������
$exit_code   = $RC_OK


# �J�n���b�Z�[�W
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****�e���o���_��ҏ��A�b�v���[�h�J�n*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# �e���o���_��ҏ��t�@�C�������Z�b�g
#---------------------------------------
$OUTPUT_DATA_FILE = "$EXT_UPLOAD_DIR\" + $M_TB_CONTRACT_BASE + ".dat"

#---------------------------------------
# �e���o���_��ҏ��t�@�C�����݃`�F�b�N
#  (�����M�t�@�C���`�F�b�N)
#---------------------------------------
if ( ( Test-Path $OUTPUT_DATA_FILE ) ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	. $OUTMSG_CMD $FILE_NOT_SEND_MSG $RC_NG $OUTPUT_DATA_FILE
	$exit_code = $RC_NG
	mb_tb_contractor_info_upload-End-Function
}

#---------------------------------------
# �e���o���_��ҏ��f�[�^�̒��o���s
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "�e���o���_��ҏ��̒��o���J�n���܂��D"

$rc=TbContractorInfoExport $OUTPUT_DATA_FILE
$ret=$?
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "�e���o���_��ҏ��̒��o�ŃG���[���������܂���"

	if ( ( Test-Path $OUTPUT_DATA_FILE ) ) {
		# �G���[���́A�f�[�^�t�@�C����ޔ�
		#  �i�t�@�C����.YYYYMMDDHHMISS�̌`���őޔ��f�B���N�g���ցj


		# DATE�֘A�ϐ���`
		$now   = Get-Date
		$date  = $now.ToString("yyyyMMdd")
		$time  = $now.ToString("HHmmss")

		# �t�@�C�����̂ݎ擾
		$new_file_name = split-path $OUTPUT_DATA_FILE  -Leaf

		# �ޔ��t�@�C�����쐬
		$new_file_name = $EXT_UPLOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


		# Move ���s
		$rc = Move-Item $OUTPUT_DATA_FILE $new_file_name -force 2>&1
		$ret=$?
		if ( $ret -ne "TRUE" ) {
	       		. $OUTMSG_CMD $COM_ERROR $RC_NG "�f�[�^�t�@�C���ޔ�($OUTPUT_DATA_FILE)�ŃG���[���������܂���"
			$exit_code=$RC_NG
			mb_tb_contractor_info_upload-End-Function
		}
		. $OUTMSG_CMD $INFO_MSG $RC_OK "�G���[�f�[�^�t�@�C����ޔ����܂���($new_file_name)"
	}

	$exit_code = $RC_NG
	mb_tb_contractor_info_upload-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "�e���o���_��ҏ��A�b�v���[�h�������I�����܂����D"




#---------------------------------------
# �I������
#---------------------------------------
mb_tb_contractor_info_upload-End-Function