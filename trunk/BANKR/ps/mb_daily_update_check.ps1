#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : �����f�[�^�X�V�`�F�b�N
#
# MODULE NAME   : mb_daily_update_check
#
# INPUT         : None
#
# EXIT          : ����I�� �E�E�E NORMAL(0)
#                 �ُ�I�� �E�E�E ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 23/04/21 | ISID-IT �y��  | First Edition.                            
# %01 | 23/04/29 | ISID-IT �y��  | �����A�T���t�@�C�����`�F�b�N�ΏۂƂ���B.                            
#============================================================================
#============================================================================
# �֐���        mb_daily_update_check-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_daily_update_check-End-Function () {
	
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
$BATNAME  = "mb_daily_update_check"
$JOB_NAME = "�����f�[�^�X�V�`�F�b�N"

# �G���[�����imsg_file�̕ύX�͔��������̂ŋ��ʃG���[���b�Z�[�W���p�j
$LOADERROR = "�̃��[�h���������Ă��Ȃ��\��������܂�."
$UPDATEERROR = "�̎捞���������Ă��Ȃ��\��������܂�."

# exit�R�[�h������
$exit_code   = $RC_OK


#-----------------------------------------------
# �J�n���b�Z�[�W ���O�o��
#-----------------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****�����f�[�^�X�V�`�F�b�N�J�n*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


#=============================================================
# �����f�[�^�t�@�C��
#=============================================================
#-----------------------------------------------
# 1.�Z���t�@�C��(M_Z07) ���݃`�F�b�N
#-----------------------------------------------
$ADDRESS_DATA_FILE = "$EXT_LOAD_DIR\" + $M_ADDRESS_BASE + ".dat"

if ( Test-Path $ADDRESS_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "�����E�Z���t�@�C���i" + $ADDRESS_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG

	$exit_code = $RC_NG
}


#=============================================================
# �T���f�[�^�t�@�C��
#=============================================================
#-----------------------------------------------
# 1.���Z�@�֎x�X�t�@�C��(W_BBR) ���݃`�F�b�N
#-----------------------------------------------
$BANK_DATA_FILE = "$EXT_LOAD_DIR\" + $M_BANK_BASE + ".dat"

if ( Test-Path $BANK_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "�T���E�S��f�[�^�i" + $BANK_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG

	$exit_code = $RC_NG
}


#=============================================================
# �����f�[�^�t�@�C��
#=============================================================
#-----------------------------------------------
# 1.�ڋq�����f�[�^�t�@�C��(D_ZKS) ���݃`�F�b�N
#-----------------------------------------------
$CUSTOMER_DATA_FILE = "$EXT_LOAD_DIR\" + $M_CUSTOMER_BASE + ".dat"

if ( Test-Path $CUSTOMER_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "�ڋq�����t�@�C���i" + $CUSTOMER_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 2.���ё����f�[�^�t�@�C��(D_SZS) ���݃`�F�b�N
#-----------------------------------------------
$HOUSEHOLD_DATA_FILE = "$EXT_LOAD_DIR\" + $M_HOUSEHOLD_BASE + ".dat"

if ( Test-Path $HOUSEHOLD_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "���ё����t�@�C���i" + $HOUSEHOLD_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 3.�ʖ��ח������a���t�@�C��(D_KRS) ���݃`�F�b�N
#-----------------------------------------------
$LIQUID_DEPOSIT_DATA_FILE = "$EXT_LOAD_DIR\" + $M_LIQUID_DEPOSIT_BASE + ".dat"

if ( Test-Path $LIQUID_DEPOSIT_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "�������a���t�@�C���i" + $LIQUID_DEPOSIT_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 4.�ʖ��ג�����a���t�@�C��(D_KKS) ���݃`�F�b�N
#-----------------------------------------------
$TERM_DEPOSIT_DATA_FILE = "$EXT_LOAD_DIR\" + $M_TERM_DEPOSIT_BASE + ".dat"

if ( Test-Path $TERM_DEPOSIT_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "������a���t�@�C���i" + $TERM_DEPOSIT_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 5.�ʖ��׊O�݃t�@�C��(D_KGS) ���݃`�F�b�N
#-----------------------------------------------
$FOREIGN_DATA_FILE = "$EXT_LOAD_DIR\" + $M_FOREIGN_BASE + ".dat"

if ( Test-Path $FOREIGN_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "�O�݃t�@�C���i" + $FOREIGN_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 6.�ڋq�v���t�@�C��(D_PRO) ���݃`�F�b�N
#-----------------------------------------------
$PROFILE_DATA_FILE = "$EXT_LOAD_DIR\" + $M_PROFILE_BASE + ".dat"

if ( Test-Path $PROFILE_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "�ڋq�v���t�@�C���i" + $PROFILE_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 7.�l�����t�@�C��(D_JIF) ���݃`�F�b�N
#-----------------------------------------------
$PERSONNEL_DATA_FILE = "$EXT_LOAD_DIR\" + $M_PERSONNEL_BASE + ".dat"

if ( Test-Path $PERSONNEL_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "�l�����t�@�C���i" + $PERSONNEL_DATA_FILE + "�j" + $UPDATEERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 8.�c�ƓX�R���^�N�g�����t�@�C��(D_LGD) ���݃`�F�b�N
#-----------------------------------------------
$BHISTORY_DATA_FILE = "$EXT_LOAD_DIR\" + $M_BHISTORY_BASE + ".dat"

if ( Test-Path $BHISTORY_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "�c�ƓX�R���^�N�g�����t�@�C���i" + $BHISTORY_DATA_FILE + "�j" + $UPDATEERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 9.�ʖ��ד��M�t�@�C��(D_Z05) ���݃`�F�b�N
#-----------------------------------------------
$FUND_DATA_FILE = "$EXT_LOAD_DIR\" + $M_FUND_BASE + ".dat"

if ( Test-Path $FUND_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "���M�t�@�C���i" + $FUND_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 10.�ʖ��ד��M���׃t�@�C��(D_KTM) ���݃`�F�b�N
#-----------------------------------------------
$FUND_DETAIL_DATA_FILE = "$EXT_LOAD_DIR\" + $M_FUND_DETAIL_BASE + ".dat"

if ( Test-Path $FUND_DETAIL_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "���M���׃t�@�C���i" + $FUND_DETAIL_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 11.���i�t�@�C��(D_PRD) ���݃`�F�b�N
#-----------------------------------------------
$PRODUCT_DATA_FILE = "$EXT_LOAD_DIR\" + $M_PRODUCT_BASE + ".dat"

if ( Test-Path $PRODUCT_DATA_FILE ) {
	# �t�@�C�����݃`�F�b�N�G���[���b�Z�[�W
	$ERROR_MSG = "���i�t�@�C���i" + $PRODUCT_DATA_FILE + "�j" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#---------------------------------------
# �I������
#---------------------------------------
mb_daily_update_check-End-Function