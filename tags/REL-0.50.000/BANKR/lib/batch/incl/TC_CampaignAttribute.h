/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* Description      : TC_キャンペーン属性                                   */
/*                                                                          */
/* File Name        : TC_CampaignAttribute.h                                */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/04 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TCCA_center_id[4+1];					/* センタID */
	short	TCCAi_center_id;

	char	TCCA_campaign_id[4+1];					/* キャンペーンID */
	short	TCCAi_campaign_id;

	varchar	TCCA_campaign_name[32+1];				/* キャンペーン名 */
	short	TCCAi_campaign_name;

	char	TCCA_campaign_abbreviation[16+1];		/* キャンペーン略称 */
	short	TCCAi_campaign_abbreviation;

	varchar	TCCA_campaign_start_date[16+1];			/* キャンペーン開始日 */
	short	TCCAi_campaign_start_date;

	varchar	TCCA_campaign_end_date[16+1];			/* キャンペーン終了日 */
	short	TCCAi_campaign_end_date;

	char	TCCA_campaign_type[1+1];				/* キャンペーンス種類 */
	short	TCCAi_campaign_type;

	char	TCCA_campaign_status[1+1];				/* キャンペーンステータス */
	short	TCCAi_campaign_status;

	varchar	TCCA_campaign_registration_date[16+1];	/* キャンペーン登録日 */
	short	TCCAi_campaign_registration_date;

	char	TCCA_campaign_series_id[2+1];			/* キャンペーンシリーズID */
	short	TCCAi_campaign_series_id;

	varchar	TCCA_target_file_name[32+1];			/* 対象ファイル名 */
	short	TCCAi_target_file_name;

	int	TCCA_number_of_allocation;					/* 配分件数 */
	short	TCCAi_number_of_allocation;

	char	TCCA_allocation_division[1+1];			/* 配分区分 */
	short	TCCAi_allocation_division;

	char	TCCA_maturity_flag[1+1];				/* 満期フラグ */
	short	TCCAi_maturity_flag;

	char	TCCA_external_flag[1+1];				/* 外部フラグ */
	short	TCCAi_external_flag;

	char	TCCA_delete_flag[1+1];					/* 削除フラグ */
	short	TCCAi_delete_flag;

	varchar	TCCA_information1[132+1];				/* 情報1 */
	short	TCCAi_information1;

	varchar	TCCA_information2[132+1];				/* 情報2 */
	short	TCCAi_information2;

	varchar	TCCA_information3[132+1];				/* 情報3 */
	short	TCCAi_information3;

	varchar	TCCA_information4[132+1];				/* 情報4 */
	short	TCCAi_information4;

	varchar	TCCA_information5[132+1];				/* 情報5 */
	short	TCCAi_information5;

	varchar	TCCA_registration_date[16+1];			/* 登録日 */
	short	TCCAi_registration_date;

	char	TCCA_registrant[8+1];					/* 登録者 */
	short	TCCAi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
