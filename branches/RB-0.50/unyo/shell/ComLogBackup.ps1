#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ログバックアップ処理関数
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
# F01.ログバックアップ処理関数                                         #
#----------------------------------------------------------------------#
# F01.1 LogBackup (Copy/Move)
# (概要)
#  ログバックアップ処理(COPY処理/MOVE処理)
#  - 第１引数：定義ファイル(Full-Path) (必須)
#  - 第２引数：処理区分(COPY,MOVE)     (必須)
#  - 第３引数：置換対象日付            (必須)
#----------------------------------------------------------------------#
function global:FC_BACKUP_COPY ( [string] ${LC_TGFILE},[string] ${LC_TGTYPE},[string] ${LC_CHGDATE})
{
    # 定義ファイル存在チェック
    FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${LC_TGFILE}]より情報取得します(${PRG_NAME})"
    if ( !(Test-Path ${LC_TGFILE}) ) {
        ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${LC_TGFILE}"
        FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${LC_TGFILE}]は存在しない為、処理を中止します(${PRG_NAME})"
        return ${False}
    }

    # 処理区分チェック
    switch("${LC_TGTYPE}") {
        "COPY"  { ${BKUP_FLG} = "C" ; ${BKUP_MODE} = "Copy処理" ; break }
        "MOVE"  { ${BKUP_FLG} = "M" ; ${BKUP_MODE} = "Move処理" ; break }
        default { FC_LogWriter ${DEF_RTNCD_NML} "バックアップ処理の処理区分に誤りがある為、処理を中止します(${PRG_NAME})"
                  return ${False}
                }
    }

    if ( ${LC_CHGDATE} -ne "x" ) {
        if ( ! (${LC_CHGDATE} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet) ) {
            FC_LogWriter 1 "置換日付の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
            return ${False}
        }
    }

    foreach ( ${LC_LINE01} in Get-Content ${LC_TGFILE} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" | Select-String -Pattern "^${BKUP_FLG}" ) {

        # 処理件数確認用
        ${LC_ACT_COUNT} = 0
        # 対象区分取得(F:ファイル,D:ディレクトリ)
        ${TG_BACKUPTYPE}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
        # 対象上位ディレクトリ取得 (キー置換記載許容)
        ${TG_SORCE_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
        # 対象対象ディレクトリ/ファイル取得 (ワイルドカード記載、キー置換記載許容)
        ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }
        # 保管先ディレクトリ (キー置換記載許容)
        ${TG_DESTI_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[4] }

        # 対象上位ディレクトリ確認処理
        if ( !(${TG_SORCE_DIRS}.EndsWith("\")) ) {
            ${TG_SORCE_DIRS} = ${TG_SORCE_DIRS} + "\"
        }
        # 対象上位ディレクトリ キー置換処理
        if ( ${TG_SORCE_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_SORCE_DIRS} = FC_ReplaceString "${TG_SORCE_DIRS}" -tdate ${LC_CHGDATE}
        }
        ${TG_SORCE_DIRS} = Invoke-Expression "Write-Output ${TG_SORCE_DIRS}"
        # ディレクトリ存在チェック
        if ( !(Test-Path ${TG_SORCE_DIRS}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "対象上位ディレクトリ[${TG_SORCE_DIRS}]が存在しない為スキップします。"
            continue
        }

        # 対象ファイル/ディレクトリ キー置換処理
        if ( ${TG_SORCE_FILE} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_SORCE_FILE} = FC_ReplaceString "${TG_SORCE_FILE}" -tdate ${LC_CHGDATE}
        }

        # 保管先ディレクトリ 確認処理
        if ( !(${TG_DESTI_DIRS}.EndsWith("\")) ) {
            ${TG_DESTI_DIRS} = ${TG_DESTI_DIRS} + "\"
        }
        # 保管先ディレクトリ キー置換記載許容
        if ( ${TG_DESTI_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_DESTI_DIRS} = FC_ReplaceString "${TG_DESTI_DIRS}" -tdate ${LC_CHGDATE}
        }
        ${TG_DESTI_DIRS} = Invoke-Expression "Write-Output ${TG_DESTI_DIRS}"
        # ディレクトリ存在チェック
        if ( !(Test-Path ${TG_DESTI_DIRS}) ) {
            # 保管先ディレクトリ作成
            #outmsg 51 ${DEF_RTNCD_NML} "${TG_DESTI_DIRS}"
            FC_LogWriter ${DEF_RTNCD_NML} "バックアップ先ディレクトリ[${TG_DESTI_DIRS}]を作成します。"
            New-Item ${TG_DESTI_DIRS} -ItemType Directory 2>&1 > $null
            ${RTN_MKDIR_CODE} = $?
            if ( ${RTN_MKDIR_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "バックアップ先ディレクトリ[${TG_DESTI_DIRS}]を作成しました。"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 1 ${PRG_EXIT_CODE} "バックアップ先ディレクトリ[${TG_DESTI_DIRS}]の作成にてエラーが発生しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "バックアップ先ディレクト[${TG_DESTI_DIRS}]の作成にてエラーが発生しました。後続処理を中止します"
                #EndProcess
                return ${False}
            }
        }

        # 対象ファイル抽出
        ${TG_SORCE_DIFI} = "${TG_SORCE_DIRS}" + "${TG_SORCE_FILE}"

        # 削除区分チェック
        switch("${TG_BACKUPTYPE}") {
            "F"     { ${BKUP_CHKFLG} = ${False} ; ${BKUP_CHKMSG} = "ファイル"     ; break }
            "D"     { ${BKUP_CHKFLG} = ${True}  ; ${BKUP_CHKMSG} = "ディレクトリ" ; break }
            default { FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]ファイルまたはディレクトリの対象区分指定に誤りがります処理をスキップします。" 
                      continue
                    }
        }

        # 対象存在チェック
        if ( !(Test-Path ${TG_SORCE_DIFI}) ) { 
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]${BKUP_CHKMSG}が存在しない為、処理をスキップします。"
            continue
        }

        ${TG_FIND_FILES} = @(Get-ChildItem ${TG_SORCE_DIFI})
        if ( ${TG_FIND_FILES}.length -gt 0 ) {
            foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

                ${LC_ACT_COUNT}++

                ${BACKUP_FILENAME_SOURCE} = ${FINDFILE}.name
                ${BACKUP_FILEDIFI_S}      = ${FINDFILE}.fullname
                ${BACKUP_FILEDIFI_D}      = ${TG_DESTI_DIRS}

                FC_LogWriter ${DEF_RTNCD_NML} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}のバックアップ処理(${BKUP_MODE})を開始します。"

                if ( !(Test-Path ${BACKUP_FILEDIFI_S}) ) {
                    FC_LogWriter ${DEF_RTNCD_NML} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}が存在しない為、バックアップ処理(${BKUP_MODE})をスキップします。"
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
                    FC_LogWriter ${DEF_RTNCD_NML} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}のバックアップ処理(${BKUP_MODE})が正常終了しました。"
                } else {
                    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                    outmsg 1 ${PRG_EXIT_CODE} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}のバックアップ処理(${BKUP_MODE})にてエラーが発生しました。"
                    FC_LogWriter ${PRG_EXIT_CODE} "[${BACKUP_FILEDIFI_S}]${BKUP_CHKMSG}のバックアップ処理(${BKUP_MODE})にてエラーが発生しました。"
                    #EndProcess
                    return ${False}
                }
            }
        }
        if ( ${LC_ACT_COUNT} -eq 0 ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]${BKUP_CHKMSG}のバックアップ処理(${BKUP_MODE})対象が存在しませんでした。"
            continue
        }
    }
    return ${True}
}


