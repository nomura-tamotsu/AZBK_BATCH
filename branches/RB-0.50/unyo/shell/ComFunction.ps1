#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 運用バッチ用共通関数
#
# ModName   : ComFunction
#
# Condition : UnyoEnv file inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Edition
#============================================================================
#----------------------------------------------------------------------#
# ComFunction for BANK*R CC  Ver.1.0.0                                 #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# F01.共通処理 (ログ出力機能)                                          #
#----------------------------------------------------------------------#
# F01.1 LogWreiter for Local LOG
# (概要)
#  ログ出力処理(ローカルログ出力)
#  - 第１引数：出力レベル(0,1,2,3,4,9,x) (必須)
#  - 第２引数：出力メッセージ          (必須)
#  - 必須変数：ログ出力フラグ(0=OFF,1=ON)
#----------------------------------------------------------------------#
function global:FC_LogWriter
{
    ${LC_LOGPRM1} = $args[0]  # Log Level 0,1,2,3
    ${LC_LOGPRM2} = $args[1]  # Output Messages

    # ログ出力フラグ確認
    if ( "${LOG_FLAG}" -eq "1" ) {

        ${LOGTIMES} = Get-Date -format "${COM_DATEFORM00}"

        switch("${LC_LOGPRM1}") {
            "0" { ${LOGLEVEL} = "[INFO] :" ; break }
            "1" { ${LOGLEVEL} = "[WARN] :" ; break }
            "2" { ${LOGLEVEL} = "[ERRO] :" ; break }
            "3" { ${LOGLEVEL} = "[CRIT] :" ; break }
            "4" { ${LOGLEVEL} = "[FAIL] :" ; break }
            "9" { ${LOGLEVEL} = "[WARN] :" ; break }
            default { ${LOGLEVEL} = "[DBUG] :" }
        }
        "${LOGTIMES} ${HOST_NAME} ${LOGLEVEL} ${LC_LOGPRM2}" | `
        Out-File -FilePath ${ACT_FILE} -Append -Encoding default
    }
    return
}


#----------------------------------------------------------------------#
# F01.2 LogWreiter for ERROR LOG (error.log)
# (概要)
#  ログ出力処理(error.log出力)
#  - 第１引数：メッセージ番号        (必須)
#  - 第２引数：エラーコード          (必須)
#  - 第３引数：付加文言1 (&a1&)      (任意)
#  - 第４引数：付加文言2 (&a2&)      (任意)
#  - 第５引数：付加文言3 (&a3&)      (任意)
#  - 第６引数：付加文言4 (&a4&)      (任意)
#  - 第７引数：付加文言5 (&a5&)      (任意)
#----------------------------------------------------------------------#
function global:outmsg
{

    ${LC_PRAM01} = ""
    ${LC_PRAM02} = ""
    ${LC_PRAM03} = ""
    ${LC_PRAM04} = ""
    ${LC_PRAM05} = ""
    ${LC_PRAM06} = ""
    ${LC_PRAM07} = ""

    if ( $args.Length -lt 2 ) { return 9 }

    ${LC_PRAM01} = $args[0]   # MSGID
    ${LC_PRAM02} = $args[1]   # ERROR_CODE
    ${LC_PRAM03} = $args[2]   # MSG_PARAM1
    ${LC_PRAM04} = $args[3]   # MSG_PARAM2
    ${LC_PRAM05} = $args[4]   # MSG_PARAM3
    ${LC_PRAM06} = $args[5]   # MSG_PARAM4
    ${LC_PRAM07} = $args[6]   # MSG_PARAM5

    # MSG_NO FORMAT
    ${MSG_NO} = ${LC_PRAM01}.ToString("00000")

    ${MSG_DEF_DATA} = Get-Content ${UNYO_FIL_DIR}\msg_file | Select-String -Pattern ^${MSG_NO}

    ${MSG_TEXT0} = "${MSG_DEF_DATA}" | %{ $_.SubString(18) }
    ${MSG_TEXT1} = "${MSG_TEXT0}"    | %{ $_ -creplace "&a1&","${LC_PRAM03}"} 
    ${MSG_TEXT2} = "${MSG_TEXT1}"    | %{ $_ -creplace "&a2&","${LC_PRAM04}"} 
    ${MSG_TEXT3} = "${MSG_TEXT2}"    | %{ $_ -creplace "&a3&","${LC_PRAM05}"} 
    ${MSG_TEXT4} = "${MSG_TEXT3}"    | %{ $_ -creplace "&a4&","${LC_PRAM06}"} 
    ${MSG_TEXT}  = "${MSG_TEXT4}"    | %{ $_ -creplace "&a5&","${LC_PRAM07}"} 

    ${MSG_ID}    = "${MSG_DEF_DATA}" | %{ $_.SubString(5,8) }
    ${MSG_LINE}  = "${MSG_DEF_DATA}" | %{ $_.Split(" ")[1] }

    # CREATE MESSAGE
    if ( "${LC_PRAM02}" -eq "0" ) {
        ${MSG_ERROR_CODE} = ""
    } else {
        ${MSG_ERROR_CODE} = "{${LC_PRAM02}}"
    }

    ${PUT_TIME} = Get-Date -format "${COM_DATEFORM00}"
    ${LGN_TIME} = Get-Date -format "${COM_DATEFORM07}"
    "${PUT_TIME} ${HOST_NAME} ${MSG_ID} ${MSG_LINE} ${MSG_TEXT} [${MOD_NAME}(${USER_NAME})] ${MSG_ERROR_CODE}" | `
    Out-File -FilePath ${UNYO_LOG_BASE_FILE} -Append -Encoding default
#    "${PUT_TIME} ${HOST_NAME} ${MSG_ID} ${MSG_LINE} ${MSG_TEXT} [${MOD_NAME}(${USER_NAME})] ${MSG_ERROR_CODE}" | `
#    Out-File -FilePath ${UNYO_LOG_DAYS_FILE}${LGN_TIME} -Append -Encoding default

    switch("${MSG_NO}") {
        "00040" { "${PRG_NAME} を開始しました。"     ; break }
        "00041" { "${PRG_NAME} を終了しました。"     ; break }
        "00045" { "${PRG_NAME} が異常終了しました。" ; break }
    }
    return
}


#----------------------------------------------------------------------#
# F01.3 Init Program Start 
# (概要)
#  プログラム起動制御
#  - 必須変数：${MOD_NAME}      (プログラム毎に定義) 
#  - 必須変数：${PRG_EXIT_CODE} (プログラム内の実行結果コード) 
#----------------------------------------------------------------------#
function global:InitProcess
{
    outmsg 40 ${DEF_RTNCD_NML} "${PRG_NAME}" 
    FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME} を開始しました。"
    return
}

