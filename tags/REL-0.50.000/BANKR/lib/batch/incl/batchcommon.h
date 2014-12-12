/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : バッチ共通ヘッダファイル                              */
/*                                                                          */
/* MODULE NAME      : batchcommon.h                                         */
/*                                                                          */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/08 | K.Miyahara  | First Edition.                            */
/* %01 | 09/08/06 | K.Miyahara  | CIF_JOINの値変更.							*/
/* %02 | 10/03/03 | K.Miyahara  | キャンペーン効果分析用の表領域定義追加	*/
/* %03 | 14/05/14 | ISID        | キャンペーン効果分析用の表領域定義削除	*/
/*==========================================================================*/
/****************************************************************************/
/*                                                                          */
/*							DECLARE DIVISION								*/
/*                                                                          */
/****************************************************************************/
/*--------------------------------------------------------------------------*/
/*							DEFINE STATEMENTS								*/
/*--------------------------------------------------------------------------*/

#define _BIND_TO_CURRENT_VCLIBS_VERSION 1	/* VC2008SP1用RunTime定義 */

#define TBS_NAME_SEG_TBL "EMBTSEGWK"	/* SEGテーブル用表領域名 */
#define TBS_NAME_SEG_IDX "EMBISEGWK"	/* SEGインデックス用表領域名 */

#if 0
/* %03 DELETE */
#define TBS_NAME_EFF_TBL "EMTTRIAL"	/* キャンペーン効果分析テーブル用表領域名 */
#define TBS_NAME_EFF_IDX "EMITRIAL"	/* キャンペーン効果分析インデックス用表領域名 */
#endif

#define CMF_JOIN            "CIF"           /* 顧客番号でユニーク   */


#define VIEW_A					1			/* テーブル識別子：A			*/
#define VIEW_B					2			/* テーブル識別子：B			*/
#define TABLE_SUFFIX_A			"A"			/* シノニムサフィックス：A		*/
#define TABLE_SUFFIX_B			"B"			/* シノニムサフィックス：B		*/

/*                */
/* 属性変更用定義 */
/*                */
#define ZK_NAME_KNJ             "0001"      /* 氏名漢字             */
#define ZK_NAME_KNA             "0002"      /* 氏名カナ             */
#define ZK_SEX                  "0003"      /* 性別                 */
#define ZK_BIRTHDAY             "0004"      /* 生年月日             */
#define ZK_ADDRESS              "0005"      /* 住所                 */
#define ZK_JITAKU_TEL           "0006"      /* 自宅電話番号         */
#define ZK_JITAKU_FAX           "0007"      /* 自宅FAX番号          */
#define ZK_KEITAI               "0008"      /* 携帯電話番号         */
#define ZK_MAIL                 "0009"      /* MAILアドレス         */
#define ZK_KINMUSAKI            "0010"      /* 勤務先名             */
#define ZK_KINMUSAKI_TEL        "0011"      /* 勤務先電話番号       */
#define ZK_REN_TEL              "0012"      /* 連絡先電話番号       */
#define ZK_KAISYA_RYO           "1001"      /* 会社寮               */
#define ZK_ITEN                 "1002"      /* 移転                 */
#define ZK_TEL_MATIGAI          "1003"      /* 電話番号間違い       */
#define ZK_SIBOU                "1004"      /* 本人死亡             */
#define ZK_FUTYAKU              "1005"      /* 郵便不着先           */
#define ZK_TM_KINSI             "1006"      /* ＴＭ禁止先           */
#define ZK_DM_KINSI             "1007"      /* ＤＭ禁止先           */
#define ZK_KOUIN				"1008"		/* 当行行員				*/

/* あおぞら用追加 */
#define ZK_ADDRESS_KANA         "0013"      /* 住所カナ             */
#define ZK_CONTACT_ADDRESS      "0014"      /* 連絡先住所           */
#define ZK_CONTACT_ADDRESS_KANA "0015"      /* 連絡先住所カナ       */
#define ZK_DAYTIME_TEL          "0016"      /* 日中連絡先電話番号   */


