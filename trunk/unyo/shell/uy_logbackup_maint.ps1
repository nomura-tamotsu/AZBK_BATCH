#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2017
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ログバックアップメンテ処理
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
${PRG_NAME}         = "ログバックアップメンテ処理"
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
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# Local Function 
#--------------------------------------------
#----------------------------------------------------------------------#
# F01.メンテ用ログバックアップリラン処理関数                           #
#----------------------------------------------------------------------#
# F01.1 Maint LOG Backkup ReRun
# (概要)
#  ログバックアップ処理を失敗分を対象に再実施
#----------------------------------------------------------------------#
function LFC_BACKUP_RERUN
{
    # 1. 引数チェック
    if ( $args.Length -ne 2 ) {
        ${PRG_EXIT_CODE}     = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE}  "メンテ用ログバックアップリラン処理関数の引数に誤りがあります。処理を中止します。"
        FC_LogWriter ${PRG_EXIT_CODE} "メンテ用ログバックアップリラン処理関数の引数に誤りがあります。処理を中止します。"
        return ${False}
    } else {
        ${LC_TGFILE} = $args[0]   # 定義ファイル
        ${LC_TGTYPE} = $args[1]   # 処理区分
    }

    # 2. 処理開始メッセージ出力
    outmsg 1 ${DEF_RTNCD_NML} "メンテ用ログバックアップリラン処理関数を開始します。"
    FC_LogWriter ${DEF_RTNCD_NML} "メンテ用ログバックアップリラン処理関数を開始します。"

    # 3. 第1引数 定義ファイル存在チェック
    FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${LC_TGFILE}]より情報取得します(${PRG_NAME})"
    if ( !(Test-Path ${LC_TGFILE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${LC_TGFILE}"
        FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${LC_TGFILE}]は存在しない為、処理を中止します(${PRG_NAME})"
        return ${False}
    }

    # 4. 第2引数 定義ファイル存在チェック
    # 処理区分チェック
    switch("${LC_TGTYPE}") {
        "COPY"  { ${BKUP_FLG} = "C" ; ${BKUP_MODE} = "Copy処理" ; break }
        "MOVE"  { ${BKUP_FLG} = "M" ; ${BKUP_MODE} = "Move処理" ; break }
        default { FC_LogWriter ${DEF_RTNCD_NML} "バックアップ処理の処理区分に誤りがある為、処理を中止します(${PRG_NAME})"
                  return ${False}
                }
    }

    # 5. メンテ用ログバックアップ失敗リストファイル名設定
    # メンテ用ログバックアップ失敗リストファイル名の設定
    ${LFC_BACKUP_TMP_FAILLIST_FNAME} = "TMP_" + $(Get-ChildItem "${LC_TGFILE}").Name
    # メンテ用ログバックアップ失敗リストファイル名(FULL-Path)
    ${LFC_BACKUP_TMP_FAILLIST_FPATH} = "${UNYO_WRK_DIR}\${LFC_BACKUP_TMP_FAILLIST_FNAME}"

    # 6. メンテ用ログバックアップ失敗リストファイルの初期化(処理区分COPYの場合のみ)
    if ( ${BKUP_FLG} -eq "C" ) {
        if ( (Test-Path ${LFC_BACKUP_TMP_FAILLIST_FPATH}) ) {
            Clear-Content -Path ${LFC_BACKUP_TMP_FAILLIST_FPATH} 2>&1 > $null
        } else {
            New-Item -ItemType file ${LFC_BACKUP_TMP_FAILLIST_FPATH} 2>&1 > $null
        }
    }

    # 7. メンテ用ログバックアップリラン処理
    :LPLABEL_MNT_BKFILELIST foreach ( ${LC_LINE01} in Get-Content ${LC_TGFILE} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" | Select-String -Pattern "^${BKUP_FLG}" ) {

        # 対象区分取得(F:ファイル,D:ディレクトリ)
        ${TG_BACKUPTYPE}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
        # 対象ファイル/ディレクトリ
        ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
        # 保管先ディレクトリ
        ${TG_DESTI_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }
        # 失敗カウント
        ${TG_FAIL_COUNT}        = "${LC_LINE01}" | %{ $_.Split(",")[4] }
        ${TG_FAIL_COUNT}        = [int]${TG_FAIL_COUNT}
        ${TMP_TG_FAIL_COUNT}    = 0

        # 削除区分チェック
        switch("${TG_BACKUPTYPE}") {
            "F"     { ${BKUP_CHKMSG} = "ファイル"     ; break }
            "D"     { ${BKUP_CHKMSG} = "ディレクトリ" ; break }
            default { FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]ファイルまたはディレクトリの対象区分指定に誤りがあります。処理をスキップします。" 
                      continue LPLABEL_MNT_BKFILELIST
                    }
        }

        # バックアップリラン処理実行
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップリラン処理(${BKUP_MODE})を開始します。"

        # 対象存在チェック
        if ( !(Test-Path ${TG_SORCE_FILE}) ) { 
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}が存在しない為、処理をスキップします。"
            continue
        }

        # COPY/MOVE処理実施
        if ( "${BKUP_FLG}" -eq "C" ) {
            # COPY処理実施
            try { 
                    ${RTN_CPY_TEMP} = Copy-Item ${TG_SORCE_FILE} ${TG_DESTI_DIRS} -Recurse
                    ${RTN_CPY_CODE} = $?
            } catch [Exception] {
                    ${RTN_CPY_CODE} = ${False}
            }
        } else {
            # 対象ファイル依存関係チェック処理
            if ( (Get-Content ${LFC_BACKUP_TMP_FAILLIST_FPATH} | Select-String -SimpleMatch ",${TG_SORCE_FILE}," -Quiet ) ) {
                # バックアップ処理失敗リストファイルへの追加
                # 失敗カウントのカウントアップ
                ${TG_FAIL_COUNT}++
                ${TMP_TG_FAIL_COUNT} = ${TG_FAIL_COUNT}
                # 処理区分${BKUP_FLG},対象区分${TG_BACKUPTYPE},${TG_SORCE_FILE},${TG_DESTI_DIRS},${TG_FAIL_COUNT}
                "${BKUP_FLG},${TG_BACKUPTYPE},${TG_SORCE_FILE},${TG_DESTI_DIRS},${TG_FAIL_COUNT}" | `
                Out-File -FilePath ${LFC_BACKUP_TMP_FAILLIST_FPATH} -Append -Encoding default
                # 失敗カウント閾値チェック
                if ( ${TMP_TG_FAIL_COUNT} -ge ${COM_LOGBAKUP_RETRYCOUNT} ) {
                    outmsg 55 ${PRG_EXIT_CODE} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップリラン処理(${BKUP_MODE})の失敗回数が上限回数を超過しました。(COPY依存関係)"
                    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップリラン処理(${BKUP_MODE})の失敗回数が上限回数を超過しました。(COPY依存関係)"
                }
                FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップ処理(${BKUP_MODE})の事前確認にてスキップ対象となりました。バックアップリラン処理(${BKUP_MODE})をスキップします。"
                continue
            }
            # MOVE処理実施
            try {
                    ${RTN_CPY_TEMP} = Move-Item ${TG_SORCE_FILE} ${TG_DESTI_DIRS} -Force -ErrorAction Stop
                    ${RTN_CPY_CODE} = $?
            } catch [Exception] {
                    ${RTN_CPY_CODE} = ${False}
            }
        }

        # COPY/MOVE処理結果判定
        if ( ${RTN_CPY_CODE} ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップリラン処理(${BKUP_MODE})が正常終了しました。"
        } else {
            # バックアップ処理失敗リストファイルへの追加
            # 失敗カウントのカウントアップ
            ${TG_FAIL_COUNT}++
            ${TMP_TG_FAIL_COUNT} = ${TG_FAIL_COUNT}
            # 失敗カウント閾値チェック
            if ( ${TMP_TG_FAIL_COUNT} -ge ${COM_LOGBAKUP_RETRYCOUNT} ) {
                outmsg 55 ${PRG_EXIT_CODE} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップリラン処理(${BKUP_MODE})の失敗回数が上限回数を超過しました。"
                FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップリラン処理(${BKUP_MODE})の失敗回数が上限回数を超過しました。"
            }
            "${BKUP_FLG},${TG_BACKUPTYPE},${TG_SORCE_FILE},${TG_DESTI_DIRS},${TG_FAIL_COUNT}" | `
            Out-File -FilePath ${LFC_BACKUP_TMP_FAILLIST_FPATH} -Append -Encoding default
            outmsg 1 ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップリラン処理(${BKUP_MODE})にてエラーが発生しました、バックアップリラン処理をスキップします"
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_FILE}]${BKUP_CHKMSG}のバックアップリラン処理(${BKUP_MODE})にてエラーが発生しました、バックアップリラン処理をスキップします。"
        }
    }

    # 8. 処理開始メッセージ出力
    outmsg 1 ${DEF_RTNCD_NML} "メンテ用ログバックアップリラン処理関数を終了します。"
    FC_LogWriter ${DEF_RTNCD_NML} "メンテ用ログバックアップリラン処理関数を終了します。"

    # 9. 処理結果
    return ${True}

}