#----------------------------------------------------------------------#
# F01.4 Program END 
# (概要)
#  プログラム終了制御
#  - 必須変数：${MOD_NAME}      (プログラム毎に定義) 
#  - 必須変数：${PRG_EXIT_CODE} (プログラム内の実行結果コード) 
#----------------------------------------------------------------------#
function global:EndProcess
{
    if ( ${PRG_EXIT_CODE} -eq ${DEF_RTNCD_NML} ) {
        outmsg 41 ${DEF_RTNCD_NML} "${PRG_NAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME} を終了しました。"
    } else {
        outmsg 45 ${PRG_EXIT_CODE} "${PRG_NAME}"
        FC_LogWriter 1 "${PRG_NAME} が異常終了しました。"
    }
    exit ${PRG_EXIT_CODE}
}

#----------------------------------------------------------------------#
# F02.共通部品                                                         #
#----------------------------------------------------------------------#
#----------------------------------------------------------------------#
# F02.1 前日日付取得(SAVE_DATE_YESTERDAY) 
# (概要)
#  前日日付ファイル(yesterday.date) 作成
#----------------------------------------------------------------------#
function global:MakeYesterdayFile
{
    outmsg 1 ${DEF_RTNCD_NML} "前日日付ファイル作成します"
    FC_LogWriter ${DEF_RTNCD_NML} "前日日付ファイル作成処理を開始しました。"

    ${LC_YESTERDAY_TIME} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
    ${LC_YESTERDAY_TIME} | Out-File -FilePath ${YESTERDAY_FILE} -Encoding default
    outmsg 1 ${DEF_RTNCD_NML} "前日日付ファイルを(内容：${LC_YESTERDAY_TIME})で作成しました"
    FC_LogWriter ${DEF_RTNCD_NML} "前日日付ファイル作成処理を終了しました。"
    return
}

