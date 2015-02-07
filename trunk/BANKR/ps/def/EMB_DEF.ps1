#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# FILE      : �Ɩ��o�b�`���ʒ�`�t�@�C��
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 13/10/XX | ISID          | First Edition.
# %01 | 14/06/24 | ISID          | Error Code �ǉ�
# %02 | 15/01/14 | �y���@�N��Y  | ���������s 1.0���Ή�
#============================================================================

# ============================================================================
# ���� Alias �ݒ�
# ============================================================================
Set-Alias grep Select-String

# ============================================================================
# ���ʒ�`
# ============================================================================
# �I���R�[�h(����)
$global:RC_OK=0
# �I���R�[�h(�ُ�)
$global:RC_NG=9
# �I���R�[�h(�x��)
$global:RC_WARNING=1


# ���ϐ��擾
$global:COMPUTERNAME=[environment]::getenvironmentvariable("computername")
$global:USERNAME=[environment]::username

$global:USER=$env:user
$global:EMB_HOME=$env:emb_home
$global:DB_UID=$env:db_uid
$global:DB_NAME=$env:db_name
$global:DB_PWD=$env:db_pwd
$global:ORACLE_TNS=$env:oracle_tns

# ============================================================================
# �f�B���N�g����`
# ============================================================================
# �N���X�^���O�f�B���N�g��
$global:CLLOG_DIR="E:\CLlog\azbk\BANKRAZB"
# ���O�f�B���N�g��
$global:LOG_DIR="$global:CLLOG_DIR\error"
# �X�N���v�g�f�B���N�g��
$global:SCRIPT_DIR="$global:EMB_HOME\ps"
# �ꎞ�t�@�C���f�B���N�g��
$global:TMP_DIR="$global:EMB_HOME\tmp"
# ���|�[�g�f�B���N�g��
$global:REP_LOG_DIR="$global:LOG_DIR\report"
$global:REP_BACKUP_DIR="$global:REP_LOG_DIR\backup"

#�O���t�@�C������M���[�g�f�B���N�g��
$global:EXTDATA_DIR="E:\extdata"
# �O���t�@�C����M�f�B���N�g��
$global:EXT_LOAD_DIR="$global:EXTDATA_DIR\rcv"
$global:EXT_LOAD_BACKUP_DIR="$global:EXT_LOAD_DIR\backup"
# �O���t�@�C�����M�f�B���N�g��
$global:EXT_UPLOAD_DIR="$global:EXTDATA_DIR\snd"
$global:EXT_UPLOAD_BACKUP_DIR="$global:EXT_UPLOAD_DIR\backup"

# ����t�@�C���i�[�f�B���N�g��
$global:CTL_FILE_DIR="$global:EMB_HOME\ctl"
# �r���[DDL�i�[�f�B���N�g��
$global:VIEW_DDL_DIR="$global:EMB_HOME\table\view_switch"
$global:VIEW_DDL_LOG_DIR="$global:VIEW_DDL_DIR\log"


# ============================================================================
# ���|�[�g�t�@�C����`
# ============================================================================
# �v�����^����t���O
$global:PRINT_FLAG="OFF"
# �v�����^�h���C�o
$global:PRINT_DRIVER="PQA4"
# �o�b�`�������|�[�g
$global:BATCH_REP_FILE_NAME="BATCH_REPORT.log"
# �e�[�u���X�y�[�X�󂫗e�ʃ��|�[�g
$global:TBL_SPACE_REP_FILE_NAME="TBL_SPACE_REPORT.log"
# �����f�[�^��M���|�[�g
$global:MONTHLY_DATA_REP_FILE_NAME="MONTHLY_DATA_REPORT.log"

# ============================================================================
# ���b�Z�[�WID��`
# ============================================================================
$global:INFO_MSG=1
$global:START_MSG=40
$global:NORMAL_END_MSG=41
$global:ERROR_END_MSG=45
$global:FILE_NOT_EXIST_MSG=51
$global:FILE_NOT_SEND_MSG=57
$global:UNMATCH_PARAMETER_COUNT_MSG=27
$global:UNMATCH_PARAMETER_COUNT=53
$global:COM_ERROR=55
$global:WARNINGL_END_MSG=56
$global:VIEW_SWITCH_ERROR=5105
$global:NOT_EXECUTE_DAY=1029
$global:EXECUTE_DAY=1030

# Add AZBK %01
$global:LOAD_EXCEED_ERR=5053
$global:LOAD_REFUSAL_WAN=5054
$global:LOAD_FAILURE=5059
$global:ERR_DUPLICATE=5104
$global:LOAD_ERROR_2026=5109


