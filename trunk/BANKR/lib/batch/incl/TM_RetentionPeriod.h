/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC                                           */
/*                                                                          */
/* Description      : TM_�ۑ�����                                           */
/*                                                                          */
/* File Name        : TM_RetentionPeriod.h                                  */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/05/01 | ISID        | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    varchar      TMRP_table_name[32+1];     /* �e�[�u����*/
    short       TMRPi_table_name;
    int      TMRP_retention_period;     /* �ۑ�����*/
    short       TMRPi_retention_period;
    varchar      TMRP_retention_period_baseline_column_name[32+1];      /* �ۑ����Ԋ�J������*/
    short       TMRPi_retention_period_baseline_column_name;
    char         TMRP_instance_division[1+1];       /* �C���X�^���X�敪*/
    short       TMRPi_instance_division;
    varchar      TMRP_registration_date[16+1];      /* �o�^��*/
    short       TMRPi_registration_date;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/