#----------------------------------------------------------------------#
# F02.2 運用日付取得(SAVE_DATE_UNYODAYS) 
# (概要)
#  運用日付ファイル(unyo.date) 作成
#----------------------------------------------------------------------#
function global:MakeUnyoudaysFile ( [string] ${FL_SEGDATE} = "x" )
{

    # JP1 環境変数内の 運用実行日 が無い場合は前日日付を取得する。
    # JP1 からの実行でない場合は 運用実行日 として前日日付を指定する。

    outmsg 1 ${DEF_RTNCD_NML} "運用日付ファイル作成します"
    FC_LogWriter ${DEF_RTNCD_NML} "運用日付ファイル作成処理を開始しました。"

    if ( ${FL_SEGDATE} -ne "x" ) {
        if ( ${FL_SEGDATE} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
        ${LC_YESTERDAY_TIME} = ${FL_SEGDATE}
        } else {
            outmsg 54 ${DEF_RTNCD_ERR}
            FC_LogWriter 1 "運用日付指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。基本日付(前日)にて設定致します"
        }
    } else {
        ${LC_YESTERDAY_TIME} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
    }
    ${LC_YESTERDAY_TIME} | Out-File -FilePath ${UNYOUDAYS_FILE} -Encoding default
    outmsg 1 ${DEF_RTNCD_NML} "運用日付ファイルを(内容：${LC_YESTERDAY_TIME})で作成しました"
    FC_LogWriter ${DEF_RTNCD_NML} "運用日付ファイル作成処理を終了しました。"
    return
}


