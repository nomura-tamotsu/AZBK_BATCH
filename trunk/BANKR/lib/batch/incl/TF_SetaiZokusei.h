/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC                                           */
/*                                                                          */
/* Description      : ���ё����e�[�u��                                      */
/*                                                                          */
/* File Name        : TF_KokyakuZokusei.h                                   */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/04/10 | ISID        | First Edition.                            */
/*==========================================================================*/
EXEC SQL BEGIN DECLARE SECTION;
    /* �X�� */
    char        TMSZs_tenban[5+1];
    short       TMSZsi_tenban;

    /* CIFNO */
    char        TMSZs_cifno[10+1];
    short       TMSZsi_cifno;

    /* �l��Ɣԍ� */
    char        TMSZs_kojin_kigyo_no[13+1];
    short       TMSZsi_kojin_kigyo_no;

    /* �l�i�敪 */
    char        TMSZs_jinkaku_kbn[1+1];
    short       TMSZsi_jinkaku_kbn;

    /* ���єԍ� */
    char        TMSZs_setai_no[13+1];
    short       TMSZsi_setai_no;

    /* �������� */
    varchar                TMSZs_name_knj[80+1];
    short       TMSZsi_name_knj;

    /* ���������X�V�t���O */
    char        TMSZs_name_knj_flg[1+1];
    short       TMSZsi_name_knj_flg;

    /* �����J�i */
    varchar                TMSZs_name_kna[80+1];
    short       TMSZsi_name_kna;

    /* �����J�i�X�V�t���O */
    char        TMSZs_name_kna_flg[1+1];
    short       TMSZsi_name_kna_flg;

    /* ���� */
    char        TMSZs_sex[1+1];
    short       TMSZsi_sex;

    /* ���ʍX�V�t���O */
    char        TMSZs_sex_flg[1+1];
    short       TMSZsi_sex_flg;

    /* ���N���� */
    char        TMSZs_birthday[8+1];
    short       TMSZsi_birthday;

    /* ���N�����X�V�t���O */
    char        TMSZs_birthday_flg[1+1];
    short       TMSZsi_birthday_flg;

    /* �Z���R�[�h */
    char        TMSZs_zip_cd[15+1];
    short       TMSZsi_zip_cd;

    /* �X�֔ԍ� */
    char        TMSZs_zip[10+1];
    short       TMSZsi_zip;

    /* �⏕�Z�� */
    varchar                TMSZs_hojo_jyusyo[60+1];
    short       TMSZsi_hojo_jyusyo;

    /* �Z���ύX�t���O */
    char        TMSZs_addressflg[1+1];
    short       TMSZsi_addressflg;

/* %01 Add Start */
    /* �⏕�Z���J�i */
    varchar                TMSZs_hojo_jyusyo_kana[120+1];
    short       TMSZsi_hojo_jyusyo_kana;

    /* �Z���J�i�ύX�t���O */
    char        TMSZs_address_kana_flg[1+1];
    short       TMSZsi_address_kana_flg;

/* %01 Add End */

    /* ����d�b�ԍ� */
    char        TMSZs_jitakutel[20+1];
    short       TMSZsi_jitakutel;

    /* ����d�b�ԍ��X�V�t���O */
    char        TMSZs_jitakutel_flg[1+1];
    short       TMSZsi_jitakutel_flg;

    /* ����FAX�ԍ� */
    char        TMSZs_jitaku_fax[20+1];
    short       TMSZsi_jitaku_fax;

    /* ����FAX�ԍ��X�V�t���O */
    char        TMSZs_jitaku_fax_flg[1+1];
    short       TMSZsi_jitaku_fax_flg;

    /* �g�ѓd�b�ԍ� */
    char        TMSZs_keitai_tel[20+1];
    short       TMSZsi_keitai_tel;

    /* �g�ѓd�b�ԍ��X�V�t���O */
    char        TMSZs_keitai_tel_flg[1+1];
    short       TMSZsi_keitai_tel_flg;

    /* MAIL�A�h���X */
    varchar                TMSZs_mail[50+1];
    short       TMSZsi_mail;

    /* MAIL�A�h���X�X�V�t���O */
    char        TMSZs_mail_flg[1+1];
    short       TMSZsi_mail_flg;

    /* �Ζ��於���� */
    varchar                TMSZs_kinmusaki[80+1];
    short       TMSZsi_kinmusaki;

    /* �Ζ��於�����X�V�t���O */
    char        TMSZs_kinmusaki_flg[1+1];
    short       TMSZsi_kinmusaki_flg;

    /* �Ζ��於�J�i */
    varchar                TMSZs_kinmusaki_kana[80+1];
    short       TMSZsi_kinmusaki_kana;

    /* �Ζ��於�J�i�X�V�t���O */
    char        TMSZs_kinmusaki_kana_flg[1+1];
    short       TMSZsi_kinmusaki_kana_flg;

    /* �Ζ���d�b�ԍ� */
    char        TMSZs_kinmusaki_tel[20+1];
    short       TMSZsi_kinmusaki_tel;

    /* �Ζ���d�b�ԍ��X�V�t���O */
    char        TMSZs_kinmusaki_tel_flg[1+1];
    short       TMSZsi_kinmusaki_tel_flg;

