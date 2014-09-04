/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : �z�X�g�ϐ�(TD_�����ύX���)     TDAC_????             */
/*                                                                          */
/* MODULE NAME      : TD_AttributeChangeInfo.h                              */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/07/02 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    char	TDAC_branch_number[5+1];				/* �X�� */
    short	TDACi_branch_number;

    char	TDAC_cif_number[10+1];					/* CIFNO */
    short	TDACi_cif_number;

    char	TDAC_contractant_number[10+1];			/* �_��Ҕԍ� */
    short	TDACi_contractant_number;

    char	TDAC_attribute_id[4+1];					/* ����ID */
    short	TDACi_attribute_id;

    char	TDAC_household_number[13+1];			/* ���єԍ� */
    short	TDACi_household_number;

    varchar	TDAC_batch_change_before[400+1];		/* �o�b�`�p�ύX�O */
    short	TDACi_batch_change_before;

    varchar	TDAC_change_after1[144+1];				/* �ύX��1 */
    short	TDACi_change_after1;

    varchar	TDAC_change_after2[144+1];				/* �ύX��2 */
    short	TDACi_change_after2;

    varchar	TDAC_change_after3[144+1];				/* �ύX��3 */
    short	TDACi_change_after3;

    varchar	TDAC_change_after4[144+1];				/* �ύX��4 */
    short	TDACi_change_after4;

    varchar	TDAC_change_before1[144+1];				/* �ύX�O1 */
    short	TDACi_change_before1;

    varchar	TDAC_change_before2[144+1];				/* �ύX�O2 */
    short	TDACi_change_before2;

    varchar	TDAC_change_before3[144+1];				/* �ύX�O3 */
    short	TDACi_change_before3;

    varchar	TDAC_change_before4[144+1];				/* �ύX�O4 */
    short	TDACi_change_before4;

    char	TDAC_address_code_change_before[15+1];	/* �ύX�O�Z���R�[�h */
    short	TDACi_address_code_change_before;

    char	TDAC_negotiating_partner[4+1];			/* ������ */
    short	TDACi_negotiating_partner;

    varchar	TDAC_name_kanji[40+1];					/* �������� */
    short	TDACi_name_kanji;

    varchar	TDAC_name_kana[40+1];					/* �����J�i */
    short	TDACi_name_kana;

    char	TDAC_business_division[2+1];			/* �Ɩ��敪 */
    short	TDACi_business_division;

    char	TDAC_center_id[4+1];					/* �Z���^ID */
    short	TDACi_center_id;

    varchar	TDAC_registration_date[16+1];			/* �o�^�� */
    short	TDACi_registration_date;

    char	TDAC_registrant[8+1];					/* �o�^�� */
    short	TDACi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
