#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : hulft�z�M����
#
# MODULE NAME   : mb_hulft_send
#
# INPUT         : $Args[0] �E�E�E hulft�t�@�C��ID
#
# EXIT          :  ����I�� �E�E�E NORMAL(0)
#                  �ُ�I�� �E�E�E ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# �֐���        Get-Hulft-Information
# �T�v          HULFT���擾
# ����          �Ȃ�
# �߂�l        ���M�t�@�C�����i�t���p�X�j
# �߂�l�^      �Ȃ�
#============================================================================
function Get-Hulft-Information () {

	#
	# HULFT��`�t�@�C�����݃`�F�b�N
	#
	if ( -not ( Test-Path $HulftConfig ) ) {
        	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $HulftConfig
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}

	# ��`�t�@�C������t�@�C��ID����
	$result_str = Get-Content $HulftConfig | grep $file_id
	if ( $result_str -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "�t�@�C��ID=$file_id(�t�@�C��ID��������܂���)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}

	#
	# ������𕪉����Ă��ꂼ��ϐ��ɃZ�b�g
	#
	# 1.����
	$ary_str  = $result_str -split " "
	
	# 2.FILE ID�Z�b�g
	$local_file_id   = $ary_str[0]
	if ( $local_file_id  -ne $file_id ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "�t�@�C��ID=$file_id(�t�@�C��ID�̈ʒu�s��)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}
	
	# 2.�t�@�C���敪�Z�b�g
	$file_class = $ary_str[1]
	if ( $file_class  -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "�t�@�C��ID=$file_id(�t�@�C���敪�擾�s�\)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}

	# 3.���M�t�@�C�����Z�b�g
	$send_file_name = $ary_str[2]
	if ( $send_file_name -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "�t�@�C��ID=$file_id(���M�t�@�C�����擾�s�\)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}

	# ���M�t�@�C�����t���p�X�Z�b�g
	# �t�@�C���敪����
	switch ( $file_class ){
    		# CRM�敪
    		$ClassCRM {
			$folder_name = "\" + $FolderCRM + "\"
        		break
    		}
    		# HOST�敪
    		$ClassHOST {
			$folder_name = "\" + $FolderHOST + "\"

        		break
    		}
    		# IB�敪
    		$ClassIB {
			$folder_name = "\" + $FolderIB + "\"
        		break
    		}
		# ���̑����b�Z�[�W�o��
    		default {
			. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "�t�@�C��ID=$file_id(�t�@�C���敪�s��)"
			$exit_code=$RC_NG
			mb_hulft_send-End-Function
        		break
    		}

	}
	
	$r_send_file_name = $EXT_UPLOAD_DIR + $folder_name + $send_file_name	

	return $r_send_file_name

}

#============================================================================
# �֐���        mb_hulft_send-Check-Argument
# �T�v          �����`�F�b�N����
# ����          �Ȃ�
# �߂�l        �Ȃ�
# �߂�l�^      �Ȃ�
#============================================================================
function mb_hulft_send-Check-Argument () {

	# �������`�F�b�N
	if ( $argc -ne 1 ) { #�p�����[�^��1�łȂ���
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT $RC_NG
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}


	# �������`�F�b�N(�����O�X�`�F�b�N:3Byte)
	if ( $file_id.length -ne $FileIdLength ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "�t�@�C��ID=$file_id(�����O�X�s��)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}


}


#============================================================================
# �֐���        mb_hulft_send-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_hulft_send-End-Function () {
	
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

#============================================================================
# ��������
#============================================================================
#
# ���ʃt�@�C���ݒ�
#
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$DefFile   = $scriptDir + "\def\EMB_DEF.ps1"
# ���ʃt�@�C�����s�iEMB_DEF.ps1�����s�j
. $DefFile

# �R�}���h���Z�b�g
$OUTMSG_CMD    = $scriptDir + "\outmsg.ps1"

# �������Z�b�g
$BATNAME  = "mb_hulft_send"
$JOB_NAME = "hulft�z�M����"


#
# exit�R�[�h������
#
$exit_code = $RC_OK



#
# �����ޔ�
#
$file_id  = $Args[0]

#
# �������Z�b�g
#
$argc = $args.length

# �J�n���b�Z�[�W
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****hulft�z�M����*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


#
# �����̃`�F�b�N
#
mb_hulft_send-Check-Argument


#
# HULFT�����擾(��`�t�@�C���ǂݍ���)
#
$g_send_file_name = Get-Hulft-Information


# ============================================================================
# ���C������
# ============================================================================

#
# hulft���M
#
##$rc = utlsend -f $file_id -sync -w 259200 2>&1

# �e�X�g�p�Ƀ_�~�[�R�}���h�g�p
$rc = dir d:\extdata 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "HULFT���M($file_id)�ŃG���[���������܂���"
	$exit_code=$RC_NG
	mb_hulft_send-End-Function
}



#
# ���M�t�@�C����ޔ��i�t�@�C����.YYYYMMDDHHMISS�̌`���őޔ��f�B���N�g���ցj
#

# DATE�֘A�ϐ���`
$now   = Get-Date
$date  = $now.ToString("yyyyMMdd")
$time  = $now.ToString("HHmmss")

# �t�@�C�����̂ݎ擾
$new_file_name = split-path $g_send_file_name  -Leaf

# �ޔ��t�@�C�����쐬
$new_file_name = $EXT_UPLOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


# Move ���s
$rc = Move-Item $g_send_file_name $new_file_name -force 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "���M�t�@�C���ޔ�($file_id)�ŃG���[���������܂���"
	$exit_code=$RC_NG
	mb_hulft_send-End-Function
}


mb_hulft_send-End-Function
