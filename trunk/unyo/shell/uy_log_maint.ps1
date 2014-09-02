#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : ���O�����e�i���X
#
# FILE      : uy_log_maint.ps1
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
    [Alias("d")]
    [string]${PRM_ReRunDay}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "���O�����e�i���X"
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
${LCOPTION}         = ""

#--------------------------------------------
# Function
#--------------------------------------------
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# �ُ�I������
#--------------------------------------------
function LFC_AbnormalEndProcess
{
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "${LC_EXECUTE_MSG}�������ُ�I�����܂����B�����𒆎~���܂��B"
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_EXECUTE_MSG}�������ُ�I�����܂����B�����𒆎~���܂��B"
    EndProcess
}

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
if ( ${PRM_ReRunDay} -ne "x" ) {
    if ( ${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
        ${LCOPTION} = "-m rerun -d ${PRM_ReRunDay} "
    } else {
        outmsg 54 ${DEF_RTNCD_ERR}
        FC_LogWriter 1 "�Ď��s�����̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        EndProcess
    }
}

#--------------------------------------------
# ����1.���������e�i���X����
#--------------------------------------------
${LC_EXECUTE_MSG} = "���������e�i���X����"
${LC_EXECUTE_PGM} = "uy_daily_batch.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}���������{���܂��B"
${RTN_COMMAND00} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
${RTN_CD00} = ${RTN_COMMAND00}.ExitCode
${RTN_COMMAND00}.Close()
if ( ${RTN_CD00} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}�������I�����܂��B"
}

#--------------------------------------------
# ����2.�e�탍�O�o�b�N�A�b�v����
#--------------------------------------------
${LC_EXECUTE_MSG} = "�e�탍�O�o�b�N�A�b�v����"
${LC_EXECUTE_PGM} = "uy_log_backup.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}���������{���܂��B"
${RTN_COMMAND00} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
${RTN_CD00} = ${RTN_COMMAND00}.ExitCode
${RTN_COMMAND00}.Close()
if ( ${RTN_CD00} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}�������I�����܂��B"
}

#--------------------------------------------
# ����3.�č����O�o�b�N�A�b�v����
#--------------------------------------------
${LC_EXECUTE_MSG} = "�č����O�o�b�N�A�b�v����"
${LC_EXECUTE_PGM} = "uy_audit_log_backup.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}���������{���܂��B"
${RTN_COMMAND00} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
${RTN_CD00} = ${RTN_COMMAND00}.ExitCode
${RTN_COMMAND00}.Close()
if ( ${RTN_CD00} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}�������I�����܂��B"
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
