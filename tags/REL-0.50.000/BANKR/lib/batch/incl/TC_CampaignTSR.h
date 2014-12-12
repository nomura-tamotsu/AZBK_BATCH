/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* Description      : TC_キャンペーンTSR                                    */
/*                                                                          */
/* File Name        :TC_CampaignTSR.h                                       */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 2006/12/26 | Toll-Irie         | First Edition.                    */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    char         TCCT_center_id[4+1];       /* センタID */
    short       TCCTi_center_id;
    char         TCCT_campaign_id[4+1];     /* キャンペーンID */
    short       TCCTi_campaign_id;
    char         TCCT_tsr_id[8+1];      /* TSRID */
    short       TCCTi_tsr_id;
    char         TCCT_contact_person_division[1+1];     /* 担当区分 */
    short       TCCTi_contact_person_division;
    varchar      TCCT_group_name[32+1];     /* グループ名 */
    short       TCCTi_group_name;
    varchar      TCCT_call_data_name[32+1];     /* コールデータ名 */
    short       TCCTi_call_data_name;
    int      TCCT_number_of_allocation;     /* 配分件数 */
    short       TCCTi_number_of_allocation;
    int      TCCT_number_of_conduct;        /* 消化件数 */
    short       TCCTi_number_of_conduct;
    char         TCCT_representative_division[1+1];     /* 代表者区分 */
    short       TCCTi_representative_division;
    varchar      TCCT_last_call_date[16+1];     /* 最終呼出し日時 */
    short       TCCTi_last_call_date;
    varchar      TCCT_registration_date[16+1];      /* 登録日 */
    short       TCCTi_registration_date;
    char         TCCT_registrant[8+1];      /* 登録者 */
    short       TCCTi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
