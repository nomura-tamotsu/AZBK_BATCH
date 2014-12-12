#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# FILE      : 業務バッチ共通関数ファイル
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 13/10/XX | ISID        | First Edition.                            
#============================================================================

#============================================================================
# 関数名        End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でexit処理を行う
# 引数          $exit_code :終了コード
# 戻り値        $exit_code
# 戻り値型      なし
#============================================================================
function End-Function ( $exit_code ) {

	if ( $exit_code -eq $RC_OK ) {
		. $OUTMSG_CMD $NORMAL_END_MSG $exit_code $JOB_NAME
	}
	else {
		. $OUTMSG_CMD $ERROR_END_MSG  $exit_code $JOB_NAME
	}

	exit $exit_code	
}

#============================================================================
# 関数名        Make-CSVHeader
# 概要          CSV出力用SQL文ファイルのヘッダ部作成
#                 
# 引数          $out_file_name :出力ファイル名
#               $spool_name    :スプールファイル名
#
# 戻り値        なし
# 戻り値型      なし
#============================================================================
function Make-CSVHeader ([string] $out_file_name,[string] $spool_name) {

    #
    # 出力ファイルにヘッダ部を出力する
    #
    echo "set echo off"      | Out-File -FilePath $out_file_name  -encoding default
    echo "set head off"      | Out-File -FilePath $out_file_name -Append -encoding default
    echo "set linesize 1000" | Out-File -FilePath $out_file_name -Append -encoding default # 1レコードの表示が1行に収まるように調節する
    echo "set pagesize 0"    | Out-File -FilePath $out_file_name -Append -encoding default # ページ間のセパレータが無くなる
    echo "set trimspool on"  | Out-File -FilePath $out_file_name -Append -encoding default # 各行の右端のスペースを削除する
    echo "set feedback off"  | Out-File -FilePath $out_file_name -Append -encoding default # 「～行が選択されました」の非表示制御

    echo "spool $spool_name" | Out-File -FilePath $out_file_name -Append -encoding default # spool出力先設定

}
#============================================================================
# 関数名        Make-CSVFooter
# 概要          CSV出力用SQL文ファイルのフッタ部作成
#                 
# 引数          $out_file_name :出力ファイル名
#
# 戻り値        なし
# 戻り値型      なし
#============================================================================
function Make-CSVFooter ([string] $out_file_name) {

    #
    # 出力ファイルにフッタ部を出力する
    #
    echo "spool off" | Out-File -FilePath $out_file_name -Append -encoding default
    echo "exit"     | Out-File -FilePath $out_file_name -Append -encoding default

}
