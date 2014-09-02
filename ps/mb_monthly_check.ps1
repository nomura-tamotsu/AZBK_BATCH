#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : ���������`�F�b�N
#
# MODULE NAME   : mb_monthly_check
#
# INPUT         : �Ȃ�
#
# EXIT          :  ����������       �E�E�E NORMAL(0)
#                  �����������łȂ� �E�E�E ERROR (1)
#                  �ُ�I��         �E�E�E ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/18 | ISID        | First Edition.                            
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
	# �z�u�����i�����j�t�@�C����ޔ��i�t�@�C����.YYYYMMDDHHMISS�̌`���őޔ��f�B���N�g���ցj
	#

	# DATE�֘A�ϐ���`
	$now   = Get-Date
	$date  = $now.ToString("yyyyMMdd")
	$time  = $now.ToString("HHmmss")

	# �t�@�C�����̂ݎ擾
	$new_file_name = split-path $MONTHLY_END_FILE  -Leaf

	# �ޔ��t�@�C�����쐬
	$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


	# Move ���s
	$rc = Move-Item $MONTHLY_END_FILE $new_file_name -force 2>&1
	$ret=$?
	if ( $ret -ne "TRUE" ) {
       		. $OUTMSG_CMD $COM_ERROR $RC_NG "�z�u�����i�����j�t�@�C���ޔ��ŃG���[���������܂���"
		$exit_code=$RC_NG
		mb_monthly_check-End-Function
	}

}



#============================================================================
# �֐���        mb_monthly_check-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_monthly_check-End-Function () {
	
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
$BATNAME  = "mb_monthly_check"
$JOB_NAME = "���������`�F�b�N "


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
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****���������`�F�b�N����*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


#
# �����̃`�F�b�N
#





# ============================================================================
# ���C������
# ============================================================================
#
# �z�u�����i�����j�t�@�C�����݃`�F�b�N
#
if ( -not ( Test-Path $MONTHLY_END_FILE ) ) {
	# �����������ł͂Ȃ����b�Z�[�W
       	. $OUTMSG_CMD $NOT_EXECUTE_DAY $RC_OK "����"

	$exit_code = $RC_WARNING
	mb_monthly_check-End-Function
}
else {
	# �����������̃��b�Z�[�W
       	. $OUTMSG_CMD $EXECUTE_DAY $RC_OK "����"
	
	# �z�u�����i�����j�t�@�C����ޔ�
	Endfile-Rename

}


#
# �I������
#
mb_monthly_check-End-Function
