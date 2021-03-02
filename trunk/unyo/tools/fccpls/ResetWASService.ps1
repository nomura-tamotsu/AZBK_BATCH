#============================================================================
#  COPYRIGHT iSiD LTD. 2020
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : PowerShell WAS�T�[�r�X�o�^
#
# FILE      : ResetWASService.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 20/12/02 | A.MIYAMOTO    | First Eddition
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$true)]
    [Alias("nodename")]
    [string]${global:BANKR_PROFNAME}="x",
    [Parameter(Mandatory=$true)]
    [Alias("newpassword")]
    [string]${NEW_PWD}="x"
)

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "WAS�T�[�r�X�ēo�^����"
${PRG_EXIT_CODE}    = 0

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
#  WAS Variable definition
#--------------------------------------------
${global:BANKR_NODENAME} = "${HOST_NMLO}_${BANKR_PROFNAME}"

#--------------------------------------------
# WAS�֘A�p�X�Ȃ�
#--------------------------------------------
${EX_WAS_USER}          = "wasadmin"
${BR_WAS_BINSDIR}       = "${COM_WAS_BASE_DIRS}\bin"
${BR_BANKRPROF_BASEDIR} = "${COM_WAS_BASE_DIRS}\profiles\${BANKR_PROFNAME}"
${BR_BANKRPROF_BINSDIR} = "${BR_BANKRPROF_BASEDIR}\bin"
${BR_BANKRPROF_LOGROOT} = "${BR_BANKRPROF_BASEDIR}\logs\server1"
${BR_WAS_RESET_SEVICES} = "${BR_WAS_BINSDIR}\WASService.exe"
${BR_BANKRPROF_STOPSVR} = "${BR_BANKRPROF_BINSDIR}\stopServer.bat"

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${LOG_FLAG}  = 1
${ACT_TIME}  = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}  = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"

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
# WAS�ēo�^���O���� �����T�[�r�X�̒�~
#--------------------------------------------
${LC_BANKR_STOPSVR_CMDLINE}    = "${BR_BANKRPROF_STOPSVR} server1 -username ${EX_WAS_USER} -password ${NEW_PWD}"
echo ${LC_BANKR_STOPSVR_CMDLINE}
#--------------------------------------------
# �������s
#--------------------------------------------
try {
    ${LC_TEMPMSG} = "�����T�[�r�X�̒�~"
    Invoke-Expression "${LC_BANKR_STOPSVR_CMDLINE}"
    if ( ${LASTEXITCODE} -eq 0 ) {
        # ���s���ʁF����
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_TEMPMSG}�ɐ������܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_TEMPMSG}�Ɏ��s���܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_TEMPMSG}�ɂĈُ킪�������܂����B"
    EndProcess
}


#--------------------------------------------
# WAS�ēo�^����
#--------------------------------------------
${LC_WAS_RSET_SERVICE_CMDLINE} = "${BR_WAS_RESET_SEVICES} -add `"${BANKR_NODENAME}`" -servername server1 -profilePath ${BR_BANKRPROF_BASEDIR} -logRoot ${BR_BANKRPROF_LOGROOT} -stopArgs `"-username ${EX_WAS_USER} -password ${NEW_PWD}`" -encodeParams"
echo ${LC_WAS_RSET_SERVICE_CMDLINE}
#--------------------------------------------
# �������s
#--------------------------------------------
try {
    ${LC_TEMPMSG} = "WAS�ēo�^����"
    Invoke-Expression "${LC_WAS_RSET_SERVICE_CMDLINE}"
    if ( ${LASTEXITCODE} -eq 0 ) {
        # ���s���ʁF����
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_TEMPMSG}�ɐ������܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_TEMPMSG}�Ɏ��s���܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_TEMPMSG}�ɂĈُ킪�������܂����B"
    EndProcess
}


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
