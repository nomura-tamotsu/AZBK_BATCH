/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC                                           */
/*                                                                          */
/* Description      : �ڋq�����e�[�u��                                      */
/*                                                                          */
/* File Name        : TF_KokyakuZokusei.h                                   */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/04/08 | ISID        | First Edition.                            */
/* %02 | 15/01/30 | �y�� �N��Y | ��������1.0���Ή�                         */
/* %03 | 15/02/16 | �y�� �N��Y | DB�ƒ������قȂ��Ă��鍀�ڏC��            */
/*==========================================================================*/
EXEC SQL BEGIN DECLARE SECTION;
    /* �X�� */
    char        TMKZs_tenban[5+1];
    short       TMKZsi_tenban;

    /* CIFNO */
    char        TMKZs_cifno[10+1];
    short       TMKZsi_cifno;

    /* �l��Ɣԍ� */
    char        TMKZs_kojin_kigyo_no[13+1];
    short       TMKZsi_kojin_kigyo_no;

    /* �l�i�敪 */
    char        TMKZs_jinkaku_kbn[1+1];
    short       TMKZsi_jinkaku_kbn;

    /* ���єԍ� */
    char        TMKZs_setai_no[13+1];
    short       TMKZsi_setai_no;

    /* �������� */
    varchar     TMKZs_name_knj[80+1];
    short       TMKZsi_name_knj;

    /* ���������X�V�t���O */
    char        TMKZs_name_knj_flg[1+1];
    short       TMKZsi_name_knj_flg;

    /* �����J�i */
    varchar     TMKZs_name_kna[80+1];
    short       TMKZsi_name_kna;

    /* �����J�i�X�V�t���O */
    char        TMKZs_name_kna_flg[1+1];
    short       TMKZsi_name_kna_flg;

    /* ���� */
    char        TMKZs_sex[1+1];
    short       TMKZsi_sex;

    /* ���ʍX�V�t���O */
    char        TMKZs_sex_flg[1+1];
    short       TMKZsi_sex_flg;

    /* ���N���� */
    char        TMKZs_birthday[8+1];
    short       TMKZsi_birthday;

    /* ���N�����X�V�t���O */
    char        TMKZs_birthday_flg[1+1];
    short       TMKZsi_birthday_flg;

    /* �Z���R�[�h */
    char        TMKZs_zip_cd[15+1];
    short       TMKZsi_zip_cd;

    /* �X�֔ԍ� */
    char        TMKZs_zip[10+1];
    short       TMKZsi_zip;

    /* �⏕�Z�� */
/* %02 1.0���Ή� EditStart */
//  varchar     TMKZs_hojo_jyusyo[70+1];
    varchar     TMKZs_hojo_jyusyo[100+1];
/* %02 Edit End */
    short       TMKZsi_hojo_jyusyo;

    /* �Z���ύX�t���O */
    char        TMKZs_addressflg[1+1];
    short       TMKZsi_addressflg;

/* %01 Add Start */
    /* �⏕�Z���J�i */
/* %02 1.0���Ή� EditStart */
//  varchar     TMKZs_hojo_jyusyo_kana[70+1];
    varchar     TMKZs_hojo_jyusyo_kana[100+1];
/* %02 Edit End */
    short       TMKZsi_hojo_jyusyo_kana;

    /* �Z���J�i�ύX�t���O */
    char        TMKZs_address_kana_flg[1+1];
    short       TMKZsi_address_kana_flg;

/* %01 Add End */

    /* ����d�b�ԍ� */
/* %03 EditStart */
//    char        TMKZs_jitakutel[20+1];
    char        TMKZs_jitakutel[15+1];
/* %03 EditEnd */
    short       TMKZsi_jitakutel;

    /* ����d�b�ԍ��X�V�t���O */
    char        TMKZs_jitakutel_flg[1+1];
    short       TMKZsi_jitakutel_flg;

    /* ����FAX�ԍ� */
/* %03 EditStart */
//    char        TMKZs_jitaku_fax[20+1];
    char        TMKZs_jitaku_fax[15+1];
/* %03 EditEnd */
    short       TMKZsi_jitaku_fax;

    /* ����FAX�ԍ��X�V�t���O */
    char        TMKZs_jitaku_fax_flg[1+1];
    short       TMKZsi_jitaku_fax_flg;

    /* �g�ѓd�b�ԍ� */
/* %03 EditStart */
//    char        TMKZs_keitai_tel[20+1];
    char        TMKZs_keitai_tel[15+1];
