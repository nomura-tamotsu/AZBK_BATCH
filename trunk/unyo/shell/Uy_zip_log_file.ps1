#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : ログファイルZIP圧縮処理
#
# FILE      : uy_zip_log_file.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 23/05/18 | ISIDIT Doi    | First Eddition
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [Alias("m")]
    [string]${PRM_PGMODE}="x",
    [Parameter(Mandatory=$false)]
    [Alias("d")]
    [string]${PRM_ReRunDay}="x",
    [Parameter(Mandatory=$false)]
    [Alias("f")]
    [string]${PRM_FilePATH}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "ログファイルZIP圧縮処理"
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
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# 運用日付取得 (YYYYMMDD) ※再実行指定時。
if ( $PRM_ReRunDay -ne "x" ) {
    if ( ! (${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet) ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 55 ${DEF_RTNCD_ERR} "運用日付の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        FC_LogWriter 1 "運用日付の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        EndProcess
    }
}
${LC_CHGDATE} = ${PRM_ReRunDay}

# 定義ファイル指定取得 (指定の場合のみ)
if ( ${PRM_FilePATH} -ne "x" ) {
    ${ZIP_LOG_FILE_DEF} = ${PRM_FilePATH}
}

# 定義ファイル存在チェック
FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${ZIP_LOG_FILE_DEF}]より情報取得します(${PRG_NAME})"
if ( !(Test-Path ${ZIP_LOG_FILE_DEF}) ) {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${ZIP_LOG_FILE_DEF}"
    FC_LogWriter ${DEF_RTNCD_ERR} "定義ファイル[${ZIP_LOG_FILE_DEF}]は存在しない為、処理を中止します(${PRG_NAME})"
    EndProcess
}

#--------------------------------------------
# ログファイルZIP圧縮処理 メインループ
#--------------------------------------------

    # 定義の処理件数カウント
    ${LINE_COUNT} = 0

