#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : ���ё����f�[�^���[�h
#
# MODULE NAME   : mb_household_load
#
# INPUT         : None
#
# EXIT          : ����I�� �E�E�E NORMAL(0)
#                 �ُ�I�� �E�E�E ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 15/01/19 | �y�� �N��Y   | First Edition.                            
#============================================================================
#============================================================================
# �֐���        mb_attribute_load-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_attribute_load-End-Function () {
	
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


# �֐����Z�b�g�����[�h
$LOAD_EXTERNAL = $SCRIPT_DIR + "\mb_load_external_data.ps1"
$CREATE_VIEW   = $SCRIPT_DIR + "\mb_create_view.ps1"
. $LOAD_EXTERNAL
. $CREATE_VIEW

# �������Z�b�g
$BATNAME  = "mb_household_load"
$JOB_NAME = "���ё����f�[�^���[�h"

# exit�R�[�h������
$exit_code   = $RC_OK


# �J�n���b�Z�[�W
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****���ё����f�[�^���[�h�J�n*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# ���ё����f�[�^�t�@�C�������Z�b�g
#---------------------------------------
$HOUSEHOLD_DATA_FILE = "$EXT_LOAD_DIR\" + $M_HOUSEHOLD_BASE + ".dat"
$VIEW_NAME = $HOUSEHOLD_BASE_VIEWNAME

#---------------------------------------
# ���ё����f�[�^�t�@�C�����݃`�F�b�N
#---------------------------------------
if ( -not ( Test-Path $HOUSEHOLD_DATA_FILE ) ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $HOUSEHOLD_DATA_FILE

	$exit_code = $RC_NG
	mb_attribute_load-End-Function
}

#---------------------------------------
# ���ё����f�[�^�t�@�C���T�C�Y�`�F�b�N
#---------------------------------------
$filesize=$(Get-ChildItem $HOUSEHOLD_DATA_FILE).Length

#�@�t�@�C���T�C�Y�� 0 �o�C�g�̏ꍇ�̓G���[
if ( $filesize  -eq 0 ) {
	$ADD_MSG = "�t�@�C���T�C�Y�� 0 �o�C�g�ł�("+ $HOUSEHOLD_DATA_FILE + ")"

	. $OUTMSG_CMD $COM_ERROR $RC_NG $ADD_MSG
	$exit_code = $RC_NG
	mb_attribute_load-End-Function
}

#-------------------------------------------------------------------------------
# �r���[�`�F�b�N����
#   (�I���R�[�h�Ńn���h�����O�������̂ŁAStart-process���g�p����)
#   �R�[�����O�V�[�P���X:CheckView �r���[��
#-------------------------------------------------------------------------------
$view_check_cmd = "CheckView"
$view_check_arg = $VIEW_NAME

#-------------------------------------------------------------------------------
# $view_check_cmd �Ƃ����A�v�������� $view_check_arg �Ŏ��s���A�I������܂őҋ@
#-------------------------------------------------------------------------------
$process = Start-Process $view_check_cmd $view_check_arg -PassThru -Wait -WindowStyle  Hidden
#-------------------------------------------------------------------------------
# �I���R�[�h�̎擾
#-------------------------------------------------------------------------------
$ret = $process.ExitCode
#-------------------------------------------------------------------------------
# ���\�[�X�̔j��
#-------------------------------------------------------------------------------
$process.Close()

$TARGET_VIEW_BASE = $SQL_VIEW_HOUSEHOLD_BASE
if ( $ret -eq $VIEW_A ) {
	$TARGET_SUFFIX = $TABLE_SUFFIX_B
	$TARGE_VIEW    = $VIEW_B
}
elseif ( $ret -eq $VIEW_B ) {
	$TARGET_SUFFIX = $TABLE_SUFFIX_A
	$TARGE_VIEW    = $VIEW_A
}
else {
	. $OUTMSG_CMD $COM_ERROR $RC_NG "�r���[�`�F�b�N�����ŃG���[���������܂���"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function
}

#---------------------------------------
# ���ё����f�[�^�t�@�C��
#  �x�[�X�l�[�����Z�b�g
#---------------------------------------
$M_BASE_NAME = $M_HOUSEHOLD_BASE

# �R���g���[���t�@�C��
$CTL_FILE      = $CTL_FILE_DIR + "\M_HOUSEHOLD_" + $TARGET_SUFFIX + ".ctl"

# �e�[�u����
$TABLE_NAME    = $VIEW_NAME + $TARGET_SUFFIX

# �f�[�^�t�@�C��
$DAT_FILE      = $EXT_LOAD_DIR+ "\" + $M_BASE_NAME + ".dat"

# BAD�t�@�C��
$BAD_FILE      = $TMP_DIR + "\" + $M_BASE_NAME + ".bad"

# DISCARD�t�@�C��
$DIS_FILE      = $TMP_DIR + "\" + $M_BASE_NAME + ".dis"

# ���O�t�@�C��
$LOAD_LOG_FILE = $TMP_DIR + "\" + $M_BASE_NAME + ".log"

#---------------------------------------
# SQL���[�h���s
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "���ё����f�[�^�t�@�C�����[�h���J�n���܂��D"

#---------------------------------------
#. $LOAD_EXTERNAL
#---------------------------------------
$rc = mb_load_external_data  $CTL_FILE $DAT_FILE $BAD_FILE $DIS_FILE $LOAD_LOG_FILE

if ( $rc -ne $RC_OK ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "���[�h���s�ŃG���[���������܂���"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "���ё����f�[�^�t�@�C�����[�h���I�����܂����D"


#---------------------------------------
# �e�[�u��Analyze
#---------------------------------------
$rc=AnalyzeTables $TABLE_NAME
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "Analyze�ŃG���[���������܂���($TABLE_NAME)"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function

}

#---------------------------------------
# �r���[�؂�ւ�
#---------------------------------------
$rc = mb_create_view  $TARGET_VIEW_BASE $TARGE_VIEW
if ( $rc -ne $RC_OK ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "�r���[�؂�ւ��ŃG���[���������܂���($TABLE_NAME)"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function

}

#---------------------------------------
# ���[�f�B���O���̍X�V
#---------------------------------------
$rc=LoadingInfomation $VIEW_NAME
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "���[�f�B���O���X�V�ŃG���[���������܂���($VIEW_NAME)"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function

}


#
# ���[�h�t�@�C����ޔ��i�t�@�C����.YYYYMMDDHHMISS�̌`���őޔ��f�B���N�g���ցj
#

# DATE�֘A�ϐ���`
$now   = Get-Date
$date  = $now.ToString("yyyyMMdd")
$time  = $now.ToString("HHmmss")

# �t�@�C�����̂ݎ擾
$new_file_name = split-path $HOUSEHOLD_DATA_FILE  -Leaf

# �ޔ��t�@�C�����쐬
$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


# Move ���s
$rc = Move-Item $HOUSEHOLD_DATA_FILE $new_file_name -force 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "���[�h�t�@�C���ޔ�($HOUSEHOLD_DATA_FILE)�ŃG���[���������܂���"
	$exit_code=$RC_NG
	mb_attribute_load-End-Function
}


#---------------------------------------
# �I������
#---------------------------------------
mb_attribute_load-End-Function