/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* Description      : 世帯属性テーブル                                      */
/*                                                                          */
/* File Name        : TF_KokyakuZokusei.h                                   */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/04/10 | ISID        | First Edition.                            */
/*==========================================================================*/
EXEC SQL BEGIN DECLARE SECTION;
    /* 店番 */
    char        TMSZs_tenban[5+1];
    short       TMSZsi_tenban;

    /* CIFNO */
    char        TMSZs_cifno[10+1];
    short       TMSZsi_cifno;

    /* 個人企業番号 */
    char        TMSZs_kojin_kigyo_no[13+1];
    short       TMSZsi_kojin_kigyo_no;

    /* 人格区分 */
    char        TMSZs_jinkaku_kbn[1+1];
    short       TMSZsi_jinkaku_kbn;

    /* 世帯番号 */
    char        TMSZs_setai_no[13+1];
    short       TMSZsi_setai_no;

    /* 氏名漢字 */
    varchar                TMSZs_name_knj[80+1];
    short       TMSZsi_name_knj;

    /* 氏名漢字更新フラグ */
    char        TMSZs_name_knj_flg[1+1];
    short       TMSZsi_name_knj_flg;

    /* 氏名カナ */
    varchar                TMSZs_name_kna[80+1];
    short       TMSZsi_name_kna;

    /* 氏名カナ更新フラグ */
    char        TMSZs_name_kna_flg[1+1];
    short       TMSZsi_name_kna_flg;

    /* 性別 */
    char        TMSZs_sex[1+1];
    short       TMSZsi_sex;

    /* 性別更新フラグ */
    char        TMSZs_sex_flg[1+1];
    short       TMSZsi_sex_flg;

    /* 生年月日 */
    char        TMSZs_birthday[8+1];
    short       TMSZsi_birthday;

    /* 生年月日更新フラグ */
    char        TMSZs_birthday_flg[1+1];
    short       TMSZsi_birthday_flg;

    /* 住所コード */
    char        TMSZs_zip_cd[15+1];
    short       TMSZsi_zip_cd;

    /* 郵便番号 */
    char        TMSZs_zip[10+1];
    short       TMSZsi_zip;

    /* 補助住所 */
    varchar                TMSZs_hojo_jyusyo[60+1];
    short       TMSZsi_hojo_jyusyo;

    /* 住所変更フラグ */
    char        TMSZs_addressflg[1+1];
    short       TMSZsi_addressflg;

/* %01 Add Start */
    /* 補助住所カナ */
    varchar                TMSZs_hojo_jyusyo_kana[120+1];
    short       TMSZsi_hojo_jyusyo_kana;

    /* 住所カナ変更フラグ */
    char        TMSZs_address_kana_flg[1+1];
    short       TMSZsi_address_kana_flg;

/* %01 Add End */

    /* 自宅電話番号 */
    char        TMSZs_jitakutel[20+1];
    short       TMSZsi_jitakutel;

    /* 自宅電話番号更新フラグ */
    char        TMSZs_jitakutel_flg[1+1];
    short       TMSZsi_jitakutel_flg;

    /* 自宅FAX番号 */
    char        TMSZs_jitaku_fax[20+1];
    short       TMSZsi_jitaku_fax;

    /* 自宅FAX番号更新フラグ */
    char        TMSZs_jitaku_fax_flg[1+1];
    short       TMSZsi_jitaku_fax_flg;

    /* 携帯電話番号 */
    char        TMSZs_keitai_tel[20+1];
    short       TMSZsi_keitai_tel;

    /* 携帯電話番号更新フラグ */
    char        TMSZs_keitai_tel_flg[1+1];
    short       TMSZsi_keitai_tel_flg;

    /* MAILアドレス */
    varchar                TMSZs_mail[50+1];
    short       TMSZsi_mail;

    /* MAILアドレス更新フラグ */
    char        TMSZs_mail_flg[1+1];
    short       TMSZsi_mail_flg;

    /* 勤務先名漢字 */
    varchar                TMSZs_kinmusaki[80+1];
    short       TMSZsi_kinmusaki;

    /* 勤務先名漢字更新フラグ */
    char        TMSZs_kinmusaki_flg[1+1];
    short       TMSZsi_kinmusaki_flg;

    /* 勤務先名カナ */
    varchar                TMSZs_kinmusaki_kana[80+1];
    short       TMSZsi_kinmusaki_kana;

    /* 勤務先名カナ更新フラグ */
    char        TMSZs_kinmusaki_kana_flg[1+1];
    short       TMSZsi_kinmusaki_kana_flg;

    /* 勤務先電話番号 */
    char        TMSZs_kinmusaki_tel[20+1];
    short       TMSZsi_kinmusaki_tel;

    /* 勤務先電話番号更新フラグ */
    char        TMSZs_kinmusaki_tel_flg[1+1];
    short       TMSZsi_kinmusaki_tel_flg;

