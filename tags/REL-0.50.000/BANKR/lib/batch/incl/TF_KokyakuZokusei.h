/*==========================================================================*/
/* Copyright@Information Services International-Dentsu, Ltd.   @          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANKER|CC                                           */
/*                                                                          */
/* Description      : Úq®«e[u                                      */
/*                                                                          */
/* File Name        : TF_KokyakuZokusei.h                                   */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/04/08 | ISID        | First Edition.                            */
/*==========================================================================*/
EXEC SQL BEGIN DECLARE SECTION;
    /* XÔ */
    char        TMKZs_tenban[5+1];
    short       TMKZsi_tenban;

    /* CIFNO */
    char        TMKZs_cifno[10+1];
    short       TMKZsi_cifno;

    /* ÂléÆÔ */
    char        TMKZs_kojin_kigyo_no[13+1];
    short       TMKZsi_kojin_kigyo_no;

    /* liæª */
    char        TMKZs_jinkaku_kbn[1+1];
    short       TMKZsi_jinkaku_kbn;

    /* ¢ÑÔ */
    char        TMKZs_setai_no[13+1];
    short       TMKZsi_setai_no;

    /* ¼¿ */
    /*struct { short len; char arr[80+1]; }
                TMKZs_name_knj;*/
	varchar		TMKZs_name_knj[80+1];
    short       TMKZsi_name_knj;

    /* ¼¿XVtO */
    char        TMKZs_name_knj_flg[1+1];
    short       TMKZsi_name_knj_flg;

    /* ¼Ji */
    /*struct { short len; char arr[80+1]; }
                TMKZs_name_kna;*/
	varchar		TMKZs_name_kna[80+1];
    short       TMKZsi_name_kna;

    /* ¼JiXVtO */
    char        TMKZs_name_kna_flg[1+1];
    short       TMKZsi_name_kna_flg;

    /* «Ê */
    char        TMKZs_sex[1+1];
    short       TMKZsi_sex;

    /* «ÊXVtO */
    char        TMKZs_sex_flg[1+1];
    short       TMKZsi_sex_flg;

    /* ¶Nú */
    char        TMKZs_birthday[8+1];
    short       TMKZsi_birthday;

    /* ¶NúXVtO */
    char        TMKZs_birthday_flg[1+1];
    short       TMKZsi_birthday_flg;

    /* ZR[h */
    char        TMKZs_zip_cd[15+1];
    short       TMKZsi_zip_cd;

    /* XÖÔ */
    char        TMKZs_zip[10+1];
    short       TMKZsi_zip;

    /* âZ */
    /*struct { short len; char arr[60+1]; }
                TMKZs_hojo_jyusyo;*/
	varchar		TMKZs_hojo_jyusyo[70+1];
    short       TMKZsi_hojo_jyusyo;

    /* ZÏXtO */
    char        TMKZs_addressflg[1+1];
    short       TMKZsi_addressflg;

/* %01 Add Start */
    /* âZJi */
    /*struct { short len; char arr[120+1]; }
                TMKZs_hojo_jyusyo_kana;*/
	varchar		TMKZs_hojo_jyusyo_kana[70+1];
    short       TMKZsi_hojo_jyusyo_kana;

    /* ZJiÏXtO */
    char        TMKZs_address_kana_flg[1+1];
    short       TMKZsi_address_kana_flg;

