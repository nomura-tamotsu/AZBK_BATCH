#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : 顧客属性差分データ取込
#
# MODULE NAME   : mb_attribute_reflect
#
# INPUT         : None
#
# EXIT          : 正常終了 ・・・ NORMAL(0)
#                 異常終了 ・・・ ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+-------------+-------------------------------------------
# %00 | 14/04/10 | ISID        | First Edition.                            
# %01 | 14/08/20 | ISID        | テーブルの調整-顧客属性を追加                            
#============================================================================
#============================================================================
# 関数名        mb_attribute_reflect-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_attribute_reflect-End-Function () {
	
	#
	# このPSのEXITCODEをセーブ
	#
	$local_exit_code = $exit_code

	if ( $exit_code -eq $RC_OK ) {

		. $OUTMSG_CMD $NORMAL_END_MSG $exit_code $JOB_NAME
	}
	else {

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
$BATNAME  = "mb_attribute_reflect"
$JOB_NAME = "顧客属性差分データ取込"

# exitコード初期化
$exit_code   = $RC_OK


# 開始メッセージ
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****顧客属性差分データ取込開始*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# 顧客属性差分データ名をセット
#---------------------------------------
$CUSTOMER_DATA_FILE = "$EXT_LOAD_DIR\" + $M_CUSTOMER_BASE + ".dat"

#---------------------------------------
# 顧客属性差分データ存在チェック
#---------------------------------------
if ( -not ( Test-Path $CUSTOMER_DATA_FILE ) ) {
	# ファイル存在チェックエラーメッセージ
	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $CUSTOMER_DATA_FILE

	$exit_code = $RC_NG
	mb_attribute_reflect-End-Function
}

#---------------------------------------
# 顧客属性差分データファイル
#  ログファイル/テーブル名をセット
#---------------------------------------
# テーブル名
$TABLE_NAME    = $CUTOMER_BASE_TBNAME
$M_BASE_NAME   = $M_CUSTOMER_BASE

# データファイル
$DAT_FILE      = $EXT_LOAD_DIR+ "\" + $M_BASE_NAME + ".dat"

# ログファイル
$LOG_FILE = $TMP_DIR + "\" + $M_BASE_NAME + ".log"


#---------------------------------------
# 顧客属性差分データ取込実行
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "顧客属性差分データ取込を開始します．"

$rc=DailyAttribute $DAT_FILE $LOG_FILE
$ret=$?
#$ret="True"
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "顧客属性差分データ取込でエラーが発生しました"
	$exit_code = $RC_NG
	mb_attribute_reflect-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "顧客属性差分データ取込を終了しました．"


#---------------------------------------
# テーブルAnalyze
#---------------------------------------
$rc=AnalyzeTables $TABLE_NAME
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "Analyzeでエラーが発生しました($TABLE_NAME)"
	$exit_code = $RC_NG
	mb_attribute_reflect-End-Function

}

#---------------------------------------
# テーブルの調整-顧客属性(%01)
#---------------------------------------
$rc=AdjustCustomer
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "テーブルの調整-顧客属性でエラーが発生しました"
	$exit_code = $RC_NG
	mb_attribute_reflect-End-Function

}


#
# データファイルを退避（ファイル名.YYYYMMDDHHMISSの形式で退避ディレクトリへ）
#

# DATE関連変数定義
$now   = Get-Date
$date  = $now.ToString("yyyyMMdd")
$time  = $now.ToString("HHmmss")

# ファイル名のみ取得
$new_file_name = split-path $CUSTOMER_DATA_FILE  -Leaf

# 退避ファイル名作成
$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


# Move 実行
$rc = Move-Item $CUSTOMER_DATA_FILE $new_file_name -force 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "データファイル退避($CUSTOMER_DATA_FILE)でエラーが発生しました"
	$exit_code=$RC_NG
	mb_attribute_reflect-End-Function
}


#---------------------------------------
# 終了処理
#---------------------------------------
mb_attribute_reflect-End-Function