/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : ホスト変数(TC_キャンペーン顧客)     TCCC_????         */
/*                                                                          */
/* MODULE NAME      : TC_CampaignCustomer.h                                 */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/12 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TCCC_center_id[4+1];					/* センタID */
	short	TCCCi_center_id;

	char	TCCC_campaign_id[4+1];					/* キャンペーンID */
	short	TCCCi_campaign_id;

	char	TCCC_branch_number[5+1];				/* 店番 */
	short	TCCCi_branch_number;

	char	TCCC_cif_number[10+1];					/* CIFNO */
	short	TCCCi_cif_number;

	varchar	TCCC_call_data_name[32+1];				/* コールデータ名 */
	short	TCCCi_call_data_name;

	varchar	TCCC_registration_date[16+1];			/* 登録日 */
	short	TCCCi_registration_date;

	char	TCCC_registrant[8+1];					/* 登録者 */
	short	TCCCi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
