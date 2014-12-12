#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : サービス制御関数
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
# F01.サービス制御関数                                                 #
#----------------------------------------------------------------------#
# F01.1 サービス制御 (起動/停止/再起動)
# (概要)
#  サービス制御処理(起動処理/停止処理/再起動処理)
#  - 第１引数：サービス名                    (必須)
#  - 第２引数：処理区分(START,STOP,RESTART)  (必須)
#----------------------------------------------------------------------#
function global:FC_SERVICE_MANG ( [string] ${LC_TGSVNAME},[string] ${LC_TGTYPE} )
{
    # サービス存在チェック
    ${CK_SERVICE_EXIST} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} }
    if ( ${CK_SERVICE_EXIST} -eq $null ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスは登録されていない為、処理を中止します。"
        return ${False}
    }
    # 処理区分チェック
    switch("${LC_TGTYPE}") {
        "START"    {   ${FC_RESULT} = FC_SERVICE_START   ${LC_TGSVNAME} ; break }
        "STOP"     {   ${FC_RESULT} = FC_SERVICE_STOP    ${LC_TGSVNAME} ; break }
        "RESTART"  {   ${FC_RESULT} = FC_SERVICE_RESTART ${LC_TGSVNAME} ; break }
        default    {   FC_LogWriter ${DEF_RTNCD_NML} "サービス制御の処理区分に誤りがある為、処理を中止します" ; ${FC_RESULT} = ${False} }
    }
    return ${FC_RESULT}
}


#----------------------------------------------------------------------#
# F01.2 サービス起動制御
# (概要)
#  サービス起動制御処理
#  - 第１引数：サービス名                    (必須)
#----------------------------------------------------------------------#
function global:FC_SERVICE_START ( [string] ${LC_TGSVNAME} )
{
    ${FC_SMG_BASE_MSG} = "起動"
    #------------------------------------------------------------------#
    # 処理起動メッセージ
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を開始します。"

    #------------------------------------------------------------------#
    # サービス起動状況確認
    #------------------------------------------------------------------#
    ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Running" } | %{ $_.Name }
    if ( ${CK_SERVICE} -ne $null ) {
        ${PRG_EXIT_CODE}   = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${LC_TGSVNAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスは既に${FC_SMG_BASE_MSG}されている為、${FC_SMG_BASE_MSG}処理を中止します。"
        return ${True}
    }

    #------------------------------------------------------------------#
    # 起動処理実行
    #------------------------------------------------------------------#
    ${RTN_SVCSTRT_TEMP} = Start-Service -Name ${LC_TGSVNAME}
    ${RTN_SVCSTRT_CMD}  = $?
    if ( ${RTN_SVCSTRT_CMD} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理が正常終了しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 1 ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理にてエラーが発生しました。"
        FC_LogWriter ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理にてエラーが発生しました。"
        return ${False}
    }

    #------------------------------------------------------------------#
    # 起動確認処理 (Running確認)
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}確認を行います。"

    for ( ${i} = 1 ; ${i} -le ${COM_ROOP_CNTS} ; ${i}++ ) {
        Start-Sleep -s ${COM_WAIT_TIME}
        ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Running" } | %{ $_.Name }
        if ( ${CK_SERVICE} -eq $null ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}確認中です(${i}回目)。"
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}確認が終了しました。"
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を終了します。"
            return ${True}
        }
    }

    if ( ${i} -eq ${COM_ROOP_CNTS} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}確認で異常終了しました。"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を終了します。"
        return ${False}
    }

}


#----------------------------------------------------------------------#
# F01.3 サービス停止制御
# (概要)
#  サービス停止制御処理
#  - 第１引数：サービス名                    (必須)
#----------------------------------------------------------------------#
function global:FC_SERVICE_STOP ( [string] ${LC_TGSVNAME} )
{
    ${FC_SMG_BASE_MSG} = "停止"
    #------------------------------------------------------------------#
    # 処理起動メッセージ
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を開始します。"

    #------------------------------------------------------------------#
    # サービス起動状況確認
    #------------------------------------------------------------------#
    ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Running" } | %{ $_.Name }
    if ( ${CK_SERVICE} -eq $null ) {
        ${PRG_EXIT_CODE}   = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${LC_TGSVNAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスは既に${FC_SMG_BASE_MSG}されている為、${FC_SMG_BASE_MSG}処理を中止します。"
        return ${True}
    }

    #------------------------------------------------------------------#
    # 停止処理実行
    #------------------------------------------------------------------#
    ${RTN_SVCSTRT_TEMP} = Stop-Service -Name ${LC_TGSVNAME}
    ${RTN_SVCSTRT_CMD}  = $?
    if ( ${RTN_SVCSTRT_CMD} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理が正常終了しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 1 ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理にてエラーが発生しました。"
        FC_LogWriter ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理にてエラーが発生しました。"
        return ${False}
    }

    #------------------------------------------------------------------#
    # 停止確認処理 (Stopped確認)
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}確認を行います。"

    for ( ${i} = 1 ; ${i} -le ${COM_ROOP_CNTS} ; ${i}++ ) {
        Start-Sleep -s ${COM_WAIT_TIME}
        ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Stopped" } | %{ $_.Name }
        if ( ${CK_SERVICE} -eq $null ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}確認中です(${i}回目)。"
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}確認が終了しました。"
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を終了します。"
            return ${True}
        }
    }

    if ( ${i} -eq ${COM_ROOP_CNTS} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}確認で異常終了しました。"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を終了します。"
        return ${False}
    }

}

#----------------------------------------------------------------------#
# F01.4 サービス再起動制御
# (概要)
#  サービス再起動制御処理
#  - 第１引数：サービス名                    (必須)
#----------------------------------------------------------------------#
function global:FC_SERVICE_RESTART ( [string] ${LC_TGSVNAME} )
{
    ${FC_SMG_BASE_MSG} = "再起動"
    #------------------------------------------------------------------#
    # 処理起動メッセージ
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を開始します。"

    #------------------------------------------------------------------#
    # 再起動処理実行
    #------------------------------------------------------------------#
    ${RTN_SVCSTRT_TEMP} = Restart-Service -Name ${LC_TGSVNAME}
    ${RTN_SVCSTRT_CMD}  = $?
    if ( ${RTN_SVCSTRT_CMD} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理が正常終了しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 1 ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理にてエラーが発生しました。"
        FC_LogWriter ${PRG_EXIT_CODE} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理にてエラーが発生しました。"
        return ${False}
    }

    #------------------------------------------------------------------#
    # 起動確認処理 (Running確認)
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの起動確認を行います。"

    for ( ${i} = 1 ; ${i} -le ${COM_ROOP_CNTS} ; ${i}++ ) {
        Start-Sleep -s ${COM_WAIT_TIME}
        ${CK_SERVICE} = Get-Service | Where-Object { $_.Name -eq ${LC_TGSVNAME} -and $_.Status -eq "Running" } | %{ $_.Name }
        if ( ${CK_SERVICE} -eq $null ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの起動確認中です(${i}回目)。"
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの起動確認が終了しました。"
            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を終了します。"
            return ${True}
        }
    }

    if ( ${i} -eq ${COM_ROOP_CNTS} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの起動確認で異常終了しました。"
        FC_LogWriter ${DEF_RTNCD_NML} "[${LC_TGSVNAME}]サービスの${FC_SMG_BASE_MSG}処理を終了します。"
        return ${False}
    }

}


