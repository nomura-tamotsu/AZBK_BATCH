/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC                                           */
/*                                                                          */
/* Description      : TS_�Ώۃt�@�C�����                                   */
/*                                                                          */
/* File Name        :TS_TargetFileInfo.h                                    */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 2006/12/26 | Toll-Irie         | First Edition.                    */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    varchar      TSTF_target_file_name[32+1];       /* �Ώۃt�@�C���� */
    short       TSTFi_target_file_name;
    varchar      TSTF_file_name_for_indication[32+1];       /* �\���p�t�@�C���� */
    short       TSTFi_file_name_for_indication;
    varchar      TSTF_proviso_name[48+1];       /* ������ */
    short       TSTFi_proviso_name;
    varchar      TSTF_parent_target_file_name[32+1];        /* �e�Ώۃt�@�C���� */
    short       TSTFi_parent_target_file_name;
    varchar      TSTF_tm_file_name[32+1];       /* TM�t�@�C���� */
    short       TSTFi_tm_file_name;
    varchar      TSTF_creation_date[16+1];      /* �쐬���t */
    short       TSTFi_creation_date;
    char         TSTF_data_division[1+1];       /* �f�[�^�敪 */
    short       TSTFi_data_division;
    varchar      TSTF_memo1[34+1];      /* ����1 */
    short       TSTFi_memo1;
    varchar      TSTF_memo2[34+1];      /* ����2 */
    short       TSTFi_memo2;
    varchar      TSTF_memo3[34+1];      /* ����3 */
    short       TSTFi_memo3;
    varchar      TSTF_memo4[34+1];      /* ����4 */
    short       TSTFi_memo4;
    char         TSTF_campaign_flag[1+1];       /* �L�����y�[���t���O */
    short       TSTFi_campaign_flag;
    int      TSTF_record_count;     /* ���R�[�h�� */
    short       TSTFi_record_count;
    int      TSTF_target_household_count;       /* �Ώې��ѐ� */
    short       TSTFi_target_household_count;
    char         TSTF_table_division[1+1];      /* �e�[�u���敪 */
    short       TSTFi_table_division;
    char         TSTF_search_division[1+1];     /* �����敪 */
    short       TSTFi_search_division;
    char         TSTF_maturity_flag[1+1];       /* �����t���O */
    short       TSTFi_maturity_flag;
    char         TSTF_external_flag[1+1];       /* �O���t���O */
    short       TSTFi_external_flag;
    char         TSTF_base_proviso_setting[1+1];        /* ��{�����ݒ� */
    short       TSTFi_base_proviso_setting;
    varchar      TSTF_maturity_start_date[16+1];        /* �����J�n�� */
    short       TSTFi_maturity_start_date;
    varchar      TSTF_maturity_end_date[16+1];      /* �����I���� */
    short       TSTFi_maturity_end_date;
    char         TSTF_former_file_division[1+1];        /* ���t�@�C���敪 */
    short       TSTFi_former_file_division;
    char         TSTF_extraction_division[1+1];     /* ���o�敪 */
    short       TSTFi_extraction_division;
    char         TSTF_center_id[4+1];       /* �Z���^ID */
    short       TSTFi_center_id;
    char         TSTF_delete_flag[1+1];     /* �폜�t���O */
    short       TSTFi_delete_flag;
    varchar      TSTF_registration_date[16+1];      /* �o�^�� */
    short       TSTFi_registration_date;
    char         TSTF_registrant[8+1];      /* �o�^�� */
    short       TSTFi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