# ============================================================================
# ���|�[�g���b�Z�[�WID��`
# ============================================================================
$global:REP_MSG_I=0
$global:REP_MSG_W=1
$global:REP_MSG_E=2


# ============================================================================
# ��Ꮘ����`
# ============================================================================
# �������ڋq�t�@�C��
$global:NO_DEAL_IMP_DATA="D_MITORIHIKI_IMP.dat"
$global:NO_DEAL_IMP_COUNT="K_MITORIHIKI_IMP.dat"
# �����������t�@�C��
$global:NO_DEAL_CLR_DATA="D_MITORIHIKI_CLR.dat"
$global:NO_DEAL_CLR_COUNT="K_MITORIHIKI_CLR.dat"
# EBM�R�[���f�[�^�t�@�C��
$global:EBM_DATA="D_EBM.dat"
$global:EBM_COUNT="K_EBM.dat"
# ������撊�o�t�@�C��
$global:NO_DEAL_EXP_DATA="D_MITORIHIKI_EXP.dat"
$global:NO_DEAL_EXP_COUNT="K_MITORIHIKI_EXP.dat"

# ============================================================================
# HULFT���M��`
# ============================================================================
$global:HulftConfig="$global:EMB_HOME\file\HULFT.conf"
$global:FileIdLength=3
$global:ClassCRM="C"
$global:ClassHOST="H"
$global:ClassIB="I"
$global:FolderCRM="crm"
$global:FolderHOST="host"
$global:FolderIB="ib"

# ============================================================================
# ����/�T��/�����f�[�^��`
# ============================================================================
# �����z�u�����t�@�C��(�]�������t�@�C��)
$global:MONTHLY_END_FILE="$global:EXT_LOAD_DIR\M_END.dat"
# �T���z�u�����t�@�C��(�]�������t�@�C��)
$global:WEEKLY_END_FILE="$global:EXT_LOAD_DIR\W_END.dat"
# �����z�u�����t�@�C��(�]�������t�@�C��)
$global:DAILY_END_FILE="$global:EXT_LOAD_DIR\D_END.dat"

# �e�f�[�^�t�@�C����(�g���q�Ȃ�)
$global:M_END_BASE="M_END"
$global:M_ADDRESS_BASE="M_Z07"              # �Z���t�@�C��
$global:M_BANK_BASE="W_BBR"         # �S��f�[�^�i���Z�@�֎x�X�t�@�C���j


$global:M_FOREIGN_BASE       ="D_KGS"       # �O�ݗa���t�@�C��
$global:M_FUND_BASE          ="D_Z05"       # ���M�f�[�^�t�@�C��
$global:M_FUND_DETAIL_BASE   ="D_KTM"           # ���M���׃f�[�^�t�@�C��
$global:M_PRODUCT_BASE       ="D_PRD"           # ���i�t�@�C��

$global:M_CUSTOMER_BASE      ="D_ZKS"       # �ڋq�����t�@�C��
$global:M_HOUSEHOLD_BASE     ="D_SZS"       # ���ё����t�@�C��
$global:M_TERM_DEPOSIT_BASE    ="D_KKS"     # ������a���t�@�C��
$global:M_LIQUID_DEPOSIT_BASE  ="D_KRS"     # �������a���t�@�C��
# $global:M_DEBENTURE_BASE     ="D_KSS"     # �������t�@�C�� (1.0���ɂ� �폜)
$global:M_PERSONNEL_BASE     ="D_JIF"       # �l�����t�@�C��
$global:M_PROFILE_BASE       ="D_PRO"       # �ڋq�v���t�@�C��
$global:M_BHISTORY_BASE      ="D_LGD"       # �c�ƓX�R���^�N�g�����t�@�C��

$global:M_OPEINFO_BASE       ="S_IB1"       # �I�y���[�^���t�@�C��
# $global:M_CONTRACT_BASE      ="S_CZU"       # �e���o���_�񑮐��t�@�C�� (1.0���ɂ� �폜)
$global:M_CONTACT_BASE       ="S_LCU"       # �R���^�N�g�����t�@�C��
$global:M_TB_CONTRACT_BASE   ="S_TB1"       # �e���o���_����t�@�C�� (1.0�� �ǉ�)
$global:M_TB_ACCOUNT_BASE    ="S_TB2"       # �e���o���_��������t�@�C�� (1.0�� �ǉ�)


# ���g�p
$global:M_K_ZOKUSEI_BASE="M_K_ZOKUSEI"
$global:M_K_ZANDAKA_BASE="M_K_ZANDAKA"
$global:M_K_HENDO_BASE="M_K_HENDO"
$global:M_S_ZOKUSEI_BASE="M_S_ZOKUSEI"
$global:M_S_ZANDAKA_BASE="M_S_ZANDAKA"
$global:M_S_HENDO_BASE="M_S_HENDO"
$global:M_M_RYUDO_BASE="M_M_RYUDO"
$global:M_M_TEIKI_BASE="M_M_TEIKI"
$global:M_M_LOAN_BASE="M_M_LOAN"



