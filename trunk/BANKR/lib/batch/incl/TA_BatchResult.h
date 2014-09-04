/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : ホスト変数(TA_バッチ処理結果)     TABR_????           */
/*                                                                          */
/* MODULE NAME      : TA_BatchResult.h                                      */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/05/25 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TABR_processing_start_date[14+1];	/* 処理開始日時 */
	short	TABRi_processing_start_date;

	char	TABR_processing_end_date[14+1];		/* 処理終了日時 */
	short	TABRi_processing_end_date;

	varchar	TABR_task_name[30+1];				/* タスク名 */
	short	TABRi_task_name;

	char	TABR_processing_division[1+1];		/* 処理区分 */
	short	TABRi_processing_division;

	char	TABR_cycle[1+1];					/* サイクル */
	short	TABRi_cycle;

	int		TABR_data_count;					/* データ件数 */
	short	TABRi_data_count;

	int		TABR_success_count;					/* 正常件数 */
	short	TABRi_success_count;

	int		TABR_error_count;					/* エラー件数 */
	short	TABRi_error_count;

	char	TABR_status[1+1];					/* ステータス */
	short	TABRi_status;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