#--------------------------------------------
# MAIN
#--------------------------------------------
# 1. Start Main Program
InitProcess

#--------------------------------------------
# 2. メンテ用各種ログバックアップリラン処理
#--------------------------------------------
# 2.1. メンテ用各種ログバックアップリランリストのファイル最新化
#--------------------------------------------
${LC_MNTTYPE} = "メンテ用各種"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリストの最新化を行います。"
${MNT_TGFILE01} = ${FAIL_BACKUP_OTHER_LOG_DEF}
${MNT_TGFILE02} = ${LOGBACKUP_OTHER_RERUN_LST}
${MNT_TGFILE03} = ${LOGBACKUP_OTHER_RERUN_LST_TMP}
# 各種ログバックアップ処理失敗リストの存在確認
if ( !(Test-Path ${MNT_TGFILE01}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${MNT_TGFILE01}"
    FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${MNT_TGFILE01}]は存在しない為、処理を中止します(${PRG_NAME})"
    EndProcess
}
# メンテ用各種ログバックアップ処理失敗リスト定義の存在確認
if ( !(Test-Path ${MNT_TGFILE02}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${MNT_TGFILE02}"
    FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${MNT_TGFILE02}]は存在しない為、処理を中止します(${PRG_NAME})"
    EndProcess
}

