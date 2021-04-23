#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2017
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ���O�o�b�N�A�b�v�����e����
#
# FILE      : uy_logbackup_maint.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 17/02/01 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "���O�o�b�N�A�b�v�����e����"
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
# Local Function 
#--------------------------------------------
#----------------------------------------------------------------------#
# F01.�����e�p���O�o�b�N�A�b�v�����������֐�                           #
#----------------------------------------------------------------------#
# F01.1 Maint LOG Backkup ReRun
# (�T�v)
#  ���O�o�b�N�A�b�v���������s����ΏۂɍĎ��{
#----------------------------------------------------------------------#
function LFC_BACKUP_RERUN
{
    # 1. �����`�F�b�N
    if ( $args.Length -ne 2 ) {
        ${PRG_EXIT_CODE}     = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE}  "�����e�p���O�o�b�N�A�b�v�����������֐��̈����Ɍ�肪����܂��B�����𒆎~���܂��B"
        FC_LogWriter ${PRG_EXIT_CODE} "�����e�p���O�o�b�N�A�b�v�����������֐��̈����Ɍ�肪����܂��B�����𒆎~���܂��B"
        return ${False}
    } else {
        ${LC_TGFILE} = $args[0]   # ��`�t�@�C��
        ${LC_TGTYPE} = $args[1]   # �����敪
    }

    # 2. �����J�n���b�Z�[�W�o��
    outmsg 1 ${DEF_RTNCD_NML} "�����e�p���O�o�b�N�A�b�v�����������֐����J�n���܂��B"
    FC_LogWriter ${DEF_RTNCD_NML} "�����e�p���O�o�b�N�A�b�v�����������֐����J�n���܂��B"

    # 3. ��1���� ��`�t�@�C�����݃`�F�b�N
    FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${LC_TGFILE}]�����擾���܂�(${PRG_NAME})"
    if ( !(Test-Path ${LC_TGFILE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${LC_TGFILE}"
        FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${LC_TGFILE}]�͑��݂��Ȃ��ׁA�����𒆎~���܂�(${PRG_NAME})"
        return ${False}
    }

    # 4. ��2���� ��`�t�@�C�����݃`�F�b�N
    # �����敪�`�F�b�N
    switch("${LC_TGTYPE}") {
        "COPY"  { ${BKUP_FLG} = "C" ; ${BKUP_MODE} = "Copy����" ; break }
        "MOVE"  { ${BKUP_FLG} = "M" ; ${BKUP_MODE} = "Move����" ; break }
        default { FC_LogWriter ${DEF_RTNCD_NML} "�o�b�N�A�b�v�����̏����敪�Ɍ�肪����ׁA�����𒆎~���܂�(${PRG_NAME})"
                  return ${False}
                }
    }

    # 5. �����e�p���O�o�b�N�A�b�v���s���X�g�t�@�C�����ݒ�
    # �����e�p���O�o�b�N�A�b�v���s���X�g�t�@�C�����̐ݒ�
    ${LFC_BACKUP_TMP_FAILLIST_FNAME} = "TMP_" + $(Get-ChildItem "${LC_TGFILE}").Name
    # �����e�p���O�o�b�N�A�b�v���s���X�g�t�@�C����(FULL-Path)
    ${LFC_BACKUP_TMP_FAILLIST_FPATH} = "${UNYO_WRK_DIR}\${LFC_BACKUP_TMP_FAILLIST_FNAME}"

    # 6. �����e�p���O�o�b�N�A�b�v���s���X�g�t�@�C���̏�����(�����敪COPY�̏ꍇ�̂�)
    if ( ${BKUP_FLG} -eq "C" ) {
        if ( (Test-Path ${LFC_BACKUP_TMP_FAILLIST_FPATH}) ) {
            Clear-Content -Path ${LFC_BACKUP_TMP_FAILLIST_FPATH} 2>&1 > $null
        } else {
            New-Item -ItemType file ${LFC_BACKUP_TMP_FAILLIST_FPATH} 2>&1 > $null
        }
    }

    # 7. �����e�p���O�o�b�N�A�b�v����������
    :LPLABEL_MNT_BKFILELIST foreach ( ${LC_LINE01} in Get-Content ${LC_TGFILE} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" | Select-String -Pattern "^${BKUP_FLG}" ) {

        # �Ώۋ敪�擾(F:�t�@�C��,D:�f�B���N�g��)
        ${TG_BACKUPTYPE}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
        # �Ώۃt�@�C��/�f�B���N�g��
        ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
        # �ۊǐ�f�B���N�g��
        ${TG_DESTI_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }
        # ���s�J�E���g
        ${TG_FAIL_COUNT}        = "${LC_LINE01}" | %{ $_.Split(",")[4] }
        ${TG_FAIL_COUNT}        = [int]${TG_FAIL_COUNT}
        ${TMP_TG_FAIL_COUNT}    = 0

        # �폜�敪�`�F�b�N
        switch("${TG_BACKUPTYPE}") {
            "F"     { ${BKUP_CHKMSG} = "�t�@�C��"     ; break }
            "D"     { ${BKUP_CHKMSG} = "�f�B���N�g��" ; break }
            default { FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]�t�@�C���܂��̓f�B���N�g���̑Ώۋ敪�w��Ɍ�肪����܂��B�������X�L�b�v���܂��B" 
                      continue LPLABEL_MNT_BKFILELIST
                    }
        }

        # �o�b�N�A�b�v�������������s
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����������(${BKUP_MODE})���J�n���܂��B"

        # �Ώۑ��݃`�F�b�N
        if ( !(Test-Path ${TG_SORCE_FILE}) ) { 
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�����݂��Ȃ��ׁA�������X�L�b�v���܂��B"
            continue
        }

        # COPY/MOVE�������{
        if ( "${BKUP_FLG}" -eq "C" ) {
            # COPY�������{
            try { 
                    ${RTN_CPY_TEMP} = Copy-Item ${TG_SORCE_FILE} ${TG_DESTI_DIRS} -Recurse
                    ${RTN_CPY_CODE} = $?
            } catch [Exception] {
                    ${RTN_CPY_CODE} = ${False}
            }
        } else {
            # �Ώۃt�@�C���ˑ��֌W�`�F�b�N����
            if ( (Get-Content ${LFC_BACKUP_TMP_FAILLIST_FPATH} | Select-String -SimpleMatch ",${TG_SORCE_FILE}," -Quiet ) ) {
                # �o�b�N�A�b�v�������s���X�g�t�@�C���ւ̒ǉ�
                # ���s�J�E���g�̃J�E���g�A�b�v
                ${TG_FAIL_COUNT}++
                ${TMP_TG_FAIL_COUNT} = ${TG_FAIL_COUNT}
                # �����敪${BKUP_FLG},�Ώۋ敪${TG_BACKUPTYPE},${TG_SORCE_FILE},${TG_DESTI_DIRS},${TG_FAIL_COUNT}
                "${BKUP_FLG},${TG_BACKUPTYPE},${TG_SORCE_FILE},${TG_DESTI_DIRS},${TG_FAIL_COUNT}" | `
                Out-File -FilePath ${LFC_BACKUP_TMP_FAILLIST_FPATH} -Append -Encoding default
                # ���s�J�E���g臒l�`�F�b�N
                if ( ${TMP_TG_FAIL_COUNT} -ge ${COM_LOGBAKUP_RETRYCOUNT} ) {
                    outmsg 55 ${PRG_EXIT_CODE} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����������(${BKUP_MODE})�̎��s�񐔂�����񐔂𒴉߂��܂����B(COPY�ˑ��֌W)"
                    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����������(${BKUP_MODE})�̎��s�񐔂�����񐔂𒴉߂��܂����B(COPY�ˑ��֌W)"
                }
                FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����(${BKUP_MODE})�̎��O�m�F�ɂăX�L�b�v�ΏۂƂȂ�܂����B�o�b�N�A�b�v����������(${BKUP_MODE})���X�L�b�v���܂��B"
                continue
            }
            # MOVE�������{
            try {
                    ${RTN_CPY_TEMP} = Move-Item ${TG_SORCE_FILE} ${TG_DESTI_DIRS} -Force -ErrorAction Stop
                    ${RTN_CPY_CODE} = $?
            } catch [Exception] {
                    ${RTN_CPY_CODE} = ${False}
            }
        }

        # COPY/MOVE�������ʔ���
        if ( ${RTN_CPY_CODE} ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����������(${BKUP_MODE})������I�����܂����B"
        } else {
            # �o�b�N�A�b�v�������s���X�g�t�@�C���ւ̒ǉ�
            # ���s�J�E���g�̃J�E���g�A�b�v
            ${TG_FAIL_COUNT}++
            ${TMP_TG_FAIL_COUNT} = ${TG_FAIL_COUNT}
            # ���s�J�E���g臒l�`�F�b�N
            if ( ${TMP_TG_FAIL_COUNT} -ge ${COM_LOGBAKUP_RETRYCOUNT} ) {
                outmsg 55 ${PRG_EXIT_CODE} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����������(${BKUP_MODE})�̎��s�񐔂�����񐔂𒴉߂��܂����B"
                FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����������(${BKUP_MODE})�̎��s�񐔂�����񐔂𒴉߂��܂����B"
            }
            "${BKUP_FLG},${TG_BACKUPTYPE},${TG_SORCE_FILE},${TG_DESTI_DIRS},${TG_FAIL_COUNT}" | `
            Out-File -FilePath ${LFC_BACKUP_TMP_FAILLIST_FPATH} -Append -Encoding default
            outmsg 1 ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����������(${BKUP_MODE})�ɂăG���[���������܂����A�o�b�N�A�b�v�������������X�L�b�v���܂�"
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}�̃o�b�N�A�b�v����������(${BKUP_MODE})�ɂăG���[���������܂����A�o�b�N�A�b�v�������������X�L�b�v���܂��B"
        }
    }

    # 8. �����J�n���b�Z�[�W�o��
    outmsg 1 ${DEF_RTNCD_NML} "�����e�p���O�o�b�N�A�b�v�����������֐����I�����܂��B"
    FC_LogWriter ${DEF_RTNCD_NML} "�����e�p���O�o�b�N�A�b�v�����������֐����I�����܂��B"

    # 9. ��������
    return ${True}

}


#--------------------------------------------
# MAIN
#--------------------------------------------
# 1. Start Main Program
InitProcess

#--------------------------------------------
# 2. �����e�p�e�탍�O�o�b�N�A�b�v����������
#--------------------------------------------
# 2.1. �����e�p�e�탍�O�o�b�N�A�b�v���������X�g�̃t�@�C���ŐV��
#--------------------------------------------
${LC_MNTTYPE} = "�����e�p�e��"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g�̍ŐV�����s���܂��B"
${MNT_TGFILE01} = ${FAIL_BACKUP_OTHER_LOG_DEF}
${MNT_TGFILE02} = ${LOGBACKUP_OTHER_RERUN_LST}
${MNT_TGFILE03} = ${LOGBACKUP_OTHER_RERUN_LST_TMP}
# �e�탍�O�o�b�N�A�b�v�������s���X�g�̑��݊m�F
if ( !(Test-Path ${MNT_TGFILE01}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${MNT_TGFILE01}"
    FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${MNT_TGFILE01}]�͑��݂��Ȃ��ׁA�����𒆎~���܂�(${PRG_NAME})"
    EndProcess
}
# �����e�p�e�탍�O�o�b�N�A�b�v�������s���X�g��`�̑��݊m�F
if ( !(Test-Path ${MNT_TGFILE02}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${MNT_TGFILE02}"
    FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${MNT_TGFILE02}]�͑��݂��Ȃ��ׁA�����𒆎~���܂�(${PRG_NAME})"
    EndProcess
}

# ���s���X�g�t�@�C���̍ŐV��
foreach ( ${LC_FILE_LINE01} in Get-Content ${MNT_TGFILE01} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

    # �����敪�擾(C:COPY,M:MOVE)
    ${FILE_BACKUPMODE}    = "${LC_FILE_LINE01}" | %{ $_.Split(",")[0] }
    # �Ώۋ敪�擾(F:�t�@�C��,D:�f�B���N�g��)
    ${FILE_BACKUPTYPE}    = "${LC_FILE_LINE01}" | %{ $_.Split(",")[1] }
    # �Ώۃt�@�C��/�f�B���N�g��
    ${FILE_SORCE_FILE01}  = "${LC_FILE_LINE01}" | %{ $_.Split(",")[2] }
    # �����e�p���s���X�g�t�@�C���ɑ��݂��邩���m�F
    if ( !(Get-Content ${MNT_TGFILE02} |  Select-String -Pattern "^${FILE_BACKUPMODE},${FILE_BACKUPTYPE}," | Select-String -SimpleMatch ",${FILE_SORCE_FILE01}," -Quiet ) ) {
        # �����e�p���s���X�g�t�@�C���ւ̒ǉ�
        "${LC_FILE_LINE01}" | Out-File -FilePath ${MNT_TGFILE02} -Append -Encoding default
    }
}

#--------------------------------------------
# 2.2. �����e�p�e�탍�O�o�b�N�A�b�v����������(COPY����)���{
#--------------------------------------------
${LC_STEPMSG} = "COPY����"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"
try {
    ${RTN_FCBACKUP_CODE} = LFC_BACKUP_RERUN ${MNT_TGFILE02} "COPY"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�͏I�����܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
    EndProcess
}

#--------------------------------------------
# 2.3. �����e�p�e�탍�O�o�b�N�A�b�v����������(MOVE����)���{
#--------------------------------------------
${LC_STEPMSG} = "MOVE����"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"
try {
    ${RTN_FCBACKUP_CODE} = LFC_BACKUP_RERUN ${MNT_TGFILE02} "MOVE"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�͏I�����܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
    EndProcess
}

#--------------------------------------------
# 2.4. �����e�p�e�탍�O�o�b�N�A�b�v���������X�g�̃t�@�C���X�V�i���ʔ��f�j
#--------------------------------------------
# �����e�p�e�탍�O�o�b�N�A�b�v���������X�g�̃t�@�C���X�V�J�n���b�Z�[�W
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f���s���܂��B"
# �����e�p�e�탍�O�o�b�N�A�b�v�������s���X�g��`�̑��݊m�F
if ( (Test-Path ${MNT_TGFILE03}) ) {
    try {
            ${RTN_CPY_TEMP} = Copy-Item ${MNT_TGFILE03} ${MNT_TGFILE02} -Recurse
            ${RTN_CPY_CODE} = $?
    } catch [Exception] {
            ${RTN_CPY_CODE} = ${False}
    }

    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f����������I�����܂����B"
        Remove-Item ${MNT_TGFILE03} -Recurse 2>&1 > $null
    } else {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f�����ɂĈُ�I�����܂����B"
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f�����ɂĈُ�I�����܂����B"
        EndProcess
    }
} else {
    Clear-Content -Path ${MNT_TGFILE02} 2>&1 > $null
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f����������I�����܂����B"
}


#--------------------------------------------
# 3. �����e�p�č����O�o�b�N�A�b�v����������
#--------------------------------------------
# 3.1. �����e�p�e�탍�O�o�b�N�A�b�v���������X�g�̃t�@�C���ŐV��
#--------------------------------------------
${LC_MNTTYPE} = "�����e�p�č�"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g�̍ŐV�����s���܂��B"
${MNT_TGFILE01} = ${FAIL_BACKUP_AUDIT_LOG_DEF}
${MNT_TGFILE02} = ${LOGBACKUP_AUDIT_RERUN_LST}
${MNT_TGFILE03} = ${LOGBACKUP_AUDIT_RERUN_LST_TMP}
# �č����O�o�b�N�A�b�v�������s���X�g�̑��݊m�F
if ( !(Test-Path ${MNT_TGFILE01}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${MNT_TGFILE01}"
    FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${MNT_TGFILE01}]�͑��݂��Ȃ��ׁA�����𒆎~���܂�(${PRG_NAME})"
    EndProcess
}
# �����e�p�č����O�o�b�N�A�b�v�������s���X�g��`�̑��݊m�F
if ( !(Test-Path ${MNT_TGFILE02}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${MNT_TGFILE02}"
    FC_LogWriter ${DEF_RTNCD_NML} "��`�t�@�C��[${MNT_TGFILE02}]�͑��݂��Ȃ��ׁA�����𒆎~���܂�(${PRG_NAME})"
    EndProcess
}

# ���s���X�g�t�@�C���̍ŐV��
foreach ( ${LC_FILE_LINE01} in Get-Content ${MNT_TGFILE01} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

    # �����敪�擾(C:COPY,M:MOVE)
    ${FILE_BACKUPMODE}    = "${LC_FILE_LINE01}" | %{ $_.Split(",")[0] }
    # �Ώۋ敪�擾(F:�t�@�C��,D:�f�B���N�g��)
    ${FILE_BACKUPTYPE}    = "${LC_FILE_LINE01}" | %{ $_.Split(",")[1] }
    # �Ώۃt�@�C��/�f�B���N�g��
    ${FILE_SORCE_FILE01}  = "${LC_FILE_LINE01}" | %{ $_.Split(",")[2] }
    # �����e�p���s���X�g�t�@�C���ɑ��݂��邩���m�F
    if ( !(Get-Content ${MNT_TGFILE02} |  Select-String -Pattern "^${FILE_BACKUPMODE},${FILE_BACKUPTYPE}," | Select-String -SimpleMatch ",${FILE_SORCE_FILE01}," -Quiet ) ) {
        # �����e�p���s���X�g�t�@�C���ւ̒ǉ�
        "${LC_FILE_LINE01}" | Out-File -FilePath ${MNT_TGFILE02} -Append -Encoding default
    }
}

#--------------------------------------------
# 3.2. �����e�p�č����O�o�b�N�A�b�v����������(COPY����)���{
#--------------------------------------------
${LC_STEPMSG} = "COPY����"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"
try {
    ${RTN_FCBACKUP_CODE} = LFC_BACKUP_RERUN ${MNT_TGFILE02} "COPY"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�͏I�����܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
    EndProcess
}

#--------------------------------------------
# 3.3. �����e�p�č����O�o�b�N�A�b�v����������(MOVE����)���{
#--------------------------------------------
${LC_STEPMSG} = "MOVE����"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�����{���܂��B"
try {
    ${RTN_FCBACKUP_CODE} = LFC_BACKUP_RERUN ${MNT_TGFILE02} "MOVE"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�͏I�����܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})�ɂĈُ킪�������܂����B"
    EndProcess
}

#--------------------------------------------
# 3.4. �����e�p�č����O�o�b�N�A�b�v���������X�g�̃t�@�C���X�V�i���ʔ��f�j
#--------------------------------------------
# �����e�p�č����O�o�b�N�A�b�v���������X�g�̃t�@�C���X�V�J�n���b�Z�[�W
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f���s���܂��B"
# �����e�p�č����O�o�b�N�A�b�v�������s���X�g��`�̑��݊m�F
if ( (Test-Path ${MNT_TGFILE03}) ) {
    try {
            ${RTN_CPY_TEMP} = Copy-Item ${MNT_TGFILE03} ${MNT_TGFILE02} -Recurse
            ${RTN_CPY_CODE} = $?
    } catch [Exception] {
            ${RTN_CPY_CODE} = ${False}
    }

    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f����������I�����܂����B"
        Remove-Item ${MNT_TGFILE03} -Recurse 2>&1 > $null
    } else {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f�����ɂĈُ�I�����܂����B"
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f�����ɂĈُ�I�����܂����B"
        EndProcess
    }
} else {
    Clear-Content -Path ${MNT_TGFILE02} 2>&1 > $null
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}���O�o�b�N�A�b�v���������X�g���ʂ̔��f����������I�����܂����B"
}

#--------------------------------------------
# 4. End Main Program
#--------------------------------------------
EndProcess
