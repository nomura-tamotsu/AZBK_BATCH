#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ���O�t�@�C��ZIP���k����
#
# FILE      : uy_zip_log_file.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 23/05/18 | ISIDIT Doi    | First Eddition
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
${PRG_NAME}         = "���O�t�@�C��ZIP���k����"
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
# �^�p���t�擾 (YYYYMMDD) ���Ď��s�w�莞�B
if ( $PRM_ReRunDay -ne "x" ) {
    if ( ! (${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet) ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 55 ${DEF_RTNCD_ERR} "�^�p���t�̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        FC_LogWriter 1 "�^�p���t�̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
        EndProcess
    }
}
${LC_CHGDATE} = ${PRM_ReRunDay}

# ��`�t�@�C���w��擾 (�w��̏ꍇ�̂�)
if ( ${PRM_FilePATH} -ne "x" ) {
    ${ZIP_LOG_FILE_DEF} = ${PRM_FilePATH}
}

# ��`�t�@�C�����݃`�F�b�N
FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${ZIP_LOG_FILE_DEF}]�����擾���܂�(${PRG_NAME})"
if ( !(Test-Path ${ZIP_LOG_FILE_DEF}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${ZIP_LOG_FILE_DEF}"
    FC_LogWriter ${DEF_RTNCD_ERR} "��`�t�@�C��[${ZIP_LOG_FILE_DEF}]�͑��݂��Ȃ��ׁA�����𒆎~���܂�(${PRG_NAME})"
    EndProcess
}

#--------------------------------------------
# ���O�t�@�C��ZIP���k���� ���C�����[�v
#--------------------------------------------

    # ��`�̏��������J�E���g
    ${LINE_COUNT} = 0

try {
    foreach ( ${LC_LINE01} in Get-Content ${ZIP_LOG_FILE_DEF} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

        ${LINE_CclearOUNT}++

        FC_LogWriter ${DEF_RTNCD_NML} "---- ��`�t�@�C�� ${LINE_COUNT} ���ڂ̏��� ----"

        # ���������m�F�p
        ${LC_ACT_COUNT} = 0

        # ��`�t�@�C������ݒ�l�擾
        # 1��ځF�Ώۏ�ʃf�B���N�g���擾 (�L�[�u���L�ڋ��e)
        ${TG_SORCE_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[0] }
        # 2��ځF�Ώۃt�@�C���擾 (���C���h�J�[�h�L�ځA�L�[�u���L�ڋ��e)
        ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
        # 3��ځF�ۊǐ�f�B���N�g���擾 (�L�[�u���L�ڋ��e)
        ${TG_DESTI_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
        # 4��ځFZIP���k�t�@�C���擾 (�L�[�u���L�ڋ��e)
        ${TG_ZIP_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }

        FC_LogWriter ${DEF_RTNCD_NML} "�Ώۏ�ʃf�B���N�g���F${TG_SORCE_DIRS}"
        FC_LogWriter ${DEF_RTNCD_NML} "�Ώۃt�@�C��        �F${TG_SORCE_FILE} "
        FC_LogWriter ${DEF_RTNCD_NML} "�ۊǐ�f�B���N�g��  �F${TG_DESTI_DIRS}"
        FC_LogWriter ${DEF_RTNCD_NML} "ZIP���k�t�@�C���擾 �F${TG_ZIP_FILE}"

        # �Ώۏ�ʃf�B���N�g���m�F����
        if ( !(${TG_SORCE_DIRS}.EndsWith("\")) ) {
            ${TG_SORCE_DIRS} = ${TG_SORCE_DIRS} + "\"
        }
        # �Ώۏ�ʃf�B���N�g�� �L�[�u������
        if ( ${TG_SORCE_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_SORCE_DIRS} = FC_ReplaceString "${TG_SORCE_DIRS}" -tdate ${LC_CHGDATE}
        }
        ${TG_SORCE_DIRS} = Invoke-Expression "Write-Output ${TG_SORCE_DIRS}"
        FC_LogWriter ${DEF_RTNCD_NML} "�L�[�u���� �Ώۏ�ʃf�B���N�g���F${TG_SORCE_DIRS}"

        # �f�B���N�g�����݃`�F�b�N
        if ( !(Test-Path ${TG_SORCE_DIRS}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "�Ώۏ�ʃf�B���N�g��[${TG_SORCE_DIRS}]�����݂��Ȃ��׃X�L�b�v���܂��B"
            continue
        }

        # �Ώۃt�@�C�� �L�[�u������
        if ( ${TG_SORCE_FILE} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_SORCE_FILE} = FC_ReplaceString "${TG_SORCE_FILE}" -tdate ${LC_CHGDATE}
        }
        FC_LogWriter ${DEF_RTNCD_NML} "�L�[�u���� �Ώۃt�@�C��        �F${TG_SORCE_FILE} "

        # �ۊǐ�f�B���N�g�� �m�F����
        if ( !(${TG_DESTI_DIRS}.EndsWith("\")) ) {
            ${TG_DESTI_DIRS} = ${TG_DESTI_DIRS} + "\"
        }
        # �ۊǐ�f�B���N�g�� �L�[�u���L�ڋ��e
        if ( ${TG_DESTI_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_DESTI_DIRS} = FC_ReplaceString "${TG_DESTI_DIRS}" -tdate ${LC_CHGDATE}
        }
        ${TG_DESTI_DIRS} = Invoke-Expression "Write-Output ${TG_DESTI_DIRS}"
        FC_LogWriter ${DEF_RTNCD_NML} "�L�[�u���� �ۊǐ�f�B���N�g��  �F${TG_DESTI_DIRS}"

        # ZIP�t�@�C�� �L�[�u������
        if ( ${TG_ZIP_FILE} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_ZIP_FILE} = FC_ReplaceString "${TG_ZIP_FILE}" -tdate ${LC_CHGDATE}
        }
        ${TG_ZIP_FILE} = Invoke-Expression "Write-Output ${TG_ZIP_FILE}"
        FC_LogWriter ${DEF_RTNCD_NML} "�L�[�u���� ZIP���k�t�@�C���擾 �F${TG_ZIP_FILE}"

        # �f�B���N�g�����݃`�F�b�N
        if ( !(Test-Path ${TG_DESTI_DIRS}) ) {
            # ���݂��Ȃ���Εۊǐ�f�B���N�g���쐬
            FC_LogWriter ${DEF_RTNCD_NML} "�ۊǐ�f�B���N�g��[${TG_DESTI_DIRS}]���쐬���܂��B"

            New-Item ${TG_DESTI_DIRS} -ItemType Directory 2>&1 > $null
            ${RTN_MKDIR_CODE} = $?
            if ( ${RTN_MKDIR_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "�ۊǐ�f�B���N�g��[${TG_DESTI_DIRS}]���쐬���܂����B"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "�ۊǐ�f�B���N�g��[${TG_DESTI_DIRS}]�̍쐬�ɂăG���[���������܂����B"
                FC_LogWriter ${DEF_RTNCD_ERR} "�ۊǐ�f�B���N�g[${TG_DESTI_DIRS}]�̍쐬�ɂăG���[���������܂����B�㑱�����𒆎~���܂�"
                EndProcess
            }
        }

        # �Ώۃt�@�C�����o
        ${TG_SORCE_DIFI} = "${TG_SORCE_DIRS}" + "${TG_SORCE_FILE}"

        # �Ώۑ��݃`�F�b�N
        if ( !(Test-Path ${TG_SORCE_DIFI}) ) { 
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]�����݂��Ȃ��ׁA�������X�L�b�v���܂��B"
            continue
        }

        # �Ώۃt�H���_�A�Ώۃt�@�C���p�^�[���Ńt�@�C���������A�Ώۃ��X�g���쐬
        ${TG_FIND_FILES} = @(Get-ChildItem ${TG_SORCE_DIFI})

        ${TG_FILE_COUN} = ${TG_FIND_FILES}.length
        FC_LogWriter ${DEF_RTNCD_NML} "�����Ώی����F${TG_FILE_COUN}��"

        # �Ώۃt�@�C�������݂��Ȃ��ꍇ�A�������X�L�b�v
        if ( ${TG_FIND_FILES}.length -eq 0 ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]��ZIP���k�����Ώۂ����݂��܂���ł����B"
            continue
        }

        #--------------------------------------------
        # ���O�t�@�C��ZIP���k����(Phase.01-COPY����)
        #--------------------------------------------
        ${LC_STEPMSG} = "Phase.01-COPY����"
        FC_LogWriter ${DEF_RTNCD_NML} "��${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"

        # ���k�Ώۃt�@�C�����ꎞ�I�ɃR�s�[����B�i���v���Z�X���g�p���̃��O�t�@�C�������k�����ɂăG���[�ƂȂ邽�߁j
        foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

            ${LC_ACT_COUNT}++

            ${COPY_FILENAME_SOURCE} = ${FINDFILE}.name
            ${COPY_FILEDIFI_S}      = ${FINDFILE}.fullname
            ${COPY_FILEDIFI_D}      = ${TG_DESTI_DIRS}

            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]�̃R�s�[�������J�n���܂��B"

            # �Ώۃt�@�C���̑��݃`�F�b�N�i�������肦�Ȃ��j
            if ( !(Test-Path ${COPY_FILEDIFI_S}) ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]�����݂��Ȃ��ׁA�R�s�[�������X�L�b�v���܂��B"
                continue
            }

            # ��COPY����
            try { 
                ${RTN_CPY_TEMP} = Copy-Item ${COPY_FILEDIFI_S} ${COPY_FILEDIFI_D} -Recurse
                ${RTN_CPY_CODE} = $?
            } catch [Exception] {
                ${RTN_CPY_CODE} = ${False}
            }

            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]�̃R�s�[����������I�����܂����B"
            } else {
                # �G���[
                outmsg 55 ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]�̃R�s�[�����ɂăG���[���������܂����A�������X�L�b�v���܂�"
                FC_LogWriter ${DEF_RTNCD_ERR} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]�̃R�s�[�����ɂăG���[���������܂����A�������X�L�b�v���܂��B"
            }
        }

        #--------------------------------------------
        # ���O�t�@�C��ZIP���k����(Phase.02-ZIP���k����)
        #--------------------------------------------
        ${LC_STEPMSG} = "Phase.02-ZIP���k����"
        FC_LogWriter ${DEF_RTNCD_NML} "��${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"

        # ���k�Ώۂ̃R�s�[���O�t�@�C���̃t���p�X���i���C���h�J�[�h�܂ށj
        ${ARC_PATH}= ${COPY_FILEDIFI_D} + ${TG_SORCE_FILE}

        # ZIP���k�t�@�C���̃t���p�X��
        ${ZIP_PATH}= ${COPY_FILEDIFI_D} + ${TG_ZIP_FILE}

        # ���k�Ώۂ̃R�s�[���O�t�@�C���̑��݃`�F�b�N
        if ( !(Test-Path ${ARC_PATH}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[[${ARC_PATH}]�ɊY������t�@�C�������݂��Ȃ��ׁA���k�������X�L�b�v���܂��B"
            continue
        }


        FC_LogWriter ${DEF_RTNCD_NML} "[${ZIP_PATH}]�ւ̈��k�������J�n���܂��B"

        # ��ZIP���k����
        # ZIP���k�t�@�C���̑��݃`�F�b�N�i�Ď��s�����j
        if ( (Test-Path ${ZIP_PATH}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "ZIP���k�t�@�C��[${ZIP_PATH}]�����݂���ׁA�폜���܂��B"

            # ���łɑ��݂��铯����ZIP���k�t�@�C�����폜
            Remove-item ${ZIP_PATH}

            FC_LogWriter ${DEF_RTNCD_NML} "ZIP���k�t�@�C��[${ZIP_PATH}]�̍폜���������܂����B"
        }

        # ZIP���k���� ���s
        try { 
            # ZIP���k ("-ErrorAction Stop"�ŃG���[���ɗ�O���X���[����悤�Ɏw��)
            ${RTN_CPY_TEMP} = Compress-Archive -Path ${ARC_PATH} -DestinationPath ${ZIP_PATH} -ErrorAction Stop
            ${RTN_CPY_CODE} = $?
        } catch [Exception] {
            ${RTN_CPY_CODE} = ${False}
            ${ERROR_MESSAGE} = $_.Exception.Message
            FC_LogWriter ${DEF_RTNCD_NML} "ZIP���k�����ŃG���[���������܂����B${ERROR_MESSAGE}"
       }

        if ( ${RTN_CPY_CODE} ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${ZIP_PATH}]�ւ̈��k����������I�����܂����B"
        } else {
            # �ُ�I��(NAS�ۊǂ��ׂ����O�������ł��Ȃ��̂ŃG���[���m������B) 
            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
            outmsg 55 ${DEF_RTNCD_ERR} "[${ZIP_PATH}]�ւ̈��k�����ɂăG���[���������܂���(${ERROR_MESSAGE})�A�������X�L�b�v���܂��B"
            FC_LogWriter ${DEF_RTNCD_ERR} "[${ZIP_PATH}]�ւ̈��k�����ɂăG���[���������܂����A�������X�L�b�v���܂��B"
            continue
        }

        #--------------------------------------------
        # ���k�σ��O�t�@�C���폜����(Phase.03-DELETE����)
        #--------------------------------------------
        ${LC_STEPMSG} = "Phase.03-DELETE����"
        FC_LogWriter ${DEF_RTNCD_NML} "��${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"

        # ���k�ς̃��O�t�@�C����Ώۃt�@�C���p�^�[���Ńt�@�C���������A�폜�Ώۃ��X�g���쐬
        ${ARC_TG_FIND_FILES} = @(Get-ChildItem ${ARC_PATH})

        ${TG_FILE_COUN} = ${ARC_TG_FIND_FILES}.length
        FC_LogWriter ${DEF_RTNCD_NML} "�ꎞ�t�@�C���폜�Ώی����F${TG_FILE_COUN}��"

        # �폜�Ώۃt�@�C�������݂��Ȃ��ꍇ�A�������X�L�b�v
        if ( ${ARC_TG_FIND_FILES}.length -eq 0 ) {
            FC_LogWriter ${DEF_RTNCD_NML} "�폜�Ώۂ�[${ARC_TG_FIND_FILES}]�̃t�@�C���͑��݂��܂���ł����B"
            continue
        }

        ${LC_ACT_COUNT} = 0

        # ���k�ς̑Ώۃt�@�C�����폜����B
        foreach ( ${FINDFILE} in ${ARC_TG_FIND_FILES} ) {

            ${LC_ACT_COUNT}++

            ${DEL_FILEDIFI_S}      = ${FINDFILE}.fullname
            ${DEL_FILEDIFI_D}      = ${TG_DESTI_DIRS}

            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${DEL_FILEDIFI_S}]�̍폜�������J�n���܂��B"

            # �Ώۃt�@�C���̑��݃`�F�b�N�i�������肦�Ȃ��j
            if ( !(Test-Path ${DEL_FILEDIFI_S}) ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${DEL_FILEDIFI_S}]�����݂��Ȃ��ׁA�폜�������X�L�b�v���܂��B"
                continue
            }

            # ��DELETE����
            try { 
                ${RTN_DEL_TEMP} = Remove-item ${DEL_FILEDIFI_S} -ErrorAction Stop
                ${RTN_DEL_CODE} = $?
            } catch [Exception] {
                ${RTN_DEL_CODE} = ${False}
                ${ERROR_MESSAGE} = $_.Exception.Message
            }

            if ( ${RTN_DEL_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${DEL_FILEDIFI_S}]�̍폜����������I�����܂����B"
            } else {
                # �폜�G���[����
                FC_LogWriter ${DEF_RTNCD_ERR} "[${LC_ACT_COUNT}][${DEL_FILEDIFI_S}]�̍폜�����ɂăG���[���������܂���(${ERROR_MESSAGE})�B�������X�L�b�v���܂��B"
                # ���̃t�@�C���폜���p������B�����O�t�@�C���͎c���Ă��ʓr���O�����e�i���X�̍폜�����Ńt�H���_���ƍ폜�����
                continue
            }
        }
    }

} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    ${ERROR_MESSAGE} = $_.Exception.Message

    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B${ERROR_MESSAGE}"

    EndProcess
}


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