# 失敗リストファイルの最新化
foreach ( ${LC_FILE_LINE01} in Get-Content ${MNT_TGFILE01} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

    # 処理区分取得(C:COPY,M:MOVE)
    ${FILE_BACKUPMODE}    = "${LC_FILE_LINE01}" | %{ $_.Split(",")[0] }
    # 対象区分取得(F:ファイル,D:ディレクトリ)
    ${FILE_BACKUPTYPE}    = "${LC_FILE_LINE01}" | %{ $_.Split(",")[1] }
    # 対象ファイル/ディレクトリ
    ${FILE_SORCE_FILE01}  = "${LC_FILE_LINE01}" | %{ $_.Split(",")[2] }
    # メンテ用失敗リストファイルに存在するかを確認
    if ( !(Get-Content ${MNT_TGFILE02} |  Select-String -Pattern "^${FILE_BACKUPMODE},${FILE_BACKUPTYPE}," | Select-String -SimpleMatch ",${FILE_SORCE_FILE01}," -Quiet ) ) {
        # メンテ用失敗リストファイルへの追加
        "${LC_FILE_LINE01}" | Out-File -FilePath ${MNT_TGFILE02} -Append -Encoding default
    }
}

#--------------------------------------------
# 2.2. メンテ用各種ログバックアップリラン処理(COPY処理)実施
#--------------------------------------------
${LC_STEPMSG} = "COPY処理"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})を実施します。"
try {
    ${RTN_FCBACKUP_CODE} = LFC_BACKUP_RERUN ${MNT_TGFILE02} "COPY"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})は終了しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
    EndProcess
}

#--------------------------------------------
# 2.3. メンテ用各種ログバックアップリラン処理(MOVE処理)実施
#--------------------------------------------
${LC_STEPMSG} = "MOVE処理"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})を実施します。"
try {
    ${RTN_FCBACKUP_CODE} = LFC_BACKUP_RERUN ${MNT_TGFILE02} "MOVE"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})は終了しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
    EndProcess
}

#--------------------------------------------
# 2.4. メンテ用各種ログバックアップリランリストのファイル更新（結果反映）
#--------------------------------------------
# メンテ用各種ログバックアップリランリストのファイル更新開始メッセージ
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映を行います。"
# メンテ用各種ログバックアップ処理失敗リスト定義の存在確認
if ( (Test-Path ${MNT_TGFILE03}) ) {
    try {
            ${RTN_CPY_TEMP} = Copy-Item ${MNT_TGFILE03} ${MNT_TGFILE02} -Recurse
            ${RTN_CPY_CODE} = $?
    } catch [Exception] {
            ${RTN_CPY_CODE} = ${False}
    }

    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映処理が正常終了しました。"
        Remove-Item ${MNT_TGFILE03} -Recurse 2>&1 > $null
    } else {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映処理にて異常終了しました。"
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映処理にて異常終了しました。"
        EndProcess
    }
} else {
    Clear-Content -Path ${MNT_TGFILE02} 2>&1 > $null
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映処理が正常終了しました。"
}