/*                                        */
/* バッチ処理結果詳細登録用エラー理由定義 */
/*                                        */
#define BE_CSV_FORMAT_ERR				"0001"	/* CSVフォーマットエラー */
#define BE_ADDRESS_CHECK_ERR			"0002"	/* 住所チェックエラー */
#define BE_ONE_BYTE_ERR					"0003"	/* 半角カナチェックエラー */
#define BE_DATE_CHECK_ERR				"0004"	/* 日付チェックエラー */
#define BE_TEMP_CIF_ERR					"0005"	/* 仮CIF採番エラー */
#define BE_NONUNIQUE_ERR				"0006"	/* 一意制約エラー */
#define BE_NOT_NULL_ERR					"0007"	/* NOTNULL制約エラー */
#define BE_BYTE_OVER_ERR				"0008"	/* バイト数超過エラー */
#define BE_OTHER_INSERT_ERR				"0009"	/* その他INSERTエラー */

#define BE_BRANCH_NUM_UNSET				"0010"	/* 店番未設定 */
#define BE_BRANCH_NUM_BYTE_OVER			"0011"	/* 店番バイト数超過 */
#define BE_BRANCH_NUM_NONEXIST			"0012"	/* 店番非存在 */
#define BE_BANK_MANAGE_NUM_BYTE_OVER	"0013"	/* 銀行管理番号バイト数超過 */
#define BE_KANJI_BYTE_OVER				"0014"	/* 氏名漢字バイト数超過 */
#define BE_KANA_UNSET					"0015"	/* 氏名カナ未設定 */
#define BE_KANA_BYTE_OVER				"0016"	/* 氏名カナバイト数超過 */
#define BE_KANA_ONE_BYTE_ERR			"0017"	/* 氏名カナ半角チェックエラー */
#define BE_SEX_UNSET					"0018"	/* 性別未設定 */
#define BE_SEX_BYTE_OVER				"0019"	/* 性別バイト数超過 */
#define BE_BIRTH_DATE_UNSET				"0020"	/* 生年月日未設定 */
#define BE_BIRTH_DATE_BYTE_OVER			"0021"	/* 生年月日バイト数超過 */
#define BE_BIRTH_DATE_ERR				"0022"	/* 生年月日日付エラー */
#define BE_ADDRESS_CODE_UNSET			"0023"	/* 住所コード未設定 */
#define BE_ADDRESS_CODE_BYTE_OVER		"0024"	/* 住所コードバイト数超過 */
#define BE_ADDRESS_CODE_NONEXIST		"0025"	/* 住所コード非存在 */
#define BE_ZIP_CODE_UNSET				"0026"	/* 郵便番号未設定 */
#define BE_ZIP_CODE_BYTE_OVER			"0027"	/* 郵便番号バイト数超過 */
#define BE_SUB_ADDRESS_UNSET			"0028"	/* 補助住所未設定 */
#define BE_SUB_ADDRESS_BYTE_OVER		"0029"	/* 補助住所バイト数超過 */
#define BE_HOME_PHONE_NUM_UNSET			"0030"	/* 自宅電話番号未設定 */
#define BE_HOME_PHONE_NUM_BYTE_OVER		"0031"	/* 自宅電話番号バイト数超過 */
#define BE_HOME_FAX_BYTE_OVER			"0032"	/* 自宅FAX番号バイト数超過 */
#define BE_MOBILE_NUM_BYTE_OVER			"0033"	/* 携帯電話番号バイト数超過 */
#define BE_MAIL_BYTE_OVER				"0034"	/* MAILアドレスバイト数超過 */
#define BE_CAMPANY_NAME_BYTE_OVER		"0035"	/* 勤務先名バイト数超過 */
#define BE_WORKPLACE_PHONE_BYTE_OVER	"0036"	/* 勤務先電話番号バイト数超過 */
#define BE_CONTACT_PHONE_NUM_BYTE_OVER	"0037"	/* 連絡先電話番号バイト数超過 */
#define BE_DATA_CHECK_ERR				"0038"	/* データチェックエラー */
#define BE_DATA_NONEXIST				"0039"	/* 該当データなし */
#define BE_DATA_DEL_ERR					"0040"	/* データ削除エラー */
#define BE_CENTER_ID_UNSET				"0041"	/* センタID未設定 */
#define BE_CENTER_ID_BYTE_OVER			"0042"	/* センタIDバイト数超過 */
#define BE_CAMP_ID_UNSET				"0043"	/* キャンペーンID未設定 */
#define BE_CAMP_ID_BYTE_OVER			"0044"	/* キャンペーンIDバイト数超過 */
#define BE_CIF_UNSET					"0045"	/* CIFNO未設定 */
#define BE_CIF_BYTE_OVER				"0046"	/* CIFNOバイト数超過 */
#define BE_HOUSEHOLD_NUM_BYTE_OVER		"0047"	/* 世帯番号バイト数超過 */
#define BE_CAMP_DATA_CHECK_ERR			"0048"	/* キャンペーンデータチェックエラー */
#define BE_CAMP_DATA_NONEXIST			"0049"	/* キャンペーンデータ非存在 */
#define BE_CUST_DATA_CHECK_ERR			"0050"	/* 顧客データチェックエラー */
#define BE_CUST_DATA_NONEXIST			"0051"	/* 顧客データ非存在 */
#define BE_TM_EXTRACTION_CHECK_ERR		"0052"	/* TM抽出チェックエラー */
#define BE_TM_EXTRACTION_CREATE_ERR		"0053"	/* TM抽出CREATEエラー */
#define BE_TM_EXTRACTION_IDX_CREATE_ERR	"0054"	/* TM抽出インデックスCREATEエラー */
#define BE_CALL_LIST_CHECK_ERR			"0055"	/* コールリストチェックエラー */
#define BE_CALL_LIST_NONEXIST			"0056"	/* コールリスト非存在 */
#define BE_CAMP_DATA_UPDATE_ERR			"0057"	/* キャンペーンデータ更新エラー */
#define BE_SEX_ERROR					"0058"	/* 性別不正 */
#define BE_TM_PROHIBITION				"0059"	/* TM禁止先顧客 */
#define BE_UNCALL_CUST_REDUPLICATION	"0060"	/* W_未コール顧客重複 */
#define BE_CALLED_CUST_REDUPLICATION	"0061"	/* W_コール済顧客重複 */

