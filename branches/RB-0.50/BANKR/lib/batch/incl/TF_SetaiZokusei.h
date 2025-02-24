/*==========================================================================*/
/* Copyright@Information Services International-Dentsu, Ltd.   @          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANKER|CC                                           */
/*                                                                          */
/* Description      : ¢Ñ®«e[u                                      */
/*                                                                          */
/* File Name        : TF_KokyakuZokusei.h                                   */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/04/10 | ISID        | First Edition.                            */
/*==========================================================================*/
EXEC SQL BEGIN DECLARE SECTION;
    /* XÔ */
    char        TMSZs_tenban[5+1];
    short       TMSZsi_tenban;

    /* CIFNO */
    char        TMSZs_cifno[10+1];
    short       TMSZsi_cifno;

    /* ÂléÆÔ */
    char        TMSZs_kojin_kigyo_no[13+1];
    short       TMSZsi_kojin_kigyo_no;

    /* liæª */
    char        TMSZs_jinkaku_kbn[1+1];
    short       TMSZsi_jinkaku_kbn;

    /* ¢ÑÔ */
    char        TMSZs_setai_no[13+1];
    short       TMSZsi_setai_no;

    /* ¼¿ */
    varchar                TMSZs_name_knj[80+1];
    short       TMSZsi_name_knj;

    /* ¼¿XVtO */
    char        TMSZs_name_knj_flg[1+1];
    short       TMSZsi_name_knj_flg;

    /* ¼Ji */
    varchar                TMSZs_name_kna[80+1];
    short       TMSZsi_name_kna;

    /* ¼JiXVtO */
    char        TMSZs_name_kna_flg[1+1];
    short       TMSZsi_name_kna_flg;

    /* «Ê */
    char        TMSZs_sex[1+1];
    short       TMSZsi_sex;

    /* «ÊXVtO */
    char        TMSZs_sex_flg[1+1];
    short       TMSZsi_sex_flg;

    /* ¶Nú */
    char        TMSZs_birthday[8+1];
    short       TMSZsi_birthday;

    /* ¶NúXVtO */
    char        TMSZs_birthday_flg[1+1];
    short       TMSZsi_birthday_flg;

    /* ZR[h */
    char        TMSZs_zip_cd[15+1];
    short       TMSZsi_zip_cd;

    /* XÖÔ */
    char        TMSZs_zip[10+1];
    short       TMSZsi_zip;

    /* âZ */
    varchar                TMSZs_hojo_jyusyo[60+1];
    short       TMSZsi_hojo_jyusyo;

    /* ZÏXtO */
    char        TMSZs_addressflg[1+1];
    short       TMSZsi_addressflg;

/* %01 Add Start */
    /* âZJi */
    varchar                TMSZs_hojo_jyusyo_kana[120+1];
    short       TMSZsi_hojo_jyusyo_kana;

    /* ZJiÏXtO */
    char        TMSZs_address_kana_flg[1+1];
    short       TMSZsi_address_kana_flg;

/* %01 Add End */

    /* ©îdbÔ */
    char        TMSZs_jitakutel[20+1];
    short       TMSZsi_jitakutel;

    /* ©îdbÔXVtO */
    char        TMSZs_jitakutel_flg[1+1];
    short       TMSZsi_jitakutel_flg;

    /* ©îFAXÔ */
    char        TMSZs_jitaku_fax[20+1];
    short       TMSZsi_jitaku_fax;

    /* ©îFAXÔXVtO */
    char        TMSZs_jitaku_fax_flg[1+1];
    short       TMSZsi_jitaku_fax_flg;

    /* gÑdbÔ */
    char        TMSZs_keitai_tel[20+1];
    short       TMSZsi_keitai_tel;

    /* gÑdbÔXVtO */
    char        TMSZs_keitai_tel_flg[1+1];
    short       TMSZsi_keitai_tel_flg;

    /* MAILAhX */
    varchar                TMSZs_mail[50+1];
    short       TMSZsi_mail;

    /* MAILAhXXVtO */
    char        TMSZs_mail_flg[1+1];
    short       TMSZsi_mail_flg;

    /* Î±æ¼¿ */
    varchar                TMSZs_kinmusaki[80+1];
    short       TMSZsi_kinmusaki;

    /* Î±æ¼¿XVtO */
    char        TMSZs_kinmusaki_flg[1+1];
    short       TMSZsi_kinmusaki_flg;

    /* Î±æ¼Ji */
    varchar                TMSZs_kinmusaki_kana[80+1];
    short       TMSZsi_kinmusaki_kana;

    /* Î±æ¼JiXVtO */
    char        TMSZs_kinmusaki_kana_flg[1+1];
    short       TMSZsi_kinmusaki_kana_flg;

    /* Î±ædbÔ */
    char        TMSZs_kinmusaki_tel[20+1];
    short       TMSZsi_kinmusaki_tel;

    /* Î±ædbÔXVtO */
    char        TMSZs_kinmusaki_tel_flg[1+1];
    short       TMSZsi_kinmusaki_tel_flg;