/* %01 Add End */

    /* ©îdbÔ */
    char        TMKZs_jitakutel[20+1];
    short       TMKZsi_jitakutel;

    /* ©îdbÔXVtO */
    char        TMKZs_jitakutel_flg[1+1];
    short       TMKZsi_jitakutel_flg;

    /* ©îFAXÔ */
    char        TMKZs_jitaku_fax[20+1];
    short       TMKZsi_jitaku_fax;

    /* ©îFAXÔXVtO */
    char        TMKZs_jitaku_fax_flg[1+1];
    short       TMKZsi_jitaku_fax_flg;

    /* gÑdbÔ */
    char        TMKZs_keitai_tel[20+1];
    short       TMKZsi_keitai_tel;

    /* gÑdbÔXVtO */
    char        TMKZs_keitai_tel_flg[1+1];
    short       TMKZsi_keitai_tel_flg;

    /* MAILAhX */
    /*struct { short len; char arr[50+1]; }
                TMKZs_mail;*/
	varchar		TMKZs_mail[50+1];
    short       TMKZsi_mail;

    /* MAILAhXXVtO */
    char        TMKZs_mail_flg[1+1];
    short       TMKZsi_mail_flg;

    /* Î±æ¼¿ */
    /*struct { short len; char arr[80+1]; }
                TMKZs_kinmusaki;*/
	varchar		TMKZs_kinmusaki[80+1];
    short       TMKZsi_kinmusaki;

    /* Î±æ¼¿XVtO */
    char        TMKZs_kinmusaki_flg[1+1];
    short       TMKZsi_kinmusaki_flg;

    /* Î±æ¼Ji */
    /*struct { short len; char arr[80+1]; }
                TMKZs_kinmusaki_kana;*/
	varchar		TMKZs_kinmusaki_kana[80+1];
    short       TMKZsi_kinmusaki_kana;

    /* Î±æ¼JiXVtO */
    char        TMKZs_kinmusaki_kana_flg[1+1];
    short       TMKZsi_kinmusaki_kana_flg;

    /* Î±ædbÔ */
    char        TMKZs_kinmusaki_tel[20+1];
    short       TMKZsi_kinmusaki_tel;

    /* Î±ædbÔXVtO */
    char        TMKZs_kinmusaki_tel_flg[1+1];
    short       TMKZsi_kinmusaki_tel_flg;

/* %01 Add Start */
    /* AæZR[h */
    char        TMKZs_renrakusaki_zip_cd[15+1];
    short       TMKZsi_renrakusaki_zip_cd;

    /* AæXÖÔ */
    char        TMKZs_renrakusaki_zip[10+1];
    short       TMKZsi_renrakusaki_zip;

    /* AæâZ */
    /*struct { short len; char arr[60+1]; }
                TMKZs_renrakusaki_hojo_jyusyo;*/
	varchar		TMKZs_renrakusaki_hojo_jyusyo[60+1];
    short       TMKZsi_renrakusaki_hojo_jyusyo;

    /* AæZÏXtO */
    char        TMKZs_renrakusaki_addressflg[1+1];
    short       TMKZsi_renrakusaki_addressflg;

    /* AæâZJi */
    /*struct { short len; char arr[120+1]; }
                TMKZs_renrakusaki_hojo_jyusyo_kana;*/
	varchar		TMKZs_renrakusaki_hojo_jyusyo_kana[120+1];
    short       TMKZsi_renrakusaki_hojo_jyusyo_kana;

    /* AæZÏXtO */
    char        TMKZs_renrakusaki_address_kana_flg[1+1];
    short       TMKZsi_renrakusaki_address_kana_flg;
/* %01 Add End */

    /* AædbÔ */
    char        TMKZs_renrakusaki_tel[20+1];
    short       TMKZsi_renrakusaki_tel;

    /* AædbÔXVtO */
    char        TMKZs_renrakusaki_tel_flg[1+1];
    short       TMKZsi_renrakusaki_tel_flg;

    /* AæFAXÔ */
    char        TMKZs_renrakusaki_fax[20+1];
    short       TMKZsi_renrakusaki_fax;

    /* AæFAXÔXVtO */
    char        TMKZs_renrakusaki_fax_flg[1+1];
    short       TMKZsi_renrakusaki_fax_flg;

    /* úAædbÔ */
    char        TMKZs_nicchu_tel[20+1];
    short       TMKZsi_nicchu_tel;

    /* úAædbÔXVtO */
    char        TMKZs_nicchu_tel_flg[1+1];
    short       TMKZsi_nicchu_tel_flg;

    /* sõæª */
    char        TMKZs_kouin_kbn[1+1];
    short       TMKZsi_kouin_kbn;

    /* XÖs */
    char        TMKZs_futyaku[1+1];
    short       TMKZsi_futyaku;

    /* ïÐ¾ */
    char        TMKZs_kaisya_ryo[1+1];
    short       TMKZsi_kaisya_ryo;

    /* dbÔÔá¢ */
    char        TMKZs_denwa_matigai[1+1];
    short       TMKZsi_denwa_matigai;

    /* Ú] */
    char        TMKZs_iten[1+1];
    short       TMKZsi_iten;

    /* {lS */
    char        TMKZs_honnin_sibo[1+1];
    short       TMKZsi_honnin_sibo;

    /* }D\z */
    char        TMKZs_yu_shinkoku[20+1];
    short       TMKZsi_yu_shinkoku;

    /* }Dpz */
    char        TMKZs_yu_riyo[20+1];
    short       TMKZsi_yu_riyo;

    /* }Á\z */
    char        TMKZs_toku_shinkoku[20+1];
    short       TMKZsi_toku_shinkoku;

    /* }Ápz */
    char        TMKZs_toku_riyo[20+1];
    short       TMKZsi_toku_riyo;

    /* zXgTMÎÛæª */
    char        TMKZs_host_tm[1+1];
    short       TMKZsi_host_tm;

    /* TMÎÛæª */
    char        TMKZs_tm[1+1];
    short       TMKZsi_tm;

    /* zXgDMÎÛæª */
    char        TMKZs_host_dm[1+1];
    short       TMKZsi_host_dm;

    /* DMÎÛæª */
    char        TMKZs_dm[1+1];
    short       TMKZsi_dm;

