#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : イベントログ取得用共通関数
#
# ModName   : ComGetEventLog
#
# Condition : UnyoEnv & ComFunction files inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Eddition
#============================================================================
#----------------------------------------------------------------------#
# ComGetEventLog for BANK*R CC  Ver.1.0.0                              #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# F01.イベントログ取得処理                                             #
#----------------------------------------------------------------------#
# F01.1 Get EventLog output to a CSV File
# (概要)
#  イベントログ取得処理(CSVファイル型式) 
#  取得対象日次の00:00～24:00間に発生したイベントログを取得する
#  - 第１引数：イベントログ種別 (0,1,2)       (必須)
#    (0:セキュリティ,1:アプリケーション,2:システム)
#  - 第２引数：出力ファイル名(FullPath)       (必須)
#  - 第３引数：取得対象日次(YYYYMMDD)         (必須)
#  (注意事項) 当ファンクション機能利用は管理者権限が必要
#----------------------------------------------------------------------#
function FC_GetEventLog ( [string] ${LC_EVNCODE},[string] ${LC_CSVNAME}, [string] ${LC_GETDATE} )
{

    # GetEvent 取得処理
    # (YYYYMMDD) -> (YYYY/MM/DD)
    ${LC_DATE01}        = ${LC_GETDATE}.Insert(4,"/").Insert(7,"/")
    ${TG_START_GETDATE} = ${LC_DATE01}
    # ${LC_DATE02}        = Get-Date ${LC_DATE01} | %{ $_.AddDays(1) } | %{ $_.ToString(${COM_DATEFORM02}) }
    ${LC_DATE02}        = (Get-Date ${LC_DATE01}).AddDays(1).ToString(${COM_DATEFORM02})
    ${TG_ENDTM_GETDATE} = ${LC_DATE02}
    # イベントログ取得(Type2)
    ${LC_EVENTS} = Get-EventLog ${COM_EVNTYPE}[${LC_EVNCODE}] -After ${TG_START_GETDATE} -Before ${TG_ENDTM_GETDATE} 

    FC_LogWriter ${DEF_RTNCD_NML} "対象日時[${TG_START_GETDATE}]のイベントログ取得処理を実施します。"

    # CSV出力
    ${HEDER_LINE} = "`"" + "種類"            + "`"" + ","  + "`"" + "イベント" + "`"" + "," `
                  + "`"" + "日付と時刻"      + "`"" + ","  + "`"" + "ソース"   + "`"" + "," `
                  + "`"" + "コンピュータ名"  + "`"" + ","  + "`"" + "カテゴリ" + "`"" + "," `
                  + "`"" + "ユーザー"        + "`"" + ","  + "`"" + "説明"     + "`"" 

    ${HEDER_LINE} | Out-File -FilePath  ${LC_CSVNAME} -Encoding default

    for ( ${i} = 0; ${i} -lt ${LC_EVENTS}.length; ${i}++ )  {
        # アカウントの取得
        ${LC_EVEUSR} = ${LC_EVENTS}[${i}].ReplacementStrings[1] 
        #改行を除去
        ${LC_EVEMSG} = ${LC_EVENTS}[${i}].Message
        ${LC_EVEMSG} = ${LC_EVEMSG} -replace "`n" , ""
        ${LC_EVEMSG} = ${LC_EVEMSG} -replace "`r" , ""
        # 日付の型式変換
        ${LC_EVETIME} = ${LC_EVENTS}[${i}].TimeGenerated
        ${LC_EVETIME} = ${LC_EVETIME} -as [DateTime]
        ${LC_EVETIME} = ${LC_EVETIME}.ToString("yyyy/MM/dd HH:mm:ss")

        ${LC_LINE} = "`"" + ${LC_EVENTS}[${i}].EntryType + "`"" + "," + "`"" + ${LC_EVENTS}[${i}].EventID  + "`"" + "," `
                   + "`"" + ${LC_EVETIME}                + "`"" + "," + "`"" + ${LC_EVENTS}[${i}].Source   + "`"" + "," `
                   + "`"" + ${LC_EVENTS}[$i].MachineName + "`"" + "," + "`"" + ${LC_EVENTS}[${i}].Category + "`"" + "," `
                   + "`"" + ${LC_EVEUSR}                 + "`"" + "," + "`"" + ${LC_EVEMSG} + "`""

        ${LC_LINE} | Out-File -FilePath ${LC_CSVNAME} -Append -encoding default

    }

    FC_LogWriter ${DEF_RTNCD_NML} "対象日時[${TG_START_GETDATE}]のイベントログ取得処理を終了します。"

}
