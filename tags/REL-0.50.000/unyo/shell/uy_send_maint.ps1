#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ���M�t�@�C�������e�i���X����
#
# FILE      : uy_send_maint.ps1
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
    [Parameter(Mandatory=$true)]
    [Alias("id")]
    [string]${FILE_ID}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "���M�t�@�C�������e�i���X����"
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
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#SENDNM_FILE_DEF

#--------------------------------------------
# DEF FILE CHECK
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${SENDNM_FILE_DEF}]�����擾���܂�(${PRG_NAME})"
# ��`�t�@�C�����݃`�F�b�N
if ( !(Test-Path ${SENDNM_FILE_DEF}) ) {
    # ���݂��Ȃ��ׁA�ُ�I��
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${SENDNM_FILE_DEF}"
    FC_LogWriter ${PRG_EXIT_CODE} "��`�t�@�C��[${SENDNM_FILE_DEF}]�����݂��Ȃ��׈ُ�I�����܂�(${PRG_NAME})"
    EndProcess
}

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# FILE ID ��`�m�F
if ( ! (Get-Content ${SENDNM_FILE_DEF} | Select-String -Pattern "^${FILE_ID}" -Quiet ) ) {
    # �w��t�@�C��ID�͖��o�^
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "��`�t�@�C��[${SENDNM_FILE_DEF}]���ɖ���`�̃t�@�C��ID���w�肳�ꂽ�ׁA�������ُ�I�����܂�"
    FC_LogWriter ${PRG_EXIT_CODE} "��`�t�@�C��[${SENDNM_FILE_DEF}]���ɖ���`�̃t�@�C��ID���w�肳�ꂽ�ׁA�������ُ�I�����܂�"
    EndProcess
} else {
    ${LC_GETLINES} = (Get-Content ${SENDNM_FILE_DEF} | Select-String -Pattern "^${FILE_ID}" )
    ${LC_FILENAME} = "${LC_GETLINES}" | %{ $_.Split(",")[1] }
    ${TG_FILEPATH} = "${UNYO_DB_EXTSND_DIR}\${LC_FILENAME}"
}


#--------------------------------------------
# ���M�t�@�C�����݃`�F�b�N
#--------------------------------------------
if ( !(Test-Path ${TG_FILEPATH}) ) {
    # ���݂��Ȃ��ׁA�ُ�I��
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "�z�M�t�@�C��[${TG_FILEPATH}]�����݂��Ȃ��ׁA�������ُ�I�����܂��B"
    FC_LogWriter ${DEF_RTNCD_NML} "�z�M�t�@�C��[${TG_FILEPATH}]�����݂��Ȃ��ׁA�������ُ�I�����܂��B"
    EndProcess
}

#--------------------------------------------
# �o�b�N�A�b�v��t�H���_���݃`�F�b�N
#--------------------------------------------
if ( !(Test-Path ${UNYO_DB_EXTSND_BKD}) ) {
    # ���݂��Ȃ��ׁA�ُ�I��
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "�o�b�N�A�b�v��t�H���_[${UNYO_DB_EXTSND_BKD}]�����݂��Ȃ��ׁA�������ُ�I�����܂��B"
    FC_LogWriter ${DEF_RTNCD_NML} "�o�b�N�A�b�v��t�H���_[${UNYO_DB_EXTSND_BKD}]�����݂��Ȃ��ׁA�������ُ�I�����܂��B"
    EndProcess
}

#--------------------------------------------
# �ۑ��t�@�C����
#--------------------------------------------
${BK_DATETIME} = Get-Date -format "${COM_DATEFORM03}"
${BK_FILENAME} = "${LC_FILENAME}.${BK_DATETIME}"
${BK_FILEPATH} = "${UNYO_DB_EXTSND_BKD}\${BK_FILENAME}"

#--------------------------------------------
# �z�M�t�@�C���o�b�N�A�b�v����
#--------------------------------------------
try {
    ${RTN_CPY_TEMP} = Move-Item ${TG_FILEPATH} ${BK_FILEPATH} -Force
    ${RTN_CPY_CODE} = $?

    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "�z�M�t�@�C��[(${FILE_ID})${TG_FILEPATH}]�̃o�b�N�A�b�v����������I�����܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "�z�M�t�@�C��[(${FILE_ID})${TG_FILEPATH}]�̃o�b�N�A�b�v�����ɂăG���[���������܂����B"
        FC_LogWriter ${PRG_EXIT_CODE} "�z�M�t�@�C��[(${FILE_ID})${TG_FILEPATH}]�̃o�b�N�A�b�v�����ɂăG���[���������܂����B"
        EndProcess
    }

} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "�z�M�t�@�C��[(${FILE_ID})${TG_FILEPATH}]�̃o�b�N�A�b�v�����ɂĈُ킪�������܂����B"
    EndProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
