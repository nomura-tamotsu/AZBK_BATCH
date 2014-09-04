/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC                                           */
/*                                                                          */
/* Description      : TC_�L�����y�[��TSR                                    */
/*                                                                          */
/* File Name        :TC_CampaignTSR.h                                       */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 2006/12/26 | Toll-Irie         | First Edition.                    */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    char         TCCT_center_id[4+1];       /* �Z���^ID */
    short       TCCTi_center_id;
    char         TCCT_campaign_id[4+1];     /* �L�����y�[��ID */
    short       TCCTi_campaign_id;
    char         TCCT_tsr_id[8+1];      /* TSRID */
    short       TCCTi_tsr_id;
    char         TCCT_contact_person_division[1+1];     /* �S���敪 */
    short       TCCTi_contact_person_division;
    varchar      TCCT_group_name[32+1];     /* �O���[�v�� */
    short       TCCTi_group_name;
    varchar      TCCT_call_data_name[32+1];     /* �R�[���f�[�^�� */
    short       TCCTi_call_data_name;
    int      TCCT_number_of_allocation;     /* �z������ */
    short       TCCTi_number_of_allocation;
    int      TCCT_number_of_conduct;        /* �������� */
    short       TCCTi_number_of_conduct;
    char         TCCT_representative_division[1+1];     /* ��\�ҋ敪 */
    short       TCCTi_representative_division;
    varchar      TCCT_last_call_date[16+1];     /* �ŏI�ďo������ */
    short       TCCTi_last_call_date;
    varchar      TCCT_registration_date[16+1];      /* �o�^�� */
    short       TCCTi_registration_date;
    char         TCCT_registrant[8+1];      /* �o�^�� */
    short       TCCTi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
