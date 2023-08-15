#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : クラスタ制御関数
#
# ModName   : ComClusterManage
#
# Condition : UnyoEnv & ComFunction files inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Eddition
# %01 | 23/06/05 | T.TOMINAGA    | WSFCモジュールの無効化【31行目】
#     |          |               | LifeKeeperコミュニケーションパスの確認を処理を追加【40～68行目】
#     |          |               | LifeKeeperリソースActive/Standbyの確認を処理を追加【78～99行目】
# %02 | 23/08/14 | T.TOMINAGA    | JP1/HULFTリソース追加があったため対応（156行目）
#============================================================================
#----------------------------------------------------------------------#
# ComSeviceManage for BANK*R CC  Ver.1.0.0                             #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Cluster Manage Load Modules                                          #
#----------------------------------------------------------------------#
#
#Import-Module FailoverClusters


#----------------------------------------------------------------------#
# F01.クラスタ制御関数                                                 #
#----------------------------------------------------------------------#
# F01.1 クラスタステータス確認関数
# (概要)
#  クラスタハートビートステータス確認（[ALIVE]：True）
#----------------------------------------------------------------------#
function global:FC_ClusterStat
{
# クラスタグループ：ハートビートステータス確認
#   ${FCL_STAT} = (Get-ClusterGroup -Name ${COM_CLST_RSGP01}).State.ToString().ToUpper()
    $flg=0
    if ( ${ENV:COMPUTERNAME} -eq "${COM_CLST_PRI_HOST}") {
        $Server = ${COM_CLST_PRI_HOST}
        $comip = @("${DB_LK_PRI_COMIP1}", "${DB_LK_PRI_COMIP2}")
    } else {
        $Server = ${COM_CLST_ALT_HOST}
        $comip = @("${DB_LK_ALT_COMIP1}", "${DB_LK_ALT_COMIP2}")
    }

    foreach($str_ip in $comip){
        if (& ${DB_LK_CHECK_PATH} -d ${Server} | sls $str_ip | sls ALIVE) { $flg++ }
    }

    if ($flg -eq 2) {
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) Comm Path -- ALL OK"
        return ${True}
    } elseif ($flg -eq 0){
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) Comm Path -- Alert"
        return ${False}
    } else {
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) Comm Path -- Warning "
        return ${False}
    }

}




#----------------------------------------------------------------------#
# F01.2 稼働ノード確認関数
# (概要)
#  稼働ノード確認処理(DBクラスタIPリソース持ちが稼働ホストとする)
#----------------------------------------------------------------------#
function global:FC_GetOwnerNode
{
    # クラスタグループ：稼働ノード確認
    if ( ${ENV:COMPUTERNAME} -eq ${COM_CLST_PRI_HOST}) {
        $HereServer = ${COM_CLST_PRI_HOST}
        $OverServer = ${COM_CLST_ALT_HOST}
        } else {
        $HereServer = ${COM_CLST_ALT_HOST}
        $OverServer = ${COM_CLST_PRI_HOST}
    }

    # オラクルリソース稼働ノード確認
    (& ${DB_LK_CHECK_RESOURCE} -R ${DB_LK_RESOURCE1} -a comm -f/ -d ${HereServer}) | `
        & ${DB_LK_CHECK_AWK} -F'/' '{print $1,$4,$7}'| `
            %{ if("$_" -like '* ISP'){
                    ${FCL_ACTNODE} = ${HereServer}
                }else{
                    ${FCL_ACTNODE} = ${OverServer}
                }
    }

    echo ${FCL_ACTNODE}
}





