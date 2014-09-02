#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ���������e�i���X
#
# MODNAME   : uy_daily_batch.ps1
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
    [string]${PRM_ReRunDay}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "���������e�i���X"
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
        outmsg 55 ${DEF_RTNCD_ERR} "�Ď��s�����̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        FC_LogWriter 1 "�Ď��s�����̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        EndProcess
    }
}

#--------------------------------------------
# ����1.�^�p���t�擾
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "�^�p���t�擾���������{���܂��B"
${RTN_GET_UNYOFILE} = MakeUnyoudaysFile ${PRM_ReRunDay}
FC_LogWriter ${DEF_RTNCD_NML} "�^�p���t�擾�������I�����܂��B"


#--------------------------------------------
# ����2.���O�t�@�C�����l�[��
#--------------------------------------------
${LC_EXECUTE_MSG} = "���O�t�@�C�����l�[��"
${LC_EXECUTE_PGM} = "uy_rename_log.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}���������{���܂��B"
${RTN_COMMAND01} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
Wait-Process -Id (${RTN_COMMAND01}.id)
${RTN_CD01} = ${RTN_COMMAND01}.ExitCode
${RTN_COMMAND01}.Close()
if ( ${RTN_CD01} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}�������I�����܂��B"
}

#--------------------------------------------
# ����3.�C�x���g���O���W
#--------------------------------------------
${LC_EXECUTE_MSG} = "�C�x���g���O���W"
${LC_EXECUTE_PGM} = "uy_collect_event_log.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}���������{���܂��B"
${RTN_COMMAND01} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
Wait-Process -Id (${RTN_COMMAND01}.id)
${RTN_CD01} = ${RTN_COMMAND01}.ExitCode
${RTN_COMMAND01}.Close()
if ( ${RTN_CD01} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}�������I�����܂��B"
}

#--------------------------------------------
# ����4.�s�v�t�@�C���폜
#--------------------------------------------
# uy_delete_old_file.ps1
${LC_EXECUTE_MSG} = "�s�v�t�@�C���폜"
${LC_EXECUTE_PGM} = "uy_delete_old_file.ps1"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}���������{���܂��B"
${RTN_COMMAND01} = Start-Process powershell.exe "${UNYO_MOD_DIR}\${LC_EXECUTE_PGM} ${LCOPTION}" -PassThru -Wait -WindowStyle  Hidden
Wait-Process -Id (${RTN_COMMAND01}.id)
${RTN_CD01} = ${RTN_COMMAND01}.ExitCode
${RTN_COMMAND01}.Close()
if ( ${RTN_CD01} -ne ${DEF_RTNCD_NML} ) {
    LFC_AbnormalEndProcess
} else {
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_EXECUTE_MSG}�������I�����܂��B"
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
