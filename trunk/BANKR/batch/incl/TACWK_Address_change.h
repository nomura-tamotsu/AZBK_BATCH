/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC (移行用-eMuSC)                            */
/*                                                                          */
/* Description      : THB_住所変更WORK                                      */
/*                                                                          */
/* File Name        : TACWK_Address_change.h                                */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/25 | ISID        | First Edition.                            */
/*==========================================================================*/


EXEC SQL BEGIN DECLARE SECTION;

char	TACWK_contactid[19+1];		/*	コンタクトID	*/
int	TACWK_br_no;			/*	枝番	*/
char	TACWK_contract_no[10+1];	/*	契約者番号	*/
char	TACWK_zip_cd[10+1];		/*	郵便番号	*/
varchar	TACWK_address_kana[300+1];	/*	住所カナ	*/
varchar	TACWK_address_kana1[50+1];	/*	住所カナ1	*/
varchar	TACWK_address_kana2[50+1];	/*	住所カナ2	*/
varchar	TACWK_address_kana3[60+1];	/*	住所カナ3	*/
varchar	TACWK_address1[50+1];		/*	住所1	*/
varchar	TACWK_address2[50+1];		/*	住所2	*/
varchar	TACWK_sub_address[60+1];	/*	補助住所	*/
char	TACWK_my_tel_no[20+1];		/*	自宅電話番号	*/
char	TACWK_my_fax_no[20+1];		/*	自宅FAX番号	*/
char	TACWK_contact_telno[20+1];	/*	連絡先電話番号	*/
char	TACWK_work_place_telno[20+1];	/*	勤務先電話番号	*/
char	TACWK_before_zipcd[10+1];	/*	変更前郵便番号	*/
varchar	TACWK_before_address_kana[300+1];	/*	変更前住所カナ	*/
varchar	TACWK_before_address_kana1[50+1];	/*	変更前住所カナ1	*/
varchar	TACWK_before_address_kana2[76+1];	/*	変更前住所カナ2	*/
varchar	TACWK_before_address_kana3[60+1];	/*	変更前住所カナ3	*/
varchar	TACWK_before_address1[50+1];	/*	変更前住所1	*/
varchar	TACWK_before_address2[76+1];	/*	変更前住所2	*/
varchar	TACWK_before_sub_address[60+1];	/*	変更前補助住所	*/
char	TACWK_before_my_tel_no[20+1];	/*	変更前自宅電話番号	*/
char	TACWK_before_my_fax_no[20+1];	/*	変更前自宅FAX番号	*/
char	TACWK_before_contact_telno[20+1];	/*	変更前連絡先電話番号	*/
char	TACWK_before_work_place_telno[20+1];	/*	変更前勤務先電話番号	*/
char	TACWK_deal_ctl_info[1+1];	/*	取引管理情報	*/
char	TACWK_p_ident_request[1+1];	/*	本人確認書類依頼済	*/
char	TACWK_p_ident_noreply[1+1];	/*	本人確認書類返送不要	*/
char	TACWK_use_account_reg_end[1+1];	/*	利用口座登録済	*/
char	TACWK_use_account_reg_hope[1+1];	/*	利用口座登録希望	*/
char	TACWK_use_account_reg_no[1+1];	/*	利用口座登録不要	*/
char	TACWK_registration_date[16+1];	/*	登録日	*/
char	TACWK_registrant[8+1];		/*	登録者	*/


short	TACWKi_contactid;		/*	コンタクトID	*/
short	TACWKi_br_no;			/*	枝番	*/
short	TACWKi_contract_no;		/*	契約者番号	*/
short	TACWKi_zip_cd;			/*	郵便番号	*/
short	TACWKi_address_kana;		/*	住所カナ	*/
short	TACWKi_address_kana1;		/*	住所カナ1	*/
short	TACWKi_address_kana2;		/*	住所カナ2	*/
short	TACWKi_address_kana3;		/*	住所カナ3	*/
short	TACWKi_address1;		/*	住所1	*/
short	TACWKi_address2;		/*	住所2	*/
short	TACWKi_sub_address;		/*	補助住所	*/
short	TACWKi_my_tel_no;		/*	自宅電話番号	*/
short	TACWKi_my_fax_no;		/*	自宅FAX番号	*/
short	TACWKi_contact_telno;		/*	連絡先電話番号	*/
short	TACWKi_work_place_telno;	/*	勤務先電話番号	*/
short	TACWKi_before_zipcd;		/*	変更前郵便番号	*/
short	TACWKi_before_address_kana;	/*	変更前住所カナ	*/
short	TACWKi_before_address_kana1;	/*	変更前住所カナ1	*/
short	TACWKi_before_address_kana2;	/*	変更前住所カナ2	*/
short	TACWKi_before_address_kana3;	/*	変更前住所カナ3	*/
short	TACWKi_before_address1;		/*	変更前住所1	*/
short	TACWKi_before_address2;		/*	変更前住所2	*/
short	TACWKi_before_sub_address;	/*	変更前補助住所	*/
short	TACWKi_before_my_tel_no;	/*	変更前自宅電話番号	*/
short	TACWKi_before_my_fax_no;	/*	変更前自宅FAX番号	*/
short	TACWKi_before_contact_telno;	/*	変更前連絡先電話番号	*/
short	TACWKi_before_work_place_telno;	/*	変更前勤務先電話番号	*/
short	TACWKi_deal_ctl_info;		/*	取引管理情報	*/
short	TACWKi_p_ident_request;		/*	本人確認書類依頼済	*/
short	TACWKi_p_ident_noreply;		/*	本人確認書類返送不要	*/
short	TACWKi_use_account_reg_end;	/*	利用口座登録済	*/
short	TACWKi_use_account_reg_hope;	/*	利用口座登録希望	*/
short	TACWKi_use_account_reg_no;	/*	利用口座登録不要	*/
short	TACWKi_registration_date;	/*	登録日	*/
short	TACWKi_registrant;		/*	登録者	*/

EXEC SQL END DECLARE SECTION;


/*-- END OF FILE --*/