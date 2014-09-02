#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : ログファイルリネーム
#
# FILE      : uy_rename_log.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/01/19 | R.YAMANO      | First  Eddition
# %01 | 07/07/01 | R.YAMANO      | Second Eddition
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
${PRG_NAME}         = "ログファイルリネーム"
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
# 運用日付取得 (YYYYMMDD)
if ( ${PRM_ReRunDay} -ne "x" ) {
    if ( ${PRM_ReRunDay} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
        ${UNYO_DATE} = ${PRM_ReRunDay}
    } else {
        outmsg 55 ${DEF_RTNCD_ERR} "運用日付の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        FC_LogWriter 1 "運用日付の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
        EndProcess
    }
} elseif ( Test-Path ${UNYOUDAYS_FILE} ) {
    ${UNYO_DATE} = Get-Content ${UNYOUDAYS_FILE} -totalCount 1
} else {
    ${UNYO_DATE} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
}
# 定義ファイル指定取得 (指定の場合のみ)
if ( ${PRM_FilePATH} -ne "x" ) {
    ${RENAME_FILE_DEF} = ${PRM_FilePATH}
}

#--------------------------------------------
# リネーム＆コピー処理 (対象全ファイル)
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${RENAME_FILE_DEF}]より情報取得します(リネーム処理)"

# 定義ファイル存在チェック
if ( !(Test-Path ${RENAME_FILE_DEF}) ) {
    # 存在しない為、異常終了
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${RENAME_FILE_DEF}"
    FC_LogWriter ${PRG_EXIT_CODE} "定義ファイル[${RENAME_FILE_DEF}]が存在しない為異常終了します(リネーム処理)"
    EndProcess
}

