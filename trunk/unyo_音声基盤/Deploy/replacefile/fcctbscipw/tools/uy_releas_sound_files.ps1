#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : 音声ファイルリリースプログラム
#
# FILE      : uy_releas_sound_files.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/08/28 | R.YAMANO      | First Eddition
#============================================================================
# Environment Variable Setting
#----------------------------------------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "音声ファイルリリースプログラム"
${PRG_EXIT_CODE}    = 0

#----------------------------------------------------------------------------
#  Variable definition
#----------------------------------------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#----------------------------------------------------------------------------
# Local Env Setting
#----------------------------------------------------------------------------
${LOG_FLAG}  = 1
${ACT_TIME}  = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}  = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"
#----------------------------------------------------------------------------
# 実行日付取得 (yyyyMMdd)
#----------------------------------------------------------------------------
${ACT_DATE}  = Get-Date -format "${COM_DATEFORM08}"

#----------------------------------------------------------------------------
# リリース対象ファイル格納定義
#----------------------------------------------------------------------------
${LC_BASE_DISTDIR} = "D:\work\azbank\releas"
${LC_FILE_DISTDIR} = "${LC_BASE_DISTDIR}\wavs"
${LC_TEMP_DISTDIR} = "${LC_BASE_DISTDIR}\temp"
#----------------------------------------------------------------------------
# バックアップ定義
#----------------------------------------------------------------------------
${LC_BASE_BKUPDIR} = "${LC_BASE_DISTDIR}\backup"
${LC_DATE_BKUPDIR} = "${LC_BASE_BKUPDIR}\${ACT_DATE}"
#----------------------------------------------------------------------------
# リリース先情報
#----------------------------------------------------------------------------
${LC_BASE_RELEDIR} = "D:\I3\IC\Resources\azbank\WAV"

#----------------------------------------------------------------------------
# Function
#----------------------------------------------------------------------------
# 共通関数
#----------------------------------------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#----------------------------------------------------------------------------
# MAIN
#----------------------------------------------------------------------------
# Start Main Program
#----------------------------------------------------------------------------
InitProcess

#----------------------------------------------------------------------------
# 1. 事前確認
#----------------------------------------------------------------------------
# 1.1 リリース対象ファイル格納用ディレクトリ存在チェック
#----------------------------------------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "リリース対象ファイル格納用ディレクトリの存在チェック処理を開始します。"
if ( !(Test-Path ${LC_FILE_DISTDIR}) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    ${LC_MSG_LINE} = "リリース対象ファイル格納用ディレクトリ[${LC_FILE_DISTDIR}]が存在しない為、処理を中止します。"
    outmsg 55 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
    FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
    EndProcess
}
FC_LogWriter ${DEF_RTNCD_NML} "リリース対象ファイル格納用ディレクトリの存在チェック処理が正常終了しました。"
#----------------------------------------------------------------------------
# 1.2 リリース対象ファイル存在チェック
#----------------------------------------------------------------------------
# リリース対象ファイル確認処理（ファイルが無い場合は後続処理を中止）
#----------------------------------------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "リリース対象ファイル確認処理を開始します。"
${TG_FIND_FILES} = @(Get-ChildItem ${LC_FILE_DISTDIR})
if ( ${TG_FIND_FILES}.length -eq 0 ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_NML}
    ${LC_MSG_LINE} = "リリース対象ファイルが存在しない為、処理を終了します。"
    outmsg 1 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
    FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
    EndProcess
}
FC_LogWriter ${DEF_RTNCD_NML} "リリース対象ファイル確認処理が終了しました。"

#----------------------------------------------------------------------------
# 1.3 リリース処理
#----------------------------------------------------------------------------
foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

    # ファイル属性：Fileのみを取得
    if ( ${FINDFILE}.PsISContainer -eq ${False} ) {
        ${TG_FILE_NAME}      = ${FINDFILE}.name
        ${TG_FILE_FULL_NAME} = ${FINDFILE}.fullname

        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]のリリース処理を開始します。"

        ${RL_FILE_FULL_NAME} = "${LC_BASE_RELEDIR}\${TG_FILE_NAME}"
        if ( (Test-Path ${RL_FILE_FULL_NAME}) ) {
            #----------------------------------------------------------------
            # 1.3.1 リリース前バックアップ処理
            #----------------------------------------------------------------
            if ( !(Test-Path ${LC_DATE_BKUPDIR}) ) {
                FC_LogWriter ${DEF_RTNCD_NML} "バックアップディレクトリ[${LC_DATE_BKUPDIR}]を作成します。"
                New-Item ${LC_DATE_BKUPDIR} -ItemType Directory 2>&1 > $null
            }
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]のリリース前バックアップ処理を開始します。"
            ${RTN_CPY_TEMP} = Copy-Item ${TG_FILE_FULL_NAME} ${LC_DATE_BKUPDIR}\${TG_FILE_NAME}.${ACT_TIME} -Recurse
            ${RTN_CPY_CODE} = $?
            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]のリリース前バックアップ処理が正常終了しました。"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                ${LC_MSG_LINE} = "[${TG_FILE_NAME}]のリリース前バックアップ処理にてエラーが発生しました。"
                outmsg 55 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
                FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
                EndProcess
            }
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]は初回リリースの為、バックアップ処理は行いません。"
        }

        #--------------------------------------------------------------------
        # 1.3.2 リリース処理
        #--------------------------------------------------------------------
        ${RTN_CPY_TEMP} = Copy-Item ${TG_FILE_FULL_NAME} ${RL_FILE_FULL_NAME} -Recurse
        ${RTN_CPY_CODE} = $?
        if ( ${RTN_CPY_CODE} ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]のリリース処理が正常終了しました。"
        } else {
            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
            ${LC_MSG_LINE} = "[${TG_FILE_NAME}]のリリース処理にてエラーが発生しました。"
            outmsg 55 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
            FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
            EndProcess
        }

        #--------------------------------------------------------------------
        # 1.3.3 リリース事後処理（リリース対象ファイルクリア処理）
        #--------------------------------------------------------------------
        if ( (Test-Path ${TG_FILE_FULL_NAME}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]リリース用ファイルの削除処理を行います。"
            Remove-Item ${TG_FILE_FULL_NAME} -Recurse 2>&1 > $null
            ${RTN_DEL_CODE} = $?
            if ( ${RTN_DEL_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_NAME}]リリース用ファイルの削除処理が正常終了しました。"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                ${LC_MSG_LINE} = "[${TG_FILE_NAME}]リリース用ファイルの削除処理にてエラーが発生しました。"
                outmsg 55 ${PRG_EXIT_CODE} ${LC_MSG_LINE}
                FC_LogWriter ${PRG_EXIT_CODE} ${LC_MSG_LINE}
                EndProcess
            }
        }

    }
}

#----------------------------------------------------------------------------
# End Main Program
#----------------------------------------------------------------------------
EndProcess
