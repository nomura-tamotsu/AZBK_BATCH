#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : 世帯属性データロード
#
# MODULE NAME   : mb_household_load
#
# INPUT         : None
#
# EXIT          : 正常終了 ・・・ NORMAL(0)
#                 異常終了 ・・・ ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 15/01/19 | 土居 康一郎   | First Edition.                            
#============================================================================
#============================================================================
# 関数名        mb_attribute_load-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_attribute_load-End-Function () {
	
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
$LOAD_EXTERNAL = $SCRIPT_DIR + "\mb_load_external_data.ps1"
$CREATE_VIEW   = $SCRIPT_DIR + "\mb_create_view.ps1"
. $LOAD_EXTERNAL
. $CREATE_VIEW

# 処理名セット
$BATNAME  = "mb_household_load"
$JOB_NAME = "世帯属性データロード"

# exitコード初期化
$exit_code   = $RC_OK


# 開始メッセージ
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****世帯属性データロード開始*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# 世帯属性データファイル名をセット
#---------------------------------------
$HOUSEHOLD_DATA_FILE = "$EXT_LOAD_DIR\" + $M_HOUSEHOLD_BASE + ".dat"
$VIEW_NAME = $HOUSEHOLD_BASE_VIEWNAME

#---------------------------------------
# 世帯属性データファイル存在チェック
#---------------------------------------
if ( -not ( Test-Path $HOUSEHOLD_DATA_FILE ) ) {
	# ファイル存在チェックエラーメッセージ
	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $HOUSEHOLD_DATA_FILE

	$exit_code = $RC_NG
	mb_attribute_load-End-Function
}

#---------------------------------------
# 世帯属性データファイルサイズチェック
#---------------------------------------
$filesize=$(Get-ChildItem $HOUSEHOLD_DATA_FILE).Length

#　ファイルサイズが 0 バイトの場合はエラー
if ( $filesize  -eq 0 ) {
	$ADD_MSG = "ファイルサイズが 0 バイトです("+ $HOUSEHOLD_DATA_FILE + ")"

	. $OUTMSG_CMD $COM_ERROR $RC_NG $ADD_MSG
	$exit_code = $RC_NG
	mb_attribute_load-End-Function
}

#-------------------------------------------------------------------------------
# ビューチェック処理
#   (終了コードでハンドリングしたいので、Start-processを使用する)
#   コーリングシーケンス:CheckView ビュー名
#-------------------------------------------------------------------------------
$view_check_cmd = "CheckView"
$view_check_arg = $VIEW_NAME

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

$TARGET_VIEW_BASE = $SQL_VIEW_HOUSEHOLD_BASE
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
	mb_attribute_load-End-Function
}

#---------------------------------------
# 世帯属性データファイル
#  ベースネームをセット
#---------------------------------------
$M_BASE_NAME = $M_HOUSEHOLD_BASE

# コントロールファイル
$CTL_FILE      = $CTL_FILE_DIR + "\M_HOUSEHOLD_" + $TARGET_SUFFIX + ".ctl"

# テーブル名
$TABLE_NAME    = $VIEW_NAME + $TARGET_SUFFIX

# データファイル
$DAT_FILE      = $EXT_LOAD_DIR+ "\" + $M_BASE_NAME + ".dat"

# BADファイル
$BAD_FILE      = $TMP_DIR + "\" + $M_BASE_NAME + ".bad"

# DISCARDファイル
$DIS_FILE      = $TMP_DIR + "\" + $M_BASE_NAME + ".dis"

# ログファイル
$LOAD_LOG_FILE = $TMP_DIR + "\" + $M_BASE_NAME + ".log"

#---------------------------------------
# SQLロード実行
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "世帯属性データファイルロードを開始します．"

#---------------------------------------
#. $LOAD_EXTERNAL
#---------------------------------------
$rc = mb_load_external_data  $CTL_FILE $DAT_FILE $BAD_FILE $DIS_FILE $LOAD_LOG_FILE

if ( $rc -ne $RC_OK ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "ロード実行でエラーが発生しました"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "世帯属性データファイルロードを終了しました．"


#---------------------------------------
# テーブルAnalyze
#---------------------------------------
$rc=AnalyzeTables $TABLE_NAME
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "Analyzeでエラーが発生しました($TABLE_NAME)"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function

}

#---------------------------------------
# ビュー切り替え
#---------------------------------------
$rc = mb_create_view  $TARGET_VIEW_BASE $TARGE_VIEW
if ( $rc -ne $RC_OK ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "ビュー切り替えでエラーが発生しました($TABLE_NAME)"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function

}

#---------------------------------------
# ローディング情報の更新
#---------------------------------------
$rc=LoadingInfomation $VIEW_NAME
$ret=$?

if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "ローディング情報更新でエラーが発生しました($VIEW_NAME)"
	$exit_code = $RC_NG
	mb_attribute_load-End-Function

}


#
# ロードファイルを退避（ファイル名.YYYYMMDDHHMISSの形式で退避ディレクトリへ）
#

# DATE関連変数定義
$now   = Get-Date
$date  = $now.ToString("yyyyMMdd")
$time  = $now.ToString("HHmmss")

# ファイル名のみ取得
$new_file_name = split-path $HOUSEHOLD_DATA_FILE  -Leaf

# 退避ファイル名作成
$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


# Move 実行
$rc = Move-Item $HOUSEHOLD_DATA_FILE $new_file_name -force 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "ロードファイル退避($HOUSEHOLD_DATA_FILE)でエラーが発生しました"
	$exit_code=$RC_NG
	mb_attribute_load-End-Function
}


#---------------------------------------
# 終了処理
#---------------------------------------
mb_attribute_load-End-Function