try {
    foreach ( ${LC_LINE01} in Get-Content ${ZIP_LOG_FILE_DEF} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

        ${LINE_CclearOUNT}++

        FC_LogWriter ${DEF_RTNCD_NML} "---- 定義ファイル ${LINE_COUNT} 件目の処理 ----"

        # 処理件数確認用
        ${LC_ACT_COUNT} = 0

        # 定義ファイルから設定値取得
        # 1列目：対象上位ディレクトリ取得 (キー置換記載許容)
        ${TG_SORCE_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[0] }
        # 2列目：対象ファイル取得 (ワイルドカード記載、キー置換記載許容)
        ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
        # 3列目：保管先ディレクトリ取得 (キー置換記載許容)
        ${TG_DESTI_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
        # 4列目：ZIP圧縮ファイル取得 (キー置換記載許容)
        ${TG_ZIP_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }

        FC_LogWriter ${DEF_RTNCD_NML} "対象上位ディレクトリ：${TG_SORCE_DIRS}"
        FC_LogWriter ${DEF_RTNCD_NML} "対象ファイル        ：${TG_SORCE_FILE} "
        FC_LogWriter ${DEF_RTNCD_NML} "保管先ディレクトリ  ：${TG_DESTI_DIRS}"
        FC_LogWriter ${DEF_RTNCD_NML} "ZIP圧縮ファイル取得 ：${TG_ZIP_FILE}"

        # 対象上位ディレクトリ確認処理
        if ( !(${TG_SORCE_DIRS}.EndsWith("\")) ) {
            ${TG_SORCE_DIRS} = ${TG_SORCE_DIRS} + "\"
        }
        # 対象上位ディレクトリ キー置換処理
        if ( ${TG_SORCE_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_SORCE_DIRS} = FC_ReplaceString "${TG_SORCE_DIRS}" -tdate ${LC_CHGDATE}
        }
        ${TG_SORCE_DIRS} = Invoke-Expression "Write-Output ${TG_SORCE_DIRS}"
        FC_LogWriter ${DEF_RTNCD_NML} "キー置換後 対象上位ディレクトリ：${TG_SORCE_DIRS}"

        # ディレクトリ存在チェック
        if ( !(Test-Path ${TG_SORCE_DIRS}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "対象上位ディレクトリ[${TG_SORCE_DIRS}]が存在しない為スキップします。"
            continue
        }

        # 対象ファイル キー置換処理
        if ( ${TG_SORCE_FILE} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_SORCE_FILE} = FC_ReplaceString "${TG_SORCE_FILE}" -tdate ${LC_CHGDATE}
        }
        FC_LogWriter ${DEF_RTNCD_NML} "キー置換後 対象ファイル        ：${TG_SORCE_FILE} "

        # 保管先ディレクトリ 確認処理
        if ( !(${TG_DESTI_DIRS}.EndsWith("\")) ) {
            ${TG_DESTI_DIRS} = ${TG_DESTI_DIRS} + "\"
        }
        # 保管先ディレクトリ キー置換記載許容
        if ( ${TG_DESTI_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_DESTI_DIRS} = FC_ReplaceString "${TG_DESTI_DIRS}" -tdate ${LC_CHGDATE}
        }
        ${TG_DESTI_DIRS} = Invoke-Expression "Write-Output ${TG_DESTI_DIRS}"
        FC_LogWriter ${DEF_RTNCD_NML} "キー置換後 保管先ディレクトリ  ：${TG_DESTI_DIRS}"

        # ZIPファイル キー置換処理
        if ( ${TG_ZIP_FILE} | Select-String -Pattern "@@.....@@" -Quiet ) {
            ${TG_ZIP_FILE} = FC_ReplaceString "${TG_ZIP_FILE}" -tdate ${LC_CHGDATE}
        }
        ${TG_ZIP_FILE} = Invoke-Expression "Write-Output ${TG_ZIP_FILE}"
        FC_LogWriter ${DEF_RTNCD_NML} "キー置換後 ZIP圧縮ファイル取得 ：${TG_ZIP_FILE}"

        # ディレクトリ存在チェック
        if ( !(Test-Path ${TG_DESTI_DIRS}) ) {
            # 存在しなければ保管先ディレクトリ作成
            FC_LogWriter ${DEF_RTNCD_NML} "保管先ディレクトリ[${TG_DESTI_DIRS}]を作成します。"

            New-Item ${TG_DESTI_DIRS} -ItemType Directory 2>&1 > $null
            ${RTN_MKDIR_CODE} = $?
            if ( ${RTN_MKDIR_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "保管先ディレクトリ[${TG_DESTI_DIRS}]を作成しました。"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "保管先ディレクトリ[${TG_DESTI_DIRS}]の作成にてエラーが発生しました。"
                FC_LogWriter ${DEF_RTNCD_ERR} "保管先ディレクト[${TG_DESTI_DIRS}]の作成にてエラーが発生しました。後続処理を中止します"
                EndProcess
            }
        }

        # 対象ファイル抽出
        ${TG_SORCE_DIFI} = "${TG_SORCE_DIRS}" + "${TG_SORCE_FILE}"

        # 対象存在チェック
        if ( !(Test-Path ${TG_SORCE_DIFI}) ) { 
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]が存在しない為、処理をスキップします。"
            continue
        }

        # 対象フォルダ、対象ファイルパターンでファイル検索し、対象リストを作成
        ${TG_FIND_FILES} = @(Get-ChildItem ${TG_SORCE_DIFI})

        ${TG_FILE_COUN} = ${TG_FIND_FILES}.length
        FC_LogWriter ${DEF_RTNCD_NML} "処理対象件数：${TG_FILE_COUN}件"

        # 対象ファイルが存在しない場合、処理をスキップ
        if ( ${TG_FIND_FILES}.length -eq 0 ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]のZIP圧縮処理対象が存在しませんでした。"
            continue
        }

        #--------------------------------------------
        # ログファイルZIP圧縮処理(Phase.01-COPY処理)
        #--------------------------------------------
        ${LC_STEPMSG} = "Phase.01-COPY処理"
        FC_LogWriter ${DEF_RTNCD_NML} "■${PRG_NAME}(${LC_STEPMSG})を実施します。"

        # 圧縮対象ファイルを一時的にコピーする。（他プロセスが使用中のログファイルが圧縮処理にてエラーとなるため）
        foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

            ${LC_ACT_COUNT}++

            ${COPY_FILENAME_SOURCE} = ${FINDFILE}.name
            ${COPY_FILEDIFI_S}      = ${FINDFILE}.fullname
            ${COPY_FILEDIFI_D}      = ${TG_DESTI_DIRS}

            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]のコピー処理を開始します。"

            # 対象ファイルの存在チェック（原則ありえない）
            if ( !(Test-Path ${COPY_FILEDIFI_S}) ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]が存在しない為、コピー処理をスキップします。"
                continue
            }

            # ■COPY処理
            try { 
                ${RTN_CPY_TEMP} = Copy-Item ${COPY_FILEDIFI_S} ${COPY_FILEDIFI_D} -Recurse
                ${RTN_CPY_CODE} = $?
            } catch [Exception] {
                ${RTN_CPY_CODE} = ${False}
            }

            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]のコピー処理が正常終了しました。"
            } else {
                # エラー
                outmsg 55 ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]のコピー処理にてエラーが発生しました、処理をスキップします"
                FC_LogWriter ${DEF_RTNCD_ERR} "[${LC_ACT_COUNT}][${COPY_FILEDIFI_S}]のコピー処理にてエラーが発生しました、処理をスキップします。"
            }
        }

        #--------------------------------------------
        # ログファイルZIP圧縮処理(Phase.02-ZIP圧縮処理)
        #--------------------------------------------
        ${LC_STEPMSG} = "Phase.02-ZIP圧縮処理"
        FC_LogWriter ${DEF_RTNCD_NML} "■${PRG_NAME}(${LC_STEPMSG})を実施します。"

        # 圧縮対象のコピーログファイルのフルパス名（ワイルドカード含む）
        ${ARC_PATH}= ${COPY_FILEDIFI_D} + ${TG_SORCE_FILE}

        # ZIP圧縮ファイルのフルパス名
        ${ZIP_PATH}= ${COPY_FILEDIFI_D} + ${TG_ZIP_FILE}

        # 圧縮対象のコピーログファイルの存在チェック
        if ( !(Test-Path ${ARC_PATH}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[[${ARC_PATH}]に該当するファイルが存在しない為、圧縮処理をスキップします。"
            continue
        }


        FC_LogWriter ${DEF_RTNCD_NML} "[${ZIP_PATH}]への圧縮処理を開始します。"

        # ■ZIP圧縮処理
        # ZIP圧縮ファイルの存在チェック（再実行時等）
        if ( (Test-Path ${ZIP_PATH}) ) {
            FC_LogWriter ${DEF_RTNCD_NML} "ZIP圧縮ファイル[${ZIP_PATH}]が存在する為、削除します。"

            # すでに存在する同名のZIP圧縮ファイルを削除
            Remove-item ${ZIP_PATH}

            FC_LogWriter ${DEF_RTNCD_NML} "ZIP圧縮ファイル[${ZIP_PATH}]の削除が完了しました。"
        }

        # ZIP圧縮処理 実行
        try { 
            # ZIP圧縮 ("-ErrorAction Stop"でエラー時に例外をスローするように指定)
            ${RTN_CPY_TEMP} = Compress-Archive -Path ${ARC_PATH} -DestinationPath ${ZIP_PATH} -ErrorAction Stop
            ${RTN_CPY_CODE} = $?
        } catch [Exception] {
            ${RTN_CPY_CODE} = ${False}
            ${ERROR_MESSAGE} = $_.Exception.Message
            FC_LogWriter ${DEF_RTNCD_NML} "ZIP圧縮処理でエラーが発生しました。${ERROR_MESSAGE}"
       }

        if ( ${RTN_CPY_CODE} ) {
            FC_LogWriter ${DEF_RTNCD_NML} "[${ZIP_PATH}]への圧縮処理が正常終了しました。"
        } else {
            # 異常終了(NAS保管すべきログが処理できないのでエラー検知させる。) 
            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
            outmsg 55 ${DEF_RTNCD_ERR} "[${ZIP_PATH}]への圧縮処理にてエラーが発生しました(${ERROR_MESSAGE})、処理をスキップします。"
            FC_LogWriter ${DEF_RTNCD_ERR} "[${ZIP_PATH}]への圧縮処理にてエラーが発生しました、処理をスキップします。"
            continue
        }

        #--------------------------------------------
        # 圧縮済ログファイル削除処理(Phase.03-DELETE処理)
        #--------------------------------------------
        ${LC_STEPMSG} = "Phase.03-DELETE処理"
        FC_LogWriter ${DEF_RTNCD_NML} "■${PRG_NAME}(${LC_STEPMSG})を実施します。"

        # 圧縮済のログファイルを対象ファイルパターンでファイル検索し、削除対象リストを作成
        ${ARC_TG_FIND_FILES} = @(Get-ChildItem ${ARC_PATH})

        ${TG_FILE_COUN} = ${ARC_TG_FIND_FILES}.length
        FC_LogWriter ${DEF_RTNCD_NML} "一時ファイル削除対象件数：${TG_FILE_COUN}件"

        # 削除対象ファイルが存在しない場合、処理をスキップ
        if ( ${ARC_TG_FIND_FILES}.length -eq 0 ) {
            FC_LogWriter ${DEF_RTNCD_NML} "削除対象の[${ARC_TG_FIND_FILES}]のファイルは存在しませんでした。"
            continue
        }

        ${LC_ACT_COUNT} = 0

        # 圧縮済の対象ファイルを削除する。
        foreach ( ${FINDFILE} in ${ARC_TG_FIND_FILES} ) {

            ${LC_ACT_COUNT}++

            ${DEL_FILEDIFI_S}      = ${FINDFILE}.fullname
            ${DEL_FILEDIFI_D}      = ${TG_DESTI_DIRS}

            FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${DEL_FILEDIFI_S}]の削除処理を開始します。"

            # 対象ファイルの存在チェック（原則ありえない）
            if ( !(Test-Path ${DEL_FILEDIFI_S}) ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${DEL_FILEDIFI_S}]が存在しない為、削除処理をスキップします。"
                continue
            }

            # ■DELETE処理
            try { 
                ${RTN_DEL_TEMP} = Remove-item ${DEL_FILEDIFI_S} -ErrorAction Stop
                ${RTN_DEL_CODE} = $?
            } catch [Exception] {
                ${RTN_DEL_CODE} = ${False}
                ${ERROR_MESSAGE} = $_.Exception.Message
            }

            if ( ${RTN_DEL_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${LC_ACT_COUNT}][${DEL_FILEDIFI_S}]の削除処理が正常終了しました。"
            } else {
                # 削除エラー発生
                FC_LogWriter ${DEF_RTNCD_ERR} "[${LC_ACT_COUNT}][${DEL_FILEDIFI_S}]の削除処理にてエラーが発生しました(${ERROR_MESSAGE})。処理をスキップします。"
                # 次のファイル削除を継続する。※ログファイルは残っても別途ログメンテナンスの削除処理でフォルダごと削除される
                continue
            }
        }
    }

} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    ${ERROR_MESSAGE} = $_.Exception.Message

    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${LC_STEPMSG})にて異常が発生しました。${ERROR_MESSAGE}"

    EndProcess
}


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