/* %03 EditEnd */
    short       TMKZsi_keitai_tel;

    /* �g�ѓd�b�ԍ��X�V�t���O */
    char        TMKZs_keitai_tel_flg[1+1];
    short       TMKZsi_keitai_tel_flg;

    /* MAIL�A�h���X */
    varchar     TMKZs_mail[50+1];
    short       TMKZsi_mail;

    /* MAIL�A�h���X�X�V�t���O */
    char        TMKZs_mail_flg[1+1];
    short       TMKZsi_mail_flg;

    /* �Ζ��於���� */
    varchar     TMKZs_kinmusaki[80+1];
    short       TMKZsi_kinmusaki;

    /* �Ζ��於�����X�V�t���O */
    char        TMKZs_kinmusaki_flg[1+1];
    short       TMKZsi_kinmusaki_flg;

    /* �Ζ��於�J�i */
    varchar     TMKZs_kinmusaki_kana[80+1];
    short       TMKZsi_kinmusaki_kana;

    /* �Ζ��於�J�i�X�V�t���O */
    char        TMKZs_kinmusaki_kana_flg[1+1];
    short       TMKZsi_kinmusaki_kana_flg;

    /* �Ζ���d�b�ԍ� */
/* %03 EditStart */
//    char        TMKZs_kinmusaki_tel[20+1];
    char        TMKZs_kinmusaki_tel[15+1];
/* %03 EditEnd */
    short       TMKZsi_kinmusaki_tel;

    /* �Ζ���d�b�ԍ��X�V�t���O */
    char        TMKZs_kinmusaki_tel_flg[1+1];
    short       TMKZsi_kinmusaki_tel_flg;

/* %01 Add Start */
    /* �A����Z���R�[�h */
    char        TMKZs_renrakusaki_zip_cd[15+1];
    short       TMKZsi_renrakusaki_zip_cd;

    /* �A����X�֔ԍ� */
    char        TMKZs_renrakusaki_zip[10+1];
    short       TMKZsi_renrakusaki_zip;

    /* �A����⏕�Z�� */
/* %02 1.0���Ή� EditStart */
//  varchar     TMKZs_renrakusaki_hojo_jyusyo[60+1];
    varchar     TMKZs_renrakusaki_hojo_jyusyo[100+1];
/* %02 Edit End */
    short       TMKZsi_renrakusaki_hojo_jyusyo;

    /* �A����Z���ύX�t���O */
    char        TMKZs_renrakusaki_addressflg[1+1];
    short       TMKZsi_renrakusaki_addressflg;

    /* �A����⏕�Z���J�i */
/* %02 1.0���Ή� EditStart */
//  varchar     TMKZs_renrakusaki_hojo_jyusyo_kana[120+1];
    varchar     TMKZs_renrakusaki_hojo_jyusyo_kana[100+1];
/* %02 Edit End */
    short       TMKZsi_renrakusaki_hojo_jyusyo_kana;

    /* �A����Z���ύX�t���O */
    char        TMKZs_renrakusaki_address_kana_flg[1+1];
    short       TMKZsi_renrakusaki_address_kana_flg;
/* %01 Add End */

    /* �A����d�b�ԍ� */
/* %03 EditStart */
//    char        TMKZs_renrakusaki_tel[20+1];
    char        TMKZs_renrakusaki_tel[15+1];
/* %03 EditEnd */
    short       TMKZsi_renrakusaki_tel;

    /* �A����d�b�ԍ��X�V�t���O */
    char        TMKZs_renrakusaki_tel_flg[1+1];
    short       TMKZsi_renrakusaki_tel_flg;

    /* �A����FAX�ԍ� */
/* %03 EditStart */
//    char        TMKZs_renrakusaki_fax[20+1];
    char        TMKZs_renrakusaki_fax[15+1];
/* %03 EditEnd */
    short       TMKZsi_renrakusaki_fax;

    /* �A����FAX�ԍ��X�V�t���O */
    char        TMKZs_renrakusaki_fax_flg[1+1];
    short       TMKZsi_renrakusaki_fax_flg;

    /* �����A����d�b�ԍ� */
/* %03 EditStart */
//    char        TMKZs_nicchu_tel[20+1];
    char        TMKZs_nicchu_tel[15+1];
