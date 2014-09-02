#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �T�[�r�X����֐�
#
# ModName   : ComSeviceManage
#
# Condition : UnyoEnv & ComFunction files inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Eddition
#============================================================================
#----------------------------------------------------------------------#
# ComSeviceManage for BANK*R CC  Ver.1.0.0                             #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# F01.�T�[�r�X����֐�                                                 #
#----------------------------------------------------------------------#
# F01.1 �T�[�r�X���� (�N��/��~/�ċN��)
# (�T�v)
#  �T�[�r�X���䏈��(�N������/��~����/�ċN������)
#  - ��P�����F�T�[�r�X��                    (�K�{)
#  - ��Q�����F�����敪(START,STOP,RESTART)  (�K�{)
#----------------------------------------------------------------------#
function global:FC_SERVICE_MANG ( [string] ${LC_TGSVNAME},[string] ${LC_TGTYPE} )
{
    # �T�[�r�X���݃`�F�b�N
    ${CK_SERVICE_EXIST} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} }
    if ( ${CK_SERVICE_EXIST} -eq $null ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X�͓o�^����Ă��Ȃ��ׁA�����𒆎~���܂��B"
        return ${False}
    }
    # �����敪�`�F�b�N
    switch("${LC_TGTYPE}") {
        "START"    {   ${FC_RESULT} = FC_SERVICE_START   ${LC_TGSVNAME} ; break }
        "STOP"     {   ${FC_RESULT} = FC_SERVICE_STOP    ${LC_TGSVNAME} ; break }
        "RESTART"  {   ${FC_RESULT} = FC_SERVICE_RESTART ${LC_TGSVNAME} ; break }
        default    {   FC_LogWriter ${DEF_RTNCD_NML} "�T�[�r�X����̏����敪�Ɍ�肪����ׁA�����𒆎~���܂�" ; ${FC_RESULT} = ${False} }
    }
    return ${FC_RESULT}
}


