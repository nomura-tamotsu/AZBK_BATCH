#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : ���엚���o�b�N�A�b�v
#
# MODULE NAME   : mb_export_operation_history
#
# INPUT         : None
#
# EXIT          : ����I�� �E�E�E NORMAL(0)
#                 �ُ�I�� �E�E�E ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/05/12 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# �֐���        Delete-file
# �T�v          �t�@�C���폜����
# ����          $file_name �t�@�C����
# �߂�l        $RC_OK,$RC_NG
# �߂�l�^      �Ȃ�
#============================================================================
function Delete-file ( [string] $file_name ) {

    #
    # �t�@�C���̑��݊m�F
    #
    if ( -not ( Test-Path $file_name ) ) {
        # ���݂��Ȃ��̂ō폜��������
        return $RC_OK
    }
    
    #
    # �t�@�C�����ʃ`�F�b�N
    #
    $rc = Get-ChildItem  $file_name | Where-Object { -not $_.PSIsContainer} | format-list name
    if ( $rc -eq $null ) {
        # �t�H���_�̏ꍇ�͍폜����
        return $RC_OK
    }

    #
    # �폜���s
    #
    $errorObject = rm -Force  $file_name  2>&1
    
    # �G���[�n���h�����O
    if ( $errorObject -eq $null ) {
        return $RC_OK
    }
    else {
        # �G���[���b�Z�[�W���t�@�C���ɏo��
        echo $errorObject > $TMP_DIR\tempe.log
        return $RC_NG
    }

}