/* %03 EditEnd */
    short       TMKZsi_nicchu_tel;

    /* �����A����d�b�ԍ��X�V�t���O */
    char        TMKZs_nicchu_tel_flg[1+1];
    short       TMKZsi_nicchu_tel_flg;

    /* �s���敪 */
    char        TMKZs_kouin_kbn[1+1];
    short       TMKZsi_kouin_kbn;

    /* �X�֕s�� */
    char        TMKZs_futyaku[1+1];
    short       TMKZsi_futyaku;

    /* ��З� */
    char        TMKZs_kaisya_ryo[1+1];
    short       TMKZsi_kaisya_ryo;

    /* �d�b�ԍ��ԈႢ */
    char        TMKZs_denwa_matigai[1+1];
    short       TMKZsi_denwa_matigai;

    /* �ړ] */
    char        TMKZs_iten[1+1];
    short       TMKZsi_iten;

    /* �{�l���S */
    char        TMKZs_honnin_sibo[1+1];
    short       TMKZsi_honnin_sibo;

    /*  �ē��敪 */
    char        TMKZs_annai_kbn[1+1];
    short       TMKZsi_annai_kbn;

    /*  �D�ǋ敪 */
    char        TMKZs_yuryo_kbn[1+1];
    short       TMKZsi_yuryo_kbn;

    /*  ������� */
    char        TMKZs_mitorihikisaki[1+1];
    short       TMKZsi_mitorihikisaki;

    /* �}���D�\���z */
    char        TMKZs_yu_shinkoku[20+1];
    short       TMKZsi_yu_shinkoku;

    /* �}���D���p�z */
    char        TMKZs_yu_riyo[20+1];
    short       TMKZsi_yu_riyo;

    /* �}�����\���z */
    char        TMKZs_toku_shinkoku[20+1];
    short       TMKZsi_toku_shinkoku;

    /* �}�������p�z */
    char        TMKZs_toku_riyo[20+1];
    short       TMKZsi_toku_riyo;

    /* �z�X�gTM�Ώۋ敪 */
    char        TMKZs_host_tm[1+1];
    short       TMKZsi_host_tm;

    /* TM�Ώۋ敪 */
    char        TMKZs_tm[1+1];
    short       TMKZsi_tm;

    /* �z�X�gDM�Ώۋ敪 */
    char        TMKZs_host_dm[1+1];
    short       TMKZsi_host_dm;

    /* DM�Ώۋ敪 */
    char        TMKZs_dm[1+1];
    short       TMKZsi_dm;

/* %01 Add Start */
    /* ����J�n�� */
    char        TMKZs_deal_day[8+1];
    short       TMKZsi_deal_day;

    /* ���ю�t���O */
    char        TMKZs_setai_flg[1+1];
    short       TMKZsi_setai_flg;

    /* ���s���Z���Y�c�� */
    char        TMKZs_zandaka[16+1];
    short       TMKZsi_zandaka;

    /* �a�莑�Y�c���P */
    char    TMKZs_azukari_shisan1[16+1];
    short   TMKZsi_azukari_shisan1;

    /* �a�莑�Y�c���Q */
    char    TMKZs_azukari_shisan2[16+1];
    short   TMKZsi_azukari_shisan2;

    /* �a�莑�Y�c���R */
    char    TMKZs_azukari_shisan3[16+1];
    short   TMKZsi_azukari_shisan3;

    /* �������a���c�� */
    char    TMKZs_ryudo_zandaka[16+1];
    short   TMKZsi_ryudo_zandaka;

    /* ������a���c�� */
    char    TMKZs_teiki_zandaka[16+1];
    short   TMKZsi_teiki_zandaka;

    /* �d�g�a���c�� */
    char    TMKZs_shikumi_zandaka[16+1];
    short   TMKZsi_shikumi_zandaka;

    /* �O�ݗa���c�� */
    char    TMKZs_gaika_zandaka[16+1];
    short   TMKZsi_gaika_zandaka;

    /* ���M�c�� */
    char    TMKZs_toushin_zandaka[16+1];
    short   TMKZsi_toushin_zandaka;

    /* ���c�� */
    char    TMKZs_saiken_zandaka[16+1];
    short   TMKZsi_saiken_zandaka;

    /* ���X�N���i�c�� */
    char    TMKZs_risk_zandaka[16+1];
    short   TMKZsi_risk_zandaka;

    /* �e���o���_�� */
    char    TMKZs_TB_contract[1+1];
    short   TMKZsi_TB_contract;

    /* �e���o���_��� */
    char    TMKZs_TB_contract_day[8+1];
    short   TMKZsi_TB_contract_day;

    /* IB�_�� */
    char    TMKZs_IB_contract[1+1];
    short   TMKZsi_IB_contract;

    /* IB�_���ID */
    char    TMKZs_IB_contract_id[16+1];
    short   TMKZsi_IB_contract_id;

    /* IB�_��\���X�� */
/* %03 EditStart */
//    char    TMKZs_IB_branch_id[3+1];
    char    TMKZs_IB_branch_id[5+1];
