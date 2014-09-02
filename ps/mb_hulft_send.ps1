#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : hulft配信処理
#
# MODULE NAME   : mb_hulft_send
#
# INPUT         : $Args[0] ・・・ hulftファイルID
#
# EXIT          :  正常終了 ・・・ NORMAL(0)
#                  異常終了 ・・・ ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# 関数名        Get-Hulft-Information
# 概要          HULFT情報取得
# 引数          なし
# 戻り値        送信ファイル名（フルパス）
# 戻り値型      なし
#============================================================================
function Get-Hulft-Information () {

	#
	# HULFT定義ファイル存在チェック
	#
	if ( -not ( Test-Path $HulftConfig ) ) {
        	. $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $HulftConfig
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}

	# 定義ファイルからファイルID検索
	$result_str = Get-Content $HulftConfig | grep $file_id
	if ( $result_str -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "ファイルID=$file_id(ファイルIDが見つかりません)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}

	#
	# 文字列を分解してそれぞれ変数にセット
	#
	# 1.分解
	$ary_str  = $result_str -split " "
	
	# 2.FILE IDセット
	$local_file_id   = $ary_str[0]
	if ( $local_file_id  -ne $file_id ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "ファイルID=$file_id(ファイルIDの位置不正)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}
	
	# 2.ファイル区分セット
	$file_class = $ary_str[1]
	if ( $file_class  -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "ファイルID=$file_id(ファイル区分取得不能)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}

	# 3.送信ファイル名セット
	$send_file_name = $ary_str[2]
	if ( $send_file_name -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "ファイルID=$file_id(送信ファイル名取得不能)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}

	# 送信ファイル名フルパスセット
	# ファイル区分処理
	switch ( $file_class ){
    		# CRM区分
    		$ClassCRM {
			$folder_name = "\" + $FolderCRM + "\"
        		break
    		}
    		# HOST区分
    		$ClassHOST {
			$folder_name = "\" + $FolderHOST + "\"

        		break
    		}
    		# IB区分
    		$ClassIB {
			$folder_name = "\" + $FolderIB + "\"
        		break
    		}
		# その他メッセージ出力
    		default {
			. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "ファイルID=$file_id(ファイル区分不正)"
			$exit_code=$RC_NG
			mb_hulft_send-End-Function
        		break
    		}

	}
	
	$r_send_file_name = $EXT_UPLOAD_DIR + $folder_name + $send_file_name	

	return $r_send_file_name

}

#============================================================================
# 関数名        mb_hulft_send-Check-Argument
# 概要          引数チェック処理
# 引数          なし
# 戻り値        なし
# 戻り値型      なし
#============================================================================
function mb_hulft_send-Check-Argument () {

	# 引数個数チェック
	if ( $argc -ne 1 ) { #パラメータが1つでない時
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT $RC_NG
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}


	# 第一引数チェック(レングスチェック:3Byte)
	if ( $file_id.length -ne $FileIdLength ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "ファイルID=$file_id(レングス不正)"
		$exit_code=$RC_NG
		mb_hulft_send-End-Function
	}


}


#============================================================================
# 関数名        mb_hulft_send-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_hulft_send-End-Function () {
	
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

#============================================================================
# 初期処理
#============================================================================
#
# 共通ファイル設定
#
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$DefFile   = $scriptDir + "\def\EMB_DEF.ps1"
# 共通ファイル実行（EMB_DEF.ps1を実行）
. $DefFile

# コマンド名セット
$OUTMSG_CMD    = $scriptDir + "\outmsg.ps1"

# 処理名セット
$BATNAME  = "mb_hulft_send"
$JOB_NAME = "hulft配信処理"


#
# exitコード初期化
#
$exit_code = $RC_OK



#
# 引数退避
#
$file_id  = $Args[0]

#
# 引数個数セット
#
$argc = $args.length

# 開始メッセージ
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****hulft配信処理*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


#
# 引数のチェック
#
mb_hulft_send-Check-Argument


#
# HULFT情報を取得(定義ファイル読み込み)
#
$g_send_file_name = Get-Hulft-Information


# ============================================================================
# メイン処理
# ============================================================================

#
# hulft送信
#
##$rc = utlsend -f $file_id -sync -w 259200 2>&1

# テスト用にダミーコマンド使用
$rc = dir d:\extdata 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "HULFT送信($file_id)でエラーが発生しました"
	$exit_code=$RC_NG
	mb_hulft_send-End-Function
}



#
# 送信ファイルを退避（ファイル名.YYYYMMDDHHMISSの形式で退避ディレクトリへ）
#

# DATE関連変数定義
$now   = Get-Date
$date  = $now.ToString("yyyyMMdd")
$time  = $now.ToString("HHmmss")

# ファイル名のみ取得
$new_file_name = split-path $g_send_file_name  -Leaf

# 退避ファイル名作成
$new_file_name = $EXT_UPLOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


# Move 実行
$rc = Move-Item $g_send_file_name $new_file_name -force 2>&1
$ret=$?
if ( $ret -ne "TRUE" ) {
       	. $OUTMSG_CMD $COM_ERROR $RC_NG "送信ファイル退避($file_id)でエラーが発生しました"
	$exit_code=$RC_NG
	mb_hulft_send-End-Function
}


mb_hulft_send-End-Function