#--------------------------------------------
# リネーム＆コピー処理＆クリア処理
#--------------------------------------------
# 定義ファイル読込
#--------------------------------------------
foreach ( ${LC_LINE01} in Get-Content ${RENAME_FILE_DEF} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

    #--------------------------------------------
    # クリア区分取得(クリア対象ファイル情報)
    ${TG_CLEAR_TYPE}        = "${LC_LINE01}" | %{ $_.Split(",")[0] }
    # リネーム対象ファイル配置 ディレクトリパス取得 (キー置換記載許容)
    ${TG_SORCE_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
    # リネーム対象ファイル名取得 (ワイルドカード記載、キー置換記載許容)
    ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
    # リネーム先ディレクトリパス取得 (キー置換記載許容)
    ${TG_DESTI_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }

    #--------------------------------------------
    # リネーム対象ファイル配置ディレクトリ
    #--------------------------------------------
    # リネーム対象ファイル配置ディレクトリパス確認処理
    if ( !(${TG_SORCE_DIRS}.EndsWith("\")) ) {
        # ディレクトリ名記載方法の補完処理[\]付加
        ${TG_SORCE_DIRS} = ${TG_SORCE_DIRS} + "\"
    }
    # リネーム対象ファイル配置ディレクトリパス キー置換処理
    if ( ${TG_SORCE_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
        ${TG_SORCE_DIRS} = FC_ReplaceString "${TG_SORCE_DIRS}" -tdate ${PRM_ReRunDay}
    }
    ${TG_SORCE_DIRS} = Invoke-Expression "Write-Output ${TG_SORCE_DIRS}"
    # ディレクトリ存在チェック
    if ( !(Test-Path ${TG_SORCE_DIRS}) ) {
        # 存在しない為、スキップ
        FC_LogWriter ${DEF_RTNCD_NML} "リネーム対象ファイル配置のディレクトリ[${TG_SORCE_DIRS}]が存在しない為スキップします。"
        continue
    }

    #--------------------------------------------
    # リネーム先ディレクトリ
    #--------------------------------------------
    # リネーム先ディレクトリパス確認処理
    if ( !(${TG_DESTI_DIRS}.EndsWith("\")) ) {
        # ディレクトリ名記載方法の補完処理
        # 終わりはあの文字ではない為、最後に[\]を付加
        ${TG_DESTI_DIRS} = ${TG_DESTI_DIRS} + "\"
    }
    # リネーム先ディレクトリパス キー置換処理
    if ( ${TG_DESTI_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
        ${TG_DESTI_DIRS} = FC_ReplaceString "${TG_DESTI_DIRS}" -tdate ${PRM_ReRunDay}
    }
    ${TG_DESTI_DIRS} = Invoke-Expression "Write-Output ${TG_DESTI_DIRS}"
    # ディレクトリ存在チェック
    if ( !(Test-Path ${TG_DESTI_DIRS}) ) {
        # 存在しない為、スキップ
        FC_LogWriter ${DEF_RTNCD_NML} "リネーム先のディレクトリ[${TG_DESTI_DIRS}]が存在しない為スキップします。"
        continue
    }

    # リネーム対象ファイル抽出
    ${TG_SORCE_DIFI} = "${TG_SORCE_DIRS}" + "${TG_SORCE_FILE}"
    ${TG_FIND_FILES} = @(Get-ChildItem ${TG_SORCE_DIFI})
    if ( ${TG_FIND_FILES}.length -gt 0 ) {
        foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

            ${RENAME_FILENAME_SOURCE} = ${FINDFILE}.name
            ${RENAME_FILENAME_DISTIN} = [String]::Join(".",(${RENAME_FILENAME_SOURCE},${UNYO_DATE}))
            ${RENAME_FILEDIFI_S}      = "${TG_SORCE_DIRS}" + "${RENAME_FILENAME_SOURCE}"
            ${RENAME_FILEDIFI_D}      = "${TG_DESTI_DIRS}" + "${RENAME_FILENAME_DISTIN}"

            FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルのリネーム処理を開始します。"

            if ( Test-Path ${RENAME_FILEDIFI_D} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルは既にリネーム処理済みです。"
                FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルのリネーム処理はスキップします。"
                continue
            }

            ${RTN_CPY_TEMP} = Copy-Item ${RENAME_FILEDIFI_S} ${RENAME_FILEDIFI_D}
            ${RTN_CPY_CODE} = $?
            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルのリネーム処理が正常終了しました。"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "[${RENAME_FILEDIFI_S}]ファイルのリネーム処理にてエラーが発生しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "[${RENAME_FILEDIFI_S}]ファイルのリネーム処理にてエラーが発生しました。"
                EndProcess
            }

            #--------------------------------------------
            # 元ファイルクリア処理
            #--------------------------------------------
            if ( ${TG_CLEAR_TYPE} -eq "NON" ) {
                continue
            }
            FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルのクリア処理を開始します。"

            switch("${TG_CLEAR_TYPE}") {
                "CLR"       {
                                # クリア区分='CLR' ならば元ファイルをクリア
                                # リネームファイルとコンペアして差があるとエラー
                                # Step.1:コンペア処理(FCコマンド利用)
                                if ( (Test-Path ${RENAME_FILEDIFI_S} ) -and (Test-Path ${RENAME_FILEDIFI_D}) ) {

                                    FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルのクリア処理(Step.1:コンペア処理)を実施します。"
                                    ${RN_COMPAR_TEMP} = Invoke-Expression "fc.exe ${RENAME_FILEDIFI_S} ${RENAME_FILEDIFI_D}"
                                    ${RN_COMPAR_CODE} = ${LASTEXITCODE}
                                    if ( ${RN_COMPAR_CODE} -eq 0 ) {
                                        # 差がない為、リネーム処理は成功しています。
                                        FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルのクリア処理(Step.2:クリア処理)を実施します。"
                                        ${RTN_CLR_TEMP} = Clear-Content -Path ${RENAME_FILEDIFI_S}
                                        ${RTN_CLR_CODE} = $?
                                        if ( !${RTN_CLR_CODE} ) {
                                            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                                            outmsg 6001 ${PRG_EXIT_CODE} ${RENAME_FILEDIFI_S}
                                            FC_LogWriter ${PRG_EXIT_CODE} "[${RENAME_FILEDIFI_S}]ファイルのクリア処理(Step.2:クリア処理)にてエラーが発生しました。"
                                            EndProcess
                                        }
                                    } else {
                                        FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルのクリア処理(Step.1:コンペア処理)にて差分があった為、クリア処理をスキップします。"
                                        continue
                                    }
                                }
                                break
                            }
                "CLF"       {
                                # クリア区分='CLF' ならば元ファイルを強制クリア
                                FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルの強制クリア処理を実施します。"

                                if ( !(Test-Path ${RENAME_FILEDIFI_S}) ) {
                                    FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルが存在しない為、強制クリア処理をスキップします。"
                                    continue
                                }

                                ${RTN_CLR_TEMP} = Clear-Content -Path ${RENAME_FILEDIFI_S}
                                ${RTN_CLR_CODE} = $?
                                if ( !${RTN_CLR_CODE} ) {
                                    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                                    outmsg 6001 ${PRG_EXIT_CODE} ${RENAME_FILEDIFI_S}
                                    FC_LogWriter ${PRG_EXIT_CODE} "[${RENAME_FILEDIFI_S}]ファイルの強制クリア処理にてエラーが発生しました。"
                                    EndProcess
                                }
                                break
                            }
                default     {
                                FC_LogWriter ${DEF_RTNCD_NML} "[${CLNAME_FILENAME_SOURCE}]ファイルのクリア区分指定に誤りがります処理をスキップします。"
                                continue
                            }
            }
            FC_LogWriter ${DEF_RTNCD_NML} "[${RENAME_FILEDIFI_S}]ファイルのクリア処理を終了します。"
        }
    }
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
