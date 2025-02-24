/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R−CC (移行用)                                  */
/*                                                                          */
/* Description      : TH_サービスログ                                       */
/*                                                                          */
/* File Name        : TSL_ServiceLog.h                                      */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/25 | ISID        | First Edition.                            */
/*==========================================================================*/


EXEC SQL BEGIN DECLARE SECTION;

char	TSL_contactid[19+1];		/*	コンタクトID	*/
int		TSL_br_no;			/*	枝番	*/
char	TSL_reception_date[16+1];	/*	受付日時	*/
char	TSL_branch_no[5+1];		/*	店番	*/
char	TSL_cifno[10+1];		/*	CIFNO	*/
varchar	TSL_name_kanji[80+1];		/*	氏名漢字	*/
varchar	TSL_name_kana[40+1];		/*	氏名カナ	*/
char	TSL_family_no[13+1];		/*	世帯番号	*/
char	TSL_contract_no[10+1];		/*	契約者番号	*/
char	TSL_negosiation_patner[4+1];	/*	交渉相手	*/
char	TSL_kind[2+1];			/*	種類	*/
char	TSL_service_id[4+1];		/*	サービス種別ID	*/
char	TSL_service_id_brno[2+1];	/*	サービス種別枝番	*/
char	TSL_product_id[10+1];		/*	商品ID	*/
char	TSL_rep_material_id[4+1];	/*	代表資料ID	*/
char	TSL_claim_id[4+1];		/*	クレーム種別ID	*/
char	TSL_general_kind[4+1];		/*	一般種別	*/
char	TSL_customer_reaction[4+1];	/*	顧客反応	*/
char	TSL_reaction_rank[4+1];		/*	反応ランク	*/
char	TSL_mail_ret_class[1+1];	/*	郵便返戻先区分	*/
char	TSL_tb_reception_date[8+1];	/*	TB受付日付	*/
int		TSL_tb_reception_no;		/*	TB受付通番	*/
char	TSL_reservation_class[1+1];	/*	予約区分	*/
char	TSL_process_schedule[8+1];	/*	処理予定日付	*/
char	TSL_payment_act_regno[3+1];	/*	出金口座登録番号	*/
char	TSL_payment_branchno[5+1];	/*	出金店番	*/
char	TSL_payment_act_cifno[10+1];	/*	出金口座CIFNO	*/
char	TSL_payment_subject_id[4+1];	/*	出金科目ID	*/
char	TSL_payment_act_kind[4+1];	/*	出金口座種類ID	*/
char	TSL_payment_regular_subject_id[6+1];	/*	出金正規科目ID	*/
char	TSL_payment_account_no[15+1];	/*	出金口座番号	*/
char	TSL_payment_account_brno[5+1];	/*	出金口座口番号	*/
char	TSL_payment_account_class[1+1];	/*	出金口座種別	*/
varchar	TSL_payment_account_name[48+1];	/*	出金口座名義	*/
char	TSL_payment_account_currency[3+1];	/*	出金口座通貨ID	*/
char	TSL_payment_account_product[10+1];	/*	出金口座商品ID	*/
double	TSL_yen_deal_amount;		/*	円貨取引金額	*/
double	TSL_foreign_deal_amount;	/*	外貨取引金額	*/
double	TSL_charge;			/*	手数料	*/
char	TSL_foreign_currency_id[3+1];	/*	外貨額通貨ID	*/
int	TSL_payment_receipt_no;		/*	出金受付票枚数	*/
int	TSL_deposit_receipt_no;		/*	入金受付票枚数	*/
int	TSL_fund_appli_no;		/*	投信申込書枚数	*/
int	TSL_betu_deposit_receipt_no;	/*	別段預金入金票枚数	*/
int	TSL_various_notification_no;	/*	諸届枚数	*/
int	TSL_new_appli_no;		/*	新規開設申込書枚数	*/
char	TSL_host_status[1+1];		/*	勘定処理状況	*/
char	TSL_error_status[1+1];		/*	エラー状況	*/
char	TSL_host_deal_date[8+1];	/*	勘定処理日付	*/
char	TSL_host_deal_time[6+1];	/*	勘定処理時刻	*/
char	TSL_failure_call_flag[1+1];	/*	不成立コールフラグ	*/
char	TSL_failure_call_flag_registrant[8+1];	/*	不成立コールフラグ登録者	*/
char	TSL_failure_call_flag_reg_id[19+1];	/*	不成立コールフラグ登録ID	*/
char	TSL_failure_detai_output_flag[1+1];	/*	不成立明細出力フラグ	*/
char	TSL_transaction_detail_output_flag[1+1];	/*	取引明細出力フラグ	*/
char	TSL_receipt_notice_flag[1+1];	/*	受付通知出力フラグ	*/
char	TSL_receipt_output_flag[1+1];	/*	受付票出力フラグ	*/
char	TSL_receipt_output_br1[2+1];	/*	受付票枝番1	*/
int	TSL_receipt_output_no1;		/*	受付票枚数1	*/
char	TSL_receipt_output_br2[2+1];	/*	受付票枝番2	*/
int	TSL_receipt_output_no2;		/*	受付票枚数2	*/
char	TSL_receipt_disp_char[20+1];	/*	受付票表示文字	*/
char	TSL_host_result_id[8+1];	/*	勘定結果ID	*/
varchar	TSL_result_msg1[82+1];		/*	取引結果MSG1行目	*/
varchar	TSL_result_msg2[82+1];		/*	取引結果MSG2行目	*/
varchar	TSL_result_msg3[82+1];		/*	取引結果MSG3行目	*/
varchar	TSL_result_msg4[82+1];		/*	取引結果MSG4行目	*/
varchar	TSL_proc_result_input_no[30+1];	/*	処理結果入力番号	*/
char	TSL_will_confirm_result[2+1];	/*	意思確認結果	*/
char	TSL_fw_response_result[2+1];	/*	FW応答結果	*/
char	TSL_host_link_class[1+1];	/*	HOST連動区分	*/
char	TSL_host_link_status[1+1];	/*	HOST連動状況	*/
char	TSL_host_link_start_date[16+1];	/*	HOST連動開始日時	*/
char	TSL_host_link_result[4+1];	/*	HOST結果コード	*/
char	TSL_host_link_response_result[4+1];	/*	HOSTFW応答結果	*/
char	TSL_host_link_response_cd[2+1];	/*	HOST応答コード	*/
char	TSL_host_link_ex_response_cd[5+1];	/*	HOST拡張応答コード	*/
char	TSL_process_result[1+1];	/*	処理結果	*/
char	TSL_refer_no[6+1];		/*	参照番号	*/
char	TSL_host_refer_no[15+1];	/*	HOST参照番号	*/
char	TSL_receipt_complete_date[16+1];	/*	受付完了日時	*/
char	TSL_trading_class[1+1];		/*	取引区分	*/
char	TSL_contact_class[1+1];		/*	連絡先区分	*/
char	TSL_contact_tel[15+1];		/*	連絡先電話番号	*/
char	TSL_branch_link[1+1];		/*	営業店連携	*/
char	TSL_branch_link_brno[5+1];	/*	営業店連携店番	*/
char	TSL_branch_link_name[20+1];	/*	営業店連携宛名	*/
char	TSL_fax_link[1+1];		/*	FAX連携	*/
char	TSL_fax_link_brno[5+1];		/*	FAX連携店番	*/
char	TSL_fax_link_name[20+1];	/*	FAX連携宛名	*/
char	TSL_tb_link[1+1];		/*	TB連携	*/
char	TSL_follow_class[1+1];		/*	フォロー区分	*/
char	TSL_coming_schedule[16+1];	/*	来店予定日	*/
char	TSL_link_output_flag[1+1];	/*	連携票出力済みフラグ	*/
char	TSL_transfer_flag[1+1];		/*	転送済みフラグ	*/
char	TSL_receipt_userid[8+1];	/*	受付ユーザID	*/
char	TSL_receipt_centerid[4+1];	/*	受付センタID	*/
char	TSL_receipt_output_userid[8+1];	/*	受付票出力ユーザID	*/
char	TSL_process_result_input_userid[8+1];	/*	処理結果入力ユーザID	*/
char	TSL_sex[1+1];			/*	性別	*/
char	TSL_customer_kind[1+1];		/*	顧客種類	*/
char	TSL_correspondence_branch[5+1];	/*	対応先営業店	*/
varchar	TSL_person_charge_name[24+1];	/*	担当者名	*/
char	TSL_transfer_class[1+1];	/*	移管区分	*/
char	TSL_registration_date[16+1];	/*	登録日	*/
char	TSL_registrant[8+1];		/*	登録者	*/
char	TSL_batch_status[1+1];		/*	バッチ状況フラグ	*/
char	TSL_external_data_class[1+1];	/*	外部データ区分	*/
char	TSL_trans_data_flag[1+1];	/*	移行履歴フラグ	*/
char	TSL_tb_product_id[10+1];	/*	TB商品ID	*/
char	TSL_tb_product_id2[10+1];	/*	TB商品ID2	*/
char	TSL_tb_product_id3[10+1];	/*	TB商品ID3	*/
char	TSL_ersponse_media[4+1];	/*	レスポンスメディア	*/
char	TSL_receipt_class[4+1];		/*	受付区分	*/
char	TSL_trans_no_cif_flag[1+1];	/*	移行CIF無しフラグ	*/
char	TSL_tb_appli_brno[5+1];		/*	TB申込店	*/


