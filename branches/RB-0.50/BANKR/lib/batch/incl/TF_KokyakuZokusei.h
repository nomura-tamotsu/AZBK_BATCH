/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* Description      : 顧客属性テーブル                                      */
/*                                                                          */
/* File Name        : TF_KokyakuZokusei.h                                   */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/04/08 | ISID        | First Edition.                            */
/*==========================================================================*/
EXEC SQL BEGIN DECLARE SECTION;
    /* 店番 */
    char        TMKZs_tenban[5+1];
    short       TMKZsi_tenban;

    /* CIFNO */
    char        TMKZs_cifno[10+1];
    short       TMKZsi_cifno;

    /* 個人企業番号 */
    char        TMKZs_kojin_kigyo_no[13+1];
    short       TMKZsi_kojin_kigyo_no;

    /* 人格区分 */
    char        TMKZs_jinkaku_kbn[1+1];
    short       TMKZsi_jinkaku_kbn;

    /* 世帯番号 */
    char        TMKZs_setai_no[13+1];
    short       TMKZsi_setai_no;

    /* 氏名漢字 */
    /*struct { short len; char arr[80+1]; }
                TMKZs_name_knj;*/
	varchar		TMKZs_name_knj[80+1];
    short       TMKZsi_name_knj;

    /* 氏名漢字更新フラグ */
    char        TMKZs_name_knj_flg[1+1];
    short       TMKZsi_name_knj_flg;

    /* 氏名カナ */
    /*struct { short len; char arr[80+1]; }
                TMKZs_name_kna;*/
	varchar		TMKZs_name_kna[80+1];
    short       TMKZsi_name_kna;

    /* 氏名カナ更新フラグ */
    char        TMKZs_name_kna_flg[1+1];
    short       TMKZsi_name_kna_flg;

    /* 性別 */
    char        TMKZs_sex[1+1];
    short       TMKZsi_sex;

    /* 性別更新フラグ */
    char        TMKZs_sex_flg[1+1];
    short       TMKZsi_sex_flg;

    /* 生年月日 */
    char        TMKZs_birthday[8+1];
    short       TMKZsi_birthday;

    /* 生年月日更新フラグ */
    char        TMKZs_birthday_flg[1+1];
    short       TMKZsi_birthday_flg;

    /* 住所コード */
    char        TMKZs_zip_cd[15+1];
    short       TMKZsi_zip_cd;

    /* 郵便番号 */
    char        TMKZs_zip[10+1];
    short       TMKZsi_zip;

    /* 補助住所 */
    /*struct { short len; char arr[60+1]; }
                TMKZs_hojo_jyusyo;*/
	varchar		TMKZs_hojo_jyusyo[70+1];
    short       TMKZsi_hojo_jyusyo;

    /* 住所変更フラグ */
    char        TMKZs_addressflg[1+1];
    short       TMKZsi_addressflg;

/* %01 Add Start */
    /* 補助住所カナ */
    /*struct { short len; char arr[120+1]; }
                TMKZs_hojo_jyusyo_kana;*/
	varchar		TMKZs_hojo_jyusyo_kana[70+1];
    short       TMKZsi_hojo_jyusyo_kana;

    /* 住所カナ変更フラグ */
    char        TMKZs_address_kana_flg[1+1];
    short       TMKZsi_address_kana_flg;

