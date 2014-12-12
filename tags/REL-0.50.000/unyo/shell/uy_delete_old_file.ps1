#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 不要ファイル削除
#
# FILE      : uy_delete_old_file.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | R.YAMANO      | First Eddition
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
${PRG_NAME}         = "不要ファイル削除"
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
    ${DELETE_FILE_DEF} = ${PRM_FilePATH}
}

#--------------------------------------------
# 不要ファイル削除処理
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "定義ファイル[${DELETE_FILE_DEF}]より情報取得します(不要ファイル削除)"

# 定義ファイル存在チェック
if ( !(Test-Path ${DELETE_FILE_DEF}) ) {
    # 存在しない為、異常終了
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    outmsg 51 ${PRG_EXIT_CODE} "${DELETE_FILE_DEF}"
    FC_LogWriter ${PRG_EXIT_CODE} "定義ファイル[${DELETE_FILE_DEF}]が存在しない為異常終了します(不要ファイル削除)"
    EndProcess
}

#--------------------------------------------
# 不要ファイル削除処理
#--------------------------------------------
# 定義ファイル読込
foreach ( ${LC_LINE01} in Get-Content ${DELETE_FILE_DEF} | Select-String -NotMatch "^#" | Select-String -NotMatch "^$" ) {

    # 処理件数確認用
    ${LC_ACT_COUNT} = 0
    # 削除区分取得(F:ファイル,D:ディレクトリ)
    ${TG_DELET_TYPE}        = "${LC_LINE01}" | %{ $_.Split(",")[0] }
    # 削除対象上位ディレクトリ取得 (キー置換記載許容)
    ${TG_SORCE_DIRS}        = "${LC_LINE01}" | %{ $_.Split(",")[1] }
    # 削除対象対象ディレクトリ/ファイル取得 (ワイルドカード記載、キー置換記載許容)
    ${TG_SORCE_FILE}        = "${LC_LINE01}" | %{ $_.Split(",")[2] }
    # 保管日数取得 (日付指定)
    ${TG_STRAG_DAYS}        = "${LC_LINE01}" | %{ $_.Split(",")[3] }

    # 削除対象上位ディレクトリ確認処理
    if ( !(${TG_SORCE_DIRS}.EndsWith("\")) ) {
        # ディレクトリ名記載方法の補完処理
        # 終わりはあの文字ではない為、最後に[\]を付加
        ${TG_SORCE_DIRS} = ${TG_SORCE_DIRS} + "\"
    }
    # 削除対象上位ディレクトリ キー置換処理
    if ( ${TG_SORCE_DIRS} | Select-String -Pattern "@@.....@@" -Quiet ) {
        ${TG_SORCE_DIRS} = FC_ReplaceString "${TG_SORCE_DIRS}" -tdate ${PRM_ReRunDay}
    }
    ${TG_SORCE_DIRS} = Invoke-Expression "Write-Output ${TG_SORCE_DIRS}"
    # ディレクトリ存在チェック
    if ( !(Test-Path ${TG_SORCE_DIRS}) ) {
        FC_LogWriter ${DEF_RTNCD_NML} "削除対象上位ディレクトリ[${TG_SORCE_DIRS}]が存在しない為スキップします。"
        continue
    }

    # 削除対象ファイル抽出
    ${TG_SORCE_DIFI} = "${TG_SORCE_DIRS}" + "${TG_SORCE_FILE}"

    # 削除区分チェック
    switch("${TG_DELET_TYPE}") {
        "F"     { ${DEL_CHKFLG} = ${False} ; ${DEL_CHKMSG} = "ファイル"     ; break }
        "D"     { ${DEL_CHKFLG} = ${True}  ; ${DEL_CHKMSG} = "ディレクトリ" ; break }
        default { FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]ファイルまたはディレクトリの削除区分指定に誤りがります処理をスキップします。" 
                  continue
                }
    }

    # 対象存在チェック
    if ( !(Test-Path ${TG_SORCE_DIFI}) ) { 
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]${DEL_CHKMSG}が存在しない為、処理をスキップします。"
        continue
    }
    
    ${TG_FIND_FILES} = @(Get-ChildItem ${TG_SORCE_DIFI})
    if ( ${TG_FIND_FILES}.length -gt 0 ) {
        foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {

            # 運用日付を基準とした保管日数を算出
            try {
                ${LC_CAL_UNYO_DATE} = ${UNYO_DATE}.Insert(4,"/").Insert(7,"/")
                ${LC_CAL_TERM} = ([DateTime]((Get-Date ${LC_CAL_UNYO_DATE}).ToString(${COM_DATEFORM02}))- [DateTime]((Get-Date).ToString(${COM_DATEFORM02}))).Days
            } catch [Exception] {
                ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
                FC_LogWriter ${PRG_EXIT_CODE} "運用日付および前回取得日取得処理にて失敗しました。後続処理を中止します。"
                EndProcess
            }

            ${DELETE_COUNTDATES} = (((Get-Date).AddDays(${LC_CAL_TERM})) - ${FINDFILE}.LastWriteTime).Days

            # (指定日以上古いファイル) かつ (フォルダ or ファイル)
            if (( ${DELETE_COUNTDATES} -ge ${TG_STRAG_DAYS} ) -and ( ${FINDFILE}.PsISContainer -eq ${DEL_CHKFLG} )) {

                ${LC_ACT_COUNT}++
                ${DELETE_FILENAME_SOURCE} = ${FINDFILE}.name
                ${DELETE_FILEDIFI_S}      = ${FINDFILE}.fullname

                FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}の削除処理を開始します。"

                if ( !(Test-Path ${DELETE_FILEDIFI_S}) ) {
                    FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}は既に削除済みです。"
                    FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}の削除処理はスキップします。"
                    continue
                }

                Remove-Item ${DELETE_FILEDIFI_S} -Recurse 2>&1 > $null
                ${RTN_DEL_CODE} = $?
                if ( ${RTN_DEL_CODE} ) {
                    FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}の削除処理が正常終了しました。"
                } else {
                    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                    outmsg 1 ${PRG_EXIT_CODE} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}の削除処理にてエラーが発生しました。"
                    FC_LogWriter ${PRG_EXIT_CODE} "[${DELETE_FILEDIFI_S}]${DEL_CHKMSG}の削除処理にてエラーが発生しました。"
                    EndProcess
                }

            }

        }

    }

    if ( ${LC_ACT_COUNT} -eq 0 ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_SORCE_DIFI}]${DEL_CHKMSG}は削除対象が存在しませんでした。"
        continue
    }

}


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