short	TSLi_contactid;			/*	コンタクトID	*/
short	TSLi_br_no;			/*	枝番	*/
short	TSLi_reception_date;		/*	受付日時	*/
short	TSLi_branch_no;			/*	店番	*/
short	TSLi_cifno;			/*	CIFNO	*/
short	TSLi_name_kanji;		/*	氏名漢字	*/
short	TSLi_name_kana;			/*	氏名カナ	*/
short	TSLi_family_no;			/*	世帯番号	*/
short	TSLi_contract_no;		/*	契約者番号	*/
short	TSLi_negosiation_patner;	/*	交渉相手	*/
short	TSLi_kind;			/*	種類	*/
short	TSLi_service_id;		/*	サービス種別ID	*/
short	TSLi_service_id_brno;		/*	サービス種別枝番	*/
short	TSLi_product_id;		/*	商品ID	*/
short	TSLi_rep_material_id;		/*	代表資料ID	*/
short	TSLi_claim_id;			/*	クレーム種別ID	*/
short	TSLi_general_kind;		/*	一般種別	*/
short	TSLi_customer_reaction;		/*	顧客反応	*/
short	TSLi_reaction_rank;		/*	反応ランク	*/
short	TSLi_mail_ret_class;		/*	郵便返戻先区分	*/
short	TSLi_tb_reception_date;		/*	TB受付日付	*/
short	TSLi_tb_reception_no;		/*	TB受付通番	*/
short	TSLi_reservation_class;		/*	予約区分	*/
short	TSLi_process_schedule;		/*	処理予定日付	*/
short	TSLi_payment_act_regno;		/*	出金口座登録番号	*/
short	TSLi_payment_branchno;		/*	出金店番	*/
short	TSLi_payment_act_cifno;		/*	出金口座CIFNO	*/
short	TSLi_payment_subject_id;	/*	出金科目ID	*/
short	TSLi_payment_act_kind;		/*	出金口座種類ID	*/
short	TSLi_payment_regular_subject_id;	/*	出金正規科目ID	*/
short	TSLi_payment_account_no;	/*	出金口座番号	*/
short	TSLi_payment_account_brno;	/*	出金口座口番号	*/
short	TSLi_payment_account_class;	/*	出金口座種別	*/
short	TSLi_payment_account_name;	/*	出金口座名義	*/
short	TSLi_payment_account_currency;	/*	出金口座通貨ID	*/
short	TSLi_payment_account_product;	/*	出金口座商品ID	*/
short	TSLi_yen_deal_amount;		/*	円貨取引金額	*/
short	TSLi_foreign_deal_amount;	/*	外貨取引金額	*/
short	TSLi_charge;			/*	手数料	*/
short	TSLi_foreign_currency_id;	/*	外貨額通貨ID	*/
short	TSLi_payment_receipt_no;	/*	出金受付票枚数	*/
short	TSLi_deposit_receipt_no;	/*	入金受付票枚数	*/
short	TSLi_fund_appli_no;		/*	投信申込書枚数	*/
short	TSLi_betu_deposit_receipt_no;	/*	別段預金入金票枚数	*/
short	TSLi_various_notification_no;	/*	諸届枚数	*/
short	TSLi_new_appli_no;		/*	新規開設申込書枚数	*/
short	TSLi_host_status;		/*	勘定処理状況	*/
short	TSLi_error_status;		/*	エラー状況	*/
short	TSLi_host_deal_date;		/*	勘定処理日付	*/
short	TSLi_host_deal_time;		/*	勘定処理時刻	*/
short	TSLi_failure_call_flag;		/*	不成立コールフラグ	*/
short	TSLi_failure_call_flag_registrant;	/*	不成立コールフラグ登録者	*/
short	TSLi_failure_call_flag_reg_id;	/*	不成立コールフラグ登録ID	*/
short	TSLi_failure_detai_output_flag;	/*	不成立明細出力フラグ	*/
short	TSLi_transaction_detail_output_flag;	/*	取引明細出力フラグ	*/
short	TSLi_receipt_notice_flag;	/*	受付通知出力フラグ	*/
short	TSLi_receipt_output_flag;	/*	受付票出力フラグ	*/
short	TSLi_receipt_output_br1;	/*	受付票枝番1	*/
short	TSLi_receipt_output_no1;	/*	受付票枚数1	*/
short	TSLi_receipt_output_br2;	/*	受付票枝番2	*/
short	TSLi_receipt_output_no2;	/*	受付票枚数2	*/
short	TSLi_receipt_disp_char;		/*	受付票表示文字	*/
short	TSLi_host_result_id;		/*	勘定結果ID	*/
short	TSLi_result_msg1;		/*	取引結果MSG1行目	*/
short	TSLi_result_msg2;		/*	取引結果MSG2行目	*/
short	TSLi_result_msg3;		/*	取引結果MSG3行目	*/
short	TSLi_result_msg4;		/*	取引結果MSG4行目	*/
short	TSLi_proc_result_input_no;	/*	処理結果入力番号	*/
short	TSLi_will_confirm_result;	/*	意思確認結果	*/
short	TSLi_fw_response_result;	/*	FW応答結果	*/
short	TSLi_host_link_class;		/*	HOST連動区分	*/
short	TSLi_host_link_status;		/*	HOST連動状況	*/
short	TSLi_host_link_start_date;	/*	HOST連動開始日時	*/
short	TSLi_host_link_result;		/*	HOST結果コード	*/
short	TSLi_host_link_response_result;	/*	HOSTFW応答結果	*/
short	TSLi_host_link_response_cd;	/*	HOST応答コード	*/
short	TSLi_host_link_ex_response_cd;	/*	HOST拡張応答コード	*/
short	TSLi_process_result;		/*	処理結果	*/
short	TSLi_refer_no;			/*	参照番号	*/
short	TSLi_host_refer_no;		/*	HOST参照番号	*/
short	TSLi_receipt_complete_date;	/*	受付完了日時	*/
short	TSLi_trading_class;		/*	取引区分	*/
short	TSLi_contact_class;		/*	連絡先区分	*/
short	TSLi_contact_tel;		/*	連絡先電話番号	*/
short	TSLi_branch_link;		/*	営業店連携	*/
short	TSLi_branch_link_brno;		/*	営業店連携店番	*/
short	TSLi_branch_link_name;		/*	営業店連携宛名	*/
short	TSLi_fax_link;			/*	FAX連携	*/
short	TSLi_fax_link_brno;		/*	FAX連携店番	*/
short	TSLi_fax_link_name;		/*	FAX連携宛名	*/
short	TSLi_tb_link;			/*	TB連携	*/
short	TSLi_follow_class;		/*	フォロー区分	*/
short	TSLi_coming_schedule;		/*	来店予定日	*/
short	TSLi_link_output_flag;		/*	連携票出力済みフラグ	*/
short	TSLi_transfer_flag;		/*	転送済みフラグ	*/
short	TSLi_receipt_userid;		/*	受付ユーザID	*/
short	TSLi_receipt_centerid;		/*	受付センタID	*/
short	TSLi_receipt_output_userid;	/*	受付票出力ユーザID	*/
short	TSLi_process_result_input_userid;	/*	処理結果入力ユーザID	*/
short	TSLi_sex;			/*	性別	*/
short	TSLi_customer_kind;		/*	顧客種類	*/
short	TSLi_correspondence_branch;	/*	対応先営業店	*/
short	TSLi_person_charge_name;	/*	担当者名	*/
short	TSLi_transfer_class;		/*	移管区分	*/
short	TSLi_registration_date;		/*	登録日	*/
short	TSLi_registrant;		/*	登録者	*/
short	TSLi_batch_status;		/*	バッチ状況フラグ	*/
short	TSLi_external_data_class;	/*	外部データ区分	*/
short	TSLi_trans_data_flag;		/*	移行履歴フラグ	*/
short	TSLi_tb_product_id;		/*	TB商品ID	*/
short	TSLi_tb_product_id2;		/*	TB商品ID2	*/
short	TSLi_tb_product_id3;		/*	TB商品ID3	*/
short	TSLi_ersponse_media;		/*	レスポンスメディア	*/
short	TSLi_receipt_class;		/*	受付区分	*/
short	TSLi_trans_no_cif_flag;		/*	移行CIF無しフラグ	*/
short	TSLi_tb_appli_brno;		/*	TB申込店	*/

EXEC SQL END DECLARE SECTION;


/*-- END OF FILE --*/

