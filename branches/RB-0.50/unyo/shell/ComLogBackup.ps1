#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ���O�o�b�N�A�b�v�����֐�
#
# ModName   : ComLogBackup
#
# Condition : UnyoEnv & ComFunction files inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Eddition
#============================================================================
#----------------------------------------------------------------------#
# ComLogBackup for BANK*R CC  Ver.1.0.0                                #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# F01.���O�o�b�N�A�b�v�����֐�                                         #
#----------------------------------------------------------------------#
# F01.1 LogBackup (Copy/Move)
# (�T�v)
#  ���O�o�b�N�A�b�v����(COPY����/MOVE����)
#  - ��P�����F��`�t�@�C��(Full-Path) (�K�{)
#  - ��Q�����F�����敪(COPY,MOVE)     (�K�{)
#  - ��R�����F�u���Ώۓ��t            (�K�{)
#----------------------------------------------------------------------#
function global:FC_BACKUP_COPY ( [string] ${LC_TGFILE},[string] ${LC_TGTYPE},[string] ${LC_CHGDATE})
{
    # ��`�t�@�C�����݃`�F�b�N
    FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${LC_TGFILE}]�����擾���܂�(${PRG_NAME})"
    if ( !(Test-Path ${LC_TGFILE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${LC_TGFILE}"
        FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${LC_TGFILE}]�͑��݂��Ȃ��ׁA�����𒆎~���܂�(${PRG_NAME})"
        return ${False}
    }

    # �����敪�`�F�b�N
    switch("${LC_TGTYPE}") {
        "COPY"  { ${BKUP_FLG} = "C" ; ${BKUP_MODE} = "Copy����" ; break }
        "MOVE"  { ${BKUP_FLG} = "M" ; ${BKUP_MODE} = "Move����" ; break }
        default { FC_LogWriter ${DEF_RTNCD_NML} "�o�b�N�A�b�v�����̏����敪�Ɍ�肪����ׁA�����𒆎~���܂�(${PRG_NAME})"
                  return ${False}
                }
    }

    if ( ${LC_CHGDATE} -ne "x" ) {
        if ( ! (${LC_CHGDATE} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet) ) {
            FC_LogWriter 1 "�u�����t�̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
            return ${False}
        }
    }

    foreach ( ${LC_LINE01} in Get-Content ${LC_TGFILE} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" | Select-String -Pattern "^${BKUP_FLG}" ) {

        # ���������m�F�p
        ${LC_ACT_COUNT} = 0
        # �Ώۋ敪�擾(F:�t�@�C��,D:�f�B���N�g��)
        ${TG_BACKUPTYPE}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
        # �Ώۏ�ʃf�B���N�g���擾 (�L�[�u���L�ڋ��e)
        ${TG_SORCE_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
        # �ΏۑΏۃf�B���N�g��/�t�@�C���擾 (���C���h�J�[�h�L�ځA�L�[�u���L�ڋ��e)
        ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }
        # �ۊǐ�f�B���N�g�� (�L�[�u���L�ڋ��e)
        ${TG_DESTI_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[4] }

        # �Ώۏ�ʃf�B���N�g���m�F����
        if ( !(${TG_SORCE_DIRS}.EndsWith("\")) ) {
            ${TG_SORCE_DIRS} = ${TG_SORCE_DIRS} + "\"
        }
        # �Ώۏ�ʃf�B���N�g�� �L�[�u������
        if ( ${TG_SORCE_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_SORCE_DIRS} = FC_ReplaceString "${TG_SORCE_DIRS}" -tdate ${LC_CHGDATE}
        }
        ${TG_SORCE_DIRS} = Invoke-Expression "Write-Output ${TG_SORCE_DIRS}"
        # �f�B���N�g�����݃`�F�b�N
        if ( !(Test-Path ${TG_SORCE_DIRS}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "�Ώۏ�ʃf�B���N�g��[${TG_SORCE_DIRS}]�����݂��Ȃ��׃X�L�b�v���܂��B"
            continue
        }

        # �Ώۃt�@�C��/�f�B���N�g�� �L�[�u������
        if ( ${TG_SORCE_FILE} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_SORCE_FILE} = FC_ReplaceString "${TG_SORCE_FILE}" -tdate ${LC_CHGDATE}
        }

        # �ۊǐ�f�B���N�g�� �m�F����
        if ( !(${TG_DESTI_DIRS}.EndsWith("\")) ) {
            ${TG_DESTI_DIRS} = ${TG_DESTI_DIRS} + "\"
        }
        # �ۊǐ�f�B���N�g�� �L�[�u���L�ڋ��e
        if ( ${TG_DESTI_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_DESTI_DIRS} = FC_ReplaceString "${TG_DESTI_DIRS}" -tdate ${LC_CHGDATE}
        }
        ${TG_DESTI_DIRS} = Invoke-Expression "Write-Output ${TG_DESTI_DIRS}"
        # �f�B���N�g�����݃`�F�b�N
        if ( !(Test-Path ${TG_DESTI_DIRS}) ) {
            # �ۊǐ�f�B���N�g���쐬
            #outmsg 51 ${DEF_RTNCD_NML} "${TG_DESTI_DIRS}"
            FC_LogWriter ${DEF_RTNCD_NML} "�o�b�N�A�b�v��f�B���N�g��[${TG_DESTI_DIRS}]���쐬���܂��B"
            New-Item ${TG_DESTI_DIRS} -ItemType Directory 2>&1 > $null
            ${RTN_MKDIR_CODE} = $?
            if ( ${RTN_MKDIR_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "�o�b�N�A�b�v��f�B���N�g��[${TG_DESTI_DIRS}]���쐬���܂����B"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 1 ${PRG_EXIT_CODE} "�o�b�N�A�b�v��f�B���N�g��[${TG_DESTI_DIRS}]�̍쐬�ɂăG���[���������܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "�o�b�N�A�b�v��f�B���N�g[${TG_DESTI_DIRS}]�̍쐬�ɂăG���[���������܂����B�㑱�����𒆎~���܂�"
                #EndProcess
                return ${False}
            }
        }

        # �Ώۃt�@�C�����o
        ${TG_SORCE_DIFI} = "${TG_SORCE_DIRS}" + "${TG_SORCE_FILE}"

        # �폜�敪�`�F�b�N
        switch("${TG_BACKUPTYPE}") {
            "F"     { ${BKUP_CHKFLG} = ${False} ; ${BKUP_CHKMSG} = "�t�@�C��"     ; break }
            "D"     { ${BKUP_CHKFLG} = ${True}  ; ${BKUP_CHKMSG} = "�f�B���N�g��" ; break }
            default { FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]�t�@�C���܂��̓f�B���N�g���̑Ώۋ敪�w��Ɍ�肪��܂��������X�L�b�v���܂��B" 
                      continue
                    }
        }

        # �Ώۑ��݃`�F�b�N
        if ( !(Test-Path ${TG_SORCE_DIFI}) ) { 
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]${BKUP_CHKMSG}�����݂��Ȃ��ׁA�������X�L�b�v���܂��B"
            continue
        }

        ${TG_FIND_FILES} = @(Get-ChildItem ${TG_SORCE_DIFI})
        if ( ${TG_FIND_FILES}.length -gt 0 ) {
            foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

                ${LC_ACT_COUNT}++

                ${BACKUP_FILENAME_SOURCE} = ${FINDFILE}.name
                ${BACKUP_FILEDIFI_S}      = ${FINDFILE}.fullname
                ${BACKUP_FILEDIFI_D}      = ${TG_DESTI_DIRS}

                FC_LogWriter ${DEF_RTNCD_NML} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����(${BKUP_MODE})���J�n���܂��B"

                if ( !(Test-Path ${BACKUP_FILEDIFI_S}) ) {
                    FC_LogWriter ${DEF_RTNCD_NML} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}�����݂��Ȃ��ׁA�o�b�N�A�b�v����(${BKUP_MODE})���X�L�b�v���܂��B"
                    continue
                }

                # COPY or MOVE
                if ( "${BKUP_FLG}" -eq "C" ) {
                    ${RTN_CPY_TEMP} = Copy-Item ${BACKUP_FILEDIFI_S} ${BACKUP_FILEDIFI_D} -Recurse
                    ${RTN_CPY_CODE} = $?
                } else {
                    ${RTN_CPY_TEMP} = Move-Item ${BACKUP_FILEDIFI_S} ${BACKUP_FILEDIFI_D} -Force
                    ${RTN_CPY_CODE} = $?
                }

                if ( ${RTN_CPY_CODE} ) {
                    FC_LogWriter ${DEF_RTNCD_NML} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����(${BKUP_MODE})������I�����܂����B"
                } else {
                    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                    outmsg 1 ${PRG_EXIT_CODE} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����(${BKUP_MODE})�ɂăG���[���������܂����B"
                    FC_LogWriter ${PRG_EXIT_CODE} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����(${BKUP_MODE})�ɂăG���[���������܂����B"
                    #EndProcess
                    return ${False}
                }
            }
        }
        if ( ${LC_ACT_COUNT} -eq 0 ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����(${BKUP_MODE})�Ώۂ����݂��܂���ł����B"
            continue
        }
    }
    return ${True}
}


