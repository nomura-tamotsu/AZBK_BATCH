/*==========================================================================*/
/* COPYRIGHT Brainyworks LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM               : Marketbrain                                       */
/*                                                                          */
/* PROGRAM NAME         : �e�[�u���ϐ�                                      */
/*                                                                          */
/*                        TM_�����ύX                   TMAC_????          */
/*                                                                          */
/* MODULE NAME          : TM_AttributeChange.h                              */
/*                                                                          */
/* ENTRY POINT          :                                                   */
/*                                                                          */
/* Mod   yyyy/mm/dd   Coder               Comment                           */
/*-----+------------+-------------------+-----------------------------------*/
/* %00 | 2007/01/09 | Toll-Irie         | First Edition.                    */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    char         TMAC_attribute_id[4+1];        /* ����ID */
    short       TMACi_attribute_id;
    varchar      TMAC_attribute_name[32+1];     /* ������ */
    short       TMACi_attribute_name;
    char         TMAC_output_check_flag[1+1];       /* �o�͗}���t���O */
    short       TMACi_output_check_flag;
    char         TMAC_tb_check_flag[1+1];       /* TB�}���t���O */
    short       TMACi_tb_check_flag;
    char         TMAC_each_authority_use_division[1+1];     /* �����ʎg�p�敪 */
    short       TMACi_each_authority_use_division;
    varchar      TMAC_registration_date[16+1];      /* �o�^�� */
    short       TMACi_registration_date;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
