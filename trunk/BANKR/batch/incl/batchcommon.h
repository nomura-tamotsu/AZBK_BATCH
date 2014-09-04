/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : �o�b�`���ʃw�b�_�t�@�C��                              */
/*                                                                          */
/* MODULE NAME      : batchcommon.h                                         */
/*                                                                          */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/08 | K.Miyahara  | First Edition.                            */
/* %01 | 09/08/06 | K.Miyahara  | CIF_JOIN�̒l�ύX.							*/
/* %02 | 10/03/03 | K.Miyahara  | �L�����y�[�����ʕ��͗p�̕\�̈��`�ǉ�	*/
/* %03 | 14/05/14 | ISID        | �L�����y�[�����ʕ��͗p�̕\�̈��`�폜	*/
/*==========================================================================*/
/****************************************************************************/
/*                                                                          */
/*							DECLARE DIVISION								*/
/*                                                                          */
/****************************************************************************/
/*--------------------------------------------------------------------------*/
/*							DEFINE STATEMENTS								*/
/*--------------------------------------------------------------------------*/

#define _BIND_TO_CURRENT_VCLIBS_VERSION 1	/* VC2008SP1�pRunTime��` */

#define TBS_NAME_SEG_TBL "EMBTSEGWK"	/* SEG�e�[�u���p�\�̈於 */
#define TBS_NAME_SEG_IDX "EMBISEGWK"	/* SEG�C���f�b�N�X�p�\�̈於 */

#if 0
/* %03 DELETE */
#define TBS_NAME_EFF_TBL "EMTTRIAL"	/* �L�����y�[�����ʕ��̓e�[�u���p�\�̈於 */
#define TBS_NAME_EFF_IDX "EMITRIAL"	/* �L�����y�[�����ʕ��̓C���f�b�N�X�p�\�̈於 */
#endif

#define CMF_JOIN            "CIF"           /* �ڋq�ԍ��Ń��j�[�N   */


#define VIEW_A					1			/* �e�[�u�����ʎq�FA			*/
#define VIEW_B					2			/* �e�[�u�����ʎq�FB			*/
#define TABLE_SUFFIX_A			"A"			/* �V�m�j���T�t�B�b�N�X�FA		*/
#define TABLE_SUFFIX_B			"B"			/* �V�m�j���T�t�B�b�N�X�FB		*/

/*                */
/* �����ύX�p��` */
/*                */
#define ZK_NAME_KNJ             "0001"      /* ��������             */
#define ZK_NAME_KNA             "0002"      /* �����J�i             */
#define ZK_SEX                  "0003"      /* ����                 */
#define ZK_BIRTHDAY             "0004"      /* ���N����             */
#define ZK_ADDRESS              "0005"      /* �Z��                 */
#define ZK_JITAKU_TEL           "0006"      /* ����d�b�ԍ�         */
#define ZK_JITAKU_FAX           "0007"      /* ����FAX�ԍ�          */
#define ZK_KEITAI               "0008"      /* �g�ѓd�b�ԍ�         */
#define ZK_MAIL                 "0009"      /* MAIL�A�h���X         */
#define ZK_KINMUSAKI            "0010"      /* �Ζ��於             */
#define ZK_KINMUSAKI_TEL        "0011"      /* �Ζ���d�b�ԍ�       */
#define ZK_REN_TEL              "0012"      /* �A����d�b�ԍ�       */
#define ZK_KAISYA_RYO           "1001"      /* ��З�               */
#define ZK_ITEN                 "1002"      /* �ړ]                 */
#define ZK_TEL_MATIGAI          "1003"      /* �d�b�ԍ��ԈႢ       */
#define ZK_SIBOU                "1004"      /* �{�l���S             */
#define ZK_FUTYAKU              "1005"      /* �X�֕s����           */
#define ZK_TM_KINSI             "1006"      /* �s�l�֎~��           */
#define ZK_DM_KINSI             "1007"      /* �c�l�֎~��           */
#define ZK_KOUIN				"1008"		/* ���s�s��				*/

/* ��������p�ǉ� */
#define ZK_ADDRESS_KANA         "0013"      /* �Z���J�i             */
#define ZK_CONTACT_ADDRESS      "0014"      /* �A����Z��           */
#define ZK_CONTACT_ADDRESS_KANA "0015"      /* �A����Z���J�i       */
#define ZK_DAYTIME_TEL          "0016"      /* �����A����d�b�ԍ�   */