/* %01 Add Start */
    /* AæZR[h */
    char        TMSZs_renrakusaki_zip_cd[15+1];
    short       TMSZsi_renrakusaki_zip_cd;

    /* AæXÖÔ */
    char        TMSZs_renrakusaki_zip[10+1];
    short       TMSZsi_renrakusaki_zip;

    /* AæâZ */
    varchar                TMSZs_renrakusaki_hojo_jyusyo[60+1];
    short       TMSZsi_renrakusaki_hojo_jyusyo;

    /* AæZÏXtO */
    char        TMSZs_renrakusaki_addressflg[1+1];
    short       TMSZsi_renrakusaki_addressflg;

    /* AæâZJi */
    varchar                TMSZs_renrakusaki_hojo_jyusyo_kana[120+1];
    short       TMSZsi_renrakusaki_hojo_jyusyo_kana;

    /* AæZÏXtO */
    char        TMSZs_renrakusaki_address_kana_flg[1+1];
    short       TMSZsi_renrakusaki_address_kana_flg;
/* %01 Add End */

    /* AædbÔ */
    char        TMSZs_renrakusaki_tel[20+1];
    short       TMSZsi_renrakusaki_tel;

    /* AædbÔXVtO */
    char        TMSZs_renrakusaki_tel_flg[1+1];
    short       TMSZsi_renrakusaki_tel_flg;

    /* AæFAXÔ */
    char        TMSZs_renrakusaki_fax[20+1];
    short       TMSZsi_renrakusaki_fax;

    /* AæFAXÔXVtO */
    char        TMSZs_renrakusaki_fax_flg[1+1];
    short       TMSZsi_renrakusaki_fax_flg;

    /* úAædbÔ */
    char        TMSZs_nicchu_tel[20+1];
    short       TMSZsi_nicchu_tel;

    /* úAædbÔXVtO */
    char        TMSZs_nicchu_tel_flg[1+1];
    short       TMSZsi_nicchu_tel_flg;

    /* sõæª */
    char        TMSZs_kouin_kbn[1+1];
    short       TMSZsi_kouin_kbn;

    /* XÖs */
    char        TMSZs_futyaku[1+1];
    short       TMSZsi_futyaku;

    /* ïÐ¾ */
    char        TMSZs_kaisya_ryo[1+1];
    short       TMSZsi_kaisya_ryo;

    /* dbÔÔá¢ */
    char        TMSZs_denwa_matigai[1+1];
    short       TMSZsi_denwa_matigai;

    /* Ú] */
    char        TMSZs_iten[1+1];
    short       TMSZsi_iten;

    /* {lS */
    char        TMSZs_honnin_sibo[1+1];
    short       TMSZsi_honnin_sibo;

    /* }D\z */
    char        TMSZs_yu_shinkoku[20+1];
    short       TMSZsi_yu_shinkoku;

    /* }Dpz */
    char        TMSZs_yu_riyo[20+1];
    short       TMSZsi_yu_riyo;

    /* }Á\z */
    char        TMSZs_toku_shinkoku[20+1];
    short       TMSZsi_toku_shinkoku;

    /* }Ápz */
    char        TMSZs_toku_riyo[20+1];
    short       TMSZsi_toku_riyo;

    /* zXgTMÎÛæª */
    char        TMSZs_host_tm[1+1];
    short       TMSZsi_host_tm;

    /* TMÎÛæª */
    char        TMSZs_tm[1+1];
    short       TMSZsi_tm;

    /* zXgDMÎÛæª */
    char        TMSZs_host_dm[1+1];
    short       TMSZsi_host_dm;

    /* DMÎÛæª */
    char        TMSZs_dm[1+1];
    short       TMSZsi_dm;

