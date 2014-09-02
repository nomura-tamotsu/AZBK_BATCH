#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �^�p�o�b�`�p���ʊ֐�
#
# ModName   : ComFunction
#
# Condition : UnyoEnv file inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Edition
#============================================================================
#----------------------------------------------------------------------#
# ComFunction for BANK*R CC  Ver.1.0.0                                 #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# F01.���ʏ��� (���O�o�͋@�\)                                          #
#----------------------------------------------------------------------#
# F01.1 LogWreiter for Local LOG
# (�T�v)
#  ���O�o�͏���(���[�J�����O�o��)
#  - ��P�����F�o�̓��x��(0,1,2,3,4,9,x) (�K�{)
#  - ��Q�����F�o�̓��b�Z�[�W          (�K�{)
#  - �K�{�ϐ��F���O�o�̓t���O(0=OFF,1=ON)
#----------------------------------------------------------------------#
function global:FC_LogWriter
{
    ${LC_LOGPRM1} = $args[0]  # Log Level 0,1,2,3
    ${LC_LOGPRM2} = $args[1]  # Output Messages

    # ���O�o�̓t���O�m�F
    if ( "${LOG_FLAG}" -eq "1" ) {

        ${LOGTIMES} = Get-Date -format "${COM_DATEFORM00}"

        switch("${LC_LOGPRM1}") {
            "0" { ${LOGLEVEL} = "[INFO] :" ; break }
            "1" { ${LOGLEVEL} = "[WARN] :" ; break }
            "2" { ${LOGLEVEL} = "[ERRO] :" ; break }
            "3" { ${LOGLEVEL} = "[CRIT] :" ; break }
            "4" { ${LOGLEVEL} = "[FAIL] :" ; break }
            "9" { ${LOGLEVEL} = "[WARN] :" ; break }
            default { ${LOGLEVEL} = "[DBUG] :" }
        }
        "${LOGTIMES} ${HOST_NAME} ${LOGLEVEL} ${LC_LOGPRM2}" | `
        Out-File -FilePath ${ACT_FILE} -Append -Encoding default
    }
    return
}


#----------------------------------------------------------------------#
# F01.2 LogWreiter for ERROR LOG (error.log)
# (�T�v)
#  ���O�o�͏���(error.log�o��)
#  - ��P�����F���b�Z�[�W�ԍ�        (�K�{)
#  - ��Q�����F�G���[�R�[�h          (�K�{)
#  - ��R�����F�t������1 (&a1&)      (�C��)
#  - ��S�����F�t������2 (&a2&)      (�C��)
#  - ��T�����F�t������3 (&a3&)      (�C��)
#  - ��U�����F�t������4 (&a4&)      (�C��)
#  - ��V�����F�t������5 (&a5&)      (�C��)
#----------------------------------------------------------------------#
function global:outmsg
{

    ${LC_PRAM01} = ""
    ${LC_PRAM02} = ""
    ${LC_PRAM03} = ""
    ${LC_PRAM04} = ""
    ${LC_PRAM05} = ""
    ${LC_PRAM06} = ""
    ${LC_PRAM07} = ""

    if ( $args.Length -lt 2 ) { return 9 }

    ${LC_PRAM01} = $args[0]   # MSGID
    ${LC_PRAM02} = $args[1]   # ERROR_CODE
    ${LC_PRAM03} = $args[2]   # MSG_PARAM1
    ${LC_PRAM04} = $args[3]   # MSG_PARAM2
    ${LC_PRAM05} = $args[4]   # MSG_PARAM3
    ${LC_PRAM06} = $args[5]   # MSG_PARAM4
    ${LC_PRAM07} = $args[6]   # MSG_PARAM5

    # MSG_NO FORMAT
    ${MSG_NO} = ${LC_PRAM01}.ToString("00000")

    ${MSG_DEF_DATA} = Get-Content ${UNYO_FIL_DIR}\msg_file | Select-String -Pattern ^${MSG_NO}

    ${MSG_TEXT0} = "${MSG_DEF_DATA}" | %{ $_.SubString(18) }
    ${MSG_TEXT1} = "${MSG_TEXT0}"    | %{ $_ -creplace "&a1&","${LC_PRAM03}"} 
    ${MSG_TEXT2} = "${MSG_TEXT1}"    | %{ $_ -creplace "&a2&","${LC_PRAM04}"} 
    ${MSG_TEXT3} = "${MSG_TEXT2}"    | %{ $_ -creplace "&a3&","${LC_PRAM05}"} 
    ${MSG_TEXT4} = "${MSG_TEXT3}"    | %{ $_ -creplace "&a4&","${LC_PRAM06}"} 
    ${MSG_TEXT}  = "${MSG_TEXT4}"    | %{ $_ -creplace "&a5&","${LC_PRAM07}"} 

    ${MSG_ID}    = "${MSG_DEF_DATA}" | %{ $_.SubString(5,8) }
    ${MSG_LINE}  = "${MSG_DEF_DATA}" | %{ $_.Split(" ")[1] }

    # CREATE MESSAGE
    if ( "${LC_PRAM02}" -eq "0" ) {
        ${MSG_ERROR_CODE} = ""
    } else {
        ${MSG_ERROR_CODE} = "{${LC_PRAM02}}"
    }

    ${PUT_TIME} = Get-Date -format "${COM_DATEFORM00}"
    ${LGN_TIME} = Get-Date -format "${COM_DATEFORM07}"
    "${PUT_TIME} ${HOST_NAME} ${MSG_ID} ${MSG_LINE} ${MSG_TEXT} [${MOD_NAME}(${USER_NAME})] ${MSG_ERROR_CODE}" | `
    Out-File -FilePath ${UNYO_LOG_BASE_FILE} -Append -Encoding default
#    "${PUT_TIME} ${HOST_NAME} ${MSG_ID} ${MSG_LINE} ${MSG_TEXT} [${MOD_NAME}(${USER_NAME})] ${MSG_ERROR_CODE}" | `
#    Out-File -FilePath ${UNYO_LOG_DAYS_FILE}${LGN_TIME} -Append -Encoding default

    switch("${MSG_NO}") {
        "00040" { "${PRG_NAME} ���J�n���܂����B"     ; break }
        "00041" { "${PRG_NAME} ���I�����܂����B"     ; break }
        "00045" { "${PRG_NAME} ���ُ�I�����܂����B" ; break }
    }
    return
}


#----------------------------------------------------------------------#
# F01.3 Init Program Start 
# (�T�v)
#  �v���O�����N������
#  - �K�{�ϐ��F${MOD_NAME}      (�v���O�������ɒ�`) 
#  - �K�{�ϐ��F${PRG_EXIT_CODE} (�v���O�������̎��s���ʃR�[�h) 
#----------------------------------------------------------------------#
function global:InitProcess
{
    outmsg 40 ${DEF_RTNCD_NML} "${PRG_NAME}" 
    FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME} ���J�n���܂����B"
    return
}

