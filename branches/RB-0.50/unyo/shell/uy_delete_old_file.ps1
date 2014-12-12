#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �s�v�t�@�C���폜
#
# FILE      : uy_delete_old_file.ps1
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
${PRG_NAME}         = "�s�v�t�@�C���폜"
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
# ��`�t�@�C���w��擾 (�w��̏ꍇ�̂�)
if ( ${PRM_FilePATH} -ne "x" ) {
    ${DELETE_FILE_DEF} = ${PRM_FilePATH}
}

#--------------------------------------------
# �s�v�t�@�C���폜����
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${DELETE_FILE_DEF}]�����擾���܂�(�s�v�t�@�C���폜)"

# ��`�t�@�C�����݃`�F�b�N
if ( !(Test-Path ${DELETE_FILE_DEF}) ) {
    # ���݂��Ȃ��ׁA�ُ�I��
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${DELETE_FILE_DEF}"
    FC_LogWriter ${PRG_EXIT_CODE} "��`�t�@�C��[${DELETE_FILE_DEF}]�����݂��Ȃ��׈ُ�I�����܂�(�s�v�t�@�C���폜)"
    EndProcess
}

#--------------------------------------------
# �s�v�t�@�C���폜����
#--------------------------------------------
# ��`�t�@�C���Ǎ�
foreach ( ${LC_LINE01} in Get-Content ${DELETE_FILE_DEF} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

    # ���������m�F�p
    ${LC_ACT_COUNT} = 0
    # �폜�敪�擾(F:�t�@�C��,D:�f�B���N�g��)
    ${TG_DELET_TYPE}        = "${LC_LINE01}" | %{ $_.Split(",")[0] }
    # �폜�Ώۏ�ʃf�B���N�g���擾 (�L�[�u���L�ڋ��e)
    ${TG_SORCE_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
    # �폜�ΏۑΏۃf�B���N�g��/�t�@�C���擾 (���C���h�J�[�h�L�ځA�L�[�u���L�ڋ��e)
    ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
    # �ۊǓ����擾 (���t�w��)
    ${TG_STRAG_DAYS}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }

    # �폜�Ώۏ�ʃf�B���N�g���m�F����
    if ( !(${TG_SORCE_DIRS}.EndsWith("\")) ) {
        # �f�B���N�g�����L�ڕ��@�̕⊮����
        # �I���͂��̕����ł͂Ȃ��ׁA�Ō��[\]��t��
        ${TG_SORCE_DIRS} = ${TG_SORCE_DIRS} + "\"
    }
    # �폜�Ώۏ�ʃf�B���N�g�� �L�[�u������
    if ( ${TG_SORCE_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
        ${TG_SORCE_DIRS} = FC_ReplaceString "${TG_SORCE_DIRS}" -tdate ${PRM_ReRunDay}
    }
    ${TG_SORCE_DIRS} = Invoke-Expression "Write-Output ${TG_SORCE_DIRS}"
    # �f�B���N�g�����݃`�F�b�N
    if ( !(Test-Path ${TG_SORCE_DIRS}) ) {
        FC_LogWriter ${DEF_RTNCD_NML} "�폜�Ώۏ�ʃf�B���N�g��[${TG_SORCE_DIRS}]�����݂��Ȃ��׃X�L�b�v���܂��B"
        continue
    }

    # �폜�Ώۃt�@�C�����o
    ${TG_SORCE_DIFI} = "${TG_SORCE_DIRS}" + "${TG_SORCE_FILE}"

    # �폜�敪�`�F�b�N
    switch("${TG_DELET_TYPE}") {
        "F"     { ${DEL_CHKFLG} = ${False} ; ${DEL_CHKMSG} = "�t�@�C��"     ; break }
        "D"     { ${DEL_CHKFLG} = ${True}  ; ${DEL_CHKMSG} = "�f�B���N�g��" ; break }
        default { FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]�t�@�C���܂��̓f�B���N�g���̍폜�敪�w��Ɍ�肪��܂��������X�L�b�v���܂��B" 
                  continue
                }
    }

    # �Ώۑ��݃`�F�b�N
    if ( !(Test-Path ${TG_SORCE_DIFI}) ) { 
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]${DEL_CHKMSG}�����݂��Ȃ��ׁA�������X�L�b�v���܂��B"
        continue
    }
    
    ${TG_FIND_FILES} = @(Get-ChildItem ${TG_SORCE_DIFI})
    if ( ${TG_FIND_FILES}.length -gt 0 ) {
        foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

            # �^�p���t����Ƃ����ۊǓ������Z�o
            try {
                ${LC_CAL_UNYO_DATE} = ${UNYO_DATE}.Insert(4,"/").Insert(7,"/")
                ${LC_CAL_TERM} = ([DateTime]((Get-Date ${LC_CAL_UNYO_DATE}).ToString(${COM_DATEFORM02}))- [DateTime]((Get-Date).ToString(${COM_DATEFORM02}))).Days
            } catch [Exception] {
                ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
                FC_LogWriter ${PRG_EXIT_CODE} "�^�p���t����ёO��擾���擾�����ɂĎ��s���܂����B�㑱�����𒆎~���܂��B"
                EndProcess
            }

            ${DELETE_COUNTDATES} = (((Get-Date).AddDays(${LC_CAL_TERM})) - ${FINDFILE}.LastWriteTime).Days

            # (�w����ȏ�Â��t�@�C��) ���� (�t�H���_ or �t�@�C��)
            if (( ${DELETE_COUNTDATES} -ge ${TG_STRAG_DAYS} ) -and ( ${FINDFILE}.PsISContainer -eq ${DEL_CHKFLG} )) {

                ${LC_ACT_COUNT}++
                ${DELETE_FILENAME_SOURCE} = ${FINDFILE}.name
                ${DELETE_FILEDIFI_S}      = ${FINDFILE}.fullname

                FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}�̍폜�������J�n���܂��B"

                if ( !(Test-Path ${DELETE_FILEDIFI_S}) ) {
                    FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}�͊��ɍ폜�ς݂ł��B"
                    FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}�̍폜�����̓X�L�b�v���܂��B"
                    continue
                }

                Remove-Item ${DELETE_FILEDIFI_S} -Recurse 2>&1 > $null
                ${RTN_DEL_CODE} = $?
                if ( ${RTN_DEL_CODE} ) {
                    FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}�̍폜����������I�����܂����B"
                } else {
                    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                    outmsg 1 ${PRG_EXIT_CODE} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}�̍폜�����ɂăG���[���������܂����B"
                    FC_LogWriter ${PRG_EXIT_CODE} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}�̍폜�����ɂăG���[���������܂����B"
                    EndProcess
                }

            }

        }

    }

    if ( ${LC_ACT_COUNT} -eq 0 ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]${DEL_CHKMSG}�͍폜�Ώۂ����݂��܂���ł����B"
        continue
    }

}


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
