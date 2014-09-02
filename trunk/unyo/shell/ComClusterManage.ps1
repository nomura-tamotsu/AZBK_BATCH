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
#============================================================================
#----------------------------------------------------------------------#
# ComSeviceManage for BANK*R CC  Ver.1.0.0                             #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Cluster Manage Load Modules                                          #
#----------------------------------------------------------------------#
Import-Module FailoverClusters


#----------------------------------------------------------------------#
# F01.クラスタ制御関数                                                 #
#----------------------------------------------------------------------#
# F01.1 クラスタステータス確認関数
# (概要)
#  クラスタステータス確認（[Online]：True）
#----------------------------------------------------------------------#
function global:FC_ClusterStat
{
    # クラスタグループ：ステータス確認
    ${FCL_STAT} = (Get-ClusterGroup -Name ${COM_CLST_RSGP01}).State.ToString().ToUpper()

    if ( ${FCL_STAT} -eq "ONLINE" ) {
        return ${True}
    } else {
        return ${False}
    }

}

#----------------------------------------------------------------------#
# F01.2 稼働ノード確認関数
# (概要)
#  稼働ノード確認処理
#----------------------------------------------------------------------#
function global:FC_GetOwnerNode
{
    # クラスタグループ：稼働ノード確認
    ${FCL_ACTNODE} = (Get-ClusterGroup -Name ${COM_CLST_RSGP01}).OwnerNode.ToString().ToLower()

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
    #------------------------------------------------------------------#
    # 稼働号機確認
    #------------------------------------------------------------------#
    ${RTN_ACT_NODE} = FC_GetOwnerNode
    if ( ${HOST_NMLO} -ne ${RTN_ACT_NODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "待機ノードの為、[${FC_CLS_BASE_MSG}]をスキップします。"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})を終了します。"
        return ${True}
    }

    #------------------------------------------------------------------#
    # 待機号機：ステータス確認 (UPでないと切替不可能の為)
    #------------------------------------------------------------------#
    ${FCL_OTHERNODE_NAME} = (Get-ClusterNode | Select-String -NotMatch -Pattern "${HOST_NMLO}").ToString()
    ${FCL_OTHERNODE_STAT} = (Get-ClusterNode -Name ${FCL_OTHERNODE_NAME}).State.ToString().ToUpper()
    if ( ${FCL_OTHERNODE_STAT} -ne "UP" ) {
        FC_LogWriter ${DEF_RTNCD_NML} "待機ノード側がクラスタ切替可能状態ではない為、[${FC_CLS_BASE_MSG}]をスキップします。"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})を終了します。"
        return ${True}
    }

    #------------------------------------------------------------------#
    # クラスタ切替処理 （Main処理）
    #------------------------------------------------------------------#
    try {
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})を実施します。"
        ${RTN_MOVECLUSTER_CODE} = Move-ClusterGroup -Name ${COM_CLST_RSGP01} -Node ${FCL_OTHERNODE_NAME} -Wait ${COM_CLST_FCOUNT}
        if ( !(${RTN_MOVECLUSTER_CODE}) ) {
            ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
            outmsg 1 ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})にてエラーが発生しました。"
            FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})にてエラーが発生しました。"
            FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})を異常終了します。"
            EndProcess
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})は正常終了しました。"
        }
    } catch [Exception] {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 1 ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})にてエラーが発生しました。"
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})にてエラーが発生しました。"
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})を異常終了します。"
        EndProcess
    }

    #------------------------------------------------------------------#
    # クラスタ切替後確認処理 （クラスタステータス確認）
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "クラスタグループ[${COM_CLST_RSGP01}]のステータス確認を開始します。"
    for ( ${i} = 1 ; ${i} -le ${COM_CLRP_CNTS} ; ${i}++ ) {
        Start-Sleep -s ${COM_CLWT_TIME}
        if ( FC_ClusterStat -ne ${True} ) {
            FC_LogWriter ${DEF_RTNCD_NML} "クラスタグループ[${COM_CLST_RSGP01}]のステータス確認中です(${i}回目)。"
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "クラスタグループ[${COM_CLST_RSGP01}]のステータス確認が終了しました。"
            FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})は全て正常終了しました。"
            return ${True}
        }
    }
    if ( ${i} -eq ${COM_CLRP_CNTS} ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "クラスタグループ[${COM_CLST_RSGP01}]のステータス確認で異常終了しました。"
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})を異常終了します。"
        return ${False}
    }

}