#----------------------------------------------------------------------#
# F02.3 キー文言置換処理(REPLACE_TEXT) 
# (概要)
#  キー項目に対して置換処理を実施
#  - 第１引数：置換対象文字列        (必須)
#  - 第２引数：置換日付(YYYYMMDD)    (任意)
#----------------------------------------------------------------------#
function global:FC_ReplaceString
{
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$false)]
        [string]${LC_TGREPMSG}="x",
        [Parameter(Mandatory=$false)]
        [Alias("tdate")]
        [string]${PRM_TGDATE}="x"
    )

    if ( ${LC_TGREPMSG} -eq "x" ) {
        return 9
    } else {
        ${MSG_OUTLINE} = ${LC_TGREPMSG}
    }

    #------------------------------------------------------------------#
    # 第１引数に渡された置換対象文字列に対してキー項目を置換する。
    #------------------------------------------------------------------#
    #  キー項目説明           置換対象文字列     説明
    #------------------------------------------------------------------#
    # 日付パターン(01)         @@D0001@@       YYYYMMDD    (20140101)
    # 日付パターン(02)         @@D0002@@       YYYYMM      (201401)
    # 日付パターン(03)         @@D0003@@       YYYY-MM-DD  (2014-01-01)
    # 日付パターン(04)         @@D0004@@       YYYY-MM     (2014-01)
    # 日付パターン(05)         @@D0005@@       YYYY_MM_DD  (2014_01_01)
    # 日付パターン(06)         @@D0006@@       YYYY-MM     (2014_01)
    # 日付パターン(07)         @@D0007@@       YYYY-M-D    (2014-1-1)
    # 日付パターン(08)         @@D0008@@       YYYY_M_D    (2014_1_1)
    # サーバ名                 @@SVRNM@@       HOSTNAME    (ServerName)
    # サーバ名(小文字)         @@SVRNL@@       hostname    (ServerName)
    # サーバ種別(略称)         @@SVRTP@@       SV_TYPE     (ServerType)
    #------------------------------------------------------------------#
    # (補足) 置換する日付は指定がない場合運用日付ファイルより取得する
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "キー文言置換処理が開始します。"

    if ( ${LC_TGREPMSG} | Select-String -Pattern "@@D....@@" -Quiet ) {

        # 置換用日付取得処理
        if ( ${PRM_TGDATE} -ne "x" ) {
            if ( ${PRM_TGDATE} | Select-String -Pattern "[1-9][0-9][0-9][0-9][0-1][0-9][0-3][0-9]" -Quiet ) {
                ${LC_BSMESG} = ${PRM_TGDATE}
            } else {
                FC_LogWriter 1 "置換日時の指定に誤りがあります。指定フォーマットは[YYYYMMDD]です。処理を中止します。"
                return 9
            }
        } elseif ( Test-Path ${UNYOUDAYS_FILE} ) {
            # ファイル存在チェック (YYYYMMDD)
            ${LC_BSMESG} = Get-Content ${UNYOUDAYS_FILE} -totalCount 1
        } else {
            ${LC_BSMESG} = (Get-Date).AddDays(-1) | %{ $_.ToString(${COM_DATEFORM08}) }
        }

        ${SER_YY1}    = "${LC_BSMESG}" | %{ $_.SubString(0,4) }   # YYYY
        ${SER_YY2}    = "${LC_BSMESG}" | %{ $_.SubString(2,2) }   # YY
        ${SER_MM0}    = "${LC_BSMESG}" | %{ $_.SubString(4,2) }   # MM
        ${SER_DD0}    = "${LC_BSMESG}" | %{ $_.SubString(6,2) }   # DD

        if ( ${SER_MM0} | Select-String -Pattern "0[1-9]" -Quiet ) {
            ${SER_MM1} = "${LC_BSMESG}" | %{ $_.SubString(5,1) }  # M
        } else {
            ${SER_MM1} = "${SER_MM0}"                             # MM
        }
        if ( ${SER_DD0} | Select-String -Pattern "0[1-9]" -Quiet ) {
            ${SER_DD1} = "${LC_BSMESG}" | %{ $_.SubString(7,1) }  # D
        } else {
            ${SER_DD1} = "${SER_DD0}"                             # DD
        }

        ${SER_TYPE02} = [String]::Join("",(${SER_YY1},${SER_MM0}))
        ${SER_TYPE03} = [String]::Join("-",(${SER_YY1},${SER_MM0},${SER_DD0}))
        ${SER_TYPE04} = [String]::Join("-",(${SER_YY1},${SER_MM0}))
        ${SER_TYPE05} = [String]::Join("_",(${SER_YY1},${SER_MM0},${SER_DD0}))
        ${SER_TYPE06} = [String]::Join("_",(${SER_YY1},${SER_MM0}))
        ${SER_TYPE07} = [String]::Join("-",(${SER_YY1},${SER_MM1},${SER_DD1}))
        ${SER_TYPE08} = [String]::Join("_",(${SER_YY1},${SER_MM1},${SER_DD1}))

        ${MSG_TEXT0}   = "${LC_TGREPMSG}"  | %{ $_ -creplace "@@D0001@@","${LC_BSMESG}"} 
        ${MSG_TEXT1}   = "${MSG_TEXT0}"    | %{ $_ -creplace "@@D0002@@","${SER_TYPE02}"} 
        ${MSG_TEXT2}   = "${MSG_TEXT1}"    | %{ $_ -creplace "@@D0003@@","${SER_TYPE03}"} 
        ${MSG_TEXT3}   = "${MSG_TEXT2}"    | %{ $_ -creplace "@@D0004@@","${SER_TYPE04}"} 
        ${MSG_TEXT4}   = "${MSG_TEXT3}"    | %{ $_ -creplace "@@D0005@@","${SER_TYPE05}"} 
        ${MSG_TEXT5}   = "${MSG_TEXT4}"    | %{ $_ -creplace "@@D0006@@","${SER_TYPE06}"} 
        ${MSG_TEXT6}   = "${MSG_TEXT5}"    | %{ $_ -creplace "@@D0007@@","${SER_TYPE07}"} 
        ${MSG_OUTLINE} = "${MSG_TEXT6}"    | %{ $_ -creplace "@@D0008@@","${SER_TYPE08}"} 

    }

    if ( ${LC_TGREPMSG} | Select-String -Pattern "@@SVR..@@" -Quiet ) {

        ${MSG_TEXT0}   = "${MSG_OUTLINE}"  | %{ $_ -creplace "@@SVRNM@@","${HOST_NAME}"} 
        ${MSG_TEXT1}   = "${MSG_TEXT0}"    | %{ $_ -creplace "@@SVRNL@@","${HOST_NMLO}"} 
        ${MSG_OUTLINE} = "${MSG_TEXT1}"    | %{ $_ -creplace "@@SVRTP@@","${HOST_TYPE}"} 

    }

    echo ${MSG_OUTLINE}

    FC_LogWriter ${DEF_RTNCD_NML} "キー文言置換処理が終了しました。"

}
