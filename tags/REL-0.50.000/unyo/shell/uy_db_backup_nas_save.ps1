#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : DBバックアップ事後処理(NAS保管)
#
# FILE      : uy_db_backup_nas_save.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 07/01/19 | R.YAMANO      | First Eddition
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
    [string]${PRM_ReRunDay}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "DBバックアップ事後処理(NAS保管)"
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
${NAS_DIRS}         = "${COM_NAS_BASE_DIRS}\${COM_DBSV_VHOST}\dbbackup"
${ACT_FLAG}         = "${UNYO_TMP_DIR}\${COM_FULLBKUP_FLAG}"
${FLG_CHEK}         = 9

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1


#--------------------------------------------
# Pre Action
#--------------------------------------------
# Active Node Check (稼働号機のみ実行)
if ( !(Test-Path ${UNYO_DB_FLBKUP_DIR}) ) {
    exit 0
}

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# Action Flag Check
# (存在する場合のみ後続処理を実行)
#--------------------------------------------
for ( ${i} = 1 ; ${i} -le ${COM_NASLP_CNTS} ; ${i}++ ) {

    if ( Test-Path ${ACT_FLAG} ) {
        ${FLG_CHEK} = 0
        break
    }
    Start-Sleep -s ${COM_NASWT_TIME}
}
if ( ${FLG_CHEK} -ne 0 ) {
    outmsg 55 ${DEF_RTNCD_ERR} "NAS転送処理の実行期限を超過しました。処理を中止します。"
    FC_LogWriter 1 "NAS転送処理の実行期限を超過しました。処理を中止します。"
    EndProcess
}

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
# 前日日付取得 (YYYYMMDD)
${LCD_YESTERDAY} = ${UNYO_DATE}.Insert(4,"/").Insert(7,"/")
${BEF_UNYO_DATE} = (Get-Date ${LCD_YESTERDAY}).AddDays(-1).ToString(${COM_DATEFORM08})

#--------------------------------------------
# DBフルバックアップジョブ事後処理
#--------------------------------------------
# 1.DBフルバックアップ（NAS保管分）の削除
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "DBフルバックアップ事後処理(前日フルバックアップ(NAS保管分)の削除処理)を開始します。"
# DBフルバックアップ (基本ディレクトリ)存在チェック
if ( !(Test-Path ${NAS_DIRS}) ) {
    FC_LogWriter ${DEF_RTNCD_NML} "DBフルバックアップ(基本ディレクトリ)[${NAS_DIRS}]を作成します。"
    New-Item ${NAS_DIRS} -ItemType Directory 2>&1 > $null
}

# 過去日付の保管ディレクトリが存在する場合は削除
${LC_ACT_COUNT} = 0
${TG_FIND_DIRS} = @(Get-ChildItem ${NAS_DIRS})
if ( ${TG_FIND_DIRS}.length -gt 0 ) {
    foreach ( ${FINDDIRS} in ${TG_FIND_DIRS} ) {
        # 削除対象はディレクトリ
        if ( ${FINDDIRS}.PsISContainer -eq ${True} ) {
            ${LC_ACT_COUNT}++
            ${DELETE_FINDDIR_NM}  = ${FINDDIRS}.name
            ${DELETE_FINDDIR_DR}  = ${FINDDIRS}.fullname

            # 運用日付(当日用ディレクトリは除く)
            if ( ${DELETE_FINDDIR_NM} -eq ${UNYO_DATE} ) {
                continue
            }
            # 前日日付(2世代前ディレクトリは除く)
            if ( ${DELETE_FINDDIR_NM} -eq ${BEF_UNYO_DATE} ) {
                continue
            }

            FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FINDDIR_DR}]の削除処理を開始します。"
            Remove-Item ${DELETE_FINDDIR_DR} -Recurse 2>&1 > $null
            ${RTN_DEL_CODE} = $?
            if ( ${RTN_DEL_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${DELETE_FINDDIR_DR}]の削除処理が正常終了しました。"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "[${DELETE_FINDDIR_DR}]の削除処理にてエラーが発生しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "[${DELETE_FINDDIR_DR}]の削除処理にてエラーが発生しました。"
                EndProcess
            }
        }
    }
    if ( ${LC_ACT_COUNT} -eq 0 ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${NAS_DIRS}]配下に削除対象の保管ディレクトリが存在しませんでした。"
    }
}
FC_LogWriter ${DEF_RTNCD_NML} "DBフルバックアップ事後処理(前日フルバックアップ(NAS保管分)の削除処理)を終了します。"

#--------------------------------------------
# 2.DBフルバックアップ（NAS保管処理）
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "DBフルバックアップ事後処理(NAS保管処理)を開始します。"
${TG_FIND_FILES} = @(Get-ChildItem ${UNYO_DB_FLBKUP_DIR})
if ( ${TG_FIND_FILES}.length -gt 0 ) {

    # DBフルバックアップ先 当日分保管用NASディレクトリ存在チェック
    ${ACTDAY_DB_BKUPDIR} = "${NAS_DIRS}\${UNYO_DATE}"
    if ( !(Test-Path ${ACTDAY_DB_BKUPDIR}) ) {
        FC_LogWriter ${DEF_RTNCD_NML} "DBフルバックアップ(当日保管用NASディレクトリ)[${ACTDAY_DB_BKUPDIR}]を作成します。"
        New-Item ${ACTDAY_DB_BKUPDIR} -ItemType Directory 2>&1 > $null
    }

    foreach ( ${FINDFILE} in ${TG_FIND_FILES} ) {
        if ( ${FINDFILE}.PsISContainer -eq ${False} ) {
            ${COPY_FILEDIFI_S} = ${FINDFILE}.fullname
            FC_LogWriter ${DEF_RTNCD_NML} "[${COPY_FILEDIFI_S}]のコピー処理を開始します。"
            ${RTN_CPY_TEMP} = Copy-Item ${COPY_FILEDIFI_S} ${ACTDAY_DB_BKUPDIR} -Recurse
            ${RTN_CPY_CODE} = $?
            if ( ${RTN_CPY_CODE} ) {
                FC_LogWriter ${DEF_RTNCD_NML} "[${COPY_FILEDIFI_S}]のコピー処理が正常終了しました。"
            } else {
                ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
                outmsg 55 ${PRG_EXIT_CODE} "[${COPY_FILEDIFI_S}]のコピー処理にてエラーが発生しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "[${COPY_FILEDIFI_S}]のコピー処理にてエラーが発生しました。"
                FC_LogWriter ${PRG_EXIT_CODE} "DBフルバックアップ事後処理(NAS保管処理)が異常終了しました。"
                EndProcess
            }
        }
    }
}
FC_LogWriter ${PRG_EXIT_CODE} "DBフルバックアップ事後処理(NAS保管処理)が終了しました。"

#--------------------------------------------
# タスクスケジュール制御フラグ (削除)
#--------------------------------------------
if ( Test-Path ${ACT_FLAG} ) {
    Remove-Item ${ACT_FLAG} -Recurse 2>&1 > $null
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
