#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : テレバン契約者情報アップロード
#
# MODULE NAME   : mb_tb_contractor_upload
#
# INPUT         : None
#
# EXIT          : 正常終了 ・・・ NORMAL(0)
#                 異常終了 ・・・ ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 15/02/05 | 土居 康一郎   | First Edition.                            
# %01 | 15/06/10 | 土居 康一郎   | 実行ファイル名変更                        
#============================================================================
#============================================================================
# 関数名        mb_tb_contractor_info_upload-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_tb_contractor_info_upload-End-Function () {
	
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
$BATNAME  = "mb_tb_contractor_upload"
$JOB_NAME = "テレバン契約者情報アップロード"

# exitコード初期化
$exit_code   = $RC_OK


# 開始メッセージ
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****テレバン契約者情報アップロード開始*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

#---------------------------------------
# テレバン契約者情報ファイル名をセット
#---------------------------------------
$OUTPUT_DATA_FILE = "$EXT_UPLOAD_DIR\" + $M_TB_CONTRACT_BASE + ".dat"

#---------------------------------------
# テレバン契約者情報ファイル存在チェック
#  (未送信ファイルチェック)
#---------------------------------------
if ( ( Test-Path $OUTPUT_DATA_FILE ) ) {
	# ファイル存在チェックエラーメッセージ
	. $OUTMSG_CMD $FILE_NOT_SEND_MSG $RC_NG $OUTPUT_DATA_FILE
	$exit_code = $RC_NG
	mb_tb_contractor_info_upload-End-Function
}

#---------------------------------------
# テレバン契約者情報データの抽出実行
#---------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "テレバン契約者情報の抽出を開始します．"

$rc=TbContractorInfoExport $OUTPUT_DATA_FILE
$ret=$?
if ( $ret -ne "True" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "テレバン契約者情報の抽出でエラーが発生しました"

	if ( ( Test-Path $OUTPUT_DATA_FILE ) ) {
		# エラー時は、データファイルを退避
		#  （ファイル名.YYYYMMDDHHMISSの形式で退避ディレクトリへ）


		# DATE関連変数定義
		$now   = Get-Date
		$date  = $now.ToString("yyyyMMdd")
		$time  = $now.ToString("HHmmss")

		# ファイル名のみ取得
		$new_file_name = split-path $OUTPUT_DATA_FILE  -Leaf

		# 退避ファイル名作成
		$new_file_name = $EXT_UPLOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


		# Move 実行
		$rc = Move-Item $OUTPUT_DATA_FILE $new_file_name -force 2>&1
		$ret=$?
		if ( $ret -ne "TRUE" ) {
	       		. $OUTMSG_CMD $COM_ERROR $RC_NG "データファイル退避($OUTPUT_DATA_FILE)でエラーが発生しました"
			$exit_code=$RC_NG
			mb_tb_contractor_info_upload-End-Function
		}
		. $OUTMSG_CMD $INFO_MSG $RC_OK "エラーデータファイルを退避しました($new_file_name)"
	}

	$exit_code = $RC_NG
	mb_tb_contractor_info_upload-End-Function

}

. $OUTMSG_CMD $INFO_MSG $RC_OK "テレバン契約者情報アップロード処理を終了しました．"




#---------------------------------------
# 終了処理
#---------------------------------------
mb_tb_contractor_info_upload-End-Function