/*                                        */
/* �o�b�`�������ʏڍדo�^�p�G���[���R��` */
/*                                        */
#define BE_CSV_FORMAT_ERR				"0001"	/* CSV�t�H�[�}�b�g�G���[ */
#define BE_ADDRESS_CHECK_ERR			"0002"	/* �Z���`�F�b�N�G���[ */
#define BE_ONE_BYTE_ERR					"0003"	/* ���p�J�i�`�F�b�N�G���[ */
#define BE_DATE_CHECK_ERR				"0004"	/* ���t�`�F�b�N�G���[ */
#define BE_TEMP_CIF_ERR					"0005"	/* ��CIF�̔ԃG���[ */
#define BE_NONUNIQUE_ERR				"0006"	/* ��Ӑ���G���[ */
#define BE_NOT_NULL_ERR					"0007"	/* NOTNULL����G���[ */
#define BE_BYTE_OVER_ERR				"0008"	/* �o�C�g�����߃G���[ */
#define BE_OTHER_INSERT_ERR				"0009"	/* ���̑�INSERT�G���[ */

#define BE_BRANCH_NUM_UNSET				"0010"	/* �X�Ԗ��ݒ� */
#define BE_BRANCH_NUM_BYTE_OVER			"0011"	/* �X�ԃo�C�g������ */
#define BE_BRANCH_NUM_NONEXIST			"0012"	/* �X�Ԕ񑶍� */
#define BE_BANK_MANAGE_NUM_BYTE_OVER	"0013"	/* ��s�Ǘ��ԍ��o�C�g������ */
#define BE_KANJI_BYTE_OVER				"0014"	/* ���������o�C�g������ */
#define BE_KANA_UNSET					"0015"	/* �����J�i���ݒ� */
#define BE_KANA_BYTE_OVER				"0016"	/* �����J�i�o�C�g������ */
#define BE_KANA_ONE_BYTE_ERR			"0017"	/* �����J�i���p�`�F�b�N�G���[ */
#define BE_SEX_UNSET					"0018"	/* ���ʖ��ݒ� */
#define BE_SEX_BYTE_OVER				"0019"	/* ���ʃo�C�g������ */
#define BE_BIRTH_DATE_UNSET				"0020"	/* ���N�������ݒ� */
#define BE_BIRTH_DATE_BYTE_OVER			"0021"	/* ���N�����o�C�g������ */
#define BE_BIRTH_DATE_ERR				"0022"	/* ���N�������t�G���[ */
#define BE_ADDRESS_CODE_UNSET			"0023"	/* �Z���R�[�h���ݒ� */
#define BE_ADDRESS_CODE_BYTE_OVER		"0024"	/* �Z���R�[�h�o�C�g������ */
#define BE_ADDRESS_CODE_NONEXIST		"0025"	/* �Z���R�[�h�񑶍� */
#define BE_ZIP_CODE_UNSET				"0026"	/* �X�֔ԍ����ݒ� */
#define BE_ZIP_CODE_BYTE_OVER			"0027"	/* �X�֔ԍ��o�C�g������ */
#define BE_SUB_ADDRESS_UNSET			"0028"	/* �⏕�Z�����ݒ� */
#define BE_SUB_ADDRESS_BYTE_OVER		"0029"	/* �⏕�Z���o�C�g������ */
#define BE_HOME_PHONE_NUM_UNSET			"0030"	/* ����d�b�ԍ����ݒ� */
#define BE_HOME_PHONE_NUM_BYTE_OVER		"0031"	/* ����d�b�ԍ��o�C�g������ */
#define BE_HOME_FAX_BYTE_OVER			"0032"	/* ����FAX�ԍ��o�C�g������ */
#define BE_MOBILE_NUM_BYTE_OVER			"0033"	/* �g�ѓd�b�ԍ��o�C�g������ */
#define BE_MAIL_BYTE_OVER				"0034"	/* MAIL�A�h���X�o�C�g������ */
#define BE_CAMPANY_NAME_BYTE_OVER		"0035"	/* �Ζ��於�o�C�g������ */
#define BE_WORKPLACE_PHONE_BYTE_OVER	"0036"	/* �Ζ���d�b�ԍ��o�C�g������ */
#define BE_CONTACT_PHONE_NUM_BYTE_OVER	"0037"	/* �A����d�b�ԍ��o�C�g������ */
#define BE_DATA_CHECK_ERR				"0038"	/* �f�[�^�`�F�b�N�G���[ */
#define BE_DATA_NONEXIST				"0039"	/* �Y���f�[�^�Ȃ� */
#define BE_DATA_DEL_ERR					"0040"	/* �f�[�^�폜�G���[ */
#define BE_CENTER_ID_UNSET				"0041"	/* �Z���^ID���ݒ� */
#define BE_CENTER_ID_BYTE_OVER			"0042"	/* �Z���^ID�o�C�g������ */
#define BE_CAMP_ID_UNSET				"0043"	/* �L�����y�[��ID���ݒ� */
#define BE_CAMP_ID_BYTE_OVER			"0044"	/* �L�����y�[��ID�o�C�g������ */
#define BE_CIF_UNSET					"0045"	/* CIFNO���ݒ� */
#define BE_CIF_BYTE_OVER				"0046"	/* CIFNO�o�C�g������ */
#define BE_HOUSEHOLD_NUM_BYTE_OVER		"0047"	/* ���єԍ��o�C�g������ */
#define BE_CAMP_DATA_CHECK_ERR			"0048"	/* �L�����y�[���f�[�^�`�F�b�N�G���[ */
#define BE_CAMP_DATA_NONEXIST			"0049"	/* �L�����y�[���f�[�^�񑶍� */
#define BE_CUST_DATA_CHECK_ERR			"0050"	/* �ڋq�f�[�^�`�F�b�N�G���[ */
#define BE_CUST_DATA_NONEXIST			"0051"	/* �ڋq�f�[�^�񑶍� */
#define BE_TM_EXTRACTION_CHECK_ERR		"0052"	/* TM���o�`�F�b�N�G���[ */
#define BE_TM_EXTRACTION_CREATE_ERR		"0053"	/* TM���oCREATE�G���[ */
#define BE_TM_EXTRACTION_IDX_CREATE_ERR	"0054"	/* TM���o�C���f�b�N�XCREATE�G���[ */
#define BE_CALL_LIST_CHECK_ERR			"0055"	/* �R�[�����X�g�`�F�b�N�G���[ */
#define BE_CALL_LIST_NONEXIST			"0056"	/* �R�[�����X�g�񑶍� */
#define BE_CAMP_DATA_UPDATE_ERR			"0057"	/* �L�����y�[���f�[�^�X�V�G���[ */
#define BE_SEX_ERROR					"0058"	/* ���ʕs�� */
#define BE_TM_PROHIBITION				"0059"	/* TM�֎~��ڋq */
#define BE_UNCALL_CUST_REDUPLICATION	"0060"	/* W_���R�[���ڋq�d�� */
#define BE_CALLED_CUST_REDUPLICATION	"0061"	/* W_�R�[���όڋq�d�� */