/* %01 Add End */

    /* 自宅電話番号 */
    char        TMKZs_jitakutel[20+1];
    short       TMKZsi_jitakutel;

    /* 自宅電話番号更新フラグ */
    char        TMKZs_jitakutel_flg[1+1];
    short       TMKZsi_jitakutel_flg;

    /* 自宅FAX番号 */
    char        TMKZs_jitaku_fax[20+1];
    short       TMKZsi_jitaku_fax;

    /* 自宅FAX番号更新フラグ */
    char        TMKZs_jitaku_fax_flg[1+1];
    short       TMKZsi_jitaku_fax_flg;

    /* 携帯電話番号 */
    char        TMKZs_keitai_tel[20+1];
    short       TMKZsi_keitai_tel;

    /* 携帯電話番号更新フラグ */
    char        TMKZs_keitai_tel_flg[1+1];
    short       TMKZsi_keitai_tel_flg;

    /* MAILアドレス */
    /*struct { short len; char arr[50+1]; }
                TMKZs_mail;*/
	varchar		TMKZs_mail[50+1];
    short       TMKZsi_mail;

    /* MAILアドレス更新フラグ */
    char        TMKZs_mail_flg[1+1];
    short       TMKZsi_mail_flg;

    /* 勤務先名漢字 */
    /*struct { short len; char arr[80+1]; }
                TMKZs_kinmusaki;*/
	varchar		TMKZs_kinmusaki[80+1];
    short       TMKZsi_kinmusaki;

    /* 勤務先名漢字更新フラグ */
    char        TMKZs_kinmusaki_flg[1+1];
    short       TMKZsi_kinmusaki_flg;

    /* 勤務先名カナ */
    /*struct { short len; char arr[80+1]; }
                TMKZs_kinmusaki_kana;*/
	varchar		TMKZs_kinmusaki_kana[80+1];
    short       TMKZsi_kinmusaki_kana;

    /* 勤務先名カナ更新フラグ */
    char        TMKZs_kinmusaki_kana_flg[1+1];
    short       TMKZsi_kinmusaki_kana_flg;

    /* 勤務先電話番号 */
    char        TMKZs_kinmusaki_tel[20+1];
    short       TMKZsi_kinmusaki_tel;

    /* 勤務先電話番号更新フラグ */
    char        TMKZs_kinmusaki_tel_flg[1+1];
    short       TMKZsi_kinmusaki_tel_flg;

/* %01 Add Start */
    /* 連絡先住所コード */
    char        TMKZs_renrakusaki_zip_cd[15+1];
    short       TMKZsi_renrakusaki_zip_cd;

    /* 連絡先郵便番号 */
    char        TMKZs_renrakusaki_zip[10+1];
    short       TMKZsi_renrakusaki_zip;

    /* 連絡先補助住所 */
    /*struct { short len; char arr[60+1]; }
                TMKZs_renrakusaki_hojo_jyusyo;*/
	varchar		TMKZs_renrakusaki_hojo_jyusyo[60+1];
    short       TMKZsi_renrakusaki_hojo_jyusyo;

    /* 連絡先住所変更フラグ */
    char        TMKZs_renrakusaki_addressflg[1+1];
    short       TMKZsi_renrakusaki_addressflg;

    /* 連絡先補助住所カナ */
    /*struct { short len; char arr[120+1]; }
                TMKZs_renrakusaki_hojo_jyusyo_kana;*/
	varchar		TMKZs_renrakusaki_hojo_jyusyo_kana[120+1];
    short       TMKZsi_renrakusaki_hojo_jyusyo_kana;

    /* 連絡先住所変更フラグ */
    char        TMKZs_renrakusaki_address_kana_flg[1+1];
    short       TMKZsi_renrakusaki_address_kana_flg;
/* %01 Add End */

    /* 連絡先電話番号 */
    char        TMKZs_renrakusaki_tel[20+1];
    short       TMKZsi_renrakusaki_tel;

    /* 連絡先電話番号更新フラグ */
    char        TMKZs_renrakusaki_tel_flg[1+1];
    short       TMKZsi_renrakusaki_tel_flg;

    /* 連絡先FAX番号 */
    char        TMKZs_renrakusaki_fax[20+1];
    short       TMKZsi_renrakusaki_fax;

    /* 連絡先FAX番号更新フラグ */
    char        TMKZs_renrakusaki_fax_flg[1+1];
    short       TMKZsi_renrakusaki_fax_flg;

    /* 日中連絡先電話番号 */
    char        TMKZs_nicchu_tel[20+1];
    short       TMKZsi_nicchu_tel;

    /* 日中連絡先電話番号更新フラグ */
    char        TMKZs_nicchu_tel_flg[1+1];
    short       TMKZsi_nicchu_tel_flg;

    /* 行員区分 */
    char        TMKZs_kouin_kbn[1+1];
    short       TMKZsi_kouin_kbn;

    /* 郵便不着 */
    char        TMKZs_futyaku[1+1];
    short       TMKZsi_futyaku;

    /* 会社寮 */
    char        TMKZs_kaisya_ryo[1+1];
    short       TMKZsi_kaisya_ryo;

    /* 電話番号間違い */
    char        TMKZs_denwa_matigai[1+1];
    short       TMKZsi_denwa_matigai;

    /* 移転 */
    char        TMKZs_iten[1+1];
    short       TMKZsi_iten;

    /* 本人死亡 */
    char        TMKZs_honnin_sibo[1+1];
    short       TMKZsi_honnin_sibo;

    /* マル優申告額 */
    char        TMKZs_yu_shinkoku[20+1];
    short       TMKZsi_yu_shinkoku;

    /* マル優利用額 */
    char        TMKZs_yu_riyo[20+1];
    short       TMKZsi_yu_riyo;

    /* マル特申告額 */
    char        TMKZs_toku_shinkoku[20+1];
    short       TMKZsi_toku_shinkoku;

    /* マル特利用額 */
    char        TMKZs_toku_riyo[20+1];
    short       TMKZsi_toku_riyo;

    /* ホストTM対象区分 */
    char        TMKZs_host_tm[1+1];
    short       TMKZsi_host_tm;

    /* TM対象区分 */
    char        TMKZs_tm[1+1];
    short       TMKZsi_tm;

    /* ホストDM対象区分 */
    char        TMKZs_host_dm[1+1];
    short       TMKZsi_host_dm;

    /* DM対象区分 */
    char        TMKZs_dm[1+1];
    short       TMKZsi_dm;

