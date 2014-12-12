#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : 外部データ取込
#
# FUNCTION NAME : mb_load_external_data
#
# INPUT         : %1 ・・・ コントロールファイル
#                 %2 ・・・ データファイル
#                 %3 ・・・ BADファイル
#                 %4 ・・・ DISCARDファイル
#                 %5 ・・・ ログファイル
#
# EXIT          : 正常終了 ・・・ NORMAL  (0)
#                 警告終了 ・・・ WARNING (1)
#                 異常終了 ・・・ ERROR   (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/10 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# 関数名        Delete-file
# 概要          ファイル削除処理
# 引数          $file_name ファイル名
# 戻り値        $RC_OK,$RC_NG
# 戻り値型      なし
#============================================================================
function Delete-file ( [string] $file_name ) {

    #
    # ファイルの存在確認
    #
    if ( -not ( Test-Path $file_name ) ) {
        # 存在しないので削除処理無し
        return $RC_OK
    }
    
    #
    # ファイル判別チェック
    #
    $rc = Get-ChildItem  $file_name | Where-Object { -not $_.PSIsContainer} | format-list name
    if ( $rc -eq $null ) {
        # フォルダの場合は削除無し
        return $RC_OK
    }

    #
    # 削除実行
    #
    $errorObject = rm -Force  $file_name  2>&1
    
    # エラーハンドリング
    if ( $errorObject -eq $null ) {
        return $RC_OK
    }
    else {
        # エラーメッセージをファイルに出力
        echo $errorObject > $TMP_DIR\tempe.log
        return $RC_NG
    }

}


#============================================================================
# 関数名        Extload-End-Function
# 概要          終了処理
#                 goto文が使用できないので、この関数でreturnコードを設定する
#                 powershellの関数では、returnできないので、
#                 ここで、戻り値を標準出力する
# 引数          なし
# 戻り値        $return_code
# 戻り値型      なし
#============================================================================
function local:Extload-End-Function () {

	if ( $return_code -eq $RC_OK ) {
		. $OUTMSG_CMD $NORMAL_END_MSG $return_code $JOB_NAME
	}
	elseif ( $return_code -eq $RC_WARNING ) {
		. $OUTMSG_CMD $WARNINGL_END_MSG $return_code $JOB_NAME
	}
	else {
		. $OUTMSG_CMD $ERROR_END_MSG $return_code $JOB_NAME
	}

	$return_code
	
}


