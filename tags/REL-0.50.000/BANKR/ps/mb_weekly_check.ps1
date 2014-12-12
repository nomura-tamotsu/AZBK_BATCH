#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : 週次処理チェック
#
# MODULE NAME   : mb_weekly_check
#
# INPUT         : なし
#
# EXIT          :  週次処理日       ・・・ NORMAL(0)
#                  週次処理日でない ・・・ ERROR (1)
#                  異常終了         ・・・ ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/24 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# 関数名        Endfile-Rename
# 概要          ファイルを退避
# 引数          なし
# 戻り値        なし
# 戻り値型      なし
#============================================================================
function Endfile-Rename () {
	#
	# 配置完了（週次）ファイルを退避（ファイル名.YYYYMMDDHHMISSの形式で退避ディレクトリへ）
	#

	# DATE関連変数定義
	$now   = Get-Date
	$date  = $now.ToString("yyyyMMdd")
	$time  = $now.ToString("HHmmss")

	# ファイル名のみ取得
	$new_file_name = split-path $WEEKLY_END_FILE  -Leaf

	# 退避ファイル名作成
	$new_file_name = $EXT_LOAD_BACKUP_DIR + "\" + $new_file_name + "." + $date +$time


	# Move 実行
	$rc = Move-Item $WEEKLY_END_FILE $new_file_name -force 2>&1
	$ret=$?
	if ( $ret -ne "TRUE" ) {
       		. $OUTMSG_CMD $COM_ERROR $RC_NG "配置完了（週次）ファイル退避でエラーが発生しました"
		$exit_code=$RC_NG
		mb_weekly_check-End-Function
	}

}



#============================================================================
# 関数名        mb_weekly_check-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_weekly_check-End-Function () {
	
	#
	# このPSのEXITCODEをセーブ
	#
	$local_exit_code = $exit_code

	if ( $exit_code -eq $RC_OK ) {

		. $OUTMSG_CMD $NORMAL_END_MSG $exit_code $JOB_NAME
	}
	elseif ( $exit_code -eq $RC_WARNING ) {

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
$BATNAME  = "mb_weekly_check"
$JOB_NAME = "週次処理チェック "


#
# exitコード初期化
#
$exit_code = $RC_OK


#
# 引数退避
#


#
# 引数個数セット
#

# 開始メッセージ
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****週次処理チェック処理*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


#
# 引数のチェック
#





# ============================================================================
# メイン処理
# ============================================================================
#
# 配置完了（週次）ファイル存在チェック
#
if ( -not ( Test-Path $WEEKLY_END_FILE ) ) {
	# 週次処理日ではないメッセージ
       	. $OUTMSG_CMD $NOT_EXECUTE_DAY $RC_OK "週次"

	$exit_code = $RC_WARNING
	mb_weekly_check-End-Function
}
else {
	# 週次処理日のメッセージ
       	. $OUTMSG_CMD $EXECUTE_DAY $RC_OK "週次"
	
	# 配置完了（週次）ファイルを退避
	Endfile-Rename

}


#
# 終了処理
#
mb_weekly_check-End-Function
