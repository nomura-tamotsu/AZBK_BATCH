#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �C�x���g���O���W(Security)
#
# MODNAME   : uy_collect_event_log.ps1
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
${PRG_NAME}         = "�C�x���g���O���W"
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

#${GET_EVENT_TYPE} = 0

#--------------------------------------------
# Function
#--------------------------------------------
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# �C�x���g���O�擾�p���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComGetEventLog.ps1


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
    if ( ${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
        ${UNYO_DATE} = ${PRM_ReRunDay}
    } else {
        outmsg 55 ${DEF_RTNCD_ERR} "�^�p���t�̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        FC_LogWriter 1 "�^�p���t�̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        EndProcess
    }
} elseif ( Test-Path ${UNYOUDAYS_FILE} ) {
    ${UNYO_DATE} = Get-Content ${UNYOUDAYS_FILE} -totalCount 1
} else {
    ${UNYO_DATE} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
}


# Get Event Type [0:Security,1:Application,2:System] Roupe Counter
# �C�x���g���O�擾�����i�C�x���g���O��ʖ��Ƀ��[�v�j
for ( ${GET_EVENT_TYPE} = 0 ; ${GET_EVENT_TYPE} -lt ${COM_EVNTYPE}.length ; ${GET_EVENT_TYPE}++ ) {

    ${TG_DATE}         = ${UNYO_DATE}
    ${TG_LOGDATE}      = ${TG_DATE}.Insert(4,"/").Insert(7,"/")
    ${TG_EVENT_OUTLOG} = ${UNYO_COLLECT_EVENT_LOGS_DIR} + "\" + ${COM_EVENT_LOGFILE}[${GET_EVENT_TYPE}] + ".log.${TG_DATE}"
    ${TG_EVENT_TYPE}   = ${COM_EVNTYPE}[${GET_EVENT_TYPE}]

    FC_LogWriter ${DEF_RTNCD_NML} "�Ώۓ���[${TG_LOGDATE}]��[${TG_EVENT_TYPE}]�C�x���g���O�擾�����֐����ďo���܂��B"

    # �C�x���g���O�擾����
    try {
        FC_GetEventLog ${GET_EVENT_TYPE} ${TG_EVENT_OUTLOG} ${TG_DATE}
    } catch [Exception] {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${TG_EVENT_OUTLOG}"
        FC_LogWriter ${PRG_EXIT_CODE} "�Ώۓ���[${TG_LOGDATE}]��[${TG_EVENT_TYPE}]�C�x���g���O�擾�����֐����ďo���ɂĎ��s���܂����B�㑱�����𒆎~���܂��B"
        EndProcess
    }

}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
