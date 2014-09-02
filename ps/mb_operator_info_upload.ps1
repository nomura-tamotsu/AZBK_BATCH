#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : オペレータ情報ファイルアップロード
#
# MODULE NAME   : mb_operator_info_upload
#
# INPUT         : None
#
# EXIT          : 正常終了 ・・・ NORMAL(0)
#                 異常終了 ・・・ ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/04/23 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# 関数名        mb_operator_info_upload-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_operator_info_upload-End-Function () {
	
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
$BATNAME  = "mb_operator_info_upload"
$JOB_NAME = "オペレータ情報アップロード"

# exitコード初期化
$exit_code   = $RC_OK

# 処理モードセット（1：通常)
$MODE = 1 


# 開始メッセージ
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****オペレータ情報アップロード開始*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# オペレータ情報ファイル名をセット
#---------------------------------------
$OPEINFO_DATA_FILE = "$EXT_UPLOAD_DIR\" + $M_OPEINFO_BASE + ".dat"

#---------------------------------------
# オペレータ情報ファイル存在チェック
#  (未送信ファイルチェック)
#---------------------------------------
if ( ( Test-Path $OPEINFO_DATA_FILE ) ) {
	# ファイル存在チェックエラーメッセージ
	. $OUTMSG_CMD $FILE_NOT_SEND_MSG $RC_NG $OPEINFO_DATA_FILE
	$exit_code = $RC_NG
	mb_operator_info_upload-End-Function
}

#---------------------------------------
# オペレータ情報連携データの抽出実行
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "オペレータ情報連携データの抽出を開始します．"

$rc=OperatorInfomationExport $MODE $OPEINFO_DATA_FILE
$ret=$?
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "オペレータ情報連携データの抽出でエラーが発生しました"

	if ( ( Test-Path $OPEINFO_DATA_FILE ) ) {
		# エラー時は、データファイルを退避
		#  （ファイル名.YYYYMMDDHHMISSの形式で退避ディレクトリへ）


		# DATE関連変数定義
		$now   = Get-Date
		$date  = $now.ToString("yyyyMMdd")
		$time  = $now.ToString("HHmmss")

		# ファイル名のみ取得
		$new_file_name = split-path $OPEINFO_DATA_FILE  -Leaf

		# 退避ファイル名作成
		$new_file_name = $EXT_UPLOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


		# Move 実行
		$rc = Move-Item $OPEINFO_DATA_FILE $new_file_name -force 2>&1
		$ret=$?
		if ( $ret -ne "TRUE" ) {
	       		. $OUTMSG_CMD $COM_ERROR $RC_NG "データファイル退避($OPEINFO_DATA_FILE)でエラーが発生しました"
			$exit_code=$RC_NG
			mb_operator_info_upload-End-Function
		}

		. $OUTMSG_CMD $INFO_MSG $RC_OK "エラーデータファイルを退避しました($new_file_name)"
	}

	$exit_code = $RC_NG
	mb_operator_info_upload-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "オペレータ情報アップロード処理を終了しました．"




#---------------------------------------
# 終了処理
#---------------------------------------
mb_operator_info_upload-End-Function