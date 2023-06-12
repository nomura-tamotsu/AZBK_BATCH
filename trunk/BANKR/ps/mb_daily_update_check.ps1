#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : 日次データ更新チェック
#
# MODULE NAME   : mb_daily_update_check
#
# INPUT         : None
#
# EXIT          : 正常終了 ・・・ NORMAL(0)
#                 異常終了 ・・・ ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 23/04/21 | ISID-IT 土居  | First Edition.                            
# %01 | 23/04/29 | ISID-IT 土居  | 月次、週次ファイルもチェック対象とする。.                            
#============================================================================
#============================================================================
# 関数名        mb_daily_update_check-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          なし
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function local:mb_daily_update_check-End-Function () {
	
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
$BATNAME  = "mb_daily_update_check"
$JOB_NAME = "日次データ更新チェック"

# エラー文言（msg_fileの変更は避けたいので共通エラーメッセージ利用）
$LOADERROR = "のロードが完了していない可能性があります."
$UPDATEERROR = "の取込が完了していない可能性があります."

# exitコード初期化
$exit_code   = $RC_OK


#-----------------------------------------------
# 開始メッセージ ログ出力
#-----------------------------------------------
. $OUTMSG_CMD $INFO_MSG $RC_OK "*****日次データ更新チェック開始*****"
. $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


#=============================================================
# 月次データファイル
#=============================================================
#-----------------------------------------------
# 1.住所ファイル(M_Z07) 存在チェック
#-----------------------------------------------
$ADDRESS_DATA_FILE = "$EXT_LOAD_DIR\" + $M_ADDRESS_BASE + ".dat"

if ( Test-Path $ADDRESS_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "月次・住所ファイル（" + $ADDRESS_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG

	$exit_code = $RC_NG
}


#=============================================================
# 週次データファイル
#=============================================================
#-----------------------------------------------
# 1.金融機関支店ファイル(W_BBR) 存在チェック
#-----------------------------------------------
$BANK_DATA_FILE = "$EXT_LOAD_DIR\" + $M_BANK_BASE + ".dat"

if ( Test-Path $BANK_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "週次・全銀データ（" + $BANK_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG

	$exit_code = $RC_NG
}


#=============================================================
# 日次データファイル
#=============================================================
#-----------------------------------------------
# 1.顧客属性データファイル(D_ZKS) 存在チェック
#-----------------------------------------------
$CUSTOMER_DATA_FILE = "$EXT_LOAD_DIR\" + $M_CUSTOMER_BASE + ".dat"

if ( Test-Path $CUSTOMER_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "顧客属性ファイル（" + $CUSTOMER_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 2.世帯属性データファイル(D_SZS) 存在チェック
#-----------------------------------------------
$HOUSEHOLD_DATA_FILE = "$EXT_LOAD_DIR\" + $M_HOUSEHOLD_BASE + ".dat"

if ( Test-Path $HOUSEHOLD_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "世帯属性ファイル（" + $HOUSEHOLD_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 3.個別明細流動性預金ファイル(D_KRS) 存在チェック
#-----------------------------------------------
$LIQUID_DEPOSIT_DATA_FILE = "$EXT_LOAD_DIR\" + $M_LIQUID_DEPOSIT_BASE + ".dat"

if ( Test-Path $LIQUID_DEPOSIT_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "流動性預金ファイル（" + $LIQUID_DEPOSIT_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 4.個別明細定期性預金ファイル(D_KKS) 存在チェック
#-----------------------------------------------
$TERM_DEPOSIT_DATA_FILE = "$EXT_LOAD_DIR\" + $M_TERM_DEPOSIT_BASE + ".dat"

if ( Test-Path $TERM_DEPOSIT_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "定期性預金ファイル（" + $TERM_DEPOSIT_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 5.個別明細外貨ファイル(D_KGS) 存在チェック
#-----------------------------------------------
$FOREIGN_DATA_FILE = "$EXT_LOAD_DIR\" + $M_FOREIGN_BASE + ".dat"

if ( Test-Path $FOREIGN_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "外貨ファイル（" + $FOREIGN_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 6.顧客プロファイル(D_PRO) 存在チェック
#-----------------------------------------------
$PROFILE_DATA_FILE = "$EXT_LOAD_DIR\" + $M_PROFILE_BASE + ".dat"

if ( Test-Path $PROFILE_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "顧客プロファイル（" + $PROFILE_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 7.人事情報ファイル(D_JIF) 存在チェック
#-----------------------------------------------
$PERSONNEL_DATA_FILE = "$EXT_LOAD_DIR\" + $M_PERSONNEL_BASE + ".dat"

if ( Test-Path $PERSONNEL_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "人事情報ファイル（" + $PERSONNEL_DATA_FILE + "）" + $UPDATEERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 8.営業店コンタクト履歴ファイル(D_LGD) 存在チェック
#-----------------------------------------------
$BHISTORY_DATA_FILE = "$EXT_LOAD_DIR\" + $M_BHISTORY_BASE + ".dat"

if ( Test-Path $BHISTORY_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "営業店コンタクト履歴ファイル（" + $BHISTORY_DATA_FILE + "）" + $UPDATEERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 9.個別明細投信ファイル(D_Z05) 存在チェック
#-----------------------------------------------
$FUND_DATA_FILE = "$EXT_LOAD_DIR\" + $M_FUND_BASE + ".dat"

if ( Test-Path $FUND_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "投信ファイル（" + $FUND_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 10.個別明細投信明細ファイル(D_KTM) 存在チェック
#-----------------------------------------------
$FUND_DETAIL_DATA_FILE = "$EXT_LOAD_DIR\" + $M_FUND_DETAIL_BASE + ".dat"

if ( Test-Path $FUND_DETAIL_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "投信明細ファイル（" + $FUND_DETAIL_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#-----------------------------------------------
# 11.商品ファイル(D_PRD) 存在チェック
#-----------------------------------------------
$PRODUCT_DATA_FILE = "$EXT_LOAD_DIR\" + $M_PRODUCT_BASE + ".dat"

if ( Test-Path $PRODUCT_DATA_FILE ) {
	# ファイル存在チェックエラーメッセージ
	$ERROR_MSG = "商品ファイル（" + $PRODUCT_DATA_FILE + "）" + $LOADERROR
	. $OUTMSG_CMD $COM_ERROR $RC_NG $ERROR_MSG
	

	$exit_code = $RC_NG
}


#---------------------------------------
# 終了処理
#---------------------------------------
mb_daily_update_check-End-Function