#============================================================================
# �֐���        mb_export_operation_history-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_export_operation_history-End-Function () {
	
	#
	# ����PS��EXITCODE���Z�[�u
	#
	$local_exit_code = $exit_code

	if ( $exit_code -eq $RC_OK ) {

		. $OUTMSG_CMD $NORMAL_END_MSG $exit_code $JOB_NAME
	}
	else {
		#�@
		# �폜�������s�O�ɃG���[�̏ꍇ�́A���o�f�[�^�t�@�C���폜
		#  ���폜�������s��́A�����R�~�b�g������̂ŁA�f�[�^�t�@�C�����폜�ł��Ȃ�
		#
		if ( ( $rm_end_flag -eq 0 ) -And ( Test-Path $OPE_EXP_FILE ) ) {
			$rc = Delete-file ( $OPE_EXP_FILE )
			. $OUTMSG_CMD $INFO_MSG $RC_OK "�G���[�����������̂Ńf�[�^�t�@�C�����폜���܂���(RemoveOldOperationHistory���s�O)"
		}

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
$BATNAME  = "mb_export_operation_history"
$JOB_NAME = "���엚���o�b�N�A�b�v"

# exit�R�[�h������
$exit_code   = $RC_OK

# �폜�����I���t���O������
$rm_end_flag = 0



# �J�n���b�Z�[�W
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****���엚���o�b�N�A�b�v�J�n*****"

#
# �V�X�e�������`�F�b�N 
# ���o���Ă��Ȃ��f�[�^�̍폜��h�����߁A���t�ύX�O�͏����s��Ȃ�
# �@�i23:00�`24:00�̊ԃX���[�v�j
#

while(1) {
	$now   = Get-Date
	$nowtime  = $now.ToString("HHmmss")

	if ( $nowtime -lt $OPE_BACKUP_TO ) {
		. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME
		break
	}

	# $OPE_BACKUP_SLEEP�b�ҋ@���܂��B
	$SLEEP_MSG="*****���s���Ԃ܂ŃX���[�v���܂�(" + $OPE_BACKUP_SLEEP + "�b)*****"
	. $OUTMSG_CMD $INFO_MSG $RC_OK $SLEEP_MSG
 	Start-Sleep -Seconds $OPE_BACKUP_SLEEP
}

#---------------------------------------
#  ���o�t�@�C�������Z�b�g
#---------------------------------------
# DATE�֘A�ϐ���`
$now   = Get-Date
$date  = $now.ToString("yyyy_MM_dd_")
$time  = $now.ToString("HHmmss")

# ���o�t�@�C����
$OPE_EXP_FILE = $OPE_EXP_BASE + "." + $date + $time

#
# DB�p�X���[�h�̕�����
#
$DB_PWD_DECODE = PDECODE $DB_NAME $DB_UID
if ( $ORACLE_TNS -ne $null ) {	
	$DB_PWD_DECODE=$DB_PWD_DECODE + "@" + $ORACLE_TNS
}

#
# ���O�t�@�C���폜
#
$rc = Delete-file ( $OPE_LOG_FILE )

#-------------------------------------------------------------------------------
# �o�b�N�A�b�v�iEXP�j�����s
#-------------------------------------------------------------------------------

#
# ���o�������Z�b�g
#
$where_phase="'WHERE ������� < TO_DATE( ADD_MONTHS( SYSDATE, - " + $RETENTION_PERIOD + ") ) '"

#
# �R�}���h�A�������Z�b�g
#
$export_cmd = "exp"
$export_arg = "$DB_UID/$DB_PWD_DECODE tables=TH_���엚�� file=$OPE_EXP_FILE log=$OPE_LOG_FILE STATISTICS=none query=" + $where_phase

#-------------------------------------------------------------------------------
# $export_cmd �Ƃ����A�v�������� $export_arg �Ŏ��s���A�I������܂őҋ@
#-------------------------------------------------------------------------------
$exp_process = Start-Process $export_cmd $export_arg  -PassThru -Wait -WindowStyle  Hidden
#-------------------------------------------------------------------------------
# �I���R�[�h�̎擾
#-------------------------------------------------------------------------------
$exp_ret = $exp_process.ExitCode
#-------------------------------------------------------------------------------
# ���\�[�X�̔j��
#-------------------------------------------------------------------------------
$exp_process.Close()


#-------------------------------------------------------------------------------
# ���O�t�@�C�����݃`�F�b�N
#  ���݂��Ȃ���΁A�G���[
#-------------------------------------------------------------------------------
if ( -not ( Test-Path $OPE_LOG_FILE ) ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $OPE_LOG_FILE
	. $OUTMSG_CMD $COM_ERROR $RC_NG "exp�R�}���h�ŃG���[���������܂���(���O�t�@�C�������݂��܂���)"

	$exit_code = $RC_NG
	mb_export_operation_history-End-Function
}

#-------------------------------------------------------------------------------
# EXPORT�̃��O�`�F�b�N����
#-------------------------------------------------------------------------------
# �f�[�^0���̏ꍇ
# �@���o�f�[�^�������ꍇ�̃��b�Z�[�W
$NO_DATA_MSG = " 0�s�G�N�X�|�[�g����܂����B"

$result_str = Get-Content $OPE_LOG_FILE | grep $NO_DATA_MSG
if ( $result_str -ne $null ) {
	. $OUTMSG_CMD $INFO_MSG $RC_OK "���o�f�[�^��0���ł���"
	$exit_code = $RC_OK
	mb_export_operation_history-End-Function
}


#-------------------------------------------------------------------------------
# EXPORT�ŃG���[���������ꍇ
#   �i��L�G���[�n���h�����O�ɊY�����Ȃ��ꍇ�j
#-------------------------------------------------------------------------------
if ( $exp_ret -ne $RC_OK ) {
	. $OUTMSG_CMD $COM_ERROR $RC_NG "exp�R�}���h�ŃG���[���������܂���"
	$exit_code = $RC_NG
	mb_export_operation_history-End-Function
}


#---------------------------------------
# ���엚���̍폜
#---------------------------------------
$rc=RemoveOldOperationHistory $RETENTION_PERIOD
$ret=$?

$rm_end_flag = 1
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "���엚���̍폜�ŃG���[���������܂���(�ۑ�����:$RETENTION_PERIOD ����)"
	$exit_code = $RC_NG
	mb_export_operation_history-End-Function

}


#---------------------------------------
# �I������
#---------------------------------------
mb_export_operation_history-End-Function