/* %01 Add Start */
    /* 連絡先住所コード */
    char        TMSZs_renrakusaki_zip_cd[15+1];
    short       TMSZsi_renrakusaki_zip_cd;

    /* 連絡先郵便番号 */
    char        TMSZs_renrakusaki_zip[10+1];
    short       TMSZsi_renrakusaki_zip;

    /* 連絡先補助住所 */
    varchar                TMSZs_renrakusaki_hojo_jyusyo[60+1];
    short       TMSZsi_renrakusaki_hojo_jyusyo;

    /* 連絡先住所変更フラグ */
    char        TMSZs_renrakusaki_addressflg[1+1];
    short       TMSZsi_renrakusaki_addressflg;

    /* 連絡先補助住所カナ */
    varchar                TMSZs_renrakusaki_hojo_jyusyo_kana[120+1];
    short       TMSZsi_renrakusaki_hojo_jyusyo_kana;

    /* 連絡先住所変更フラグ */
    char        TMSZs_renrakusaki_address_kana_flg[1+1];
    short       TMSZsi_renrakusaki_address_kana_flg;
/* %01 Add End */

    /* 連絡先電話番号 */
    char        TMSZs_renrakusaki_tel[20+1];
    short       TMSZsi_renrakusaki_tel;

    /* 連絡先電話番号更新フラグ */
    char        TMSZs_renrakusaki_tel_flg[1+1];
    short       TMSZsi_renrakusaki_tel_flg;

    /* 連絡先FAX番号 */
    char        TMSZs_renrakusaki_fax[20+1];
    short       TMSZsi_renrakusaki_fax;

    /* 連絡先FAX番号更新フラグ */
    char        TMSZs_renrakusaki_fax_flg[1+1];
    short       TMSZsi_renrakusaki_fax_flg;

    /* 日中連絡先電話番号 */
    char        TMSZs_nicchu_tel[20+1];
    short       TMSZsi_nicchu_tel;

    /* 日中連絡先電話番号更新フラグ */
    char        TMSZs_nicchu_tel_flg[1+1];
    short       TMSZsi_nicchu_tel_flg;

    /* 行員区分 */
    char        TMSZs_kouin_kbn[1+1];
    short       TMSZsi_kouin_kbn;

    /* 郵便不着 */
    char        TMSZs_futyaku[1+1];
    short       TMSZsi_futyaku;

    /* 会社寮 */
    char        TMSZs_kaisya_ryo[1+1];
    short       TMSZsi_kaisya_ryo;

    /* 電話番号間違い */
    char        TMSZs_denwa_matigai[1+1];
    short       TMSZsi_denwa_matigai;

    /* 移転 */
    char        TMSZs_iten[1+1];
    short       TMSZsi_iten;

    /* 本人死亡 */
    char        TMSZs_honnin_sibo[1+1];
    short       TMSZsi_honnin_sibo;

    /* マル優申告額 */
    char        TMSZs_yu_shinkoku[20+1];
    short       TMSZsi_yu_shinkoku;

    /* マル優利用額 */
    char        TMSZs_yu_riyo[20+1];
    short       TMSZsi_yu_riyo;

    /* マル特申告額 */
    char        TMSZs_toku_shinkoku[20+1];
    short       TMSZsi_toku_shinkoku;

    /* マル特利用額 */
    char        TMSZs_toku_riyo[20+1];
    short       TMSZsi_toku_riyo;

    /* ホストTM対象区分 */
    char        TMSZs_host_tm[1+1];
    short       TMSZsi_host_tm;

    /* TM対象区分 */
    char        TMSZs_tm[1+1];
    short       TMSZsi_tm;

    /* ホストDM対象区分 */
    char        TMSZs_host_dm[1+1];
    short       TMSZsi_host_dm;

    /* DM対象区分 */
    char        TMSZs_dm[1+1];
    short       TMSZsi_dm;