/* %01 Add Start */
    /* �A����Z���R�[�h */
    char        TMSZs_renrakusaki_zip_cd[15+1];
    short       TMSZsi_renrakusaki_zip_cd;

    /* �A����X�֔ԍ� */
    char        TMSZs_renrakusaki_zip[10+1];
    short       TMSZsi_renrakusaki_zip;

    /* �A����⏕�Z�� */
    varchar                TMSZs_renrakusaki_hojo_jyusyo[60+1];
    short       TMSZsi_renrakusaki_hojo_jyusyo;

    /* �A����Z���ύX�t���O */
    char        TMSZs_renrakusaki_addressflg[1+1];
    short       TMSZsi_renrakusaki_addressflg;

    /* �A����⏕�Z���J�i */
    varchar                TMSZs_renrakusaki_hojo_jyusyo_kana[120+1];
    short       TMSZsi_renrakusaki_hojo_jyusyo_kana;

    /* �A����Z���ύX�t���O */
    char        TMSZs_renrakusaki_address_kana_flg[1+1];
    short       TMSZsi_renrakusaki_address_kana_flg;
/* %01 Add End */

    /* �A����d�b�ԍ� */
    char        TMSZs_renrakusaki_tel[20+1];
    short       TMSZsi_renrakusaki_tel;

    /* �A����d�b�ԍ��X�V�t���O */
    char        TMSZs_renrakusaki_tel_flg[1+1];
    short       TMSZsi_renrakusaki_tel_flg;

    /* �A����FAX�ԍ� */
    char        TMSZs_renrakusaki_fax[20+1];
    short       TMSZsi_renrakusaki_fax;

    /* �A����FAX�ԍ��X�V�t���O */
    char        TMSZs_renrakusaki_fax_flg[1+1];
    short       TMSZsi_renrakusaki_fax_flg;

    /* �����A����d�b�ԍ� */
    char        TMSZs_nicchu_tel[20+1];
    short       TMSZsi_nicchu_tel;

    /* �����A����d�b�ԍ��X�V�t���O */
    char        TMSZs_nicchu_tel_flg[1+1];
    short       TMSZsi_nicchu_tel_flg;

    /* �s���敪 */
    char        TMSZs_kouin_kbn[1+1];
    short       TMSZsi_kouin_kbn;

    /* �X�֕s�� */
    char        TMSZs_futyaku[1+1];
    short       TMSZsi_futyaku;

    /* ��З� */
    char        TMSZs_kaisya_ryo[1+1];
    short       TMSZsi_kaisya_ryo;

    /* �d�b�ԍ��ԈႢ */
    char        TMSZs_denwa_matigai[1+1];
    short       TMSZsi_denwa_matigai;

    /* �ړ] */
    char        TMSZs_iten[1+1];
    short       TMSZsi_iten;

    /* �{�l���S */
    char        TMSZs_honnin_sibo[1+1];
    short       TMSZsi_honnin_sibo;

    /* �}���D�\���z */
    char        TMSZs_yu_shinkoku[20+1];
    short       TMSZsi_yu_shinkoku;

    /* �}���D���p�z */
    char        TMSZs_yu_riyo[20+1];
    short       TMSZsi_yu_riyo;

    /* �}�����\���z */
    char        TMSZs_toku_shinkoku[20+1];
    short       TMSZsi_toku_shinkoku;

    /* �}�������p�z */
    char        TMSZs_toku_riyo[20+1];
    short       TMSZsi_toku_riyo;

    /* �z�X�gTM�Ώۋ敪 */
    char        TMSZs_host_tm[1+1];
    short       TMSZsi_host_tm;

    /* TM�Ώۋ敪 */
    char        TMSZs_tm[1+1];
    short       TMSZsi_tm;

    /* �z�X�gDM�Ώۋ敪 */
    char        TMSZs_host_dm[1+1];
    short       TMSZsi_host_dm;

    /* DM�Ώۋ敪 */
    char        TMSZs_dm[1+1];
    short       TMSZsi_dm;