#define CASCADE 	            "TRUE"		/* �֘A�����̓��v�擾�t���O */

/*					*/
/* ���[�h�p��` 	*/
/*					*/
#define LOAD_DIR			"C:\\extdata\\load"					/* �O���f�[�^��M�f�B���N�g�� */

/* �������[�h�p��` */
#define FNAME_K_ZOKUSEI		"M_K_ZOKUSEI.dat"		/* �ڋq�����t�@�C�� */
#define FNAME_K_ZANDAKA		"M_K_ZANDAKA.dat"		/* �ڋq�c���t�@�C�� */
#define FNAME_K_HENDO		"M_K_HENDO.dat"			/* �ڋq�ϓ����t�@�C�� */
#define FNAME_S_ZOKUSEI		"M_S_ZOKUSEI.dat"		/* ���ё����t�@�C�� */
#define FNAME_S_ZANDAKA		"M_S_ZANDAKA.dat"		/* ���юc���t�@�C�� */
#define FNAME_S_HENDO		"M_S_HENDO.dat"			/* ���ѕϓ����t�@�C�� */
#define FNAME_M_RYUDO		"M_M_RYUDO.dat"			/* �ʖ��ח������t�@�C�� */
#define FNAME_M_TEIKI		"M_M_TEIKI.dat"			/* �ʖ��ג�����t�@�C�� */
#define FNAME_M_LOAN		"M_M_LOAN.dat"			/* �ʖ��׃��[���t�@�C�� */
#define FNAME_JUSHO			"M_JUSHO.dat"			/* �Z���t�@�C�� */
#define FNAME_SHOHIN		"M_SHOHIN.dat"			/* ���i�t�@�C�� */
#define FNAME_END			"M_END.dat"				/* �z�u�����t�@�C�� */

/*--------------------------------------------------------------------------*/
/*							GLOBAL DECLARES									*/
/*--------------------------------------------------------------------------*/
int G_POSITION;							/* EXEC SQL �̈ʒu					*/
char G_STATION[32];						/* �����s���W���[����				*/
char G_KOKYAKU_KEY[16];                 /* �ڋq������UNIQUE KEY             */
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
