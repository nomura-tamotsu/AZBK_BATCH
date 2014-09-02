#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : �S��f�[�^�捞
#
# MODULE NAME   : mb_jbdata_reflect
#
# INPUT         : None
#
# EXIT          : ����I�� �E�E�E NORMAL(0)
#                 �ُ�I�� �E�E�E ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/24 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# �֐���        mb_jbdata_reflect-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_jbdata_reflect-End-Function () {
	
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
$CREATE_VIEW   = $SCRIPT_DIR + "\mb_create_view.ps1"
. $CREATE_VIEW

# �������Z�b�g
$BATNAME  = "mb_jbdata_reflect"
$JOB_NAME = "�S��f�[�^�捞"

# exit�R�[�h������
$exit_code   = $RC_OK


# �J�n���b�Z�[�W
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****�S��f�[�^�捞�J�n*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# �S��f�[�^�����Z�b�g
#---------------------------------------
$JBANK_DATA_FILE = "$EXT_LOAD_DIR\" + $M_BANK_BASE + ".dat"
$VIEW_NAME  = $JBANK_VIEWNAME
$BASE_NAME  = $JBANK_BASE_TBNAME
$BASE_NAME2 = $JBANK_BASE_TBNAME2


#---------------------------------------
# �S��f�[�^���݃`�F�b�N
#---------------------------------------
if ( -not ( Test-Path $JBANK_DATA_FILE ) ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $JBANK_DATA_FILE

	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function
}


#-------------------------------------------------------------------------------
# �r���[�`�F�b�N����
#   (�I���R�[�h�Ńn���h�����O�������̂ŁAStart-process���g�p����)
#   �R�[�����O�V�[�P���X:CheckView �r���[�� ���e�[�u����
#-------------------------------------------------------------------------------
$view_check_cmd = "CheckView"
$view_check_arg = "$VIEW_NAME $BASE_NAME"

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



$TARGET_VIEW_BASE = $SQL_VIEW_JBANK_BASE
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
	mb_jbdata_reflect-End-Function
}



#---------------------------------------
# �S��f�[�^�t�@�C��
#  �x�[�X�l�[�����Z�b�g
#---------------------------------------
$M_BASE_NAME = $M_BANK_BASE

# �e�[�u����
$TABLE_NAME    = $BASE_NAME  + $TARGET_SUFFIX
$TABLE_NAME2   = $BASE_NAME2 + $TARGET_SUFFIX

# �f�[�^�t�@�C��
$DAT_FILE      = $EXT_LOAD_DIR+ "\" + $M_BASE_NAME + ".dat"

# ���O�t�@�C��
$JBANK_LOG_FILE = $TMP_DIR + "\" + $M_BASE_NAME + ".log"


#echo $TABLE_NAME

#---------------------------------------
# �S��f�[�^�捞���s
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "�S��f�[�^�捞���J�n���܂��D"

$rc=UpdateJBData $DAT_FILE $JBANK_LOG_FILE $TABLE_NAME $TABLE_NAME2
$ret=$?
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "�S��f�[�^�捞�ŃG���[���������܂���"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "�S��f�[�^�捞���I�����܂����D"


#---------------------------------------
# �e�[�u��Analyze(��s)
#---------------------------------------
$rc=AnalyzeTables $TABLE_NAME
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "Analyze�ŃG���[���������܂���($TABLE_NAME)"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function

}
#---------------------------------------
# �e�[�u��Analyze(�x�X)
#---------------------------------------
$rc=AnalyzeTables $TABLE_NAME2
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "Analyze�ŃG���[���������܂���($TABLE_NAME2)"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function

}


#echo ("TARGET_VIEW_BASE=" + $TARGET_VIEW_BASE)

#echo ("TARGE_VIEW=" + $TARGE_VIEW)




#---------------------------------------
# �r���[�؂�ւ�
#---------------------------------------
$rc = mb_create_view  $TARGET_VIEW_BASE $TARGE_VIEW
if ( $rc -ne $RC_OK ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "�r���[�؂�ւ��ŃG���[���������܂���($VIEW_NAME)"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function

}


#
# �f�[�^�t�@�C����ޔ��i�t�@�C����.YYYYMMDDHHMISS�̌`���őޔ��f�B���N�g���ցj
#

# DATE�֘A�ϐ���`
$now   = Get-Date
$date  = $now.ToString("yyyyMMdd")
$time  = $now.ToString("HHmmss")

# �t�@�C�����̂ݎ擾
$new_file_name = split-path $JBANK_DATA_FILE  -Leaf

# �ޔ��t�@�C�����쐬
$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


# Move ���s
$rc = Move-Item $JBANK_DATA_FILE $new_file_name -force 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "�f�[�^�t�@�C���ޔ�($JBANK_DATA_FILE)�ŃG���[���������܂���"
	$exit_code=$RC_NG
	mb_jbdata_reflect-End-Function
}


#---------------------------------------
# �I������
#---------------------------------------
mb_jbdata_reflect-End-Function