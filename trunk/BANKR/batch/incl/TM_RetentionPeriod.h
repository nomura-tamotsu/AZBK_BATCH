/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* Description      : TM_保存期間                                           */
/*                                                                          */
/* File Name        : TM_RetentionPeriod.h                                  */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/05/01 | ISID        | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    varchar      TMRP_table_name[32+1];     /* テーブル名*/
    short       TMRPi_table_name;
    int      TMRP_retention_period;     /* 保存期間*/
    short       TMRPi_retention_period;
    varchar      TMRP_retention_period_baseline_column_name[32+1];      /* 保存期間基準カラム名*/
    short       TMRPi_retention_period_baseline_column_name;
    char         TMRP_instance_division[1+1];       /* インスタンス区分*/
    short       TMRPi_instance_division;
    varchar      TMRP_registration_date[16+1];      /* 登録日*/
    short       TMRPi_registration_date;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/