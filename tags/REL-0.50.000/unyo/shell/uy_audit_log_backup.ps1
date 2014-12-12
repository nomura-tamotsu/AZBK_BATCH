#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �č����O�o�b�N�A�b�v����
#
# FILE      : uy_audit_log_backup.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [Alias("m")]
    [string]${PRM_PGMODE}="x",
    [Parameter(Mandatory=$false)]
    [Alias("d")]
    [string]${PRM_ReRunDay}="x",
    [Parameter(Mandatory=$false)]
    [Alias("f")]
    [string]${PRM_FilePATH}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "�č����O�o�b�N�A�b�v����"
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
# Function
#--------------------------------------------
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# ���O�o�b�N�A�b�v�����֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComLogBackup.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# �^�p���t�擾 (YYYYMMDD)
if ( ${PRM_ReRunDay} -ne "x" ) {
    if ( ! (${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet) ) {
        outmsg 55 ${DEF_RTNCD_ERR} "�^�p���t�̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        FC_LogWriter 1 "�^�p���t�̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        EndProcess
    }
}
# ��`�t�@�C���w��擾 (�w��̏ꍇ�̂�)
if ( ${PRM_FilePATH} -ne "x" ) {
    ${BACKUP_AUDIT_LOG_DEF} = ${PRM_FilePATH}
}

#--------------------------------------------
# �č����O�o�b�N�A�b�v����(Phase.01-COPY����)
#--------------------------------------------
${LC_STEPMSG} = "Phase.01-COPY����"
FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"
try {
    #FC_BACKUP_COPY ${BACKUP_AUDIT_LOG_DEF} "COPY" 2>&1 > $null
    #${RTN_FCBACKUP_CODE} = $?
    ${RTN_FCBACKUP_CODE} = FC_BACKUP_COPY ${BACKUP_AUDIT_LOG_DEF} "COPY" "${PRM_ReRunDay}"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${LC_STEPMSG})�͏I�����܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
    EndProcess
}

#--------------------------------------------
# �č����O�o�b�N�A�b�v����(Phase.02-MOVE����)
#--------------------------------------------
${LC_STEPMSG} = "Phase.02-MOVE����"
FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"
try {
    #FC_BACKUP_COPY ${BACKUP_AUDIT_LOG_DEF} "MOVE" 2>&1 > $null
    #${RTN_FCBACKUP_CODE} = $?
    ${RTN_FCBACKUP_CODE} = FC_BACKUP_COPY ${BACKUP_AUDIT_LOG_DEF} "MOVE" "${PRM_ReRunDay}"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${LC_STEPMSG})�͏I�����܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
    EndProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
