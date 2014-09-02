#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : メッセージ出力
#
# MODULE NAME   : outmsg
#
# INPUT         :  $Args[0] ・・・ メッセージ番号
#                  $Args[1] ・・・ エラーコード
#                  $Args[2] ・・・ 付加文言1
#                  $Args[3] ・・・ 付加文言2
#                  $Args[4] ・・・ 付加文言3
# 
# EXIT          :  正常終了 ・・・ NORMAL(0)
#                  異常終了 ・・・ ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 13/10/XX | ISID        | First Edition.                            
#============================================================================


#============================================================================
# 関数名        Write-Errlog
# 概要          エラーログ書き込み処理
# 引数          なし
# 戻り値        なし
# 戻り値型      なし
#============================================================================
function Write-Errlog () {

	# ブランク定義(コンピュータ名とメッセージの間の空白)
	$complen = $COMPUTERNAME.length
	if ( $complen -eq 13 ) {
		$blank_string = "      "
	}
	else {
		$blank_string = "       "
	}

	# DATE関連変数定義
	$now       = Get-Date
	$date_char = $now.ToString("yyyy_MM_dd")
	$date      = $now.ToString("yyyy/MM/dd")
	$time      = $now.ToString("HH:mm:ss")

	# 参考(以下のコードでも取得可)
	# $time    = $now.ToLongTimeString()



	# ログファイル名セットする
	#$error_logfile = "$LOG_DIR\err.$DATE_CHAR"

	$error_logfile = "$LogName.$DATE_CHAR"


	# 日付情報セット
	$date_string = $date + " " + $time

	# 出力メッセージ生成
	$out_msg = $date_string + " " + $COMPUTERNAME + $blank_string + $out_msg

	# メッセージに改行コード付加
	#$out_msg="`n"+$out_msg+"`n"

	# メッセージ出力処理
	echo  $out_msg | Out-File -FilePath $error_logfile -Append -Encoding default

}
#============================================================================
# 関数名        Outmsg-Check-Argument
# 概要          引数チェック処理
# 引数          なし
# 戻り値        なし
# 戻り値型      なし
#============================================================================
function Outmsg-Check-Argument () {

	# 第一引数チェック
	if ( $msg_no -eq $null ) {

		# エラーメッセージセット
		$out_msg="引数:メッセージ番号が指定されていません。 [$OM_BATNAME($USERNAME)]"
		Write-Errlog

		$lc_exit_code=$RC_NG
		Outmsg-End-Function
	}

	# 第二引数チェック
	if ( $error_code -eq $null ) {

		# エラーメッセージセット
		$out_msg="引数:エラーコードが指定されていません。 [$OM_BATNAME($USERNAME)]" 
		Write-Errlog

		$lc_exit_code=$RC_NG
		Outmsg-End-Function
	}

}

#============================================================================
# 関数名        Outmsg-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $lc_exit_code
# 戻り値型      なし
#============================================================================
function local:Outmsg-End-Function () {
	exit $lc_exit_code	
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


#
# exitコード初期化
#
$local:lc_exit_code = $RC_OK
$global:msg_text = ""

#
# 引数退避
#
$msg_no     = $Args[0]
$error_code = $Args[1]
$parm1      = $Args[2]
$parm2      = $Args[3]
$parm3      = $Args[4]


#
# ローカル変数定義
#
$ErrlogPram = "$EMB_HOME\file\ERRLOG.parm"

# ファイル読み込み
$lines = get-content $ErrlogPram
foreach ( $line in $lines ) {
	$cnt++
	if ( $cnt -eq 1 ) {
		$MsgFileName = $line
	}
	if ( $cnt -eq 2 ) {
		$LogName = $line
		break
	}
}

#$MsgFileName = "$EMB_HOME\file\msg_file"

#バッチ名を別変数で使用
$OM_BATNAME = $BATNAME


#
# 引数のチェック
#
Outmsg-Check-Argument

#============================================================================
# メイン処理
#============================================================================

#
# メッセージ番号作成(5桁 0-Padding)
#
$msg_no = "{0:00000}" -f $msg_no

#
# 検索文字列作成(先頭に^を付加)
#
$search_str = "^" + $msg_no

#
# 指定メッセージ番号のメッセージを取得
#
# メッセージファイルから文字列検索
$result_str = Get-Content $MsgFileName | grep $search_str 


#
# 文字列を分解してそれぞれ変数にセット
#
# 1.分解
$ary_str  = $result_str -split " "
# 2.メッセージIDセット
$msg_id   = $ary_str[0]
# 3.メッセージ行セット
$msg_line = $ary_str[1]
# 4.メッセージ部（最初のトークン)セット
$msg_text = $ary_str[2]

# 5.メッセージIDセット (残り）セット
for ( $i = 3 ; $ary_str[$i] -ne $null ; $i++ ) {
	$msg_text = $msg_text + " " + $ary_str[$i];
}



#
# メッセージファイルに該当番号が存在しない場合
#
if ($msg_id -eq $null) {
	$out_msg="メッセージファイル 読込エラー 又は メッセージ番号が不正です。 (msgno : $msg_no) [$OM_BATNAME($USERNAME)]" 
	Write-Errlog

	$lc_exit_code=$RC_NG
	Outmsg-End-Function

}

#
# メッセージID編集(8桁に編集)
#
$msg_id = $msg_id.SubString(5,8)

#
# 可変文言置換
#
#  第一引数置換
if ( $parm1 -ne $null ) {
	$msg_text = $msg_text -replace "&a1&", $parm1
}
else {
	$msg_text = $msg_text -replace "&a1&", " "
}

#  第二引数置換
if ( $parm2 -ne $null ) {
	$msg_text = $msg_text -replace "&a2&", $parm2
}
else {
	$msg_text = $msg_text -replace "&a2&", " "
}

#  第三引数置換
if ( $parm3 -ne $null ) {
	$msg_text = $msg_text -replace "&a3&", $parm3
}
else {
	$msg_text = $msg_text -replace "&a3&", " "
}


#
# エラーコードセット
#
if ( $error_code -eq $RC_OK ) {
	$msg_error_code = ""
}
else {
	$msg_error_code = $error_code
}


#
# メッセージ出力
#
$out_msg = "$msg_id $msg_line $msg_text [$OM_BATNAME($USER)] $msg_error_code"
Write-Errlog


Outmsg-End-Function