#----------------------------------------------------------------------#
# F01.4 Program END 
# (�T�v)
#  �v���O�����I������
#  - �K�{�ϐ��F${MOD_NAME}      (�v���O�������ɒ�`) 
#  - �K�{�ϐ��F${PRG_EXIT_CODE} (�v���O�������̎��s���ʃR�[�h) 
#----------------------------------------------------------------------#
function global:EndProcess
{
    if ( ${PRG_EXIT_CODE} -eq ${DEF_RTNCD_NML} ) {
        outmsg 41 ${DEF_RTNCD_NML} "${PRG_NAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME} ���I�����܂����B"
    } else {
        outmsg 45 ${PRG_EXIT_CODE} "${PRG_NAME}"
        FC_LogWriter 1 "${PRG_NAME} ���ُ�I�����܂����B"
    }
    exit ${PRG_EXIT_CODE}
}

#----------------------------------------------------------------------#
# F02.���ʕ��i                                                         #
#----------------------------------------------------------------------#
#----------------------------------------------------------------------#
# F02.1 �O�����t�擾(SAVE_DATE_YESTERDAY) 
# (�T�v)
#  �O�����t�t�@�C��(yesterday.date) �쐬
#----------------------------------------------------------------------#
function global:MakeYesterdayFile
{
    outmsg 1 ${DEF_RTNCD_NML} "�O�����t�t�@�C���쐬���܂�"
    FC_LogWriter ${DEF_RTNCD_NML} "�O�����t�t�@�C���쐬�������J�n���܂����B"

    ${LC_YESTERDAY_TIME} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
    ${LC_YESTERDAY_TIME} | Out-File -FilePath ${YESTERDAY_FILE} -Encoding default
    outmsg 1 ${DEF_RTNCD_NML} "�O�����t�t�@�C����(���e�F${LC_YESTERDAY_TIME})�ō쐬���܂���"
    FC_LogWriter ${DEF_RTNCD_NML} "�O�����t�t�@�C���쐬�������I�����܂����B"
    return
}

