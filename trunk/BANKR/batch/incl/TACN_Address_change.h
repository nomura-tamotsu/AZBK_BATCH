/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC (移行用)                                  */
/*                                                                          */
/* Description      : THB_住所変更                                          */
/*                                                                          */
/* File Name        : TACN_Address_change.h                                 */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/25 | ISID        | First Edition.                            */
/*==========================================================================*/


EXEC SQL BEGIN DECLARE SECTION;

char	TACN_contactid[19+1];		/*	コンタクトID	*/
int	TACN_br_no;			/*	枝番	*/
char	TACN_contract_no[10+1];		/*	契約者番号	*/
char	TACN_tb_reception_date[16+1];	/*	TB受付日時	*/
int	TACN_tb_reception_no;		/*	TB受付通番	*/
char	TACN_attributeid[4+1];		/*	属性ID	*/
varchar	TACN_batch_change_before[144+1];	/*	バッチ用変更前	*/
varchar	TACN_change_after1[144+1];	/*	変更後1	*/
varchar	TACN_change_after2[144+1];	/*	変更後2	*/
varchar	TACN_change_after3[144+1];	/*	変更後3	*/
varchar	TACN_change_after4[144+1];	/*	変更後4	*/
varchar	TACN_change_before1[144+1];	/*	変更前1	*/
varchar	TACN_change_before2[144+1];	/*	変更前2	*/
varchar	TACN_change_before3[144+1];	/*	変更前3	*/
varchar	TACN_change_before4[144+1];	/*	変更前4	*/
char	TACN_address_cd[15+1];		/*	住所コード	*/
char	TACN_deal_ctl_info[1+1];	/*	取引管理情報	*/
char	TACN_p_ident_request[1+1];	/*	本人確認書類依頼済	*/
char	TACN_p_ident_noreply[1+1];	/*	本人確認書類返送不要	*/
char	TACN_use_account_reg_end[1+1];	/*	利用口座登録済	*/
char	TACN_use_account_reg_hope[1+1];	/*	利用口座登録希望	*/
char	TACN_use_account_reg_no[1+1];	/*	利用口座登録不要	*/
char	TACN_registration_date[16+1];	/*	登録日	*/
char	TACN_registrant[8+1];		/*	登録者	*/

short	TACNi_contactid;		/*	コンタクトID	*/
short	TACNi_br_no;			/*	枝番	*/
short	TACNi_contract_no;		/*	契約者番号	*/
short	TACNi_tb_reception_date;	/*	TB受付日時	*/
short	TACNi_tb_reception_no;		/*	TB受付通番	*/
short	TACNi_attributeid;		/*	属性ID	*/
short	TACNi_batch_change_before;	/*	バッチ用変更前	*/
short	TACNi_change_after1;		/*	変更後1	*/
short	TACNi_change_after2;		/*	変更後2	*/
short	TACNi_change_after3;		/*	変更後3	*/
short	TACNi_change_after4;		/*	変更後4	*/
short	TACNi_change_before1;		/*	変更前1	*/
short	TACNi_change_before2;		/*	変更前2	*/
short	TACNi_change_before3;		/*	変更前3	*/
short	TACNi_change_before4;		/*	変更前4	*/
short	TACNi_address_cd;		/*	住所コード	*/
short	TACNi_deal_ctl_info;		/*	取引管理情報	*/
short	TACNi_p_ident_request;		/*	本人確認書類依頼済	*/
short	TACNi_p_ident_noreply;		/*	本人確認書類返送不要	*/
short	TACNi_use_account_reg_end;	/*	利用口座登録済	*/
short	TACNi_use_account_reg_hope;	/*	利用口座登録希望	*/
short	TACNi_use_account_reg_no;	/*	利用口座登録不要	*/
short	TACNi_registration_date;	/*	登録日	*/
short	TACNi_registrant;		/*	登録者	*/

EXEC SQL END DECLARE SECTION;


/*-- END OF FILE --*/

