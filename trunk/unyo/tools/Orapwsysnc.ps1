#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : �t�@�C�������v���O����(�T���v��)
#
# FILE      : uy_sample_file_sysnc.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/06/28 | R.YAMANO      | First Eddition
#============================================================================
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "�t�@�C�������v���O����(�T���v��)"
${PRG_EXIT_CODE}    = 0

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${LOG_FLAG}          = 1
${ACT_TIME}          = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}          = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"
#--------------------------------------------
# �������
#--------------------------------------------
# ������T�[�o��
${LC_SYNC_HOST}      = "fcctbsappw02"
# �������f�B���N�g���p�X
${LC_SYNC_SRCE_DIR} = "D:\BANKR_CC\temp"
# ������f�B���N�g���p�X(UNC�p�X�\�L)
${LC_SYNC_DEST_DIR} = "\\${LC_SYNC_HOST}\D$\BANKR_CC\temp"

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
# �擾��T�[�o�����`�F�b�N (ICMP���x��)
#--------------------------------------------
if ( !(Test-Connection ${LC_SYNC_HOST} -quiet) ) {
    # �ڑ��s�\�ׁ̈A�����𒆎~���܂��B
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "�t�@�C�������T�[�o[${LC_SYNC_HOST}]�ɐڑ��ł��Ȃ��ׁA�����𒆎~���܂��B"
    FC_LogWriter ${PRG_EXIT_CODE} "�t�@�C��������T�[�o[${LC_SYNC_HOST}]�ɐڑ��ł��Ȃ��ׁA�����𒆎~���܂��B"
    EndProcess
}

#--------------------------------------------
# 1. ���O�m�F
#--------------------------------------------
#--------------------------------------------
# 1.1 �������f�B���N�g�����݃`�F�b�N
#--------------------------------------------
FC_LogWriter ${LC_SYNC_DEST_DIR} "�t�@�C���������f�B���N�g���̑��݃`�F�b�N�������J�n���܂��B"
if ( !(Test-Path ${LC_SYNC_SRCE_DIR}) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "�t�@�C���������f�B���N�g��[${LC_SYNC_SRCE_DIR}]�����݂��Ȃ��ׁA�����𒆎~���܂��B"
    FC_LogWriter ${PRG_EXIT_CODE} "�t�@�C���������f�B���N�g��[${LC_SYNC_SRCE_DIR}]�����݂��Ȃ��ׁA�����𒆎~���܂��B"
    EndProcess
}
FC_LogWriter ${LC_SYNC_DEST_DIR} "�t�@�C���������f�B���N�g���̑��݃`�F�b�N����������I�����܂����B"
#--------------------------------------------
# 1.2 ������f�B���N�g���󋵃`�F�b�N
#--------------------------------------------
FC_LogWriter ${LC_SYNC_DEST_DIR} "�t�@�C��������f�B���N�g���ւ̃A�N�Z�X�󋵊m�F�������J�n���܂��B"
if ( !(Test-Path ${LC_SYNC_DEST_DIR}) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "�t�@�C��������f�B���N�g��[${LC_SYNC_DEST_DIR}]�ւ̃A�N�Z�X���s���Ȃ��ׁA�����𒆎~���܂��B"
    FC_LogWriter ${PRG_EXIT_CODE} "�t�@�C��������f�B���N�g��[${LC_SYNC_DEST_DIR}]�ւ̃A�N�Z�X���s���Ȃ��ׁA�����𒆎~���܂��B"
    EndProcess
}
FC_LogWriter ${LC_SYNC_DEST_DIR} "�t�@�C��������f�B���N�g���ւ̃A�N�Z�X�󋵊m�F����������I�����܂����B

#--------------------------------------------
# 2.�t�@�C����������
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "�t�@�C�������������J�n���܂��B"
${TG_FIND_FILES} = @(Get-ChildItem ${LC_SYNC_SRCE_DIR})
if ( ${TG_FIND_FILES}.length -gt 0 ) {

    foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {
        if ( ${FINDFILE}.PsISContainer -eq ${False} ) {
            ${COPY_FILEDIFI_S} = ${FINDFILE}.fullname
            FC_LogWriter ${DEF_RTNCD_NML} "[${COPY_FILEDIFI_S}]�̃R�s�[�������J�n���܂��B"
            ${RTN_CPY_TEMP} = Copy-Item ${COPY_FILEDIFI_S} ${LC_SYNC_DEST_DIR} -Recurse
            ${RTN_CPY_CODE} = $?
            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${COPY_FILEDIFI_S}]�̃R�s�[����������I�����܂����B"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "[${COPY_FILEDIFI_S}]�̃R�s�[�����ɂăG���[���������܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "[${COPY_FILEDIFI_S}]�̃R�s�[�����ɂăG���[���������܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "�t�@�C�������������ُ�I�����܂����B"
                EndProcess
            }
        }
    }
}
FC_LogWriter ${PRG_EXIT_CODE} "�t�@�C�������������I�����܂����B"

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
