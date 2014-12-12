#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : DB�o�b�N�A�b�v���㏈��(NAS�ۊ�)
#
# FILE      : uy_db_backup_nas_save.ps1
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
${PRG_NAME}         = "DB�o�b�N�A�b�v���㏈��(NAS�ۊ�)"
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
${NAS_DIRS}         = "${COM_NAS_BASE_DIRS}\${COM_DBSV_VHOST}\dbbackup"
${ACT_FLAG}         = "${UNYO_TMP_DIR}\${COM_FULLBKUP_FLAG}"
${FLG_CHEK}         = 9

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
# Start Main Program
InitProcess

#--------------------------------------------
# Action Flag Check
# (���݂���ꍇ�̂݌㑱���������s)
#--------------------------------------------
for ( ${i} = 1 ; ${i} -le ${COM_NASLP_CNTS} ; ${i}++ ) {

    if ( Test-Path ${ACT_FLAG} ) {
        ${FLG_CHEK} = 0
        break
    }
    Start-Sleep -s ${COM_NASWT_TIME}
}
if ( ${FLG_CHEK} -ne 0 ) {
    outmsg 55 ${DEF_RTNCD_ERR} "NAS�]�������̎��s�����𒴉߂��܂����B�����𒆎~���܂��B"
    FC_LogWriter 1 "NAS�]�������̎��s�����𒴉߂��܂����B�����𒆎~���܂��B"
    EndProcess
}

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
# �O�����t�擾 (YYYYMMDD)
${LCD_YESTERDAY} = ${UNYO_DATE}.Insert(4,"/").Insert(7,"/")
${BEF_UNYO_DATE} = (Get-Date ${LCD_YESTERDAY}).AddDays(-1).ToString(${COM_DATEFORM08})

#--------------------------------------------
# DB�t���o�b�N�A�b�v�W���u���㏈��
#--------------------------------------------
# 1.DB�t���o�b�N�A�b�v�iNAS�ۊǕ��j�̍폜
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "DB�t���o�b�N�A�b�v���㏈��(�O���t���o�b�N�A�b�v(NAS�ۊǕ�)�̍폜����)���J�n���܂��B"
# DB�t���o�b�N�A�b�v (��{�f�B���N�g��)���݃`�F�b�N
if ( !(Test-Path ${NAS_DIRS}) ) {
    FC_LogWriter ${DEF_RTNCD_NML} "DB�t���o�b�N�A�b�v(��{�f�B���N�g��)[${NAS_DIRS}]���쐬���܂��B"
    New-Item ${NAS_DIRS} -ItemType Directory 2>&1 > $null
}

# �ߋ����t�̕ۊǃf�B���N�g�������݂���ꍇ�͍폜
${LC_ACT_COUNT} = 0
${TG_FIND_DIRS} = @(Get-ChildItem ${NAS_DIRS})
if ( ${TG_FIND_DIRS}.length -gt 0 ) {
    foreach ( ${FINDDIRS} in ${TG_FIND_DIRS} ) {
        # �폜�Ώۂ̓f�B���N�g��
        if ( ${FINDDIRS}.PsISContainer -eq ${True} ) {
            ${LC_ACT_COUNT}++
            ${DELETE_FINDDIR_NM}  = ${FINDDIRS}.name
            ${DELETE_FINDDIR_DR}  = ${FINDDIRS}.fullname

            # �^�p���t(�����p�f�B���N�g���͏���)
            if ( ${DELETE_FINDDIR_NM} -eq ${UNYO_DATE} ) {
                continue
            }
            # �O�����t(2����O�f�B���N�g���͏���)
            if ( ${DELETE_FINDDIR_NM} -eq ${BEF_UNYO_DATE} ) {
                continue
            }

            FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FINDDIR_DR}]�̍폜�������J�n���܂��B"
            Remove-Item ${DELETE_FINDDIR_DR} -Recurse 2>&1 > $null
            ${RTN_DEL_CODE} = $?
            if ( ${RTN_DEL_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FINDDIR_DR}]�̍폜����������I�����܂����B"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "[${DELETE_FINDDIR_DR}]�̍폜�����ɂăG���[���������܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "[${DELETE_FINDDIR_DR}]�̍폜�����ɂăG���[���������܂����B"
                EndProcess
            }
        }
    }
    if ( ${LC_ACT_COUNT} -eq 0 ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${NAS_DIRS}]�z���ɍ폜�Ώۂ̕ۊǃf�B���N�g�������݂��܂���ł����B"
    }
}
FC_LogWriter ${DEF_RTNCD_NML} "DB�t���o�b�N�A�b�v���㏈��(�O���t���o�b�N�A�b�v(NAS�ۊǕ�)�̍폜����)���I�����܂��B"

#--------------------------------------------
# 2.DB�t���o�b�N�A�b�v�iNAS�ۊǏ����j
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "DB�t���o�b�N�A�b�v���㏈��(NAS�ۊǏ���)���J�n���܂��B"
${TG_FIND_FILES} = @(Get-ChildItem ${UNYO_DB_FLBKUP_DIR})
if ( ${TG_FIND_FILES}.length -gt 0 ) {

    # DB�t���o�b�N�A�b�v�� �������ۊǗpNAS�f�B���N�g�����݃`�F�b�N
    ${ACTDAY_DB_BKUPDIR} = "${NAS_DIRS}\${UNYO_DATE}"
    if ( !(Test-Path ${ACTDAY_DB_BKUPDIR}) ) {
        FC_LogWriter ${DEF_RTNCD_NML} "DB�t���o�b�N�A�b�v(�����ۊǗpNAS�f�B���N�g��)[${ACTDAY_DB_BKUPDIR}]���쐬���܂��B"
        New-Item ${ACTDAY_DB_BKUPDIR} -ItemType Directory 2>&1 > $null
    }

    foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {
        if ( ${FINDFILE}.PsISContainer -eq ${False} ) {
            ${COPY_FILEDIFI_S} = ${FINDFILE}.fullname
            FC_LogWriter ${DEF_RTNCD_NML} "[${COPY_FILEDIFI_S}]�̃R�s�[�������J�n���܂��B"
            ${RTN_CPY_TEMP} = Copy-Item ${COPY_FILEDIFI_S} ${ACTDAY_DB_BKUPDIR} -Recurse
            ${RTN_CPY_CODE} = $?
            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${COPY_FILEDIFI_S}]�̃R�s�[����������I�����܂����B"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "[${COPY_FILEDIFI_S}]�̃R�s�[�����ɂăG���[���������܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "[${COPY_FILEDIFI_S}]�̃R�s�[�����ɂăG���[���������܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "DB�t���o�b�N�A�b�v���㏈��(NAS�ۊǏ���)���ُ�I�����܂����B"
                EndProcess
            }
        }
    }
}
FC_LogWriter ${PRG_EXIT_CODE} "DB�t���o�b�N�A�b�v���㏈��(NAS�ۊǏ���)���I�����܂����B"

#--------------------------------------------
# �^�X�N�X�P�W���[������t���O (�폜)
#--------------------------------------------
if ( Test-Path ${ACT_FLAG} ) {
    Remove-Item ${ACT_FLAG} -Recurse 2>&1 > $null
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
