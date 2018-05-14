#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2017
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : Oracle�č����O�����e����
#
# FILE      : uy_ora_audit_maint.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 17/02/01 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "Oracle�č����O�����e����"
${PRG_EXIT_CODE}    = 0
#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${LOG_FLAG}         = 1
${ACT_TIME}         = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}         = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"

#--------------------------------------------
# �ǉ��ϐ���`
#--------------------------------------------
${LCDB_ORACLE_SID} = "BANKRAZB"
${LCSQL_DBMS_AUDIT_LAST_ARCTIME}    = "${UNYO_HOME}\sql\DB_DBMS_AUDIT_LAST_ARCTIME.sql"
${LCSQL_DBMS_AUDIT_CLEAN_TFILES}    = "${UNYO_HOME}\sql\DB_DBMS_AUDIT_CLEAN_TFILES.sql"

#--------------------------------------------
# Function
#--------------------------------------------
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# Pre Action
#--------------------------------------------
# Active Node Check (�ғ����@�̂ݎ��s)
if ( !(Test-Path ${UNYO_DB_FLBKUP_DIR}) ) {
    exit 0
}

#--------------------------------------------
# MAIN
#--------------------------------------------
# 1. Start Main Program
InitProcess

#--------------------------------------------
# Oracle�č����O�A�[�J�C�u�^�C���X�^���v�ݒ�
#--------------------------------------------
# DBMS_AUDIT_MGMT�v���V�[�W��SQL���s 01
${LC_SQLMSG} = "Oracle�č����O�A�[�J�C�u�^�C���X�^���v�ݒ菈��"
${LC_SQL001} = "${LCSQL_DBMS_AUDIT_LAST_ARCTIME}"
sqlplus /@${LCDB_ORACLE_SID} as sysdba "@${LC_SQL001}" 2>&1 > $null
${RTN_CODE} = $?
if ( ${RTN_CODE} ) {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_SQLMSG}������I�����܂����B"
} else {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "${LC_SQLMSG}�ɂăG���[���������܂����B"
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_SQLMSG}�ɂăG���[���������܂����B"
    EndProcess
}

#--------------------------------------------
# Oracle�č����O�폜
#--------------------------------------------
# DBMS_AUDIT_MGMT�v���V�[�W��SQL���s 02
${LC_SQLMSG} = "Oracle�č����O�폜����"
${LC_SQL001} = "${LCSQL_DBMS_AUDIT_CLEAN_TFILES}"
sqlplus /@${LCDB_ORACLE_SID} as sysdba "@${LC_SQL001}" 2>&1 > $null
${RTN_CODE} = $?
if ( ${RTN_CODE} ) {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_SQLMSG}������I�����܂����B"
} else {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "${LC_SQLMSG}�ɂăG���[���������܂����B"
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_SQLMSG}�ɂăG���[���������܂����B"
    EndProcess
}

#--------------------------------------------
# 4. End Main Program
#--------------------------------------------
EndProcess