/* %03 Edit End */
    short   TMKZsi_IB_branch_id;

    /* IB�_���\�����Ȗ� */
    char    TMKZs_IB_accnt_id[4+1];
    short   TMKZsi_IB_accnt_id;

/* %02 1.0���Ή� EditStart */
//    /* IB�_���\�������ԍ� */
//    char    TMKZs_IB_kuchi_no[3+1];
    /* IB�_���\�����ԍ� */
    char    TMKZs_IB_kuchi_no[15+1];
/* %02 Edit End */
    short   TMKZsi_IB_kuchi_no;

    /* IB�_��� */
    char    TMKZs_IB_contract_day[8+1];
    short   TMKZsi_IB_contract_day;

    /* IB�_����� */
    char    TMKZs_IB_cancel_day[8+1];
    short   TMKZsi_IB_cancel_day;

    /* IB�_��ŏI�X�V�� */
    char    TMKZs_IB_update_day[8+1];
    short   TMKZsi_IB_update_day;

    /* �l�b�g�x�X�_�� */
    char    TMKZs_net_contract[1+1];
    short   TMKZsi_net_contract;

    /* �l�b�g�x�X�_���ID */
    char    TMKZs_net_contract_id[16+1];
    short   TMKZsi_net_contract_id;

    /* �l�b�g�x�X�_��\���X�� */
/* %03 EditStart */
//    char    TMKZs_net_branch_id[3+1];
    char    TMKZs_net_branch_id[5+1];
/* %03 EditEND */
    short   TMKZsi_net_branch_id;

    /* �l�b�g�x�X�_���\�����Ȗ� */
    char    TMKZs_net_accnt_id[4+1];
    short   TMKZsi_net_accnt_id;

    /* �l�b�g�x�X�_���\�������ԍ� */
    char    TMKZs_net_kuchi_no[3+1];
    short   TMKZsi_net_kuchi_no;

    /* �l�b�g�x�X�_��� */
    char    TMKZs_net_contract_day[8+1];
    short   TMKZsi_net_contract_day;

    /* �l�b�g�x�X�_����� */
    char    TMKZs_net_cancel_day[8+1];
    short   TMKZsi_net_cancel_day;

    /* �l�b�g�x�X�_��ŏI�X�V�� */
    char    TMKZs_net_update_day[8+1];
    short   TMKZsi_net_update_day;

    /* �E�ƃR�[�h */
    char    TMKZs_occp_code[4+1];
    short   TMKZsi_occp_code;

    /* �N�� */
    char    TMKZs_income[15+1];
    short   TMKZsi_income;

    /* �����N�x */
    char    TMKZs_income_year[4+1];
    short   TMKZsi_income_year;

    /* ����Ǘ���� */
    char    TMKZs_torikan[1+1];
    short   TMKZsi_torikan;

    /* �S���Җ� */
    char    TMKZs_operate_name[24+1];
    short   TMKZsi_operate_name;

    /* �J�[�h���s�T�C�� */
    char    TMKZs_card_sign[1+1];
    short   TMKZsi_card_sign;

    /* ����Z���s���{�� */
    varchar TMKZs_adress1[10+1];
    short   TMKZsi_adress1;

    /* ����Z���s�撬�� */
    varchar     TMKZs_adress2[24+1];
    short   TMKZsi_adress2;

    /* ����Z���厚�ʏ� */
    varchar     TMKZs_adress3[36+1];
    short   TMKZsi_adress3;

    /* ����Z�������� */
    varchar     TMKZs_adress4[40+1];
    short   TMKZsi_adress4;

/* %02 1.0���Ή� EditStart */
//    /* ����Z���Ԓn */
//  varchar     TMKZs_adress5[30+1];
    /* ����Z���Ԓn�C�t */
    varchar     TMKZs_adress5[100+1];
/* %02 Edit End */
    short   TMKZsi_adress5;

/* %02 1.0���Ή� EDIT Start */
//    /* ����Z���C�t �y���g�p�z*/
/* %02 1.0���Ή� EDIT End */
    varchar     TMKZs_adress6[30+1];
    short   TMKZsi_adress6;

    /* ����Z���s���{���J�i */
    varchar     TMKZs_adress_kana1[20+1];
    short   TMKZsi_adress_kana1;

    /* ����Z���s�撬���J�i */
    varchar     TMKZs_adress_kana2[48+1];
    short   TMKZsi_adress_kana2;

    /* ����Z���厚�ʏ̃J�i */
    varchar     TMKZs_adress_kana3[72+1];
    short   TMKZsi_adress_kana3;

    /* ����Z�������ڃJ�i */
    varchar     TMKZs_adress_kana4[80+1];
    short   TMKZsi_adress_kana4;

