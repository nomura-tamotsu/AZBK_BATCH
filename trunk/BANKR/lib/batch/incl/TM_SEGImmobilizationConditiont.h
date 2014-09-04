/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : ホスト変数(TM_SEG固定条件)        TMSE_????           */
/*                                                                          */
/* MODULE NAME      : TM_SEGImmobilizationConditiont.h                      */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/09 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TMSE_data_division[1+1];		/* データ区分 */
	short	TMSEi_data_division;

	int		TMSE_sequence;					/* SEQ */
	short	TMSEi_sequence;

	varchar	TMSE_condition_equation[256+1];	/* 条件式 */
	short	TMSEi_condition_equation;

	varchar	TMSE_display_column_name[32+1];	/* 表示カラム名 */
	short	TMSEi_display_column_name;

	char	TMSE_registration_date[16+1];	/* 登録日 */
	short	TMSEi_registration_date;

	char	TMSE_registrant[8+1];			/* 登録者 */
	short	TMSEi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