#----------------------------------------------------------------------#
# F01.32 クラスタ切替関数
# (概要)
#  クラスタ切替処理 (待機号機へ切替）
#----------------------------------------------------------------------#
function global:FC_MoveCluster
{
    ${FC_CLS_BASE_MSG} = "クラスタ切替処理"
    FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}[${FC_CLS_BASE_MSG}]を開始します。"
    Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}[${FC_CLS_BASE_MSG}]を開始します。"
    #------------------------------------------------------------------#
    # 稼働号機確認
    #------------------------------------------------------------------#
    ${RTN_ACT_NODE} = FC_GetOwnerNode
    if ( ${ENV:COMPUTERNAME} -ne ${RTN_ACT_NODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "待機ノードの為、[${FC_CLS_BASE_MSG}]をスキップします。"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})を終了します。"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) 待機ノードの為、[${FC_CLS_BASE_MSG}]をスキップします。"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})を終了します。"
        return ${True}
    }

    #------------------------------------------------------------------#
    # 待機号機：ステータス確認 (ALIVEでないと切替不可能の為)
    #------------------------------------------------------------------#
    if ( ${COM_CLST_PRI_HOST} -eq ${RTN_ACT_NODE} ) {
        ${FCL_OTHERNODE_NAME} = ${COM_CLST_ALT_HOST}
    } else {
        ${FCL_OTHERNODE_NAME} = ${COM_CLST_PRI_HOST}
    }

    ${FCL_OTHERNODE_STAT} = ( & ${DB_LK_CHECK_SYSGET} -s ${FCL_OTHERNODE_NAME} )

    if ( ${FCL_OTHERNODE_STAT} -ne "ALIVE" ) {
        FC_LogWriter ${DEF_RTNCD_NML} "待機ノード側がクラスタ切替可能状態ではない為、[${FC_CLS_BASE_MSG}]をスキップします。"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})を終了します。"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) 待機ノード側がクラスタ切替可能状態ではない為、[${FC_CLS_BASE_MSG}]をスキップします。"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})を終了します。"

        return ${True}
    }


    #------------------------------------------------------------------#
    # クラスタ切替処理 （Main処理）
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})を実施します。"
    Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})を実施します。"
    ${LK_TOP_RESOURCE} = @("${DB_LK_RESOURCE1}", "${DB_LK_RESOURCE2}", "${DB_LK_RESOURCE3}", "${DB_LK_RESOURCE4}, "${DB_LK_RESOURCE5}")
    foreach( $str_LK in ${LK_TOP_RESOURCE}){

        ### LKリソース停止処理 ###
        ${LK_RESOURCE_STOP} = (& ${DB_LK_FAILOVER_ACTION} -t ${str_LK} -a remove)
        &{if ( "$?" -eq "True"){
            FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは正常に停止処理しました。"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは正常に停止処理しました。"
        } else {
            outmsg 1 ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは停止処理で異常を検知しました。"
            FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは停止処理で異常を検知しました。"
            FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースを異常終了します。"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは停止処理で異常を検知しました。"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースを異常終了します。"
            EndProcess
            }
        }


        ### LKリソース起動処理 ###
        (& ${DB_LK_FAILOVER_EXEC} -d ${FCL_OTHERNODE_NAME} -- ${DB_LK_FAILOVER_ACTION} -t ${str_LK} -a restore) | `
            &{if ( "$?" -eq "True"){
                FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは正常に切替えました。"
                Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) {PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは正常に切替えました。"
            } else {
                outmsg 1 ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは起動処理で異常を検知しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは起動処理で異常を検知しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースを異常終了します。"
                Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss'))  ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースは起動処理で異常を検知しました。"
                Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_EXIT_CODE} ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})リソースを異常終了します。"
                EndProcess
            }
        }

        #sleep -s 5

    }


    #------------------------------------------------------------------#
    # クラスタ切替後確認処理 （クラスタステータス確認）
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "クラスタグループ[${COM_CLST_RSGP01}]のステータス確認を開始します。"
    Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) クラスタグループ[${COM_CLST_RSGP01}]のステータス確認を開始します。"

    $RESOURCEflg = 0
    ${RTN_ACT_NODE} = FC_GetOwnerNode
    ${LK_ALLRESOURCE_CNTS} = (& ${DB_LK_CHECK_RESOURCE} ).Count

    (& ${DB_LK_CHECK_RESOURCE} -d ${RTN_ACT_NODE} -f/ ) | & ${DB_LK_CHECK_AWK} -F'/' '{print $1,$4,$7}'| `
        %{ if("$_" -like '* ISP'){
            $DB_LK_RESOURCE_STATUS = ( "$_" | & ${DB_LK_CHECK_AWK} '{print $2}')
            $RESOURCEflg++
            FC_LogWriter ${DEF_RTNCD_NML} "リソース[${DB_LK_RESOURCE_STATUS}]のステータス確認が終了しました。"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) リソース[${DB_LK_RESOURCE_STATUS}]のステータス確認が終了しました。"
        }else{
            $DB_LK_RESOURCE_STATUS = ( "$_" | & ${DB_LK_CHECK_AWK} '{print $2}')
            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
            FC_LogWriter ${PRG_EXIT_CODE} "リソース[${DB_LK_RESOURCE_STATUS}]のステータス確認で異常終了しました。"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) リソース[${DB_LK_RESOURCE_STATUS}]のステータス確認で異常終了しました。"
        }
    }


    if ("$RESOURCEflg"-eq "${LK_ALLRESOURCE_CNTS}") {
        #Write-Host "LK RESOURCE -- ALL OK"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})は全て正常終了しました。"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})は全て正常終了しました。"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) リソース切替え完了"
        return ${True}
    } else {
        #Write-Host "LK RESOURCE -- Warning or Alert"
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})を異常終了します。"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})を異常終了します。"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) リソース切替え停止"
        return ${False}
    }

}