/* %01 Add Start */
    /* 取引開始日 */
    char        TMKZs_deal_day[8+1];
    short       TMKZsi_deal_day;

    /* 世帯主フラグ */
    char        TMKZs_setai_flg[1+1];
    short       TMKZsi_setai_flg;

    /* 当行金融資産残高 */
    char        TMKZs_zandaka[16+1];
    short       TMKZsi_zandaka;

    /* 預り資産残高１ */
    char    TMKZs_azukari_shisan1[16+1];
    short   TMKZsi_azukari_shisan1;

    /* 預り資産残高２ */
    char    TMKZs_azukari_shisan2[16+1];
    short   TMKZsi_azukari_shisan2;

    /* 預り資産残高３ */
    char    TMKZs_azukari_shisan3[16+1];
    short   TMKZsi_azukari_shisan3;

    /* 流動性預金残高 */
    char    TMKZs_ryudo_zandaka[16+1];
    short   TMKZsi_ryudo_zandaka;

    /* 定期性預金残高 */
    char    TMKZs_teiki_zandaka[16+1];
    short   TMKZsi_teiki_zandaka;

    /* 仕組預金残高 */
    char    TMKZs_shikumi_zandaka[16+1];
    short   TMKZsi_shikumi_zandaka;

    /* 外貨預金残高 */
    char    TMKZs_gaika_zandaka[16+1];
    short   TMKZsi_gaika_zandaka;

    /* 投信残高 */
    char    TMKZs_toushin_zandaka[16+1];
    short   TMKZsi_toushin_zandaka;

    /* 債券残高 */
    char    TMKZs_saiken_zandaka[16+1];
    short   TMKZsi_saiken_zandaka;

    /* リスク商品残高 */
    char    TMKZs_risk_zandaka[16+1];
    short   TMKZsi_risk_zandaka;

    /* テレバン契約 */
    char    TMKZs_TB_contract[1+1];
    short   TMKZsi_TB_contract;

    /* テレバン契約日 */
    char    TMKZs_TB_contract_day[8+1];
    short   TMKZsi_TB_contract_day;

    /* IB契約 */
    char    TMKZs_IB_contract[1+1];
    short   TMKZsi_IB_contract;

    /* IB契約者ID */
    char    TMKZs_IB_contract_id[16+1];
    short   TMKZsi_IB_contract_id;

    /* IB契約申込店番 */
    char    TMKZs_IB_branch_id[3+1];
    short   TMKZsi_IB_branch_id;

    /* IB契約代表口座科目 */
    char    TMKZs_IB_accnt_id[4+1];
    short   TMKZsi_IB_accnt_id;

    /* IB契約代表口座口番号 */
    char    TMKZs_IB_kuchi_no[3+1];
    short   TMKZsi_IB_kuchi_no;

    /* IB契約日 */
    char    TMKZs_IB_contract_day[8+1];
    short   TMKZsi_IB_contract_day;

    /* IB契約解約日 */
    char    TMKZs_IB_cancel_day[8+1];
    short   TMKZsi_IB_cancel_day;

    /* IB契約最終更新日 */
    char    TMKZs_IB_update_day[8+1];
    short   TMKZsi_IB_update_day;

    /* ネット支店契約 */
    char    TMKZs_net_contract[1+1];
    short   TMKZsi_net_contract;

    /* ネット支店契約者ID */
    char    TMKZs_net_contract_id[16+1];
    short   TMKZsi_net_contract_id;

    /* ネット支店契約申込店番 */
    char    TMKZs_net_branch_id[3+1];
    short   TMKZsi_net_branch_id;

    /* ネット支店契約代表口座科目 */
    char    TMKZs_net_accnt_id[4+1];
    short   TMKZsi_net_accnt_id;

    /* ネット支店契約代表口座口番号 */
    char    TMKZs_net_kuchi_no[3+1];
    short   TMKZsi_net_kuchi_no;

    /* ネット支店契約日 */
    char    TMKZs_net_contract_day[8+1];
    short   TMKZsi_net_contract_day;

    /* ネット支店契約解約日 */
    char    TMKZs_net_cancel_day[8+1];
    short   TMKZsi_net_cancel_day;

    /* ネット支店契約最終更新日 */
    char    TMKZs_net_update_day[8+1];
    short   TMKZsi_net_update_day;

    /* 職業コード */
    char    TMKZs_occp_code[4+1];
    short   TMKZsi_occp_code;

    /* 年収 */
    char    TMKZs_income[15+1];
    short   TMKZsi_income;

    /* 所得年度 */
    char    TMKZs_income_year[4+1];
    short   TMKZsi_income_year;

    /* 取引管理情報 */
    char    TMKZs_torikan[1+1];
    short   TMKZsi_torikan;

    /* 担当者名 */
    char    TMKZs_operate_name[24+1];
    short   TMKZsi_operate_name;

    /* カード発行サイン */
    char    TMKZs_card_sign[1+1];
    short   TMKZsi_card_sign;

    /* 自宅住所都道府県 */
    /*struct { short len; char arr[10+1]; }
            TMKZs_adress1;*/
    varchar	TMKZs_adress1[10+1];
	short   TMKZsi_adress1;

    /* 自宅住所市区町村 */
    /*struct { short len; char arr[24+1]; }
            TMKZs_adress2;*/
	varchar		TMKZs_adress2[24+1];
    short   TMKZsi_adress2;

    /* 自宅住所大字通称 */
    /*struct { short len; char arr[36+1]; }
            TMKZs_adress3;*/
	varchar		TMKZs_adress3[36+1];
    short   TMKZsi_adress3;

    /* 自宅住所字丁目 */
    /*struct { short len; char arr[40+1]; }
            TMKZs_adress4;*/
	varchar		TMKZs_adress4[40+1];
    short   TMKZsi_adress4;

    /* 自宅住所番地 */
    /*struct { short len; char arr[30+1]; }
            TMKZs_adress5;*/
	varchar		TMKZs_adress5[30+1];
    short   TMKZsi_adress5;

    /* 自宅住所気付 */
    /*struct { short len; char arr[30+1]; }
            TMKZs_adress6;*/
	varchar		TMKZs_adress6[30+1];
    short   TMKZsi_adress6;

    /* 自宅住所都道府県カナ */
    /*struct { short len; char arr[20+1]; }
            TMKZs_adress_kana1;*/
	varchar		TMKZs_adress_kana1[20+1];
    short   TMKZsi_adress_kana1;

    /* 自宅住所市区町村カナ */
    /*struct { short len; char arr[48+1]; }
            TMKZs_adress_kana2;*/
	varchar		TMKZs_adress_kana2[48+1];
    short   TMKZsi_adress_kana2;

    /* 自宅住所大字通称カナ */
    /*struct { short len; char arr[72+1]; }
            TMKZs_adress_kana3;*/
	varchar		TMKZs_adress_kana3[72+1];
    short   TMKZsi_adress_kana3;

    /* 自宅住所字丁目カナ */
    /*struct { short len; char arr[80+1]; }
            TMKZs_adress_kana4;*/
	varchar		TMKZs_adress_kana4[80+1];
    short   TMKZsi_adress_kana4;

    /* 自宅住所番地カナ */
    /*struct { short len; char arr[60+1]; }
            TMKZs_adress_kana5;*/
	varchar		TMKZs_adress_kana5[60+1];
    short   TMKZsi_adress_kana5;

    /* 自宅住所気付カナ */
    /*struct { short len; char arr[60+1]; }
            TMKZs_adress_kana6;*/
	varchar		TMKZs_adress_kana6[60+1];
    short   TMKZsi_adress_kana6;

    /* 自宅住所 */
    /*struct { short len; char arr[170+1]; }
            TMKZs_adress;*/
	varchar		TMKZs_adress[170+1];
    short   TMKZsi_adress;

    /* 自宅住所カナ */
    /*struct { short len; char arr[175+1]; }
            TMKZs_adress_kana;*/
	varchar		TMKZs_adress_kana[175+1];
    short   TMKZsi_adress_kana;

    /* 連絡先住所都道府県 */
    /*struct { short len; char arr[10+1]; }
            TMKZs_renrakusaki_adress1;*/
	varchar		TMKZs_renrakusaki_adress1[10+1];
    short   TMKZsi_renrakusaki_adress1;

    /* 連絡先住所市区町村 */
    /*struct { short len; char arr[24+1]; }
            TMKZs_renrakusaki_adress2;*/
	varchar		TMKZs_renrakusaki_adress2[24+1];
    short   TMKZsi_renrakusaki_adress2;

    /* 連絡先住所大字通称 */
    /*struct { short len; char arr[36+1]; }
            TMKZs_renrakusaki_adress3;*/
	varchar		TMKZs_renrakusaki_adress3[36+1];
    short   TMKZsi_renrakusaki_adress3;

    /* 連絡先住所字丁目 */
    /*struct { short len; char arr[40+1]; }
            TMKZs_renrakusaki_adress4;*/
	varchar		TMKZs_renrakusaki_adress4[40+1];
    short   TMKZsi_renrakusaki_adress4;

    /* 連絡先住所番地 */
    /*struct { short len; char arr[30+1]; }
            TMKZs_renrakusaki_adress5;*/
	varchar		TMKZs_renrakusaki_adress5[30+1];
    short   TMKZsi_renrakusaki_adress5;

    /* 連絡先住所気付 */
    /*struct { short len; char arr[30+1]; }
            TMKZs_renrakusaki_adress6;*/
	varchar		TMKZs_renrakusaki_adress6[30+1];
    short   TMKZsi_renrakusaki_adress6;

    /* 連絡先住所都道府県カナ */
    /*struct { short len; char arr[20+1]; }
            TMKZs_renrakusaki_adress_kana1;*/
	varchar		TMKZs_renrakusaki_adress_kana1[20+1];
    short   TMKZsi_renrakusaki_adress_kana1;

    /* 連絡先住所市区町村カナ */
    /*struct { short len; char arr[48+1]; }
            TMKZs_renrakusaki_adress_kana2;*/
	varchar		TMKZs_renrakusaki_adress_kana2[48+1];
    short   TMKZsi_renrakusaki_adress_kana2;

    /* 連絡先住所大字通称カナ */
    /*struct { short len; char arr[72+1]; }
            TMKZs_renrakusaki_adress_kana3;*/
	varchar		TMKZs_renrakusaki_adress_kana3[72+1];
    short   TMKZsi_renrakusaki_adress_kana3;

    /* 連絡先住所字丁目カナ */
    /*struct { short len; char arr[80+1]; }
            TMKZs_renrakusaki_adress_kana4;*/
	varchar		TMKZs_renrakusaki_adress_kana4[80+1];
    short   TMKZsi_renrakusaki_adress_kana4;

    /* 連絡先住所番地カナ */
    /*struct { short len; char arr[60+1]; }
            TMKZs_renrakusaki_adress_kana5;*/
	varchar		TMKZs_renrakusaki_adress_kana5[60+1];
    short   TMKZsi_renrakusaki_adress_kana5;

    /* 連絡先住所気付カナ */
    /*struct { short len; char arr[60+1]; }
            TMKZs_renrakusaki_adress_kana6;*/
	varchar		TMKZs_renrakusaki_adress_kana6[60+1];
    short   TMKZsi_renrakusaki_adress_kana6;

    /* 連絡先住所 */
    /*struct { short len; char arr[170+1]; }
            TMKZs_renrakusaki_adress;*/
	varchar		TMKZs_renrakusaki_adress[170+1];
    short   TMKZsi_renrakusaki_adress;

    /* 連絡先住所カナ */
    /*struct { short len; char arr[175+1]; }
            TMKZs_renrakusaki_adress_kana;*/
	varchar		TMKZs_renrakusaki_adress_kana[175+1];
    short   TMKZsi_renrakusaki_adress_kana;

    /* データ基準日 */
    char    TMKZs_data_date[8+1];
    short   TMKZsi_data_date;

	/* マル優 */
    char    TMKZs_tax_free[1+1];
    short   TMKZsi_tax_free;

    /* 更新者 */
    char    TMKZs_change_name[16+1];
    short   TMKZsi_change_name;

    /* 更新タイムスタンプ */
    char    TMKZs_change_timestamp[26+1];
    short   TMKZsi_change_timestamp;

/* %01 Add End */

EXEC SQL END DECLARE SECTION;

