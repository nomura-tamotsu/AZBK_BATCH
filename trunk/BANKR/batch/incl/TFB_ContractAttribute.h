/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : ホスト変数(TFB_テレバン契約属性)     TFB_????         */
/*                                                                          */
/* MODULE NAME      : TFB_ContractAttribute.h                               */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/10 | ISID        | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;
  
		char             TFB_contractant_no[10+1];              /* 契約者番号 */
        short           TFBi_contractant_no;
        char             TFB_branch_number[5+1];                /* 店番 */
        short           TFBi_branch_number;
        char             TFB_cif_number[10+1];          /* CIFNO */
        short           TFBi_cif_number;
        char             TFB_tb_appli_branch[5+1];      /* TB申込店 */
        short           TFBi_tb_appli_branch;
        varchar          TFB_name_kanji[80+1];          /* 氏名漢字 */
        short           TFBi_name_kanji;
        varchar          TFB_name_kana[80+1];           /* 氏名カナ */
        short           TFBi_name_kana;
        char             TFB_sex[1+1];          /* 性別 */
        short           TFBi_sex;
        char             TFB_birth_date[8+1];           /* 生年月日 */
        short           TFBi_birth_date;
        char             TFB_address_code[15+1];                /* 住所コード */
        short           TFBi_address_code;
        char             TFB_zip_code[10+1];            /* 郵便番号 */
        short           TFBi_zip_code;
        varchar          TFB_sub_address[70+1];         /* 補助住所 */
        short           TFBi_sub_address;
        varchar          TFB_sub_address_kana[70+1];    /* 補助住所カナ */
        short           TFBi_sub_address_kana;
        char             TFB_home_phone_number[15+1];           /* 自宅電話番号 */
        short           TFBi_home_phone_number;
        char             TFB_contac_phone_number[15+1];         /* 日中連絡先電話番号 */
        short           TFBi_contac_phone_number;
        char             TFB_application_date[8+1];             /* 申込日 */
        short           TFBi_application_date;
        char             TFB_contract_date[8+1];                /* 契約日 */
        short           TFBi_contract_date;
        char             TFB_cancel_date[8+1];                  /* 契約解除日 */
        short           TFBi_cancel_date;
        char             TFB_preferential_class[1+1];                   /* 手数料優遇区分 */
        short           TFBi_preferential_class;
        double           TFB_furikae_limit_amount_once;         /* 振替限度額1回 */
        short           TFBi_TFB_furikae_limit_amount_once;
        double           TFB_furikae_limit_amount_day;          /* 振替限度額1日 */
        short           TFBi_TFB_furikae_limit_amount_day;
        double           TFB_transfer_prelimit_amount_once;             /* 事前振込限度額1回 */
        short           TFBi_transfer_prelimit_amount_once;
        double           TFB_transfer_prelimit_amount_day;              /* 事前振込限度額1日 */
        short           TFBi_transfer_prelimit_amount_day;
        double           TFB_transfer_limit_amount_once;                /* 都度振込限度額1回 */
        short           TFBi_transfer_limit_amount_once;
        double           TFB_transfer_limit_amount_day;                 /* 都度振込限度額1日 */
        short           TFBi_transfer_limit_amount_day;
        char             TFB_pin_number[12+1];          /* 暗証番号 */
        short           TFBi_pin_number;
        char             TFB_pin_change_date[8+1];              /* 暗証変更日 */
        short           TFBi_pin_change_date;
        int              TFB_pin_number_input_count;                /* 暗証番号入力回数 */
        short           TFBi_pin_number_input_count;
        varchar          TFB_pin_wrong_date[32+1];              /* 暗証番号誤入力日時 */
        short           TFBi_pin_wrong_date;
        char             TFB_pin_number_lock[1+1];              /* 暗証番号ロック */
        short           TFBi_pin_number_lock;
        varchar          TFB_pin_number_lock_date[32+1];        /* 暗証番号ロック日時 */
        short           TFBi_pin_number_lock_date;
        char             TFB_accident[1+1];             /* 事故届 */
        short           TFBi_accident;
        char             TFB_accident_id[4+1];          /* 事故設定ID */
        short           TFBi_accident_id;
        varchar          TFB_accident_date[32+1];       /* 事故設定日時 */
        short           TFBi_accident_date;
        varchar          TFB_accident_canceldate[32+1]; /* 事故設定解除日時 */
        short           TFBi_accident_canceldate;
        char             TFB_accident_set[8+1];         /* 事故設定者 */
        short           TFBi_accident_set;
        varchar          TFB_recognition_date[32+1];    /* 承認日 */
        short           TFBi_recognition_date;
        char             TFB_recognition[8+1];          /* 承認者 */
        short           TFBi_recognition;
        varchar          TFB_registration_date[32+1];           /* 登録日 */
        short           TFBi_registration_date;
        char             TFB_registrant[8+1];           /* 登録者 */
        short           TFBi_registrant;
        char             TFB_processing_class[8+1];             /* 処理区分 */
        short           TFBi_processing_class;
        char             TFB_standard_date[8+1];                /* データ基準日 */
        short           TFBi_standard_date;
        char           TFB_last_update_date[32+1];            /* 最終更新日 */
        short           TFBi_last_update_date;
        char             TFB_last_update[8+1];          /* 最終更新者 */
        short           TFBi_last_update;
        char             TFB_center_id[4+1];            /* センターID */
        short           TFBi_center_id;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
