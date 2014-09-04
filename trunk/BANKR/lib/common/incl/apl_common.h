/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* PROGRAM NAME     : アプリ共通ヘッダファイル                              */
/*                                                                          */
/* MODULE NAME      : apl_common.h                                          */
/*                                                                          */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 13/10/XX | ISID        | First Edition.                            */
/*==========================================================================*/
/****************************************************************************/
/*                                                                          */
/*							DECLARE DIVISION								*/
/*                                                                          */
/****************************************************************************/
/*--------------------------------------------------------------------------*/
/*							DEFINE STATEMENTS								*/
/*--------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
/* Macro Function Decralation  i                                             */
/*---------------------------------------------------------------------------*/

#define AP_CONFIG_LINE  256						/* １行の長さ */
#define AP_GYO_CONFIG_DATA_VALUE 256+1			/* データ値 */
#define AP_C_NOTE_LEN_H 128						/* 備考長 */
#define AP_GYO_CONFIG_MAX 9999                  /* 最大行数 */


#define EMB_C_DATE_LEN                 10         /* 日付 */
#define EMB_C_COMP_CODE_LEN             4         /* リターンコード */
#define EMB_C_DTIME_LEN                19         /* 日時 */

#define EMB_ERR_DB_NOT_FOUND 4005
#define EMB_ERR_DB_DUPLICATE 4008

#define USUALITY 1								/* 通常時 */
#define OBSTACLE 2								/* 障害時 */

#define AP_DELSP( string, len ){                                 \
   int i;                                                        \
   for( i = (len-1); i >= 0; i-- ) {                             \
      if( string[i] == 0x20 || string[i] == 0x00 ) {             \
         string[i] = 0x00;                                       \
      } else if( i > 0 ) {                                       \
         if( string[i-1] == 0x81 && string[i] == 0x40 ) {        \
             string[i--] = 0x00;                                 \
             string[i  ] = 0x00;                                 \
         } else if( string[i-1] == 0xA1 && string[i] == 0xA1 ) { \
             string[i--] = 0x00;                                 \
             string[i  ] = 0x00;                                 \
         } else {                                                \
             break;                                              \
         }                                                       \
      } else {                                                   \
         break;                                                  \
      }                                                          \
   }                                                             \
}                                                                \


/*--------------------------------------------------------------------------*/
/*							STRUCT DECLARATIONS								*/
/*--------------------------------------------------------------------------*/
typedef struct _AP_D_BTLOG_LIST {
    char szDateTime     [EMB_C_DTIME_LEN        ]; /* 日時                 */
    char szRtType       [EMB_C_COMP_CODE_LEN    ]; /* 処理結果             */
    char szRtInfo       [EMB_C_COMP_CODE_LEN * 3]; /* 処理結果             */
    char szNote         [AP_C_NOTE_LEN_H          ]; /* 備考                 */
    char szDelimit      [1                        ]; /* LF                   */
    char szNote1        [EMB_C_DTIME_LEN + EMB_C_COMP_CODE_LEN * 4 + AP_C_NOTE_LEN_H];
   /* 備考                 */
    char szDelimit1     [1                        ]; /* LF                   */
} AP_D_BTLOG;


/*--------------------------------------------------------------------------*/
/*							GLOBAL DECLARES									*/
/*--------------------------------------------------------------------------*/


/*--------------------------------------------------------------------------*/
/*							EXTERNAL DECLARES								*/
/*--------------------------------------------------------------------------*/



/*--------------------------------------------------------------------------*/
/*							SUBROUTNE DEFINITION							*/
/*--------------------------------------------------------------------------*/

/* 銀行タイプ */
#define AP_C_BANK_TYPE_01               1            /* 銀行                 */
#define AP_C_BANK_TYPE_02               2            /* 信金                 */
#define AP_C_BANK_TYPE_03               3            /* 信組                 */
#define AP_C_BANK_TYPE_99              99            /* その他               */

/* 異動事由コード */
#define AP_C_IDO_LEN                    2
#define AP_C_IDO_TEISHI                 0            /* 業務停止             */
#define AP_C_IDO_JOUTO                  1            /* 譲渡店舗             */
#define AP_C_IDO_TOUGOU                 2            /* 店舗統合             */


/* 処理区分 */
#define AP_C_SYORI_NEW                  1            /* 新規                 */
#define AP_C_SYORI_UPDATE               2            /* 変更                 */
#define AP_C_SYORI_DELETE               3            /* 削除                 */

/* 変更区分 */
#define AP_C_SYORI_NORMAL               1            /* 通常                 */
#define AP_C_SYORI_RESET                2            /* パスワードリセット   */
#define AP_C_SYORI_STOP                 3            /* 停止                 */
#define AP_C_SYORI_FREE                 4            /* 解除                 */