#define CASCADE 	            "TRUE"		/* 関連索引の統計取得フラグ */

/*					*/
/* ロード用定義 	*/
/*					*/
#define LOAD_DIR			"C:\\extdata\\load"					/* 外部データ受信ディレクトリ */

/* 月次ロード用定義 */
#define FNAME_K_ZOKUSEI		"M_K_ZOKUSEI.dat"		/* 顧客属性ファイル */
#define FNAME_K_ZANDAKA		"M_K_ZANDAKA.dat"		/* 顧客残高ファイル */
#define FNAME_K_HENDO		"M_K_HENDO.dat"			/* 顧客変動情報ファイル */
#define FNAME_S_ZOKUSEI		"M_S_ZOKUSEI.dat"		/* 世帯属性ファイル */
#define FNAME_S_ZANDAKA		"M_S_ZANDAKA.dat"		/* 世帯残高ファイル */
#define FNAME_S_HENDO		"M_S_HENDO.dat"			/* 世帯変動情報ファイル */
#define FNAME_M_RYUDO		"M_M_RYUDO.dat"			/* 個別明細流動性ファイル */
#define FNAME_M_TEIKI		"M_M_TEIKI.dat"			/* 個別明細定期性ファイル */
#define FNAME_M_LOAN		"M_M_LOAN.dat"			/* 個別明細ローンファイル */
#define FNAME_JUSHO			"M_JUSHO.dat"			/* 住所ファイル */
#define FNAME_SHOHIN		"M_SHOHIN.dat"			/* 商品ファイル */
#define FNAME_END			"M_END.dat"				/* 配置完了ファイル */

/*--------------------------------------------------------------------------*/
/*							GLOBAL DECLARES									*/
/*--------------------------------------------------------------------------*/
int G_POSITION;							/* EXEC SQL の位置					*/
char G_STATION[32];						/* 現実行モジュール名				*/
char G_KOKYAKU_KEY[16];                 /* 顧客属性のUNIQUE KEY             */
char G_SQL[4096];

/*--------------------------------------------------------------------------*/
/*							EXTERNAL DECLARES								*/
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*							STRUCT DECLARATIONS								*/
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*							SUBROUTNE DEFINITION							*/
/*--------------------------------------------------------------------------*/
