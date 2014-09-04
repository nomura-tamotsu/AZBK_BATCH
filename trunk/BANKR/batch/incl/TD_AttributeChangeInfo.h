/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : ホスト変数(TD_属性変更情報)     TDAC_????             */
/*                                                                          */
/* MODULE NAME      : TD_AttributeChangeInfo.h                              */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/07/02 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    char	TDAC_branch_number[5+1];				/* 店番 */
    short	TDACi_branch_number;

    char	TDAC_cif_number[10+1];					/* CIFNO */
    short	TDACi_cif_number;

    char	TDAC_contractant_number[10+1];			/* 契約者番号 */
    short	TDACi_contractant_number;

    char	TDAC_attribute_id[4+1];					/* 属性ID */
    short	TDACi_attribute_id;

    char	TDAC_household_number[13+1];			/* 世帯番号 */
    short	TDACi_household_number;

    varchar	TDAC_batch_change_before[400+1];		/* バッチ用変更前 */
    short	TDACi_batch_change_before;

    varchar	TDAC_change_after1[144+1];				/* 変更後1 */
    short	TDACi_change_after1;

    varchar	TDAC_change_after2[144+1];				/* 変更後2 */
    short	TDACi_change_after2;

    varchar	TDAC_change_after3[144+1];				/* 変更後3 */
    short	TDACi_change_after3;

    varchar	TDAC_change_after4[144+1];				/* 変更後4 */
    short	TDACi_change_after4;

    varchar	TDAC_change_before1[144+1];				/* 変更前1 */
    short	TDACi_change_before1;

    varchar	TDAC_change_before2[144+1];				/* 変更前2 */
    short	TDACi_change_before2;

    varchar	TDAC_change_before3[144+1];				/* 変更前3 */
    short	TDACi_change_before3;

    varchar	TDAC_change_before4[144+1];				/* 変更前4 */
    short	TDACi_change_before4;

    char	TDAC_address_code_change_before[15+1];	/* 変更前住所コード */
    short	TDACi_address_code_change_before;

    char	TDAC_negotiating_partner[4+1];			/* 交渉相手 */
    short	TDACi_negotiating_partner;

    varchar	TDAC_name_kanji[40+1];					/* 氏名漢字 */
    short	TDACi_name_kanji;

    varchar	TDAC_name_kana[40+1];					/* 氏名カナ */
    short	TDACi_name_kana;

    char	TDAC_business_division[2+1];			/* 業務区分 */
    short	TDACi_business_division;

    char	TDAC_center_id[4+1];					/* センタID */
    short	TDACi_center_id;

    varchar	TDAC_registration_date[16+1];			/* 登録日 */
    short	TDACi_registration_date;

    char	TDAC_registrant[8+1];					/* 登録者 */
    short	TDACi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
