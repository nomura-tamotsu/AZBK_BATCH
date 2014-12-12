#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : 契約者ファイル取込実行
#
# FILE      : uy_execute_member_regist_start.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %01 | 14/05/14 | N.OGAWA       | First Eddition
# %02 | 14/06/10 | R.YAMANO      | First Eddition Fix
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "契約者ファイル取込実行"
${PRG_EXIT_CODE}    = 0

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
#  Java Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\ExecuteMemberRegistEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${LOG_FLAG}         = 1
${ACT_TIME}         = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}         = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# 取得先サーバ生存チェック
#--------------------------------------------
if ( !(Test-Connection ${COM_DBSV_VHOST} -quiet) ) {
    # 接続不能の為、処理を中止します。
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "ファイル取得先サーバ[${COM_DBSV_VHOST}]に接続できない為、処理を中止します。"
    FC_LogWriter ${DEF_RTNCD_NML} "ファイル取得先サーバ[${COM_DBSV_VHOST}]に接続できない為、処理を中止します。"
    EndProcess
}

#--------------------------------------------
# 契約者ファイル取得処理
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "契約者ファイル取得処理を開始します。"
for ( ${GET_FILE_COUNT} = 0 ; ${GET_FILE_COUNT} -lt ${BR_TRG_EN_FILE00}.length ; ${GET_FILE_COUNT}++ ) {

    ${TG_FILE_ENAME} = ${BR_TRG_EN_FILE00}[${GET_FILE_COUNT}]
    ${TG_FILE_JNAME} = ${BR_TRG_JP_FILE00}[${GET_FILE_COUNT}]
    ${ST_FILE_ENAME} = ${BR_SET_EN_FILE00}[${GET_FILE_COUNT}]

    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]を確認します。"

    ${TG_FULLPATH_FNAME} = "${BR_GET_FILEDIR00}\${TG_FILE_ENAME}"
    ${ST_FULLPATH_FNAME} = "${BR_SET_FILEDIR00}\${ST_FILE_ENAME}"

    if ( !(Test-Path ${TG_FULLPATH_FNAME}) ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${TG_FILE_ENAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]は存在しない為、処理を中止します。"
        EndProcess
    }

    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]を確認しました。ファイル取得処理を開始します。"
    ${RTN_CPY_TEMP} = Copy-Item ${TG_FULLPATH_FNAME} ${ST_FULLPATH_FNAME} -Recurse
    ${RTN_CPY_CODE} = $?
    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]の取得処理が正常終了しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]の取得処理にてエラーが発生した為、処理を中止します。"
        FC_LogWriter ${PRG_EXIT_CODE} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]の取得処理にてエラーが発生した為、処理を中止します。"
        EndProcess
    }

}
FC_LogWriter ${DEF_RTNCD_NML} "契約者ファイル取得処理を終了します。"


#--------------------------------------------
# 契約者ファイル取込実行コマンド取得
#--------------------------------------------
${COM_RESERVE_CMDLINE} = "${COM_WAS_CMND_JAVA} "
${LC_CLPATH_00} = "${BR_JAVA_CLPATH01};${BR_JAVA_CLPATH02}"
${LC_CLNAME_00} = "${BR_JAVA_CLFILE01}"
${LC_SECPRP_00} = "`"${BR_JAVA_SECPRP01}`" `"${BR_JAVA_SECPRP02}`" `"${BR_JAVA_SECPRP03}`" `"${BR_JAVA_SECPRP04}`" `"${BR_JAVA_SECPRP05}`""


#--------------------------------------------
# 処理実行
#--------------------------------------------
try {
    Invoke-Expression "${COM_WAS_CMND_JAVA} ${LC_SECPRP_00} -DeMBSV=1 -classpath '${LC_CLPATH_00}' ${LC_CLNAME_00}"
    if ( ${LASTEXITCODE} -eq 0 ) {
        # 実行結果：成功
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}に成功しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}に失敗しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}にて異常が発生しました。"
    EndProcess
}


#--------------------------------------------
# 契約者ファイルバックアップ処理
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "契約者ファイルバックアップ処理を開始します。"
for ( ${GET_FILE_COUNT} = 0 ; ${GET_FILE_COUNT} -lt ${BR_TRG_EN_FILE00}.length ; ${GET_FILE_COUNT}++ ) {

    ${TG_FILE_ENAME} = ${BR_TRG_EN_FILE00}[${GET_FILE_COUNT}]
    ${TG_FILE_JNAME} = ${BR_TRG_JP_FILE00}[${GET_FILE_COUNT}]
    ${TG_BKUP_TIMES} = Get-Date -format "${COM_DATEFORM03}"

    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]を確認します。"

    ${TG_FULLPATH_FNAME} = "${BR_GET_FILEDIR00}\${TG_FILE_ENAME}"
    ${BK_FULLPATH_FNAME} = "${BR_GET_FILEDIR00}\backup\${TG_FILE_ENAME}.${TG_BKUP_TIMES}"

    if ( !(Test-Path ${TG_FULLPATH_FNAME}) ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${TG_FILE_ENAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]は存在しない為、処理を中止します。"
        EndProcess
    }

    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]を確認しました。バックアップ取得処理を開始します。"
    ${RTN_CPY_TEMP} = Move-Item ${TG_FULLPATH_FNAME} ${BK_FULLPATH_FNAME} -Force
    ${RTN_CPY_CODE} = $?

    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]のバックアップ処理が正常終了しました。"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]のバックアップ処理にてエラーが発生した為、処理を中止します。"
        FC_LogWriter ${PRG_EXIT_CODE} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]の取得処理にてエラーが発生した為、処理を中止します。"
        EndProcess
    }

}
FC_LogWriter ${DEF_RTNCD_NML} "契約者ファイルバックアップ取得処理を終了します。"


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
