#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : �T�������`�F�b�N
#
# MODULE NAME   : mb_weekly_check
#
# INPUT         : �Ȃ�
#
# EXIT          :  �T��������       �E�E�E NORMAL(0)
#                  �T���������łȂ� �E�E�E ERROR (1)
#                  �ُ�I��         �E�E�E ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/24 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# �֐���        Endfile-Rename
# �T�v          �t�@�C����ޔ�
# ����          �Ȃ�
# �߂�l        �Ȃ�
# �߂�l�^      �Ȃ�
#============================================================================
function Endfile-Rename () {
	#
	# �z�u�����i�T���j�t�@�C����ޔ��i�t�@�C����.YYYYMMDDHHMISS�̌`���őޔ��f�B���N�g���ցj
	#

	# DATE�֘A�ϐ���`
	$now   = Get-Date
	$date  = $now.ToString("yyyyMMdd")
	$time  = $now.ToString("HHmmss")

	# �t�@�C�����̂ݎ擾
	$new_file_name = split-path $WEEKLY_END_FILE  -Leaf

	# �ޔ��t�@�C�����쐬
	$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


	# Move ���s
	$rc = Move-Item $WEEKLY_END_FILE $new_file_name -force 2>&1
	$ret=$?
	if ( $ret -ne "TRUE" ) {
       		. $OUTMSG_CMD $COM_ERROR $RC_NG "�z�u�����i�T���j�t�@�C���ޔ��ŃG���[���������܂���"
		$exit_code=$RC_NG
		mb_weekly_check-End-Function
	}

}



#============================================================================
# �֐���        mb_weekly_check-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_weekly_check-End-Function () {
	
	#
	# ����PS��EXITCODE���Z�[�u
	#
	$local_exit_code = $exit_code

	if ( $exit_code -eq $RC_OK ) {

		. $OUTMSG_CMD $NORMAL_END_MSG $exit_code $JOB_NAME
	}
	elseif ( $exit_code -eq $RC_WARNING ) {

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
$BATNAME  = "mb_weekly_check"
$JOB_NAME = "�T�������`�F�b�N "


#
# exit�R�[�h������
#
$exit_code = $RC_OK


#
# �����ޔ�
#


#
# �������Z�b�g
#

# �J�n���b�Z�[�W
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****�T�������`�F�b�N����*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


#
# �����̃`�F�b�N
#





# ============================================================================
# ���C������
# ============================================================================
#
# �z�u�����i�T���j�t�@�C�����݃`�F�b�N
#
if ( -not ( Test-Path $WEEKLY_END_FILE ) ) {
	# �T���������ł͂Ȃ����b�Z�[�W
       	. $OUTMSG_CMD $NOT_EXECUTE_DAY $RC_OK "�T��"

	$exit_code = $RC_WARNING
	mb_weekly_check-End-Function
}
else {
	# �T���������̃��b�Z�[�W
       	. $OUTMSG_CMD $EXECUTE_DAY $RC_OK "�T��"
	
	# �z�u�����i�T���j�t�@�C����ޔ�
	Endfile-Rename

}


#
# �I������
#
mb_weekly_check-End-Function