/* %01 Add Start */
    /* ����J�n�� */
    char        TMSZs_deal_day[8+1];
    short       TMSZsi_deal_day;

    /* ���ю�t���O */
    char        TMSZs_setai_flg[1+1];
    short       TMSZsi_setai_flg;

    /* ���s���Z���Y�c�� */
    char        TMSZs_zandaka[16+1];
    short       TMSZsi_zandaka;

    /* �a�莑�Y�c���P */
    char    TMSZs_azukari_shisan1[16+1];
    short   TMSZsi_azukari_shisan1;

    /* �a�莑�Y�c���Q */
    char    TMSZs_azukari_shisan2[16+1];
    short   TMSZsi_azukari_shisan2;

    /* �a�莑�Y�c���R */
    char    TMSZs_azukari_shisan3[16+1];
    short   TMSZsi_azukari_shisan3;

    /* �������a���c�� */
    char    TMSZs_ryudo_zandaka[16+1];
    short   TMSZsi_ryudo_zandaka;

    /* ������a���c�� */
    char    TMSZs_teiki_zandaka[16+1];
    short   TMSZsi_teiki_zandaka;

    /* �d�g�a���c�� */
    char    TMSZs_shikumi_zandaka[16+1];
    short   TMSZsi_shikumi_zandaka;

    /* �O�ݗa���c�� */
    char    TMSZs_gaika_zandaka[16+1];
    short   TMSZsi_gaika_zandaka;

    /* ���M�c�� */
    char    TMSZs_toushin_zandaka[16+1];
    short   TMSZsi_toushin_zandaka;

    /* ���c�� */
    char    TMSZs_saiken_zandaka[16+1];
    short   TMSZsi_saiken_zandaka;

    /* ���X�N���i�c�� */
    char    TMSZs_risk_zandaka[16+1];
    short   TMSZsi_risk_zandaka;

    /* �e���o���_�� */
    char    TMSZs_TB_contract[1+1];
    short   TMSZsi_TB_contract;

    /* �e���o���_��� */
    char    TMSZs_TB_contract_day[8+1];
    short   TMSZsi_TB_contract_day;

    /* IB�_�� */
    char    TMSZs_IB_contract[1+1];
    short   TMSZsi_IB_contract;

    /* IB�_���ID */
    char    TMSZs_IB_contract_id[16+1];
    short   TMSZsi_IB_contract_id;

    /* IB�_��\���X�� */
    char    TMSZs_IB_branch_id[3+1];
    short   TMSZsi_IB_branch_id;

    /* IB�_���\�����Ȗ� */
    char    TMSZs_IB_accnt_id[4+1];
    short   TMSZsi_IB_accnt_id;

    /* IB�_���\�������ԍ� */
    char    TMSZs_IB_kuchi_no[3+1];
    short   TMSZsi_IB_kuchi_no;

    /* IB�_��� */
    char    TMSZs_IB_contract_day[8+1];
    short   TMSZsi_IB_contract_day;

    /* IB�_����� */
    char    TMSZs_IB_cancel_day[8+1];
    short   TMSZsi_IB_cancel_day;

    /* IB�_��ŏI�X�V�� */
    char    TMSZs_IB_update_day[8+1];
    short   TMSZsi_IB_update_day;

    /* �l�b�g�x�X�_�� */
    char    TMSZs_net_contract[1+1];
    short   TMSZsi_net_contract;

    /* �l�b�g�x�X�_���ID */
    char    TMSZs_net_contract_id[16+1];
    short   TMSZsi_net_contract_id;

    /* �l�b�g�x�X�_��\���X�� */
    char    TMSZs_net_branch_id[3+1];
    short   TMSZsi_net_branch_id;

    /* �l�b�g�x�X�_���\�����Ȗ� */
    char    TMSZs_net_accnt_id[4+1];
    short   TMSZsi_net_accnt_id;

    /* �l�b�g�x�X�_���\�������ԍ� */
    char    TMSZs_net_kuchi_no[3+1];
    short   TMSZsi_net_kuchi_no;

    /* �l�b�g�x�X�_��� */
    char    TMSZs_net_contract_day[8+1];
    short   TMSZsi_net_contract_day;

    /* �l�b�g�x�X�_����� */
    char    TMSZs_net_cancel_day[8+1];
    short   TMSZsi_net_cancel_day;

    /* �l�b�g�x�X�_��ŏI�X�V�� */
    char    TMSZs_net_update_day[8+1];
    short   TMSZsi_net_update_day;

    /* �E�ƃR�[�h */
    char    TMSZs_occp_code[4+1];
    short   TMSZsi_occp_code;

    /* �N�� */
    char    TMSZs_income[15+1];
    short   TMSZsi_income;

    /* �����N�x */
    char    TMSZs_income_year[4+1];
    short   TMSZsi_income_year;

    /* ����Ǘ���� */
    char    TMSZs_torikan[1+1];
    short   TMSZsi_torikan;

    /* �S���Җ� */
    char    TMSZs_operate_name[24+1];
    short   TMSZsi_operate_name;

    /* �J�[�h���s�T�C�� */
    char    TMSZs_card_sign[1+1];
    short   TMSZsi_card_sign;

    /* ����Z���s���{�� */
    varchar            TMSZs_adress1[10+1];
    short   TMSZsi_adress1;

    /* ����Z���s�撬�� */
    varchar            TMSZs_adress2[24+1];
    short   TMSZsi_adress2;

    /* ����Z���厚�ʏ� */
    varchar            TMSZs_adress3[36+1];
    short   TMSZsi_adress3;

    /* ����Z�������� */
    varchar            TMSZs_adress4[40+1];
    short   TMSZsi_adress4;

    /* ����Z���Ԓn */
    varchar            TMSZs_adress5[30+1];
    short   TMSZsi_adress5;

    /* ����Z���C�t */
    varchar            TMSZs_adress6[30+1];
    short   TMSZsi_adress6;

    /* ����Z���s���{���J�i */
    varchar            TMSZs_adress_kana1[20+1];
    short   TMSZsi_adress_kana1;

    /* ����Z���s�撬���J�i */
    varchar            TMSZs_adress_kana2[48+1];
    short   TMSZsi_adress_kana2;

    /* ����Z���厚�ʏ̃J�i */
    varchar            TMSZs_adress_kana3[72+1];
    short   TMSZsi_adress_kana3;

    /* ����Z�������ڃJ�i */
    varchar            TMSZs_adress_kana4[80+1];
    short   TMSZsi_adress_kana4;

    /* ����Z���Ԓn�J�i */
    varchar            TMSZs_adress_kana5[60+1];
    short   TMSZsi_adress_kana5;

    /* ����Z���C�t�J�i */
    varchar            TMSZs_adress_kana6[60+1];
    short   TMSZsi_adress_kana6;

    /* ����Z�� */
    varchar            TMSZs_adress[170+1];
    short   TMSZsi_adress;

    /* ����Z���J�i */
    varchar            TMSZs_adress_kana[175+1];
    short   TMSZsi_adress_kana;

    /* �A����Z���s���{�� */
    varchar            TMSZs_renrakusaki_adress1[10+1];
    short   TMSZsi_renrakusaki_adress1;

    /* �A����Z���s�撬�� */
    varchar            TMSZs_renrakusaki_adress2[24+1];
    short   TMSZsi_renrakusaki_adress2;

    /* �A����Z���厚�ʏ� */
    varchar            TMSZs_renrakusaki_adress3[36+1];
    short   TMSZsi_renrakusaki_adress3;

    /* �A����Z�������� */
    varchar            TMSZs_renrakusaki_adress4[40+1];
    short   TMSZsi_renrakusaki_adress4;

    /* �A����Z���Ԓn */
    varchar            TMSZs_renrakusaki_adress5[30+1];
    short   TMSZsi_renrakusaki_adress5;

    /* �A����Z���C�t */
    varchar            TMSZs_renrakusaki_adress6[30+1];
    short   TMSZsi_renrakusaki_adress6;

    /* �A����Z���s���{���J�i */
    varchar            TMSZs_renrakusaki_adress_kana1[20+1];
    short   TMSZsi_renrakusaki_adress_kana1;

    /* �A����Z���s�撬���J�i */
    varchar            TMSZs_renrakusaki_adress_kana2[48+1];
    short   TMSZsi_renrakusaki_adress_kana2;

    /* �A����Z���厚�ʏ̃J�i */
    varchar            TMSZs_renrakusaki_adress_kana3[72+1];
    short   TMSZsi_renrakusaki_adress_kana3;

    /* �A����Z�������ڃJ�i */
    varchar            TMSZs_renrakusaki_adress_kana4[80+1];
    short   TMSZsi_renrakusaki_adress_kana4;

    /* �A����Z���Ԓn�J�i */
    varchar            TMSZs_renrakusaki_adress_kana5[60+1];
    short   TMSZsi_renrakusaki_adress_kana5;

    /* �A����Z���C�t�J�i */
    varchar            TMSZs_renrakusaki_adress_kana6[60+1];
    short   TMSZsi_renrakusaki_adress_kana6;

    /* �A����Z�� */
    varchar            TMSZs_renrakusaki_adress[170+1];
    short   TMSZsi_renrakusaki_adress;

    /* �A����Z���J�i */
    varchar            TMSZs_renrakusaki_adress_kana[175+1];
    short   TMSZsi_renrakusaki_adress_kana;

    /* �f�[�^��� */
    char    TMSZs_data_date[8+1];
    short   TMSZsi_data_date;

	/* �}���D */
    char    TMSZs_tax_free[1+1];
    short   TMSZsi_tax_free;

    /* �X�V�� */
    char    TMSZs_change_name[16+1];
    short   TMSZsi_change_name;

    /* �X�V�^�C���X�^���v */
    char    TMSZs_change_timestamp[26+1];
    short   TMSZsi_change_timestamp;

/* %01 Add End */

EXEC SQL END DECLARE SECTION;