#--------------------------------------------
# 3. メンテ用監査ログバックアップリラン処理
#--------------------------------------------
# 3.1. メンテ用各種ログバックアップリランリストのファイル最新化
#--------------------------------------------
${LC_MNTTYPE} = "メンテ用監査"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリストの最新化を行います。"
${MNT_TGFILE01} = ${FAIL_BACKUP_AUDIT_LOG_DEF}
${MNT_TGFILE02} = ${LOGBACKUP_AUDIT_RERUN_LST}
${MNT_TGFILE03} = ${LOGBACKUP_AUDIT_RERUN_LST_TMP}
# 監査ログバックアップ処理失敗リストの存在確認
if ( !(Test-Path ${MNT_TGFILE01}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${MNT_TGFILE01}"
    FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${MNT_TGFILE01}]は存在しない為、処理を中止します(${PRG_NAME})"
    EndProcess
}
# メンテ用監査ログバックアップ処理失敗リスト定義の存在確認
if ( !(Test-Path ${MNT_TGFILE02}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${MNT_TGFILE02}"
    FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${MNT_TGFILE02}]は存在しない為、処理を中止します(${PRG_NAME})"
    EndProcess
}

# 失敗リストファイルの最新化
foreach ( ${LC_FILE_LINE01} in Get-Content ${MNT_TGFILE01} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

    # 処理区分取得(C:COPY,M:MOVE)
    ${FILE_BACKUPMODE}    = "${LC_FILE_LINE01}" | %{ $_.Split(",")[0] }
    # 対象区分取得(F:ファイル,D:ディレクトリ)
    ${FILE_BACKUPTYPE}    = "${LC_FILE_LINE01}" | %{ $_.Split(",")[1] }
    # 対象ファイル/ディレクトリ
    ${FILE_SORCE_FILE01}  = "${LC_FILE_LINE01}" | %{ $_.Split(",")[2] }
    # メンテ用失敗リストファイルに存在するかを確認
    if ( !(Get-Content ${MNT_TGFILE02} |  Select-String -Pattern "^${FILE_BACKUPMODE},${FILE_BACKUPTYPE}," | Select-String -SimpleMatch ",${FILE_SORCE_FILE01}," -Quiet ) ) {
        # メンテ用失敗リストファイルへの追加
        "${LC_FILE_LINE01}" | Out-File -FilePath ${MNT_TGFILE02} -Append -Encoding default
    }
}

#--------------------------------------------
# 3.2. メンテ用監査ログバックアップリラン処理(COPY処理)実施
#--------------------------------------------
${LC_STEPMSG} = "COPY処理"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})を実施します。"
try {
    ${RTN_FCBACKUP_CODE} = LFC_BACKUP_RERUN ${MNT_TGFILE02} "COPY"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})は終了しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
    EndProcess
}

#--------------------------------------------
# 3.3. メンテ用監査ログバックアップリラン処理(MOVE処理)実施
#--------------------------------------------
${LC_STEPMSG} = "MOVE処理"
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})を実施します。"
try {
    ${RTN_FCBACKUP_CODE} = LFC_BACKUP_RERUN ${MNT_TGFILE02} "MOVE"
    if ( !(${RTN_FCBACKUP_CODE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
        EndProcess
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})は終了しました。"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${LC_MNTTYPE}${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。"
    EndProcess
}

#--------------------------------------------
# 3.4. メンテ用監査ログバックアップリランリストのファイル更新（結果反映）
#--------------------------------------------
# メンテ用監査ログバックアップリランリストのファイル更新開始メッセージ
FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映を行います。"
# メンテ用監査ログバックアップ処理失敗リスト定義の存在確認
if ( (Test-Path ${MNT_TGFILE03}) ) {
    try {
            ${RTN_CPY_TEMP} = Copy-Item ${MNT_TGFILE03} ${MNT_TGFILE02} -Recurse
            ${RTN_CPY_CODE} = $?
    } catch [Exception] {
            ${RTN_CPY_CODE} = ${False}
    }

    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映処理が正常終了しました。"
        Remove-Item ${MNT_TGFILE03} -Recurse 2>&1 > $null
    } else {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映処理にて異常終了しました。"
        FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映処理にて異常終了しました。"
        EndProcess
    }
} else {
    Clear-Content -Path ${MNT_TGFILE02} 2>&1 > $null
    FC_LogWriter ${DEF_RTNCD_NML} "${LC_MNTTYPE}ログバックアップリランリスト結果の反映処理が正常終了しました。"
}

#--------------------------------------------
# 4. End Main Program
#--------------------------------------------
EndProcess