#----------------------------------------------------------------------#
# F01.2 �T�[�r�X�N������
# (�T�v)
#  �T�[�r�X�N�����䏈��
#  - ��P�����F�T�[�r�X��                    (�K�{)
#----------------------------------------------------------------------#
function global:FC_SERVICE_START ( [string] ${LC_TGSVNAME} )
{
    ${FC_SMG_BASE_MSG} = "�N��"
    #------------------------------------------------------------------#
    # �����N�����b�Z�[�W
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������J�n���܂��B"

    #------------------------------------------------------------------#
    # �T�[�r�X�N���󋵊m�F
    #------------------------------------------------------------------#
    ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Running" } | %{ $_.Name }
    if ( ${CK_SERVICE} -ne $null ) {
        ${PRG_EXIT_CODE}   = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${LC_TGSVNAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X�͊���${FC_SMG_BASE_MSG}����Ă���ׁA${FC_SMG_BASE_MSG}�����𒆎~���܂��B"
        return ${True}
    }

    #------------------------------------------------------------------#
    # �N���������s
    #------------------------------------------------------------------#
    ${RTN_SVCSTRT_TEMP} = Start-Service -Name ${LC_TGSVNAME}
    ${RTN_SVCSTRT_CMD}  = $?
    if ( ${RTN_SVCSTRT_CMD} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}����������I�����܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 1 ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�����ɂăG���[���������܂����B"
        FC_LogWriter ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�����ɂăG���[���������܂����B"
        return ${False}
    }

    #------------------------------------------------------------------#
    # �N���m�F���� (Running�m�F)
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�m�F���s���܂��B"

    for ( ${i} = 1 ; ${i} -le ${COM_ROOP_CNTS} ; ${i}++ ) {
        Start-Sleep -s ${COM_WAIT_TIME}
        ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Running" } | %{ $_.Name }
        if ( ${CK_SERVICE} -eq $null ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�m�F���ł�(${i}���)�B"
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�m�F���I�����܂����B"
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������I�����܂��B"
            return ${True}
        }
    }

    if ( ${i} -eq ${COM_ROOP_CNTS} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�m�F�ňُ�I�����܂����B"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������I�����܂��B"
        return ${False}
    }

}


#----------------------------------------------------------------------#
# F01.3 �T�[�r�X��~����
# (�T�v)
#  �T�[�r�X��~���䏈��
#  - ��P�����F�T�[�r�X��                    (�K�{)
#----------------------------------------------------------------------#
function global:FC_SERVICE_STOP ( [string] ${LC_TGSVNAME} )
{
    ${FC_SMG_BASE_MSG} = "��~"
    #------------------------------------------------------------------#
    # �����N�����b�Z�[�W
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������J�n���܂��B"

    #------------------------------------------------------------------#
    # �T�[�r�X�N���󋵊m�F
    #------------------------------------------------------------------#
    ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Running" } | %{ $_.Name }
    if ( ${CK_SERVICE} -eq $null ) {
        ${PRG_EXIT_CODE}   = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${LC_TGSVNAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X�͊���${FC_SMG_BASE_MSG}����Ă���ׁA${FC_SMG_BASE_MSG}�����𒆎~���܂��B"
        return ${True}
    }

    #------------------------------------------------------------------#
    # ��~�������s
    #------------------------------------------------------------------#
    ${RTN_SVCSTRT_TEMP} = Stop-Service -Name ${LC_TGSVNAME}
    ${RTN_SVCSTRT_CMD}  = $?
    if ( ${RTN_SVCSTRT_CMD} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}����������I�����܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 1 ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�����ɂăG���[���������܂����B"
        FC_LogWriter ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�����ɂăG���[���������܂����B"
        return ${False}
    }

    #------------------------------------------------------------------#
    # ��~�m�F���� (Stopped�m�F)
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�m�F���s���܂��B"

    for ( ${i} = 1 ; ${i} -le ${COM_ROOP_CNTS} ; ${i}++ ) {
        Start-Sleep -s ${COM_WAIT_TIME}
        ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Stopped" } | %{ $_.Name }
        if ( ${CK_SERVICE} -eq $null ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�m�F���ł�(${i}���)�B"
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�m�F���I�����܂����B"
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������I�����܂��B"
            return ${True}
        }
    }

    if ( ${i} -eq ${COM_ROOP_CNTS} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�m�F�ňُ�I�����܂����B"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������I�����܂��B"
        return ${False}
    }

}

#----------------------------------------------------------------------#
# F01.4 �T�[�r�X�ċN������
# (�T�v)
#  �T�[�r�X�ċN�����䏈��
#  - ��P�����F�T�[�r�X��                    (�K�{)
#----------------------------------------------------------------------#
function global:FC_SERVICE_RESTART ( [string] ${LC_TGSVNAME} )
{
    ${FC_SMG_BASE_MSG} = "�ċN��"
    #------------------------------------------------------------------#
    # �����N�����b�Z�[�W
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������J�n���܂��B"

    #------------------------------------------------------------------#
    # �ċN���������s
    #------------------------------------------------------------------#
    ${RTN_SVCSTRT_TEMP} = Restart-Service -Name ${LC_TGSVNAME}
    ${RTN_SVCSTRT_CMD}  = $?
    if ( ${RTN_SVCSTRT_CMD} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}����������I�����܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 1 ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�����ɂăG���[���������܂����B"
        FC_LogWriter ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�����ɂăG���[���������܂����B"
        return ${False}
    }

    #------------------------------------------------------------------#
    # �N���m�F���� (Running�m�F)
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X�̋N���m�F���s���܂��B"

    for ( ${i} = 1 ; ${i} -le ${COM_ROOP_CNTS} ; ${i}++ ) {
        Start-Sleep -s ${COM_WAIT_TIME}
        ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Running" } | %{ $_.Name }
        if ( ${CK_SERVICE} -eq $null ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X�̋N���m�F���ł�(${i}���)�B"
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X�̋N���m�F���I�����܂����B"
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������I�����܂��B"
            return ${True}
        }
    }

    if ( ${i} -eq ${COM_ROOP_CNTS} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X�̋N���m�F�ňُ�I�����܂����B"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]�T�[�r�X��${FC_SMG_BASE_MSG}�������I�����܂��B"
        return ${False}
    }

}


