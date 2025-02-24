/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : zXgÏ(TM_SEGÅèð)        TMSE_????           */
/*                                                                          */
/* MODULE NAME      : TM_SEGImmobilizationConditiont.h                      */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/09 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TMSE_data_division[1+1];		/* f[^æª */
	short	TMSEi_data_division;

	int		TMSE_sequence;					/* SEQ */
	short	TMSEi_sequence;

	varchar	TMSE_condition_equation[256+1];	/* ð® */
	short	TMSEi_condition_equation;

	varchar	TMSE_display_column_name[32+1];	/* \¦J¼ */
	short	TMSEi_display_column_name;

	char	TMSE_registration_date[16+1];	/* o^ú */
	short	TMSEi_registration_date;

	char	TMSE_registrant[8+1];			/* o^Ò */
	short	TMSEi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
