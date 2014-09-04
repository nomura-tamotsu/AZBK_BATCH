/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : ホスト変数(TS_タスク管理)         TSTM_????           */
/*                                                                          */
/* MODULE NAME      : TS_TaskManagement.h                                   */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/09 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TSTM_cycle[1+1];							/* サイクル */
	short	TSTMi_cycle;

	char	TSTM_processing_division[1+1];				/* 処理区分 */
	short	TSTMi_processing_division;

	varchar	TSTM_task_name[48+1];						/* タスク名 */
	short	TSTMi_task_name;

	int		TSTM_processing_time;						/* 処理時間 */
	short	TSTMi_processing_time;

	varchar	TSTM_application_start_date[16+1];			/* 適用開始日 */
	short	TSTMi_application_start_date;

	varchar	TSTM_application_end_date[16+1];			/* 適用終了日 */
	short	TSTMi_application_end_date;

	char	TSTM_temporary_reservation_division[1+1];	/* 一時保留区分 */
	short	TSTMi_temporary_reservation_division;

	char	TSTM_center_id[4+1];						/* センタID */
	short	TSTMi_center_id;

	char	TSTM_campaign_id[4+1];						/* キャンペーンID */
	short	TSTMi_campaign_id;

	varchar	TSTM_target_file_name[30+1];				/* 対象ファイル名 */
	short	TSTMi_target_file_name;

	varchar	TSTM_parent_target_file_name[32+1];			/* 親対象ファイル名 */
	short	TSTMi_parent_target_file_name;

	char	TSTM_former_file_division[1+1];				/* 元ファイル区分 */
	short	TSTMi_former_file_division;

	char	TSTM_data_division[1+1];					/* データ区分 */
	short	TSTMi_data_division;

	varchar	TSTM_condition_name[48+1];					/* 条件名 */
	short	TSTMi_condition_name;

	varchar	TSTM_memo1[34+1];							/* メモ１ */
	short	TSTMi_memo1;

	varchar	TSTM_memo2[34+1];							/* メモ２ */
	short	TSTMi_memo2;

	varchar	TSTM_memo3[34+1];							/* メモ３ */
	short	TSTMi_memo3;

	varchar	TSTM_memo4[34+1];							/* メモ４ */
	short	TSTMi_memo4;

	char	TSTM_cmp_object_person_exclusion[1+1];		/* CMP対象者除外 */
	short	TSTMi_cmp_object_person_exclusion;

	char	TSTM_retention_period[1+1];					/* 保有期間 */
	short	TSTMi_retention_period;

	varchar	TSTM_registration_date[16+1];				/* 登録日 */
	short	TSTMi_registration_date;

	varchar	TSTM_registrant[8+1];						/* 登録者 */
	short	TSTMi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