/* %01 Add Start */
    /* 取引開始日 */
    char        TMSZs_deal_day[8+1];
    short       TMSZsi_deal_day;

    /* 世帯主フラグ */
    char        TMSZs_setai_flg[1+1];
    short       TMSZsi_setai_flg;

    /* 当行金融資産残高 */
    char        TMSZs_zandaka[16+1];
    short       TMSZsi_zandaka;

    /* 預り資産残高１ */
    char    TMSZs_azukari_shisan1[16+1];
    short   TMSZsi_azukari_shisan1;

    /* 預り資産残高２ */
    char    TMSZs_azukari_shisan2[16+1];
    short   TMSZsi_azukari_shisan2;

    /* 預り資産残高３ */
    char    TMSZs_azukari_shisan3[16+1];
    short   TMSZsi_azukari_shisan3;

    /* 流動性預金残高 */
    char    TMSZs_ryudo_zandaka[16+1];
    short   TMSZsi_ryudo_zandaka;

    /* 定期性預金残高 */
    char    TMSZs_teiki_zandaka[16+1];
    short   TMSZsi_teiki_zandaka;

    /* 仕組預金残高 */
    char    TMSZs_shikumi_zandaka[16+1];
    short   TMSZsi_shikumi_zandaka;

    /* 外貨預金残高 */
    char    TMSZs_gaika_zandaka[16+1];
    short   TMSZsi_gaika_zandaka;

    /* 投信残高 */
    char    TMSZs_toushin_zandaka[16+1];
    short   TMSZsi_toushin_zandaka;

    /* 債券残高 */
    char    TMSZs_saiken_zandaka[16+1];
    short   TMSZsi_saiken_zandaka;

    /* リスク商品残高 */
    char    TMSZs_risk_zandaka[16+1];
    short   TMSZsi_risk_zandaka;

    /* テレバン契約 */
    char    TMSZs_TB_contract[1+1];
    short   TMSZsi_TB_contract;

    /* テレバン契約日 */
    char    TMSZs_TB_contract_day[8+1];
    short   TMSZsi_TB_contract_day;

    /* IB契約 */
    char    TMSZs_IB_contract[1+1];
    short   TMSZsi_IB_contract;

    /* IB契約者ID */
    char    TMSZs_IB_contract_id[16+1];
    short   TMSZsi_IB_contract_id;

    /* IB契約申込店番 */
    char    TMSZs_IB_branch_id[3+1];
    short   TMSZsi_IB_branch_id;

    /* IB契約代表口座科目 */
    char    TMSZs_IB_accnt_id[4+1];
    short   TMSZsi_IB_accnt_id;

    /* IB契約代表口座口番号 */
    char    TMSZs_IB_kuchi_no[3+1];
    short   TMSZsi_IB_kuchi_no;

    /* IB契約日 */
    char    TMSZs_IB_contract_day[8+1];
    short   TMSZsi_IB_contract_day;

    /* IB契約解約日 */
    char    TMSZs_IB_cancel_day[8+1];
    short   TMSZsi_IB_cancel_day;

    /* IB契約最終更新日 */
    char    TMSZs_IB_update_day[8+1];
    short   TMSZsi_IB_update_day;

    /* ネット支店契約 */
    char    TMSZs_net_contract[1+1];
    short   TMSZsi_net_contract;

    /* ネット支店契約者ID */
    char    TMSZs_net_contract_id[16+1];
    short   TMSZsi_net_contract_id;

    /* ネット支店契約申込店番 */
    char    TMSZs_net_branch_id[3+1];
    short   TMSZsi_net_branch_id;

    /* ネット支店契約代表口座科目 */
    char    TMSZs_net_accnt_id[4+1];
    short   TMSZsi_net_accnt_id;

    /* ネット支店契約代表口座口番号 */
    char    TMSZs_net_kuchi_no[3+1];
    short   TMSZsi_net_kuchi_no;

    /* ネット支店契約日 */
    char    TMSZs_net_contract_day[8+1];
    short   TMSZsi_net_contract_day;

    /* ネット支店契約解約日 */
    char    TMSZs_net_cancel_day[8+1];
    short   TMSZsi_net_cancel_day;

    /* ネット支店契約最終更新日 */
    char    TMSZs_net_update_day[8+1];
    short   TMSZsi_net_update_day;

    /* 職業コード */
    char    TMSZs_occp_code[4+1];
    short   TMSZsi_occp_code;

    /* 年収 */
    char    TMSZs_income[15+1];
    short   TMSZsi_income;

    /* 所得年度 */
    char    TMSZs_income_year[4+1];
    short   TMSZsi_income_year;

    /* 取引管理情報 */
    char    TMSZs_torikan[1+1];
    short   TMSZsi_torikan;

    /* 担当者名 */
    char    TMSZs_operate_name[24+1];
    short   TMSZsi_operate_name;

    /* カード発行サイン */
    char    TMSZs_card_sign[1+1];
    short   TMSZsi_card_sign;

    /* 自宅住所都道府県 */
    varchar            TMSZs_adress1[10+1];
    short   TMSZsi_adress1;

    /* 自宅住所市区町村 */
    varchar            TMSZs_adress2[24+1];
    short   TMSZsi_adress2;

    /* 自宅住所大字通称 */
    varchar            TMSZs_adress3[36+1];
    short   TMSZsi_adress3;

    /* 自宅住所字丁目 */
    varchar            TMSZs_adress4[40+1];
    short   TMSZsi_adress4;

    /* 自宅住所番地 */
    varchar            TMSZs_adress5[30+1];
    short   TMSZsi_adress5;

    /* 自宅住所気付 */
    varchar            TMSZs_adress6[30+1];
    short   TMSZsi_adress6;

    /* 自宅住所都道府県カナ */
    varchar            TMSZs_adress_kana1[20+1];
    short   TMSZsi_adress_kana1;

    /* 自宅住所市区町村カナ */
    varchar            TMSZs_adress_kana2[48+1];
    short   TMSZsi_adress_kana2;

    /* 自宅住所大字通称カナ */
    varchar            TMSZs_adress_kana3[72+1];
    short   TMSZsi_adress_kana3;

    /* 自宅住所字丁目カナ */
    varchar            TMSZs_adress_kana4[80+1];
    short   TMSZsi_adress_kana4;

    /* 自宅住所番地カナ */
    varchar            TMSZs_adress_kana5[60+1];
    short   TMSZsi_adress_kana5;

    /* 自宅住所気付カナ */
    varchar            TMSZs_adress_kana6[60+1];
    short   TMSZsi_adress_kana6;

    /* 自宅住所 */
    varchar            TMSZs_adress[170+1];
    short   TMSZsi_adress;

    /* 自宅住所カナ */
    varchar            TMSZs_adress_kana[175+1];
    short   TMSZsi_adress_kana;

    /* 連絡先住所都道府県 */
    varchar            TMSZs_renrakusaki_adress1[10+1];
    short   TMSZsi_renrakusaki_adress1;

    /* 連絡先住所市区町村 */
    varchar            TMSZs_renrakusaki_adress2[24+1];
    short   TMSZsi_renrakusaki_adress2;

    /* 連絡先住所大字通称 */
    varchar            TMSZs_renrakusaki_adress3[36+1];
    short   TMSZsi_renrakusaki_adress3;

    /* 連絡先住所字丁目 */
    varchar            TMSZs_renrakusaki_adress4[40+1];
    short   TMSZsi_renrakusaki_adress4;

    /* 連絡先住所番地 */
    varchar            TMSZs_renrakusaki_adress5[30+1];
    short   TMSZsi_renrakusaki_adress5;

    /* 連絡先住所気付 */
    varchar            TMSZs_renrakusaki_adress6[30+1];
    short   TMSZsi_renrakusaki_adress6;

    /* 連絡先住所都道府県カナ */
    varchar            TMSZs_renrakusaki_adress_kana1[20+1];
    short   TMSZsi_renrakusaki_adress_kana1;

    /* 連絡先住所市区町村カナ */
    varchar            TMSZs_renrakusaki_adress_kana2[48+1];
    short   TMSZsi_renrakusaki_adress_kana2;

    /* 連絡先住所大字通称カナ */
    varchar            TMSZs_renrakusaki_adress_kana3[72+1];
    short   TMSZsi_renrakusaki_adress_kana3;

    /* 連絡先住所字丁目カナ */
    varchar            TMSZs_renrakusaki_adress_kana4[80+1];
    short   TMSZsi_renrakusaki_adress_kana4;

    /* 連絡先住所番地カナ */
    varchar            TMSZs_renrakusaki_adress_kana5[60+1];
    short   TMSZsi_renrakusaki_adress_kana5;

    /* 連絡先住所気付カナ */
    varchar            TMSZs_renrakusaki_adress_kana6[60+1];
    short   TMSZsi_renrakusaki_adress_kana6;

    /* 連絡先住所 */
    varchar            TMSZs_renrakusaki_adress[170+1];
    short   TMSZsi_renrakusaki_adress;

    /* 連絡先住所カナ */
    varchar            TMSZs_renrakusaki_adress_kana[175+1];
    short   TMSZsi_renrakusaki_adress_kana;

    /* データ基準日 */
    char    TMSZs_data_date[8+1];
    short   TMSZsi_data_date;

	/* マル優 */
    char    TMSZs_tax_free[1+1];
    short   TMSZsi_tax_free;

    /* 更新者 */
    char    TMSZs_change_name[16+1];
    short   TMSZsi_change_name;

    /* 更新タイムスタンプ */
    char    TMSZs_change_timestamp[26+1];
    short   TMSZsi_change_timestamp;

/* %01 Add End */

EXEC SQL END DECLARE SECTION;