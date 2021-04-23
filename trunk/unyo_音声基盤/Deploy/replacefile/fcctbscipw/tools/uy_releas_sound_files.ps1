#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : �����t�@�C�������[�X�v���O����
#
# FILE      : uy_releas_sound_files.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/08/28 | R.YAMANO      | First Eddition
#============================================================================
# Environment Variable Setting
#----------------------------------------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "�����t�@�C�������[�X�v���O����"
${PRG_EXIT_CODE}    = 0

#----------------------------------------------------------------------------
#  Variable definition
#----------------------------------------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#----------------------------------------------------------------------------
# Local Env Setting
#----------------------------------------------------------------------------
${LOG_FLAG}  = 1
${ACT_TIME}  = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}  = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"
#----------------------------------------------------------------------------
# ���s���t�擾 (yyyyMMdd)
#----------------------------------------------------------------------------
${ACT_DATE}  = Get-Date -format "${COM_DATEFORM08}"

#----------------------------------------------------------------------------
# �����[�X�Ώۃt�@�C���i�[��`
#----------------------------------------------------------------------------
${LC_BASE_DISTDIR} = "D:\work\azbank\releas"
${LC_FILE_DISTDIR} = "${LC_BASE_DISTDIR}\wavs"
${LC_TEMP_DISTDIR} = "${LC_BASE_DISTDIR}\temp"
#----------------------------------------------------------------------------
# �o�b�N�A�b�v��`
#----------------------------------------------------------------------------
${LC_BASE_BKUPDIR} = "${LC_BASE_DISTDIR}\backup"
${LC_DATE_BKUPDIR} = "${LC_BASE_BKUPDIR}\${ACT_DATE}"
#----------------------------------------------------------------------------
# �����[�X����
#----------------------------------------------------------------------------
${LC_BASE_RELEDIR} = "D:\I3\IC\Resources\azbank\WAV"

#----------------------------------------------------------------------------
# Function
#----------------------------------------------------------------------------
# ���ʊ֐�
#----------------------------------------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#----------------------------------------------------------------------------
# MAIN
#----------------------------------------------------------------------------
# Start Main Program
#----------------------------------------------------------------------------
InitProcess

#----------------------------------------------------------------------------
# 1. ���O�m�F
#----------------------------------------------------------------------------
# 1.1 �����[�X�Ώۃt�@�C���i�[�p�f�B���N�g�����݃`�F�b�N
#----------------------------------------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "�����[�X�Ώۃt�@�C���i�[�p�f�B���N�g���̑��݃`�F�b�N�������J�n���܂��B"
if ( !(Test-Path ${LC_FILE_DISTDIR}) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    ${LC_MSG_LINE} = "�����[�X�Ώۃt�@�C���i�[�p�f�B���N�g��[${LC_FILE_DISTDIR}]�����݂��Ȃ��ׁA�����𒆎~���܂��B"
    outmsg 55 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
    FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
    EndProcess
}
FC_LogWriter ${DEF_RTNCD_NML} "�����[�X�Ώۃt�@�C���i�[�p�f�B���N�g���̑��݃`�F�b�N����������I�����܂����B"
#----------------------------------------------------------------------------
# 1.2 �����[�X�Ώۃt�@�C�����݃`�F�b�N
#----------------------------------------------------------------------------
# �����[�X�Ώۃt�@�C���m�F�����i�t�@�C���������ꍇ�͌㑱�����𒆎~�j
#----------------------------------------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "�����[�X�Ώۃt�@�C���m�F�������J�n���܂��B"
${TG_FIND_FILES} = @(Get-ChildItem ${LC_FILE_DISTDIR})
if ( ${TG_FIND_FILES}.length -eq 0 ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_NML}
    ${LC_MSG_LINE} = "�����[�X�Ώۃt�@�C�������݂��Ȃ��ׁA�������I�����܂��B"
    outmsg 1 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
    FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
    EndProcess
}
FC_LogWriter ${DEF_RTNCD_NML} "�����[�X�Ώۃt�@�C���m�F�������I�����܂����B"

#----------------------------------------------------------------------------
# 1.3 �����[�X����
#----------------------------------------------------------------------------
foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

    # �t�@�C�������FFile�݂̂��擾
    if ( ${FINDFILE}.PsISContainer -eq ${False} ) {
        ${TG_FILE_NAME}      = ${FINDFILE}.name
        ${TG_FILE_FULL_NAME} = ${FINDFILE}.fullname

        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]�̃����[�X�������J�n���܂��B"

        ${RL_FILE_FULL_NAME} = "${LC_BASE_RELEDIR}\${TG_FILE_NAME}"
        if ( (Test-Path ${RL_FILE_FULL_NAME}) ) {
            #----------------------------------------------------------------
            # 1.3.1 �����[�X�O�o�b�N�A�b�v����
            #----------------------------------------------------------------
            if ( !(Test-Path ${LC_DATE_BKUPDIR}) ) {
                FC_LogWriter ${DEF_RTNCD_NML} "�o�b�N�A�b�v�f�B���N�g��[${LC_DATE_BKUPDIR}]���쐬���܂��B"
                New-Item ${LC_DATE_BKUPDIR} -ItemType Directory 2>&1 > $null
            }
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]�̃����[�X�O�o�b�N�A�b�v�������J�n���܂��B"
            ${RTN_CPY_TEMP} = Copy-Item ${TG_FILE_FULL_NAME} ${LC_DATE_BKUPDIR}\${TG_FILE_NAME}.${ACT_TIME} -Recurse
            ${RTN_CPY_CODE} = $?
            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]�̃����[�X�O�o�b�N�A�b�v����������I�����܂����B"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                ${LC_MSG_LINE} = "[${TG_FILE_NAME}]�̃����[�X�O�o�b�N�A�b�v�����ɂăG���[���������܂����B"
                outmsg 55 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
                FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
                EndProcess
            }
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]�͏��񃊃��[�X�ׁ̈A�o�b�N�A�b�v�����͍s���܂���B"
        }

        #--------------------------------------------------------------------
        # 1.3.2 �����[�X����
        #--------------------------------------------------------------------
        ${RTN_CPY_TEMP} = Copy-Item ${TG_FILE_FULL_NAME} ${RL_FILE_FULL_NAME} -Recurse
        ${RTN_CPY_CODE} = $?
        if ( ${RTN_CPY_CODE} ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]�̃����[�X����������I�����܂����B"
        } else {
            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
            ${LC_MSG_LINE} = "[${TG_FILE_NAME}]�̃����[�X�����ɂăG���[���������܂����B"
            outmsg 55 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
            FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
            EndProcess
        }

        #--------------------------------------------------------------------
        # 1.3.3 �����[�X���㏈���i�����[�X�Ώۃt�@�C���N���A�����j
        #--------------------------------------------------------------------
        if ( (Test-Path ${TG_FILE_FULL_NAME}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]�����[�X�p�t�@�C���̍폜�������s���܂��B"
            Remove-Item ${TG_FILE_FULL_NAME} -Recurse 2>&1 > $null
            ${RTN_DEL_CODE} = $?
            if ( ${RTN_DEL_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]�����[�X�p�t�@�C���̍폜����������I�����܂����B"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                ${LC_MSG_LINE} = "[${TG_FILE_NAME}]�����[�X�p�t�@�C���̍폜�����ɂăG���[���������܂����B"
                outmsg 55 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
                FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
                EndProcess
            }
        }

    }
}

#----------------------------------------------------------------------------
# End Main Program
#----------------------------------------------------------------------------
EndProcess
