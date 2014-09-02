#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : 全銀データ取込
#
# MODULE NAME   : mb_jbdata_reflect
#
# INPUT         : None
#
# EXIT          : 正常終了 ・・・ NORMAL(0)
#                 異常終了 ・・・ ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/24 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# 関数名        mb_jbdata_reflect-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_jbdata_reflect-End-Function () {
	
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


# 関数名セット＆ロード
$CREATE_VIEW   = $SCRIPT_DIR + "\mb_create_view.ps1"
. $CREATE_VIEW

# 処理名セット
$BATNAME  = "mb_jbdata_reflect"
$JOB_NAME = "全銀データ取込"

# exitコード初期化
$exit_code   = $RC_OK


# 開始メッセージ
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****全銀データ取込開始*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# 全銀データ名をセット
#---------------------------------------
$JBANK_DATA_FILE = "$EXT_LOAD_DIR\" + $M_BANK_BASE + ".dat"
$VIEW_NAME  = $JBANK_VIEWNAME
$BASE_NAME  = $JBANK_BASE_TBNAME
$BASE_NAME2 = $JBANK_BASE_TBNAME2


#---------------------------------------
# 全銀データ存在チェック
#---------------------------------------
if ( -not ( Test-Path $JBANK_DATA_FILE ) ) {
	# ファイル存在チェックエラーメッセージ
	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $JBANK_DATA_FILE

	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function
}


#-------------------------------------------------------------------------------
# ビューチェック処理
#   (終了コードでハンドリングしたいので、Start-processを使用する)
#   コーリングシーケンス:CheckView ビュー名 元テーブル名
#-------------------------------------------------------------------------------
$view_check_cmd = "CheckView"
$view_check_arg = "$VIEW_NAME $BASE_NAME"

#-------------------------------------------------------------------------------
# $view_check_cmd というアプリを引数 $view_check_arg で実行し、終了するまで待機
#-------------------------------------------------------------------------------
$process = Start-Process $view_check_cmd $view_check_arg -PassThru -Wait -WindowStyle  Hidden
#-------------------------------------------------------------------------------
# 終了コードの取得
#-------------------------------------------------------------------------------
$ret = $process.ExitCode
#-------------------------------------------------------------------------------
# リソースの破棄
#-------------------------------------------------------------------------------
$process.Close()



$TARGET_VIEW_BASE = $SQL_VIEW_JBANK_BASE
if ( $ret -eq $VIEW_A ) {
	$TARGET_SUFFIX = $TABLE_SUFFIX_B
	$TARGE_VIEW    = $VIEW_B
}
elseif ( $ret -eq $VIEW_B ) {
	$TARGET_SUFFIX = $TABLE_SUFFIX_A
	$TARGE_VIEW    = $VIEW_A
}
else {
	. $OUTMSG_CMD $COM_ERROR $RC_NG "ビューチェック処理でエラーが発生しました"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function
}



#---------------------------------------
# 全銀データファイル
#  ベースネームをセット
#---------------------------------------
$M_BASE_NAME = $M_BANK_BASE

# テーブル名
$TABLE_NAME    = $BASE_NAME  + $TARGET_SUFFIX
$TABLE_NAME2   = $BASE_NAME2 + $TARGET_SUFFIX

# データファイル
$DAT_FILE      = $EXT_LOAD_DIR+ "\" + $M_BASE_NAME + ".dat"

# ログファイル
$JBANK_LOG_FILE = $TMP_DIR + "\" + $M_BASE_NAME + ".log"


#echo $TABLE_NAME

#---------------------------------------
# 全銀データ取込実行
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "全銀データ取込を開始します．"

$rc=UpdateJBData $DAT_FILE $JBANK_LOG_FILE $TABLE_NAME $TABLE_NAME2
$ret=$?
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "全銀データ取込でエラーが発生しました"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "全銀データ取込を終了しました．"


#---------------------------------------
# テーブルAnalyze(銀行)
#---------------------------------------
$rc=AnalyzeTables $TABLE_NAME
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "Analyzeでエラーが発生しました($TABLE_NAME)"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function

}
#---------------------------------------
# テーブルAnalyze(支店)
#---------------------------------------
$rc=AnalyzeTables $TABLE_NAME2
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "Analyzeでエラーが発生しました($TABLE_NAME2)"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function

}


#echo ("TARGET_VIEW_BASE=" + $TARGET_VIEW_BASE)

#echo ("TARGE_VIEW=" + $TARGE_VIEW)




#---------------------------------------
# ビュー切り替え
#---------------------------------------
$rc = mb_create_view  $TARGET_VIEW_BASE $TARGE_VIEW
if ( $rc -ne $RC_OK ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "ビュー切り替えでエラーが発生しました($VIEW_NAME)"
	$exit_code = $RC_NG
	mb_jbdata_reflect-End-Function

}


#
# データファイルを退避（ファイル名.YYYYMMDDHHMISSの形式で退避ディレクトリへ）
#

# DATE関連変数定義
$now   = Get-Date
$date  = $now.ToString("yyyyMMdd")
$time  = $now.ToString("HHmmss")

# ファイル名のみ取得
$new_file_name = split-path $JBANK_DATA_FILE  -Leaf

# 退避ファイル名作成
$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


# Move 実行
$rc = Move-Item $JBANK_DATA_FILE $new_file_name -force 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "データファイル退避($JBANK_DATA_FILE)でエラーが発生しました"
	$exit_code=$RC_NG
	mb_jbdata_reflect-End-Function
}


#---------------------------------------
# 終了処理
#---------------------------------------
mb_jbdata_reflect-End-Function