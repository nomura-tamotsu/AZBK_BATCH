#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : DB�o�b�N�A�b�v����
#
# FILE      : uy_db_backup.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/01/19 | R.YAMANO      | First Eddition
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
${PRG_NAME}         = "DB�o�b�N�A�b�v����"
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
${ACT_FLAG}         = "${UNYO_TMP_DIR}\${COM_FULLBKUP_FLAG}"

#--------------------------------------------
# Function
#--------------------------------------------
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# LOAD MODULE
#--------------------------------------------
# BACKUP EXEC 
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "BackupExec����p���W���[���̃��[�h�������J�n���܂��B"
Import-Module BEMCLI
FC_LogWriter ${DEF_RTNCD_NML} "BackupExec����p���W���[���̃��[�h�������������܂����B"

#--------------------------------------------
# �^�X�N�X�P�W���[������t���O (�폜)
#--------------------------------------------
if ( Test-Path ${ACT_FLAG} ) {
    # ���݂���ꍇ�A�폜����
    Remove-Item ${ACT_FLAG} -Recurse 2>&1 > $null
}

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# �^�p���t�擾 (YYYYMMDD)
if ( ${PRM_ReRunDay} -ne "x" ) {
    if ( ${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
        ${UNYO_DATE} = ${PRM_ReRunDay}
    } else {
        outmsg 54 ${DEF_RTNCD_ERR}
        FC_LogWriter 1 "�^�p���t�̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        EndProcess
    }
} elseif ( Test-Path ${UNYOUDAYS_FILE} ) {
    ${UNYO_DATE} = Get-Content ${UNYOUDAYS_FILE} -totalCount 1
} else {
    ${UNYO_DATE} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
}
# �O�����t�擾 (YYYYMMDD)
${LCD_YESTERDAY} = ${UNYO_DATE}.Insert(4,"/").Insert(7,"/")
${BEF_UNYO_DATE} = (Get-Date ${LCD_YESTERDAY}).AddDays(-1).ToString(${COM_DATEFORM08})


#--------------------------------------------
# DB�t���o�b�N�A�b�v�W���u���s(BackupExec)
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "DB�t���o�b�N�A�b�v�W���u[${COM_FULLBKUP_JOBS}]�����s���܂��B"
try {
    ${RTN_JOBTMP} = Get-BEJob -Name "${COM_FULLBKUP_JOBS}" | Start-BEJob -Confirm:$False | Wait-BEJob
    ${RTN_JOBRSL} = (Get-BEJob -Name "${COM_FULLBKUP_JOBS}").Status.ToString().ToUpper()
    if ( ${RTN_JOBRSL} -eq "SUCCEEDED" ) {
        # ���s���ʁF����
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}�ɐ������܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}�Ɏ��s���܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}�ɂĈُ킪�������܂����B"
    EndProcess
}

#--------------------------------------------
# �^�X�N�X�P�W���[������t���O (�쐬)
#--------------------------------------------
${UNYO_DATE} | Out-File -FilePath ${ACT_FLAG} -Append -Encoding default

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
