/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : ホスト変数(TS_抽出条件)           TSEC_????           */
/*                                                                          */
/* MODULE NAME      : TS_ExtractionCondition.h                              */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/09 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	varchar	TSEC_condition_name[48+1];					/* 条件名 */
	short	TSECi_condition_name;

	char	TSEC_condition_type[1+1];					/* 条件種別 */
	short	TSECi_condition_type;

	int		TSEC_sequence_number;						/* SEQNO */
	short	TSECi_sequence_number;

	varchar	TSEC_condition[512+1];						/* 条件 */
	short	TSECi_condition;

	char	TSEC_condition_value[24+1];					/* 条件値 */
	short	TSECi_condition_value;

	varchar	TSEC_class_name[512+1];						/* クラス名 */
	short	TSECi_class_name;

	char	TSEC_control_id[3+1];						/* コントロールID */
	short	TSECi_control_id;

	int		TSEC_index_number;							/* インデックスNO */
	short	TSECi_index_number;

	char	TSEC_retention_division[1+1];				/* 登録区分 */
	short	TSECi_retention_division;

	varchar	TSEC_item[62+1];							/* 項目 */
	short	TSECi_item;

	varchar	TSEC_value[400+1];							/* 値 */
	short	TSECi_value;

	char	TSEC_operator[4+1];							/* 演算子 */
	short	TSECi_operator;

	varchar	TSEC_registration_date[16+1];				/* 登録日 */
	short	TSECi_registration_date;

	varchar	TSEC_registrant[8+1];						/* 登録者 */
	short	TSECi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
