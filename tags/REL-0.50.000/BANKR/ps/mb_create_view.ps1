#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : VIEW切替
#
# FUNCTION NAME : mb_create_view
#
# INPUT         : $Args[0] ・・・ ビューDDL識別子(view_tf_??)
#               : $Args[1] ・・・ ビュー参照先識別子( 1:A or 2:B )
#
# EXIT          :  正常終了 ・・・ NORMAL(0)
#                  異常終了 ・・・ ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# 関数名        mb_create_view-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でreturnコードを設定する
#                 powershellの関数では、returnできないので、
#                 ここで、戻り値を標準出力する
# 引数          なし
# 戻り値        $return_code
# 戻り値型      なし
#============================================================================
function local:mb_create_view-End-Function () {
	
	if ( $return_code -eq $RC_OK ) {

		. $OUTMSG_CMD $NORMAL_END_MSG $return_code $JOB_NAME
	}
	else {

		. $OUTMSG_CMD $ERROR_END_MSG $return_code $JOB_NAME
	}

	$return_code
	
}

function mb_create_view (　$view_ddl_base , $view_ddl_suffix ) {


        #============================================================================
        # 初期処理
        #============================================================================
        #
        # 共通ファイル設定
        #
        $DefFile   = $EMB_HOME + "\ps\def\EMB_DEF.ps1"
        # 共通ファイル実行（EMB_DEF.ps1を実行）
        . $DefFile

        # コマンド名セット
        $OUTMSG_CMD    = $EMB_HOME + "\ps\outmsg.ps1"

        # 処理名セット
        $local:BATNAME  = "mb_create_view"
        $local:JOB_NAME = "VIEW切替"

        #
        # exitコード初期化
        #
        $local:return_code = $RC_OK


        # 開始メッセージ
        #. $OUTMSG_CMD $INFO_MSG $RC_OK "*****ビュー切替処理*****"
        . $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


        #
        # 引数のチェック
        #
	# 第一引数チェック
	if ( $view_ddl_base -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "ビューDDL識別子が指定されていません"
		$return_code = $RC_NG
		mb_create_view-End-Function
		return 

	}


	# 第二引数チェック
	if ( $view_ddl_suffix -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "ビュー参照先識別子が指定されていません"
		$return_code = $RC_NG
		mb_create_view-End-Function
		return 
	}


        # ============================================================================
        # メイン処理
        # ============================================================================

        #
        # ファイル名作成　DDLファイル(FullPATH)
        #
        $local:view_ddl_file = $VIEW_DDL_DIR + "\" + $view_ddl_base + $view_ddl_suffix + ".ddl"
	$local:view_ddl_file_cmd = "@" + $VIEW_DDL_DIR + "\" + $view_ddl_base + $view_ddl_suffix + ".ddl"
     
        #
        # ファイル存在チェック
        #
        if ( -not ( Test-Path $view_ddl_file ) ) {
                . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $view_ddl_file
                $return_code = $RC_NG
                mb_create_view-End-Function
		return 
        }

        #
        # ログファイル名作成　DDL実行ログファイル(FullPATH)
        #
        $local:view_ddl_log = $VIEW_DDL_LOG_DIR + "\" + $view_ddl_base + $view_ddl_suffix + ".log"


        # DBパスワードの複合化
        $DB_PWD_DECODE = PDECODE $DB_NAME $DB_UID
        if ( $ORACLE_TNS -ne $null ) {
            $DB_PWD_DECODE=$DB_PWD_DECODE + "@" + $ORACLE_TNS
        }

        #
        # ログファイル削除
        #
        $errorObject = rm -Force  $view_ddl_log  2>&1


        #
        # ビュー作成を実行
        #
        $rc = sqlplus $DB_UID/$DB_PWD_DECODE  $view_ddl_file_cmd > $view_ddl_log
        $ret=$?
        if ( $ret -ne "TRUE" ) {
                . $OUTMSG_CMD $COM_ERROR $RC_NG "sqlplusでエラーが発生しました"
                $return_code=$RC_NG
                mb_create_view-End-Function
		return
        }


        #
        # ログファイルが存在しません
        #
        if ( -not ( Test-Path $view_ddl_log ) ) {
            . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $view_ddl_log
            . $OUTMSG_CMD $COM_ERROR $RC_NG "sqlplusコマンドでエラーが発生したか、ログ が作成できませんでした"
            $return_code = $RC_NG
            mb_create_view-End-Function
	    return
        }


        #
        # ログからエラーチェック "ORA-" 検索
        #
        $local:error_string = "ORA-"
        $local:result_str = Get-Content $view_ddl_log | grep $error_string
        if ( $result_str -ne $null ) {
                . $OUTMSG_CMD $VIEW_SWITCH_ERROR $RC_NG

	        #-------------------------------------------------
                # ログファイル名を変更　開始
                #-------------------------------------------------

                # DATE関連変数定義
                $now   = Get-Date
                $date  = $now.ToString("yyyyMMdd")
                $time  = $now.ToString("HHmmss")

                # ファイル名のみ取得
                $local:new_file_name = split-path $view_ddl_log  -Leaf
                $local:path_name = Split-Path $view_ddl_log -parent


                # 新ファイル名作成
                $local:new_file_name = $path_name + "\" + $new_file_name + "." + $date +$time

                # Move 実行
                $rc = Move-Item $view_ddl_log $new_file_name -force 2>&1
                $ret=$?
                if ( $ret -ne "TRUE" ) {
                        . $OUTMSG_CMD $COM_ERROR $RC_NG "ログファイルのリネームでエラーが 発生しました"
                        $return_code = $RC_NG
                        mb_create_view-End-Function
			return
                }
		#-------------------------------------------------
                # ログファイル名を変更　終了
                #-------------------------------------------------

                $return_code=$RC_NG
                mb_create_view-End-Function
		return
        }

	#
	# 正常終了処理
	#
        mb_create_view-End-Function

	return
}