# �e�r���[DDL��(�g���q�Ȃ�)
$global:SQL_VIEW_ADDRESS_BASE="view_tf_09"
$global:SQL_VIEW_JBANK_BASE="view_tmb_07"
$global:SQL_VIEW_FOREIGN_BASE="view_tf_05"
$global:SQL_VIEW_FUND_BASE="view_tf_07"
$global:SQL_VIEW_FUND_DETAIL_BASE="view_tf_08"
$global:SQL_VIEW_PRODUCT_BASE="view_tf_10"
$global:SQL_VIEW_CUSTOMER_BASE="view_tf_01"  # TF_�ڋq�����@(1.0�� �ǉ�)
$global:SQL_VIEW_HOUSEHOLD_BASE="view_tf_02"    # TF_���ё����@(1.0�� �ǉ�)
$global:SQL_VIEW_TERM_DEPOSIT_BASE="view_tf_03"    # TF_�ʖ��׌Œ萫�a���@(1.0�� �ǉ�)
$global:SQL_VIEW_LIQUID_DEPOSIT_BASE="view_tf_04"    # TF_�ʖ��ח������a���@(1.0�� �ǉ�)


# ���g�p
$global:SQL_VIEW_KOKYAKU_BASE="view_tf_01"
$global:SQL_VIEW_LOAN_BASE=""


# �r���[���ʎq
$global:VIEW_A=1
$global:VIEW_B=2
$global:TABLE_SUFFIX_A="A"
$global:TABLE_SUFFIX_B="B"
# SQL*Loader�G���[�R�[�h
$global:LOADER_ERROR=1

#
# �r���[����
#
$global:CUSTOMER_BASE_VIEWNAME   ="TF_�ڋq����"                  # (1.0�� �ǉ�)
$global:HOUSEHOLD_BASE_VIEWNAME ="TF_���ё���"                  # (1.0�� �ǉ�)
$global:TERM_DEPOSIT_BASE_VIEWNAME ="TF_�ʖ��׌Œ萫�a��" �@  # (1.0�� �ǉ�)
$global:LIQUID_DEPOSIT_BASE_VIEWNAME ="TF_�ʖ��ח������a��"   # (1.0�� �ǉ�)

$global:ADDRESS_VIEWNAME="TF_�Z��"
$global:JBANK_VIEWNAME="TMB_�S��"
$global:JBANK_BASE_TBNAME ="TMB_��s"
$global:JBANK_BASE_TBNAME2="TMB_�x�X"

$global:FOREIGN_VIEWNAME="TF_�ʖ��׊O�ݗa��"
$global:FUND_VIEWNAME="TF_�ʖ��ד��M����"
$global:FUND_DETAIL_VIEWNAME="TF_�ʖ��ד��M��������"
$global:PRODUCT_VIEWNAME="TF_���i"

# $global:CUTOMER_BASE_TBNAME   ="TF_�ڋq����"   (1.0�� VIEW�ɕύX)
# $global:HOUSEHOLD_BASE_TBNAME ="TF_���ё���"   (1.0�� VIEW�ɕύX)
# $global:TERM_DEPOSIT_BASE_TBNAME ="TF_�ʖ��׌Œ萫�a��"    (1.0�� VIEW�ɕύX)
# $global:LIQUID_DEPOSIT_BASE_TBNAME ="TF_�ʖ��ח������a��"  (1.0�� VIEW�ɕύX)
# $global:DEBENTURE_BASE_TBNAME ="TF_�ʖ��׍�" (1.0�� �폜)
$global:PERSONNEL_BASE_TBNAME ="TM_���[�U"
$global:PROFILE_BASE_TBNAME ="TF_�ڋq�v���t�@�C��"
$global:BHISTROY_BASE_TBNAME ="TH_�c�ƓX����"



# ============================================================================
# ���엚���o�b�N�A�b�v�p��`
# ============================================================================
$global:AUDIT_OPE_DIR="$global:CLLOG_DIR\audit\opelog"
$global:OPE_BACKUP_FROM=0000
$global:OPE_BACKUP_TO=2300
$global:OPE_BACKUP_SLEEP=30
$global:OPE_EXP_BASE="$global:AUDIT_OPE_DIR\ope_history.dump"


$global:OPE_LOG_FILE="$global:TMP_DIR\ope_history.log"
$global:RETENTION_PERIOD=6