/* %01 Add Start */
    /* æøJnú */
    char        TMSZs_deal_day[8+1];
    short       TMSZsi_deal_day;

    /* ¢ÑåtO */
    char        TMSZs_setai_flg[1+1];
    short       TMSZsi_setai_flg;

    /* sàZYc */
    char        TMSZs_zandaka[16+1];
    short       TMSZsi_zandaka;

    /* aèYcP */
    char    TMSZs_azukari_shisan1[16+1];
    short   TMSZsi_azukari_shisan1;

    /* aèYcQ */
    char    TMSZs_azukari_shisan2[16+1];
    short   TMSZsi_azukari_shisan2;

    /* aèYcR */
    char    TMSZs_azukari_shisan3[16+1];
    short   TMSZsi_azukari_shisan3;

    /* ¬®«aàc */
    char    TMSZs_ryudo_zandaka[16+1];
    short   TMSZsi_ryudo_zandaka;

    /* èú«aàc */
    char    TMSZs_teiki_zandaka[16+1];
    short   TMSZsi_teiki_zandaka;

    /* dgaàc */
    char    TMSZs_shikumi_zandaka[16+1];
    short   TMSZsi_shikumi_zandaka;

    /* OÝaàc */
    char    TMSZs_gaika_zandaka[16+1];
    short   TMSZsi_gaika_zandaka;

    /* Mc */
    char    TMSZs_toushin_zandaka[16+1];
    short   TMSZsi_toushin_zandaka;

    /* Âc */
    char    TMSZs_saiken_zandaka[16+1];
    short   TMSZsi_saiken_zandaka;

    /* XN¤ic */
    char    TMSZs_risk_zandaka[16+1];
    short   TMSZsi_risk_zandaka;

    /* eo_ñ */
    char    TMSZs_TB_contract[1+1];
    short   TMSZsi_TB_contract;

    /* eo_ñú */
    char    TMSZs_TB_contract_day[8+1];
    short   TMSZsi_TB_contract_day;

    /* IB_ñ */
    char    TMSZs_IB_contract[1+1];
    short   TMSZsi_IB_contract;

    /* IB_ñÒID */
    char    TMSZs_IB_contract_id[16+1];
    short   TMSZsi_IB_contract_id;

    /* IB_ñ\XÔ */
    char    TMSZs_IB_branch_id[3+1];
    short   TMSZsi_IB_branch_id;

    /* IB_ñã\ûÀÈÚ */
    char    TMSZs_IB_accnt_id[4+1];
    short   TMSZsi_IB_accnt_id;

    /* IB_ñã\ûÀûÔ */
    char    TMSZs_IB_kuchi_no[3+1];
    short   TMSZsi_IB_kuchi_no;

    /* IB_ñú */
    char    TMSZs_IB_contract_day[8+1];
    short   TMSZsi_IB_contract_day;

    /* IB_ñðñú */
    char    TMSZs_IB_cancel_day[8+1];
    short   TMSZsi_IB_cancel_day;

    /* IB_ñÅIXVú */
    char    TMSZs_IB_update_day[8+1];
    short   TMSZsi_IB_update_day;

    /* lbgxX_ñ */
    char    TMSZs_net_contract[1+1];
    short   TMSZsi_net_contract;

    /* lbgxX_ñÒID */
    char    TMSZs_net_contract_id[16+1];
    short   TMSZsi_net_contract_id;

    /* lbgxX_ñ\XÔ */
    char    TMSZs_net_branch_id[3+1];
    short   TMSZsi_net_branch_id;

    /* lbgxX_ñã\ûÀÈÚ */
    char    TMSZs_net_accnt_id[4+1];
    short   TMSZsi_net_accnt_id;

    /* lbgxX_ñã\ûÀûÔ */
    char    TMSZs_net_kuchi_no[3+1];
    short   TMSZsi_net_kuchi_no;

    /* lbgxX_ñú */
    char    TMSZs_net_contract_day[8+1];
    short   TMSZsi_net_contract_day;

    /* lbgxX_ñðñú */
    char    TMSZs_net_cancel_day[8+1];
    short   TMSZsi_net_cancel_day;

    /* lbgxX_ñÅIXVú */
    char    TMSZs_net_update_day[8+1];
    short   TMSZsi_net_update_day;

    /* EÆR[h */
    char    TMSZs_occp_code[4+1];
    short   TMSZsi_occp_code;

    /* Nû */
    char    TMSZs_income[15+1];
    short   TMSZsi_income;

    /* ¾Nx */
    char    TMSZs_income_year[4+1];
    short   TMSZsi_income_year;

    /* æøÇîñ */
    char    TMSZs_torikan[1+1];
    short   TMSZsi_torikan;

    /* SÒ¼ */
    char    TMSZs_operate_name[24+1];
    short   TMSZsi_operate_name;

    /* J[h­sTC */
    char    TMSZs_card_sign[1+1];
    short   TMSZsi_card_sign;

    /* ©îZs¹{§ */
    varchar            TMSZs_adress1[10+1];
    short   TMSZsi_adress1;

    /* ©îZsæ¬º */
    varchar            TMSZs_adress2[24+1];
    short   TMSZsi_adress2;

    /* ©îZåÊÌ */
    varchar            TMSZs_adress3[36+1];
    short   TMSZsi_adress3;

    /* ©îZÚ */
    varchar            TMSZs_adress4[40+1];
    short   TMSZsi_adress4;

    /* ©îZÔn */
    varchar            TMSZs_adress5[30+1];
    short   TMSZsi_adress5;

    /* ©îZCt */
    varchar            TMSZs_adress6[30+1];
    short   TMSZsi_adress6;

    /* ©îZs¹{§Ji */
    varchar            TMSZs_adress_kana1[20+1];
    short   TMSZsi_adress_kana1;

    /* ©îZsæ¬ºJi */
    varchar            TMSZs_adress_kana2[48+1];
    short   TMSZsi_adress_kana2;

    /* ©îZåÊÌJi */
    varchar            TMSZs_adress_kana3[72+1];
    short   TMSZsi_adress_kana3;

    /* ©îZÚJi */
    varchar            TMSZs_adress_kana4[80+1];
    short   TMSZsi_adress_kana4;

    /* ©îZÔnJi */
    varchar            TMSZs_adress_kana5[60+1];
    short   TMSZsi_adress_kana5;

    /* ©îZCtJi */
    varchar            TMSZs_adress_kana6[60+1];
    short   TMSZsi_adress_kana6;

    /* ©îZ */
    varchar            TMSZs_adress[170+1];
    short   TMSZsi_adress;

    /* ©îZJi */
    varchar            TMSZs_adress_kana[175+1];
    short   TMSZsi_adress_kana;

    /* AæZs¹{§ */
    varchar            TMSZs_renrakusaki_adress1[10+1];
    short   TMSZsi_renrakusaki_adress1;

    /* AæZsæ¬º */
    varchar            TMSZs_renrakusaki_adress2[24+1];
    short   TMSZsi_renrakusaki_adress2;

    /* AæZåÊÌ */
    varchar            TMSZs_renrakusaki_adress3[36+1];
    short   TMSZsi_renrakusaki_adress3;

    /* AæZÚ */
    varchar            TMSZs_renrakusaki_adress4[40+1];
    short   TMSZsi_renrakusaki_adress4;

    /* AæZÔn */
    varchar            TMSZs_renrakusaki_adress5[30+1];
    short   TMSZsi_renrakusaki_adress5;

    /* AæZCt */
    varchar            TMSZs_renrakusaki_adress6[30+1];
    short   TMSZsi_renrakusaki_adress6;

    /* AæZs¹{§Ji */
    varchar            TMSZs_renrakusaki_adress_kana1[20+1];
    short   TMSZsi_renrakusaki_adress_kana1;

    /* AæZsæ¬ºJi */
    varchar            TMSZs_renrakusaki_adress_kana2[48+1];
    short   TMSZsi_renrakusaki_adress_kana2;

    /* AæZåÊÌJi */
    varchar            TMSZs_renrakusaki_adress_kana3[72+1];
    short   TMSZsi_renrakusaki_adress_kana3;

    /* AæZÚJi */
    varchar            TMSZs_renrakusaki_adress_kana4[80+1];
    short   TMSZsi_renrakusaki_adress_kana4;

    /* AæZÔnJi */
    varchar            TMSZs_renrakusaki_adress_kana5[60+1];
    short   TMSZsi_renrakusaki_adress_kana5;

    /* AæZCtJi */
    varchar            TMSZs_renrakusaki_adress_kana6[60+1];
    short   TMSZsi_renrakusaki_adress_kana6;

    /* AæZ */
    varchar            TMSZs_renrakusaki_adress[170+1];
    short   TMSZsi_renrakusaki_adress;

    /* AæZJi */
    varchar            TMSZs_renrakusaki_adress_kana[175+1];
    short   TMSZsi_renrakusaki_adress_kana;

    /* f[^îú */
    char    TMSZs_data_date[8+1];
    short   TMSZsi_data_date;

	/* }D */
    char    TMSZs_tax_free[1+1];
    short   TMSZsi_tax_free;

    /* XVÒ */
    char    TMSZs_change_name[16+1];
    short   TMSZsi_change_name;

    /* XV^CX^v */
    char    TMSZs_change_timestamp[26+1];
    short   TMSZsi_change_timestamp;

/* %01 Add End */

EXEC SQL END DECLARE SECTION;