/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : zXgÏ(TS_oð)           TSEC_????           */
/*                                                                          */
/* MODULE NAME      : TS_ExtractionCondition.h                              */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/09 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	varchar	TSEC_condition_name[48+1];					/* ð¼ */
	short	TSECi_condition_name;

	char	TSEC_condition_type[1+1];					/* ðíÊ */
	short	TSECi_condition_type;

	int		TSEC_sequence_number;						/* SEQNO */
	short	TSECi_sequence_number;

	varchar	TSEC_condition[512+1];						/* ð */
	short	TSECi_condition;

	char	TSEC_condition_value[24+1];					/* ðl */
	short	TSECi_condition_value;

	varchar	TSEC_class_name[512+1];						/* NX¼ */
	short	TSECi_class_name;

	char	TSEC_control_id[3+1];						/* Rg[ID */
	short	TSECi_control_id;

	int		TSEC_index_number;							/* CfbNXNO */
	short	TSECi_index_number;

	char	TSEC_retention_division[1+1];				/* o^æª */
	short	TSECi_retention_division;

	varchar	TSEC_item[62+1];							/* Ú */
	short	TSECi_item;

	varchar	TSEC_value[400+1];							/* l */
	short	TSECi_value;

	char	TSEC_operator[4+1];							/* Zq */
	short	TSECi_operator;

	varchar	TSEC_registration_date[16+1];				/* o^ú */
	short	TSECi_registration_date;

	varchar	TSEC_registrant[8+1];						/* o^Ò */
	short	TSECi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
