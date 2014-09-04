/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC                                           */
/*                                                                          */
/* PROGRAM NAME     : �A�v�����ʃw�b�_�t�@�C��                              */
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

#define AP_CONFIG_LINE  256						/* �P�s�̒��� */
#define AP_GYO_CONFIG_DATA_VALUE 256+1			/* �f�[�^�l */
#define AP_C_NOTE_LEN_H 128						/* ���l�� */
#define AP_GYO_CONFIG_MAX 9999                  /* �ő�s�� */


#define EMB_C_DATE_LEN                 10         /* ���t */
#define EMB_C_COMP_CODE_LEN             4         /* ���^�[���R�[�h */
#define EMB_C_DTIME_LEN                19         /* ���� */

#define EMB_ERR_DB_NOT_FOUND 4005
#define EMB_ERR_DB_DUPLICATE 4008

#define USUALITY 1								/* �ʏ펞 */
#define OBSTACLE 2								/* ��Q�� */

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
    char szDateTime     [EMB_C_DTIME_LEN        ]; /* ����                 */
    char szRtType       [EMB_C_COMP_CODE_LEN    ]; /* ��������             */
    char szRtInfo       [EMB_C_COMP_CODE_LEN * 3]; /* ��������             */
    char szNote         [AP_C_NOTE_LEN_H          ]; /* ���l                 */
    char szDelimit      [1                        ]; /* LF                   */
    char szNote1        [EMB_C_DTIME_LEN + EMB_C_COMP_CODE_LEN * 4 + AP_C_NOTE_LEN_H];
   /* ���l                 */
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

/* ��s�^�C�v */
#define AP_C_BANK_TYPE_01               1            /* ��s                 */
#define AP_C_BANK_TYPE_02               2            /* �M��                 */
#define AP_C_BANK_TYPE_03               3            /* �M�g                 */
#define AP_C_BANK_TYPE_99              99            /* ���̑�               */

/* �ٓ����R�R�[�h */
#define AP_C_IDO_LEN                    2
#define AP_C_IDO_TEISHI                 0            /* �Ɩ���~             */
#define AP_C_IDO_JOUTO                  1            /* ���n�X��             */
#define AP_C_IDO_TOUGOU                 2            /* �X�ܓ���             */


/* �����敪 */
#define AP_C_SYORI_NEW                  1            /* �V�K                 */
#define AP_C_SYORI_UPDATE               2            /* �ύX                 */
#define AP_C_SYORI_DELETE               3            /* �폜                 */

/* �ύX�敪 */
#define AP_C_SYORI_NORMAL               1            /* �ʏ�                 */
#define AP_C_SYORI_RESET                2            /* �p�X���[�h���Z�b�g   */
#define AP_C_SYORI_STOP                 3            /* ��~                 */
#define AP_C_SYORI_FREE                 4            /* ����                 */