/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : zXgÏ(TFB_eo_ñ®«)     TFB_????         */
/*                                                                          */
/* MODULE NAME      : TFB_ContractAttribute.h                               */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/10 | ISID        | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;
  
		char             TFB_contractant_no[10+1];              /* _ñÒÔ */
        short           TFBi_contractant_no;
        char             TFB_branch_number[5+1];                /* XÔ */
        short           TFBi_branch_number;
        char             TFB_cif_number[10+1];          /* CIFNO */
        short           TFBi_cif_number;
        char             TFB_tb_appli_branch[5+1];      /* TB\X */
        short           TFBi_tb_appli_branch;
        varchar          TFB_name_kanji[80+1];          /* ¼¿ */
        short           TFBi_name_kanji;
        varchar          TFB_name_kana[80+1];           /* ¼Ji */
        short           TFBi_name_kana;
        char             TFB_sex[1+1];          /* «Ê */
        short           TFBi_sex;
        char             TFB_birth_date[8+1];           /* ¶Nú */
        short           TFBi_birth_date;
        char             TFB_address_code[15+1];                /* ZR[h */
        short           TFBi_address_code;
        char             TFB_zip_code[10+1];            /* XÖÔ */
        short           TFBi_zip_code;
        varchar          TFB_sub_address[70+1];         /* âZ */
        short           TFBi_sub_address;
        varchar          TFB_sub_address_kana[70+1];    /* âZJi */
        short           TFBi_sub_address_kana;
        char             TFB_home_phone_number[15+1];           /* ©îdbÔ */
        short           TFBi_home_phone_number;
        char             TFB_contac_phone_number[15+1];         /* úAædbÔ */
        short           TFBi_contac_phone_number;
        char             TFB_application_date[8+1];             /* \ú */
        short           TFBi_application_date;
        char             TFB_contract_date[8+1];                /* _ñú */
        short           TFBi_contract_date;
        char             TFB_cancel_date[8+1];                  /* _ñðú */
        short           TFBi_cancel_date;
        char             TFB_preferential_class[1+1];                   /* è¿Döæª */
        short           TFBi_preferential_class;
        double           TFB_furikae_limit_amount_once;         /* UÖÀxz1ñ */
        short           TFBi_TFB_furikae_limit_amount_once;
        double           TFB_furikae_limit_amount_day;          /* UÖÀxz1ú */
        short           TFBi_TFB_furikae_limit_amount_day;
        double           TFB_transfer_prelimit_amount_once;             /* OUÀxz1ñ */
        short           TFBi_transfer_prelimit_amount_once;
        double           TFB_transfer_prelimit_amount_day;              /* OUÀxz1ú */
        short           TFBi_transfer_prelimit_amount_day;
        double           TFB_transfer_limit_amount_once;                /* sxUÀxz1ñ */
        short           TFBi_transfer_limit_amount_once;
        double           TFB_transfer_limit_amount_day;                 /* sxUÀxz1ú */
        short           TFBi_transfer_limit_amount_day;
        char             TFB_pin_number[12+1];          /* ÃØÔ */
        short           TFBi_pin_number;
        char             TFB_pin_change_date[8+1];              /* ÃØÏXú */
        short           TFBi_pin_change_date;
        int              TFB_pin_number_input_count;                /* ÃØÔüÍñ */
        short           TFBi_pin_number_input_count;
        varchar          TFB_pin_wrong_date[32+1];              /* ÃØÔëüÍú */
        short           TFBi_pin_wrong_date;
        char             TFB_pin_number_lock[1+1];              /* ÃØÔbN */
        short           TFBi_pin_number_lock;
        varchar          TFB_pin_number_lock_date[32+1];        /* ÃØÔbNú */
        short           TFBi_pin_number_lock_date;
        char             TFB_accident[1+1];             /* ÌÍ */
        short           TFBi_accident;
        char             TFB_accident_id[4+1];          /* ÌÝèID */
        short           TFBi_accident_id;
        varchar          TFB_accident_date[32+1];       /* ÌÝèú */
        short           TFBi_accident_date;
        varchar          TFB_accident_canceldate[32+1]; /* ÌÝèðú */
        short           TFBi_accident_canceldate;
        char             TFB_accident_set[8+1];         /* ÌÝèÒ */
        short           TFBi_accident_set;
        varchar          TFB_recognition_date[32+1];    /* ³Fú */
        short           TFBi_recognition_date;
        char             TFB_recognition[8+1];          /* ³FÒ */
        short           TFBi_recognition;
        varchar          TFB_registration_date[32+1];           /* o^ú */
        short           TFBi_registration_date;
        char             TFB_registrant[8+1];           /* o^Ò */
        short           TFBi_registrant;
        char             TFB_processing_class[8+1];             /* æª */
        short           TFBi_processing_class;
        char             TFB_standard_date[8+1];                /* f[^îú */
        short           TFBi_standard_date;
        char           TFB_last_update_date[32+1];            /* ÅIXVú */
        short           TFBi_last_update_date;
        char             TFB_last_update[8+1];          /* ÅIXVÒ */
        short           TFBi_last_update;
        char             TFB_center_id[4+1];            /* Z^[ID */
        short           TFBi_center_id;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