/* %01 Add Start */
    /* æøJnú */
    char        TMKZs_deal_day[8+1];
    short       TMKZsi_deal_day;

    /* ¢ÑåtO */
    char        TMKZs_setai_flg[1+1];
    short       TMKZsi_setai_flg;

    /* sàZYc */
    char        TMKZs_zandaka[16+1];
    short       TMKZsi_zandaka;

    /* aèYcP */
    char    TMKZs_azukari_shisan1[16+1];
    short   TMKZsi_azukari_shisan1;

    /* aèYcQ */
    char    TMKZs_azukari_shisan2[16+1];
    short   TMKZsi_azukari_shisan2;

    /* aèYcR */
    char    TMKZs_azukari_shisan3[16+1];
    short   TMKZsi_azukari_shisan3;

    /* ¬®«aàc */
    char    TMKZs_ryudo_zandaka[16+1];
    short   TMKZsi_ryudo_zandaka;

    /* èú«aàc */
    char    TMKZs_teiki_zandaka[16+1];
    short   TMKZsi_teiki_zandaka;

    /* dgaàc */
    char    TMKZs_shikumi_zandaka[16+1];
    short   TMKZsi_shikumi_zandaka;

    /* OÝaàc */
    char    TMKZs_gaika_zandaka[16+1];
    short   TMKZsi_gaika_zandaka;

    /* Mc */
    char    TMKZs_toushin_zandaka[16+1];
    short   TMKZsi_toushin_zandaka;

    /* Âc */
    char    TMKZs_saiken_zandaka[16+1];
    short   TMKZsi_saiken_zandaka;

    /* XN¤ic */
    char    TMKZs_risk_zandaka[16+1];
    short   TMKZsi_risk_zandaka;

    /* eo_ñ */
    char    TMKZs_TB_contract[1+1];
    short   TMKZsi_TB_contract;

    /* eo_ñú */
    char    TMKZs_TB_contract_day[8+1];
    short   TMKZsi_TB_contract_day;

    /* IB_ñ */
    char    TMKZs_IB_contract[1+1];
    short   TMKZsi_IB_contract;

    /* IB_ñÒID */
    char    TMKZs_IB_contract_id[16+1];
    short   TMKZsi_IB_contract_id;

    /* IB_ñ\XÔ */
    char    TMKZs_IB_branch_id[3+1];
    short   TMKZsi_IB_branch_id;

    /* IB_ñã\ûÀÈÚ */
    char    TMKZs_IB_accnt_id[4+1];
    short   TMKZsi_IB_accnt_id;

    /* IB_ñã\ûÀûÔ */
    char    TMKZs_IB_kuchi_no[3+1];
    short   TMKZsi_IB_kuchi_no;

    /* IB_ñú */
    char    TMKZs_IB_contract_day[8+1];
    short   TMKZsi_IB_contract_day;

    /* IB_ñðñú */
    char    TMKZs_IB_cancel_day[8+1];
    short   TMKZsi_IB_cancel_day;

    /* IB_ñÅIXVú */
    char    TMKZs_IB_update_day[8+1];
    short   TMKZsi_IB_update_day;

    /* lbgxX_ñ */
    char    TMKZs_net_contract[1+1];
    short   TMKZsi_net_contract;

    /* lbgxX_ñÒID */
    char    TMKZs_net_contract_id[16+1];
    short   TMKZsi_net_contract_id;

    /* lbgxX_ñ\XÔ */
    char    TMKZs_net_branch_id[3+1];
    short   TMKZsi_net_branch_id;

    /* lbgxX_ñã\ûÀÈÚ */
    char    TMKZs_net_accnt_id[4+1];
    short   TMKZsi_net_accnt_id;

    /* lbgxX_ñã\ûÀûÔ */
    char    TMKZs_net_kuchi_no[3+1];
    short   TMKZsi_net_kuchi_no;

    /* lbgxX_ñú */
    char    TMKZs_net_contract_day[8+1];
    short   TMKZsi_net_contract_day;

    /* lbgxX_ñðñú */
    char    TMKZs_net_cancel_day[8+1];
    short   TMKZsi_net_cancel_day;

    /* lbgxX_ñÅIXVú */
    char    TMKZs_net_update_day[8+1];
    short   TMKZsi_net_update_day;

    /* EÆR[h */
    char    TMKZs_occp_code[4+1];
    short   TMKZsi_occp_code;

    /* Nû */
    char    TMKZs_income[15+1];
    short   TMKZsi_income;

    /* ¾Nx */
    char    TMKZs_income_year[4+1];
    short   TMKZsi_income_year;

    /* æøÇîñ */
    char    TMKZs_torikan[1+1];
    short   TMKZsi_torikan;

    /* SÒ¼ */
    char    TMKZs_operate_name[24+1];
    short   TMKZsi_operate_name;

    /* J[h­sTC */
    char    TMKZs_card_sign[1+1];
    short   TMKZsi_card_sign;

    /* ©îZs¹{§ */
    /*struct { short len; char arr[10+1]; }
            TMKZs_adress1;*/
    varchar	TMKZs_adress1[10+1];
	short   TMKZsi_adress1;

    /* ©îZsæ¬º */
    /*struct { short len; char arr[24+1]; }
            TMKZs_adress2;*/
	varchar		TMKZs_adress2[24+1];
    short   TMKZsi_adress2;

    /* ©îZåÊÌ */
    /*struct { short len; char arr[36+1]; }
            TMKZs_adress3;*/
	varchar		TMKZs_adress3[36+1];
    short   TMKZsi_adress3;

    /* ©îZÚ */
    /*struct { short len; char arr[40+1]; }
            TMKZs_adress4;*/
	varchar		TMKZs_adress4[40+1];
    short   TMKZsi_adress4;

    /* ©îZÔn */
    /*struct { short len; char arr[30+1]; }
            TMKZs_adress5;*/
	varchar		TMKZs_adress5[30+1];
    short   TMKZsi_adress5;

    /* ©îZCt */
    /*struct { short len; char arr[30+1]; }
            TMKZs_adress6;*/
	varchar		TMKZs_adress6[30+1];
    short   TMKZsi_adress6;

    /* ©îZs¹{§Ji */
    /*struct { short len; char arr[20+1]; }
            TMKZs_adress_kana1;*/
	varchar		TMKZs_adress_kana1[20+1];
    short   TMKZsi_adress_kana1;

    /* ©îZsæ¬ºJi */
    /*struct { short len; char arr[48+1]; }
            TMKZs_adress_kana2;*/
	varchar		TMKZs_adress_kana2[48+1];
    short   TMKZsi_adress_kana2;

    /* ©îZåÊÌJi */
    /*struct { short len; char arr[72+1]; }
            TMKZs_adress_kana3;*/
	varchar		TMKZs_adress_kana3[72+1];
    short   TMKZsi_adress_kana3;

    /* ©îZÚJi */
    /*struct { short len; char arr[80+1]; }
            TMKZs_adress_kana4;*/
	varchar		TMKZs_adress_kana4[80+1];
    short   TMKZsi_adress_kana4;

    /* ©îZÔnJi */
    /*struct { short len; char arr[60+1]; }
            TMKZs_adress_kana5;*/
	varchar		TMKZs_adress_kana5[60+1];
    short   TMKZsi_adress_kana5;

    /* ©îZCtJi */
    /*struct { short len; char arr[60+1]; }
            TMKZs_adress_kana6;*/
	varchar		TMKZs_adress_kana6[60+1];
    short   TMKZsi_adress_kana6;

    /* ©îZ */
    /*struct { short len; char arr[170+1]; }
            TMKZs_adress;*/
	varchar		TMKZs_adress[170+1];
    short   TMKZsi_adress;

    /* ©îZJi */
    /*struct { short len; char arr[175+1]; }
            TMKZs_adress_kana;*/
	varchar		TMKZs_adress_kana[175+1];
    short   TMKZsi_adress_kana;

    /* AæZs¹{§ */
    /*struct { short len; char arr[10+1]; }
            TMKZs_renrakusaki_adress1;*/
	varchar		TMKZs_renrakusaki_adress1[10+1];
    short   TMKZsi_renrakusaki_adress1;

    /* AæZsæ¬º */
    /*struct { short len; char arr[24+1]; }
            TMKZs_renrakusaki_adress2;*/
	varchar		TMKZs_renrakusaki_adress2[24+1];
    short   TMKZsi_renrakusaki_adress2;

    /* AæZåÊÌ */
    /*struct { short len; char arr[36+1]; }
            TMKZs_renrakusaki_adress3;*/
	varchar		TMKZs_renrakusaki_adress3[36+1];
    short   TMKZsi_renrakusaki_adress3;

    /* AæZÚ */
    /*struct { short len; char arr[40+1]; }
            TMKZs_renrakusaki_adress4;*/
	varchar		TMKZs_renrakusaki_adress4[40+1];
    short   TMKZsi_renrakusaki_adress4;

    /* AæZÔn */
    /*struct { short len; char arr[30+1]; }
            TMKZs_renrakusaki_adress5;*/
	varchar		TMKZs_renrakusaki_adress5[30+1];
    short   TMKZsi_renrakusaki_adress5;

    /* AæZCt */
    /*struct { short len; char arr[30+1]; }
            TMKZs_renrakusaki_adress6;*/
	varchar		TMKZs_renrakusaki_adress6[30+1];
    short   TMKZsi_renrakusaki_adress6;

    /* AæZs¹{§Ji */
    /*struct { short len; char arr[20+1]; }
            TMKZs_renrakusaki_adress_kana1;*/
	varchar		TMKZs_renrakusaki_adress_kana1[20+1];
    short   TMKZsi_renrakusaki_adress_kana1;

    /* AæZsæ¬ºJi */
    /*struct { short len; char arr[48+1]; }
            TMKZs_renrakusaki_adress_kana2;*/
	varchar		TMKZs_renrakusaki_adress_kana2[48+1];
    short   TMKZsi_renrakusaki_adress_kana2;

    /* AæZåÊÌJi */
    /*struct { short len; char arr[72+1]; }
            TMKZs_renrakusaki_adress_kana3;*/
	varchar		TMKZs_renrakusaki_adress_kana3[72+1];
    short   TMKZsi_renrakusaki_adress_kana3;

    /* AæZÚJi */
    /*struct { short len; char arr[80+1]; }
            TMKZs_renrakusaki_adress_kana4;*/
	varchar		TMKZs_renrakusaki_adress_kana4[80+1];
    short   TMKZsi_renrakusaki_adress_kana4;

    /* AæZÔnJi */
    /*struct { short len; char arr[60+1]; }
            TMKZs_renrakusaki_adress_kana5;*/
	varchar		TMKZs_renrakusaki_adress_kana5[60+1];
    short   TMKZsi_renrakusaki_adress_kana5;

    /* AæZCtJi */
    /*struct { short len; char arr[60+1]; }
            TMKZs_renrakusaki_adress_kana6;*/
	varchar		TMKZs_renrakusaki_adress_kana6[60+1];
    short   TMKZsi_renrakusaki_adress_kana6;

    /* AæZ */
    /*struct { short len; char arr[170+1]; }
            TMKZs_renrakusaki_adress;*/
	varchar		TMKZs_renrakusaki_adress[170+1];
    short   TMKZsi_renrakusaki_adress;

    /* AæZJi */
    /*struct { short len; char arr[175+1]; }
            TMKZs_renrakusaki_adress_kana;*/
	varchar		TMKZs_renrakusaki_adress_kana[175+1];
    short   TMKZsi_renrakusaki_adress_kana;

    /* f[^îú */
    char    TMKZs_data_date[8+1];
    short   TMKZsi_data_date;

	/* }D */
    char    TMKZs_tax_free[1+1];
    short   TMKZsi_tax_free;

    /* XVÒ */
    char    TMKZs_change_name[16+1];
    short   TMKZsi_change_name;

    /* XV^CX^v */
    char    TMKZs_change_timestamp[26+1];
    short   TMKZsi_change_timestamp;

/* %01 Add End */

EXEC SQL END DECLARE SECTION;

