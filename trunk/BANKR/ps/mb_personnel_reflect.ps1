#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : �l�����f�[�^�捞
#
# MODULE NAME   : mb_personnel_reflect
#
# INPUT         : None
#
# EXIT          : ����I�� �E�E�E NORMAL(0)
#                 �ُ�I�� �E�E�E ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/04/16 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# �֐���        mb_personnel_reflect-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_personnel_reflect-End-Function () {
	
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
$BATNAME  = "mb_personnel_reflect"
$JOB_NAME = "�l�����f�[�^�捞"

# exit�R�[�h������
$exit_code   = $RC_OK


# �J�n���b�Z�[�W
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****�l�����f�[�^�捞�J�n*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# �l�����f�[�^�����Z�b�g
#---------------------------------------
$PERSONNEL_DATA_FILE = "$EXT_LOAD_DIR\" + $M_PERSONNEL_BASE + ".dat"

#---------------------------------------
# �l�����f�[�^���݃`�F�b�N
#---------------------------------------
if ( -not ( Test-Path $PERSONNEL_DATA_FILE ) ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $PERSONNEL_DATA_FILE

	$exit_code = $RC_NG
	mb_personnel_reflect-End-Function
}

#---------------------------------------
# �l�����f�[�^�t�@�C��
#  ���O�t�@�C��/�e�[�u�������Z�b�g
#---------------------------------------
# �e�[�u����
$TABLE_NAME    = $PERSONNEL_BASE_TBNAME
$M_BASE_NAME   = $M_PERSONNEL_BASE

# �f�[�^�t�@�C��
$DAT_FILE      = $EXT_LOAD_DIR+ "\" + $M_BASE_NAME + ".dat"

# ���O�t�@�C��
$LOG_FILE = $TMP_DIR + "\" + $M_BASE_NAME + ".log"


#---------------------------------------
# �l�����f�[�^�捞���s
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "�l�����f�[�^�捞���J�n���܂��D"

$rc=DailyPersonnel $DAT_FILE $LOG_FILE
$ret=$?
#$ret="True"
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "�l�����f�[�^�捞�ŃG���[���������܂���"
	$exit_code = $RC_NG
	mb_personnel_reflect-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "�l�����f�[�^�捞���I�����܂����D"


#---------------------------------------
# �e�[�u��Analyze
#---------------------------------------
$rc=AnalyzeTables $TABLE_NAME
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "Analyze�ŃG���[���������܂���($TABLE_NAME)"
	$exit_code = $RC_NG
	mb_personnel_reflect-End-Function

}


#
# �f�[�^�t�@�C����ޔ��i�t�@�C����.YYYYMMDDHHMISS�̌`���őޔ��f�B���N�g���ցj
#

# DATE�֘A�ϐ���`
$now   = Get-Date
$date  = $now.ToString("yyyyMMdd")
$time  = $now.ToString("HHmmss")

# �t�@�C�����̂ݎ擾
$new_file_name = split-path $PERSONNEL_DATA_FILE  -Leaf

# �ޔ��t�@�C�����쐬
$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


# Move ���s
$rc = Move-Item $PERSONNEL_DATA_FILE $new_file_name -force 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "�f�[�^�t�@�C���ޔ�($PERSONNEL_DATA_FILE)�ŃG���[���������܂���"
	$exit_code=$RC_NG
	mb_personnel_reflect-End-Function
}


#---------------------------------------
# �I������
#---------------------------------------
mb_personnel_reflect-End-Function