/* %02 1.0���Ή� EDIT Start */
    /* ����Z���Ԓn�J�i */
//  varchar     TMKZs_adress_kana5[60+1];
    /* ����Z���Ԓn�C�t�J�i */
    varchar     TMKZs_adress_kana5[84+1];
/* %02 Edit End */
    short   TMKZsi_adress_kana5;

/* %02 1.0���Ή� EDIT Start */
//    /* ����Z���C�t�J�i �y���g�p�z*/
/* %02 1.0���Ή� DELETE End */
    varchar     TMKZs_adress_kana6[60+1];
    short   TMKZsi_adress_kana6;

    /* ����Z�� */
    varchar     TMKZs_adress[170+1];
    short   TMKZsi_adress;

    /* ����Z���J�i */
    varchar     TMKZs_adress_kana[175+1];
    short   TMKZsi_adress_kana;

    /* �A����Z���s���{�� */
    varchar     TMKZs_renrakusaki_adress1[10+1];
    short   TMKZsi_renrakusaki_adress1;

    /* �A����Z���s�撬�� */
    varchar     TMKZs_renrakusaki_adress2[24+1];
    short   TMKZsi_renrakusaki_adress2;

    /* �A����Z���厚�ʏ� */
    varchar     TMKZs_renrakusaki_adress3[36+1];
    short   TMKZsi_renrakusaki_adress3;

    /* �A����Z�������� */
    varchar     TMKZs_renrakusaki_adress4[40+1];
    short   TMKZsi_renrakusaki_adress4;

/* %02 1.0���Ή� EDIT Start */
//    /* �A����Z���Ԓn */
//  varchar     TMKZs_renrakusaki_adress5[30+1];
    /* �A����Z���Ԓn�C�t */
    varchar     TMKZs_renrakusaki_adress5[100+1];
/* %02 Edit End */
    short   TMKZsi_renrakusaki_adress5;

    /* �A����Z���C�t �y���g�p�z*/
    varchar     TMKZs_renrakusaki_adress6[30+1];
    short   TMKZsi_renrakusaki_adress6;

    /* �A����Z���s���{���J�i */
    varchar     TMKZs_renrakusaki_adress_kana1[20+1];
    short   TMKZsi_renrakusaki_adress_kana1;

    /* �A����Z���s�撬���J�i */
    varchar     TMKZs_renrakusaki_adress_kana2[48+1];
    short   TMKZsi_renrakusaki_adress_kana2;

    /* �A����Z���厚�ʏ̃J�i */
    varchar     TMKZs_renrakusaki_adress_kana3[72+1];
    short   TMKZsi_renrakusaki_adress_kana3;

    /* �A����Z�������ڃJ�i */
    varchar     TMKZs_renrakusaki_adress_kana4[80+1];
    short   TMKZsi_renrakusaki_adress_kana4;

/* %02 1.0���Ή� EDIT Start */
//    /* �A����Z���Ԓn�J�i */
//  varchar     TMKZs_renrakusaki_adress_kana5[60+1];
    /* �A����Z���Ԓn�C�t�J�i */
    varchar     TMKZs_renrakusaki_adress_kana5[84+1];
/* %02 Edit End */
    short   TMKZsi_renrakusaki_adress_kana5;

/* %02 1.0���Ή� DELETE Start */
//    /* �A����Z���C�t�J�i �y���g�p�z*/
/* %02 EDIT End */
    varchar     TMKZs_renrakusaki_adress_kana6[60+1];
    short   TMKZsi_renrakusaki_adress_kana6;

    /* �A����Z�� */
    varchar     TMKZs_renrakusaki_adress[170+1];
    short   TMKZsi_renrakusaki_adress;

    /* �A����Z���J�i */
    varchar     TMKZs_renrakusaki_adress_kana[175+1];
    short   TMKZsi_renrakusaki_adress_kana;

    /* �f�[�^��� */
    char    TMKZs_data_date[8+1];
    short   TMKZsi_data_date;

    /* �}���D */
    char    TMKZs_tax_free[1+1];
    short   TMKZsi_tax_free;

    /* �X�V�� */
    char    TMKZs_change_name[16+1];
    short   TMKZsi_change_name;

    /* �X�V�^�C���X�^���v */
    char    TMKZs_change_timestamp[26+1];
    short   TMKZsi_change_timestamp;

/* %01 Add End */

EXEC SQL END DECLARE SECTION;