#----------------------------------------------------------------------#
# F02.2 �^�p���t�擾(SAVE_DATE_UNYODAYS) 
# (�T�v)
#  �^�p���t�t�@�C��(unyo.date) �쐬
#----------------------------------------------------------------------#
function global:MakeUnyoudaysFile ( [string] ${FL_SEGDATE} = "x" )
{

    # JP1 ���ϐ����� �^�p���s�� �������ꍇ�͑O�����t���擾����B
    # JP1 ����̎��s�łȂ��ꍇ�� �^�p���s�� �Ƃ��đO�����t���w�肷��B

    outmsg 1 ${DEF_RTNCD_NML} "�^�p���t�t�@�C���쐬���܂�"
    FC_LogWriter ${DEF_RTNCD_NML} "�^�p���t�t�@�C���쐬�������J�n���܂����B"

    if ( ${FL_SEGDATE} -ne "x" ) {
        if ( ${FL_SEGDATE} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
        ${LC_YESTERDAY_TIME} = ${FL_SEGDATE}
        } else {
            outmsg 54 ${DEF_RTNCD_ERR}
            FC_LogWriter 1 "�^�p���t�w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B��{���t(�O��)�ɂĐݒ�v���܂�"
        }
    } else {
        ${LC_YESTERDAY_TIME} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
    }
    ${LC_YESTERDAY_TIME} | Out-File -FilePath ${UNYOUDAYS_FILE} -Encoding default
    outmsg 1 ${DEF_RTNCD_NML} "�^�p���t�t�@�C����(���e�F${LC_YESTERDAY_TIME})�ō쐬���܂���"
    FC_LogWriter ${DEF_RTNCD_NML} "�^�p���t�t�@�C���쐬�������I�����܂����B"
    return
}


