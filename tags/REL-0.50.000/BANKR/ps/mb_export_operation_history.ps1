#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : 操作履歴バックアップ
#
# MODULE NAME   : mb_export_operation_history
#
# INPUT         : None
#
# EXIT          : 正常終了 ・・・ NORMAL(0)
#                 異常終了 ・・・ ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/05/12 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# 関数名        Delete-file
# 概要          ファイル削除処理
# 引数          $file_name ファイル名
# 戻り値        $RC_OK,$RC_NG
# 戻り値型      なし
#============================================================================
function Delete-file ( [string] $file_name ) {

    #
    # ファイルの存在確認
    #
    if ( -not ( Test-Path $file_name ) ) {
        # 存在しないので削除処理無し
        return $RC_OK
    }
    
    #
    # ファイル判別チェック
    #
    $rc = Get-ChildItem  $file_name | Where-Object { -not $_.PSIsContainer} | format-list name
    if ( $rc -eq $null ) {
        # フォルダの場合は削除無し
        return $RC_OK
    }

    #
    # 削除実行
    #
    $errorObject = rm -Force  $file_name  2>&1
    
    # エラーハンドリング
    if ( $errorObject -eq $null ) {
        return $RC_OK
    }
    else {
        # エラーメッセージをファイルに出力
        echo $errorObject > $TMP_DIR\tempe.log
        return $RC_NG
    }

}

#============================================================================
# 関数名        mb_export_operation_history-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_export_operation_history-End-Function () {
	
	#
	# このPSのEXITCODEをセーブ
	#
	$local_exit_code = $exit_code

	if ( $exit_code -eq $RC_OK ) {

		. $OUTMSG_CMD $NORMAL_END_MSG $exit_code $JOB_NAME
	}
	else {
		#　
		# 削除処理実行前にエラーの場合は、抽出データファイル削除
		#  ※削除処理実行後は、分割コミットがあるので、データファイルを削除できない
		#
		if ( ( $rm_end_flag -eq 0 ) -And ( Test-Path $OPE_EXP_FILE ) ) {
			$rc = Delete-file ( $OPE_EXP_FILE )
			. $OUTMSG_CMD $INFO_MSG $RC_OK "エラーが発生したのでデータファイルを削除しました(RemoveOldOperationHistory実行前)"
		}

		. $OUTMSG_CMD $ERROR_END_MSG $exit_code $JOB_NAME

	}

	exit $local_exit_code

}

#
# 共通ファイル設定
#
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$DefFile   = $scriptDir + "\def\EMB_DEF.ps1"
# 共通ファイル実行（EMB_DEF.ps1を実行）
. $DefFile

# コマンド名セット
$OUTMSG_CMD    = $SCRIPT_DIR + "\outmsg.ps1"


# 処理名セット
$BATNAME  = "mb_export_operation_history"
$JOB_NAME = "操作履歴バックアップ"

# exitコード初期化
$exit_code   = $RC_OK

# 削除処理終了フラグ初期化
$rm_end_flag = 0



# 開始メッセージ
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****操作履歴バックアップ開始*****"

#
# システム時刻チェック 
# 抽出していないデータの削除を防ぐため、日付変更前は処理行わない
# 　（23:00～24:00の間スリープ）
#

while(1) {
	$now   = Get-Date
	$nowtime  = $now.ToString("HHmmss")

	if ( $nowtime -lt $OPE_BACKUP_TO ) {
		. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME
		break
	}

	# $OPE_BACKUP_SLEEP秒待機します。
	$SLEEP_MSG="*****実行時間までスリープします(" + $OPE_BACKUP_SLEEP + "秒)*****"
	. $OUTMSG_CMD $INFO_MSG $RC_OK $SLEEP_MSG
 	Start-Sleep -Seconds $OPE_BACKUP_SLEEP
}

#---------------------------------------
#  抽出ファイル名をセット
#---------------------------------------
# DATE関連変数定義
$now   = Get-Date
$date  = $now.ToString("yyyy_MM_dd_")
$time  = $now.ToString("HHmmss")

# 抽出ファイル名
$OPE_EXP_FILE = $OPE_EXP_BASE + "." + $date + $time

#
# DBパスワードの複合化
#
$DB_PWD_DECODE = PDECODE $DB_NAME $DB_UID
if ( $ORACLE_TNS -ne $null ) {	
	$DB_PWD_DECODE=$DB_PWD_DECODE + "@" + $ORACLE_TNS
}

#
# ログファイル削除
#
$rc = Delete-file ( $OPE_LOG_FILE )

#-------------------------------------------------------------------------------
# バックアップ（EXP）を実行
#-------------------------------------------------------------------------------

#
# 抽出条件をセット
#
$where_phase="'WHERE 操作日時 < TO_DATE( ADD_MONTHS( SYSDATE, - " + $RETENTION_PERIOD + ") ) '"

#
# コマンド、引数をセット
#
$export_cmd = "exp"
$export_arg = "$DB_UID/$DB_PWD_DECODE tables=TH_操作履歴 file=$OPE_EXP_FILE log=$OPE_LOG_FILE STATISTICS=none query=" + $where_phase

#-------------------------------------------------------------------------------
# $export_cmd というアプリを引数 $export_arg で実行し、終了するまで待機
#-------------------------------------------------------------------------------
$exp_process = Start-Process $export_cmd $export_arg  -PassThru -Wait -WindowStyle  Hidden
#-------------------------------------------------------------------------------
# 終了コードの取得
#-------------------------------------------------------------------------------
$exp_ret = $exp_process.ExitCode
#-------------------------------------------------------------------------------
# リソースの破棄
#-------------------------------------------------------------------------------
$exp_process.Close()


#-------------------------------------------------------------------------------
# ログファイル存在チェック
#  存在しなければ、エラー
#-------------------------------------------------------------------------------
if ( -not ( Test-Path $OPE_LOG_FILE ) ) {
	# ファイル存在チェックエラーメッセージ
	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $OPE_LOG_FILE
	. $OUTMSG_CMD $COM_ERROR $RC_NG "expコマンドでエラーが発生しました(ログファイルが存在しません)"

	$exit_code = $RC_NG
	mb_export_operation_history-End-Function
}

#-------------------------------------------------------------------------------
# EXPORTのログチェック処理
#-------------------------------------------------------------------------------
# データ0件の場合
# 　抽出データが無い場合のメッセージ
$NO_DATA_MSG = " 0行エクスポートされました。"

$result_str = Get-Content $OPE_LOG_FILE | grep $NO_DATA_MSG
if ( $result_str -ne $null ) {
	. $OUTMSG_CMD $INFO_MSG $RC_OK "抽出データが0件でした"
	$exit_code = $RC_OK
	mb_export_operation_history-End-Function
}


#-------------------------------------------------------------------------------
# EXPORTでエラーがあった場合
#   （上記エラーハンドリングに該当しない場合）
#-------------------------------------------------------------------------------
if ( $exp_ret -ne $RC_OK ) {
	. $OUTMSG_CMD $COM_ERROR $RC_NG "expコマンドでエラーが発生しました"
	$exit_code = $RC_NG
	mb_export_operation_history-End-Function
}


#---------------------------------------
# 操作履歴の削除
#---------------------------------------
$rc=RemoveOldOperationHistory $RETENTION_PERIOD
$ret=$?

$rm_end_flag = 1
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "操作履歴の削除でエラーが発生しました(保存期間:$RETENTION_PERIOD ヶ月)"
	$exit_code = $RC_NG
	mb_export_operation_history-End-Function

}


#---------------------------------------
# 終了処理
#---------------------------------------
mb_export_operation_history-End-Function