#============================================================================
# 関数名        mb_load_external_data
# 概要          外部データ取込メイン
#                 
# 引数          : %1 ・・・ コントロールファイル
#                 %2 ・・・ データファイル
#                 %3 ・・・ BADファイル
#                 %4 ・・・ DISCARDファイル
#                 %5 ・・・ ログファイル
#
# 戻り値        : 正常終了 ・・・ NORMAL  (0)
#                 警告終了 ・・・ WARNING (1)
#                 異常終了 ・・・ ERROR   (9)
#
# 戻り値型      なし
#============================================================================
function mb_load_external_data ( $control_file, $data_file, $bad_file, $discard_file, $log_file ) {


        # ============================================================================
        # 初期処理
        # ============================================================================

        #
        # 共通ファイル設定
        #
        $DefFile   = $EMB_HOME + "\ps\def\EMB_DEF.ps1"
        # 共通ファイル実行（EMB_DEF.ps1を実行）
        . $DefFile

        # コマンド名セット
        $OUTMSG_CMD    = $EMB_HOME + "\ps\outmsg.ps1"


        # 処理名セット
        $local:BATNAME  = $MyInvocation.MyCommand.Name
        $local:JOB_NAME = "外部データ取込"

        # return_code初期化
        $local:return_code = $RC_OK


        # 開始メッセージ
        . $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

        #-----------------------------------------
        # 引数のチェック
        #-----------------------------------------
	$local:arg_info = $null

	# 引数の必須チェック
	if ( $control_file -eq $null ) {
		$arg_info = "第１引数 コントロールファイル"
	}
	elseif ( $data_file    -eq $null ) {
		$arg_info = "第２引数 データファイル"
	}
	elseif ( $bad_file     -eq $null ) {
		$arg_info = "第３引数 不良ファイル"
	}	
	elseif ( $discard_file -eq $null ) {
		$arg_info = "第４引数 廃棄ファイル"
	}
	elseif ( $log_file     -eq $null ) {
		$arg_info = "第５引数 ログファイル"
	}

	#
	# エラーの場合メッセージ出力
	#
	if ( $arg_info -ne $null ) {
	    . $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG $arg_info
	    $return_code = $RC_NG
            Extload-End-Function
            return
	}



        # ============================================================================
        # メイン処理
        # ============================================================================

        # integer 変数初期化
        $local:num        = 0
        $local:num_read   = 0
        $local:num_skip   = 0
        $local:num_load   = 0
        $local:num_reject = 0
        $local:num_delete = 0
        $local:num_commit = 0
        $local:kensu      = 0

        # ファイルの存在確認
        if ( -not ( Test-Path $control_file ) ) {
            . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $control_file
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        if ( -not ( Test-Path $data_file ) ) {
            . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $data_file
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }



        # DBパスワードの複合化
        $DB_PWD_DECODE = PDECODE $DB_NAME $DB_UID
        if ( $ORACLE_TNS -ne $null ) {
            $DB_PWD_DECODE=$DB_PWD_DECODE + "@" + $ORACLE_TNS
        }


        # ファイル削除
        $rc = Delete-file ( $bad_file     )
        $rc = Delete-file ( $discard_file )
        $rc = Delete-file ( $log_file     )


	#-------------------------------------------------------------------------------
	# ダイレクトロードを実行
	#-------------------------------------------------------------------------------
	$sqllload_cmd = "sqlldr"
	$load_arg     = "$DB_UID/$DB_PWD_DECODE CONTROL=$control_file,DATA=$data_file,BAD=$bad_file,DISCARD=$discard_file,LOG=$log_file"

	#-------------------------------------------------------------------------------
	# $sqllload_cmd というアプリを引数 $load_arg で実行し、終了するまで待機
	#-------------------------------------------------------------------------------
	$load_process = Start-Process $sqllload_cmd $load_arg  -PassThru -Wait -WindowStyle  Hidden
	#-------------------------------------------------------------------------------
	# 終了コードの取得
	#-------------------------------------------------------------------------------
	$load_ret = $load_process.ExitCode
	#-------------------------------------------------------------------------------
	# リソースの破棄
	#-------------------------------------------------------------------------------
	$load_process.Close()


	#-------------------------------------------------------------------------------
        # ロードのエラーチェック処理
	#-------------------------------------------------------------------------------
        $local:result_str=""
        # ログファイルが存在しません
        if ( -not ( Test-Path $log_file ) ) {
            . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $log_file
            . $OUTMSG_CMD $COM_ERROR $RC_NG "sqlldrコマンドでエラーが発生したか、ログ が作成できませんでした"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }


        #echo  "最大エラー件数を超えました" | Out-File -FilePath $log_file -Append -Encoding default
        $result_str = Get-Content $log_file | grep "最大エラー件数を超えました"
        if ( $result_str -ne $null ) {
            . $OUTMSG_CMD $LOAD_EXCEED_ERR $RC_NG
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        #echo  "ロードが停止しました" | Out-File -FilePath $log_file -Append -Encoding default
        $result_str = Get-Content $log_file | grep "ロードが停止しました"
        if ( $result_str -ne $null ) {
            . $OUTMSG_CMD $LOAD_FAILURE $RC_NG
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        #echo  "重複するキーがあります" | Out-File -FilePath $log_file -Append -Encoding default
        $result_str = Get-Content $log_file | grep "重複するキーがあります"
        if ( $result_str -ne $null ) {

            . $OUTMSG_CMD $ERR_DUPLICATE $RC_NG 
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        #echo  "Loader-2026" | Out-File -FilePath $log_file -Append -Encoding default
        $result_str = Get-Content $log_file | grep "Loader-2026"
        if ( $result_str -ne $null ) {
            . $OUTMSG_CMD $LOAD_ERROR_2026 $RC_NG
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }




	#-------------------------------------------------------------------------------
        # ロード件数のチェック処理
	#-------------------------------------------------------------------------------
        $local:result_str=""

        $result_str = Get-Content $log_file | grep "読み込まれた論理レコード"
        if ( $result_str -ne $null ) {
            # 文字列を編集ー数字までの文字を全て削除
            $tmp_str=$result_str -replace ".* ",""
            #数値型に変換
            $rc=[int]::TryParse($tmp_str, [ref]$num_read)
        }
        else {
            . $OUTMSG_CMD $COM_ERROR $RC_NG "ログファイルが不正です。(読み込まれた論理レコードがありません)"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        $result_str = Get-Content $log_file | grep "スキップされた論理レコード"
        if ( $result_str -ne $null ) {
            # 文字列を編集ー数字までの文字を全て削除
            $tmp_str=$result_str -replace ".* ",""
            #数値型に変換
            $rc=[int]::TryParse($tmp_str, [ref]$num_skip)
        }
        else {
            . $OUTMSG_CMD $COM_ERROR $RC_NG "ログファイルが不正です。(スキップされた論理レコードがありません)"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        $result_str = Get-Content $log_file | grep "拒否された論理レコード"
        if ( $result_str -ne $null ) {
            # 文字列を編集ー数字までの文字を全て削除
            $tmp_str=$result_str -replace ".* ",""
            #数値型に変換
            $rc=[int]::TryParse($tmp_str, [ref]$num_reject)
        }
        else {
            . $OUTMSG_CMD $COM_ERROR $RC_NG "ログファイルが不正です。(拒否された論理レコードがありません)"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        $result_str = Get-Content $log_file | grep "廃棄された論理レコード"
        if ( $result_str -ne $null ) {
            # 文字列を編集ー数字までの文字を全て削除
            $tmp_str=$result_str -replace ".* ",""
            #数値型に変換
            $rc=[int]::TryParse($tmp_str, [ref]$num_delete)
        }
        else {
            . $OUTMSG_CMD $COM_ERROR $RC_NG "ログファイルが不正です。(廃棄された論理レコードがありません)"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }




        $num_load   = $num_read - $num_skip - $num_reject - $num_delete
        $num_commit = $num_load
        $num        = $num_skip + $num_reject + $num_delete


        #
        # 警告有り
        #
        if ( $num -gt 0 ) {
            # 外部データロードで拒否されたレコードがあります
            . $OUTMSG_CMD $LOAD_REFUSAL_WAN $RC_OK $num
            . $OUTMSG_CMD $INFO_MSG $RC_OK "外部データの導入が終了しました。【$CONTROL_FILE】"

            $return_code = $RC_OK

            $load_ret = "TRUE"

            Extload-End-Function
	    return 

        }

        #
        # ロードでエラーがあった場合
        #   （上記エラーハンドリングに該当しない場合）
        #
        if ( $load_ret -ne $RC_OK ) {
                . $OUTMSG_CMD $COM_ERROR $RC_NG "sqlldrコマンドでエラーが発生しました"
                $return_code = $RC_NG
                Extload-End-Function
	        return 
        }

         . $OUTMSG_CMD $INFO_MSG $RC_OK "外部データの導入が正常終了しました。【$CONTROL_FILE】"

	#
	# 正常終了処理
	#
        Extload-End-Function
	return


}