#----------------------------------------------------------------------#
# F02.3 �L�[�����u������(REPLACE_TEXT) 
# (�T�v)
#  �L�[���ڂɑ΂��Ēu�����������{
#  - ��P�����F�u���Ώە�����        (�K�{)
#  - ��Q�����F�u�����t(YYYYMMDD)    (�C��)
#----------------------------------------------------------------------#
function global:FC_ReplaceString
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$false)]
        [string]${LC_TGREPMSG}="x",
        [Parameter(Mandatory=$false)]
        [Alias("tdate")]
        [string]${PRM_TGDATE}="x"
    )

    if ( ${LC_TGREPMSG} -eq "x" ) {
        return 9
    } else {
        ${MSG_OUTLINE} = ${LC_TGREPMSG}
    }

    #------------------------------------------------------------------#
    # ��P�����ɓn���ꂽ�u���Ώە�����ɑ΂��ăL�[���ڂ�u������B
    #------------------------------------------------------------------#
    #  �L�[���ڐ���           �u���Ώە�����     ����
    #------------------------------------------------------------------#
    # ���t�p�^�[��(01)         @@D0001@@       YYYYMMDD    (20140101)
    # ���t�p�^�[��(02)         @@D0002@@       YYYYMM      (201401)
    # ���t�p�^�[��(03)         @@D0003@@       YYYY-MM-DD  (2014-01-01)
    # ���t�p�^�[��(04)         @@D0004@@       YYYY-MM     (2014-01)
    # ���t�p�^�[��(05)         @@D0005@@       YYYY_MM_DD  (2014_01_01)
    # ���t�p�^�[��(06)         @@D0006@@       YYYY-MM     (2014_01)
    # ���t�p�^�[��(07)         @@D0007@@       YYYY-M-D    (2014-1-1)
    # ���t�p�^�[��(08)         @@D0008@@       YYYY_M_D    (2014_1_1)
    # �T�[�o��                 @@SVRNM@@       HOSTNAME    (ServerName)
    # �T�[�o��(������)         @@SVRNL@@       hostname    (ServerName)
    # �T�[�o���(����)         @@SVRTP@@       SV_TYPE     (ServerType)
    #------------------------------------------------------------------#
    # (�⑫) �u��������t�͎w�肪�Ȃ��ꍇ�^�p���t�t�@�C�����擾����
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "�L�[�����u���������J�n���܂��B"

    if ( ${LC_TGREPMSG} | Select-String -Pattern "@@D....@@" -Quiet ) {

        # �u���p���t�擾����
        if ( ${PRM_TGDATE} -ne "x" ) {
            if ( ${PRM_TGDATE} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
                ${LC_BSMESG} = ${PRM_TGDATE}
            } else {
                FC_LogWriter 1 "�u�������̎w��Ɍ�肪����܂��B�w��t�H�[�}�b�g��[YYYYMMDD]�ł��B�����𒆎~���܂��B"
                return 9
            }
        } elseif ( Test-Path ${UNYOUDAYS_FILE} ) {
            # �t�@�C�����݃`�F�b�N (YYYYMMDD)
            ${LC_BSMESG} = Get-Content ${UNYOUDAYS_FILE} -totalCount 1
        } else {
            ${LC_BSMESG} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
        }

        ${SER_YY1}    = "${LC_BSMESG}" | %{ $_.SubString(0,4) }   # YYYY
        ${SER_YY2}    = "${LC_BSMESG}" | %{ $_.SubString(2,2) }   # YY
        ${SER_MM0}    = "${LC_BSMESG}" | %{ $_.SubString(4,2) }   # MM
        ${SER_DD0}    = "${LC_BSMESG}" | %{ $_.SubString(6,2) }   # DD

        if ( ${SER_MM0} | Select-String -Pattern "0[1-9]" -Quiet ) {
            ${SER_MM1} = "${LC_BSMESG}" | %{ $_.SubString(5,1) }  # M
        } else {
            ${SER_MM1} = "${SER_MM0}"                             # MM
        }
        if ( ${SER_DD0} | Select-String -Pattern "0[1-9]" -Quiet ) {
            ${SER_DD1} = "${LC_BSMESG}" | %{ $_.SubString(7,1) }  # D
        } else {
            ${SER_DD1} = "${SER_DD0}"                             # DD
        }

        ${SER_TYPE02} = [String]::Join("",(${SER_YY1},${SER_MM0}))
        ${SER_TYPE03} = [String]::Join("-",(${SER_YY1},${SER_MM0},${SER_DD0}))
        ${SER_TYPE04} = [String]::Join("-",(${SER_YY1},${SER_MM0}))
        ${SER_TYPE05} = [String]::Join("_",(${SER_YY1},${SER_MM0},${SER_DD0}))
        ${SER_TYPE06} = [String]::Join("_",(${SER_YY1},${SER_MM0}))
        ${SER_TYPE07} = [String]::Join("-",(${SER_YY1},${SER_MM1},${SER_DD1}))
        ${SER_TYPE08} = [String]::Join("_",(${SER_YY1},${SER_MM1},${SER_DD1}))

        ${MSG_TEXT0}   = "${LC_TGREPMSG}"  | %{ $_ -creplace "@@D0001@@","${LC_BSMESG}"} 
        ${MSG_TEXT1}   = "${MSG_TEXT0}"    | %{ $_ -creplace "@@D0002@@","${SER_TYPE02}"} 
        ${MSG_TEXT2}   = "${MSG_TEXT1}"    | %{ $_ -creplace "@@D0003@@","${SER_TYPE03}"} 
        ${MSG_TEXT3}   = "${MSG_TEXT2}"    | %{ $_ -creplace "@@D0004@@","${SER_TYPE04}"} 
        ${MSG_TEXT4}   = "${MSG_TEXT3}"    | %{ $_ -creplace "@@D0005@@","${SER_TYPE05}"} 
        ${MSG_TEXT5}   = "${MSG_TEXT4}"    | %{ $_ -creplace "@@D0006@@","${SER_TYPE06}"} 
        ${MSG_TEXT6}   = "${MSG_TEXT5}"    | %{ $_ -creplace "@@D0007@@","${SER_TYPE07}"} 
        ${MSG_OUTLINE} = "${MSG_TEXT6}"    | %{ $_ -creplace "@@D0008@@","${SER_TYPE08}"} 

    }

    if ( ${LC_TGREPMSG} | Select-String -Pattern "@@SVR..@@" -Quiet ) {

        ${MSG_TEXT0}   = "${MSG_OUTLINE}"  | %{ $_ -creplace "@@SVRNM@@","${HOST_NAME}"} 
        ${MSG_TEXT1}   = "${MSG_TEXT0}"    | %{ $_ -creplace "@@SVRNL@@","${HOST_NMLO}"} 
        ${MSG_OUTLINE} = "${MSG_TEXT1}"    | %{ $_ -creplace "@@SVRTP@@","${HOST_TYPE}"} 

    }

    echo ${MSG_OUTLINE}

    FC_LogWriter ${DEF_RTNCD_NML} "�L�[�����u���������I�����܂����B"

}
