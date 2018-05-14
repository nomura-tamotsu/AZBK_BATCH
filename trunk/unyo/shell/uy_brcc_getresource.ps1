#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2017
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : BANK*R CC ��������\�[�X���擾�c�[��
#
# FILE      : uy_brcc_getresource.ps1
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
${PRG_NAME}         = "��������\�[�X���擾�c�[��"
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
${LCDB_ORACLE_SID} = "BRCCAZBK"
${LCSQL_BRCC_GET_RESORCE_TFILES}    = "${UNYO_HOME}\sql\BRCC_GET_RESOURCE.sql"

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
#--------------------------------------------
InitProcess

#--------------------------------------------
# ��������\�[�X���擾�c�[��
#--------------------------------------------
# 2. GET RESORCE
#--------------------------------------------
${LC_SQLMSG} = "��������\�[�X���擾�c�[��"
${LC_SQL001} = "${LCSQL_BRCC_GET_RESORCE_TFILES}"
# �擾�Ώۊ��Ԃ̐ݒ�
${LC_TGTMONTH} =  (Get-Date).AddMonths(-1) | %{ $_.ToString("yyyy/MM") }
${LC_NOWMONTH} =  (Get-Date) | %{ $_.ToString("yyyy/MM") }
${LC_TGTFILEN} =  (Get-Date ${LC_TGTMONTH} -format "yyyyMM")
# ��������\�[�X���o�t�@�C�����̐ݒ�
${LC_GETFILENAME} = "BRCC_GET_RESORCE_${LC_TGTFILEN}.log"


sqlplus /@${LCDB_ORACLE_SID} as sysdba "@${LC_SQL001}" "${LC_TGTMONTH}" "${LC_NOWMONTH}" "${LC_GETFILENAME}" 2>&1 > $null
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
# 3. End Main Program
#--------------------------------------------
EndProcess
