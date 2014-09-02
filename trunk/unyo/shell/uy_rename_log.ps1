#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : ���O�t�@�C�����l�[��
#
# FILE      : uy_rename_log.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/01/19 | R.YAMANO      | First  Eddition
# %01 | 07/07/01 | R.YAMANO      | Second Eddition
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
${PRG_NAME}         = "���O�t�@�C�����l�[��"
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
    ${RENAME_FILE_DEF} = ${PRM_FilePATH}
}

#--------------------------------------------
# ���l�[�����R�s�[���� (�ΏۑS�t�@�C��)
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${RENAME_FILE_DEF}]�����擾���܂�(���l�[������)"

# ��`�t�@�C�����݃`�F�b�N
if ( !(Test-Path ${RENAME_FILE_DEF}) ) {
    # ���݂��Ȃ��ׁA�ُ�I��
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${RENAME_FILE_DEF}"
    FC_LogWriter ${PRG_EXIT_CODE} "��`�t�@�C��[${RENAME_FILE_DEF}]�����݂��Ȃ��׈ُ�I�����܂�(���l�[������)"
    EndProcess
}

#--------------------------------------------
# ���l�[�����R�s�[�������N���A����
#--------------------------------------------
# ��`�t�@�C���Ǎ�
#--------------------------------------------
foreach ( ${LC_LINE01} in Get-Content ${RENAME_FILE_DEF} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

    #--------------------------------------------
    # �N���A�敪�擾(�N���A�Ώۃt�@�C�����)
    ${TG_CLEAR_TYPE}        = "${LC_LINE01}" | %{ $_.Split(",")[0] }
    # ���l�[���Ώۃt�@�C���z�u �f�B���N�g���p�X�擾 (�L�[�u���L�ڋ��e)
    ${TG_SORCE_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
    # ���l�[���Ώۃt�@�C�����擾 (���C���h�J�[�h�L�ځA�L�[�u���L�ڋ��e)
    ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
    # ���l�[����f�B���N�g���p�X�擾 (�L�[�u���L�ڋ��e)
    ${TG_DESTI_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }

    #--------------------------------------------
    # ���l�[���Ώۃt�@�C���z�u�f�B���N�g��
    #--------------------------------------------
    # ���l�[���Ώۃt�@�C���z�u�f�B���N�g���p�X�m�F����
    if ( !(${TG_SORCE_DIRS}.EndsWith("\")) ) {
        # �f�B���N�g�����L�ڕ��@�̕⊮����[\]�t��
        ${TG_SORCE_DIRS} = ${TG_SORCE_DIRS} + "\"
    }
    # ���l�[���Ώۃt�@�C���z�u�f�B���N�g���p�X �L�[�u������
    if ( ${TG_SORCE_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
        ${TG_SORCE_DIRS} = FC_ReplaceString "${TG_SORCE_DIRS}" -tdate ${PRM_ReRunDay}
    }
    ${TG_SORCE_DIRS} = Invoke-Expression "Write-Output ${TG_SORCE_DIRS}"
    # �f�B���N�g�����݃`�F�b�N
    if ( !(Test-Path ${TG_SORCE_DIRS}) ) {
        # ���݂��Ȃ��ׁA�X�L�b�v
        FC_LogWriter ${DEF_RTNCD_NML} "���l�[���Ώۃt�@�C���z�u�̃f�B���N�g��[${TG_SORCE_DIRS}]�����݂��Ȃ��׃X�L�b�v���܂��B"
        continue
    }

    #--------------------------------------------
    # ���l�[����f�B���N�g��
    #--------------------------------------------
    # ���l�[����f�B���N�g���p�X�m�F����
    if ( !(${TG_DESTI_DIRS}.EndsWith("\")) ) {
        # �f�B���N�g�����L�ڕ��@�̕⊮����
        # �I���͂��̕����ł͂Ȃ��ׁA�Ō��[\]��t��
        ${TG_DESTI_DIRS} = ${TG_DESTI_DIRS} + "\"
    }
    # ���l�[����f�B���N�g���p�X �L�[�u������
    if ( ${TG_DESTI_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
        ${TG_DESTI_DIRS} = FC_ReplaceString "${TG_DESTI_DIRS}" -tdate ${PRM_ReRunDay}
    }
    ${TG_DESTI_DIRS} = Invoke-Expression "Write-Output ${TG_DESTI_DIRS}"
    # �f�B���N�g�����݃`�F�b�N
    if ( !(Test-Path ${TG_DESTI_DIRS}) ) {
        # ���݂��Ȃ��ׁA�X�L�b�v
        FC_LogWriter ${DEF_RTNCD_NML} "���l�[����̃f�B���N�g��[${TG_DESTI_DIRS}]�����݂��Ȃ��׃X�L�b�v���܂��B"
        continue
    }

    # ���l�[���Ώۃt�@�C�����o
    ${TG_SORCE_DIFI} = "${TG_SORCE_DIRS}" + "${TG_SORCE_FILE}"
    ${TG_FIND_FILES} = @(Get-ChildItem ${TG_SORCE_DIFI})
    if ( ${TG_FIND_FILES}.length -gt 0 ) {
        foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

            ${RENAME_FILENAME_SOURCE} = ${FINDFILE}.name
            ${RENAME_FILENAME_DISTIN} = [String]::Join(".",(${RENAME_FILENAME_SOURCE},${UNYO_DATE}))
            ${RENAME_FILEDIFI_S}      = "${TG_SORCE_DIRS}" + "${RENAME_FILENAME_SOURCE}"
            ${RENAME_FILEDIFI_D}      = "${TG_DESTI_DIRS}" + "${RENAME_FILENAME_DISTIN}"

            FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̃��l�[���������J�n���܂��B"

            if ( Test-Path ${RENAME_FILEDIFI_D} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���͊��Ƀ��l�[�������ς݂ł��B"
                FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̃��l�[�������̓X�L�b�v���܂��B"
                continue
            }

            ${RTN_CPY_TEMP} = Copy-Item ${RENAME_FILEDIFI_S} ${RENAME_FILEDIFI_D}
            ${RTN_CPY_CODE} = $?
            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̃��l�[������������I�����܂����B"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "[${RENAME_FILEDIFI_S}]�t�@�C���̃��l�[�������ɂăG���[���������܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "[${RENAME_FILEDIFI_S}]�t�@�C���̃��l�[�������ɂăG���[���������܂����B"
                EndProcess
            }

            #--------------------------------------------
            # ���t�@�C���N���A����
            #--------------------------------------------
            if ( ${TG_CLEAR_TYPE} -eq "NON" ) {
                continue
            }
            FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̃N���A�������J�n���܂��B"

            switch("${TG_CLEAR_TYPE}") {
                "CLR"       {
                                # �N���A�敪='CLR' �Ȃ�Ό��t�@�C�����N���A
                                # ���l�[���t�@�C���ƃR���y�A���č�������ƃG���[
                                # Step.1:�R���y�A����(FC�R�}���h���p)
                                if ( (Test-Path ${RENAME_FILEDIFI_S} ) -and (Test-Path ${RENAME_FILEDIFI_D}) ) {

                                    FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̃N���A����(Step.1:�R���y�A����)�����{���܂��B"
                                    ${RN_COMPAR_TEMP} = Invoke-Expression "fc.exe ${RENAME_FILEDIFI_S} ${RENAME_FILEDIFI_D}"
                                    ${RN_COMPAR_CODE} = ${LASTEXITCODE}
                                    if ( ${RN_COMPAR_CODE} -eq 0 ) {
                                        # �����Ȃ��ׁA���l�[�������͐������Ă��܂��B
                                        FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̃N���A����(Step.2:�N���A����)�����{���܂��B"
                                        ${RTN_CLR_TEMP} = Clear-Content -Path ${RENAME_FILEDIFI_S}
                                        ${RTN_CLR_CODE} = $?
                                        if ( !${RTN_CLR_CODE} ) {
                                            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                                            outmsg 6001 ${PRG_EXIT_CODE} ${RENAME_FILEDIFI_S}
                                            FC_LogWriter ${PRG_EXIT_CODE} "[${RENAME_FILEDIFI_S}]�t�@�C���̃N���A����(Step.2:�N���A����)�ɂăG���[���������܂����B"
                                            EndProcess
                                        }
                                    } else {
                                        FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̃N���A����(Step.1:�R���y�A����)�ɂč������������ׁA�N���A�������X�L�b�v���܂��B"
                                        continue
                                    }
                                }
                                break
                            }
                "CLF"       {
                                # �N���A�敪='CLF' �Ȃ�Ό��t�@�C���������N���A
                                FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̋����N���A���������{���܂��B"

                                if ( !(Test-Path ${RENAME_FILEDIFI_S}) ) {
                                    FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C�������݂��Ȃ��ׁA�����N���A�������X�L�b�v���܂��B"
                                    continue
                                }

                                ${RTN_CLR_TEMP} = Clear-Content -Path ${RENAME_FILEDIFI_S}
                                ${RTN_CLR_CODE} = $?
                                if ( !${RTN_CLR_CODE} ) {
                                    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                                    outmsg 6001 ${PRG_EXIT_CODE} ${RENAME_FILEDIFI_S}
                                    FC_LogWriter ${PRG_EXIT_CODE} "[${RENAME_FILEDIFI_S}]�t�@�C���̋����N���A�����ɂăG���[���������܂����B"
                                    EndProcess
                                }
                                break
                            }
                default     {
                                FC_LogWriter ${DEF_RTNCD_NML} "[${CLNAME_FILENAME_SOURCE}]�t�@�C���̃N���A�敪�w��Ɍ�肪��܂��������X�L�b�v���܂��B"
                                continue
                            }
            }
            FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]�t�@�C���̃N���A�������I�����܂��B"
        }
    }
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
