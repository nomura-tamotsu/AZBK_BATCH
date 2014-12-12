/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC (�ڍs�p-eMuSC)                            */
/*                                                                          */
/* Description      : THB_�Z���ύXWORK                                      */
/*                                                                          */
/* File Name        : TACWK_Address_change.h                                */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/25 | ISID        | First Edition.                            */
/*==========================================================================*/


EXEC SQL BEGIN DECLARE SECTION;

char	TACWK_contactid[19+1];		/*	�R���^�N�gID	*/
int	TACWK_br_no;			/*	�}��	*/
char	TACWK_contract_no[10+1];	/*	�_��Ҕԍ�	*/
char	TACWK_zip_cd[10+1];		/*	�X�֔ԍ�	*/
varchar	TACWK_address_kana[300+1];	/*	�Z���J�i	*/
varchar	TACWK_address_kana1[50+1];	/*	�Z���J�i1	*/
varchar	TACWK_address_kana2[50+1];	/*	�Z���J�i2	*/
varchar	TACWK_address_kana3[60+1];	/*	�Z���J�i3	*/
varchar	TACWK_address1[50+1];		/*	�Z��1	*/
varchar	TACWK_address2[50+1];		/*	�Z��2	*/
varchar	TACWK_sub_address[60+1];	/*	�⏕�Z��	*/
char	TACWK_my_tel_no[20+1];		/*	����d�b�ԍ�	*/
char	TACWK_my_fax_no[20+1];		/*	����FAX�ԍ�	*/
char	TACWK_contact_telno[20+1];	/*	�A����d�b�ԍ�	*/
char	TACWK_work_place_telno[20+1];	/*	�Ζ���d�b�ԍ�	*/
char	TACWK_before_zipcd[10+1];	/*	�ύX�O�X�֔ԍ�	*/
varchar	TACWK_before_address_kana[300+1];	/*	�ύX�O�Z���J�i	*/
varchar	TACWK_before_address_kana1[50+1];	/*	�ύX�O�Z���J�i1	*/
varchar	TACWK_before_address_kana2[76+1];	/*	�ύX�O�Z���J�i2	*/
varchar	TACWK_before_address_kana3[60+1];	/*	�ύX�O�Z���J�i3	*/
varchar	TACWK_before_address1[50+1];	/*	�ύX�O�Z��1	*/
varchar	TACWK_before_address2[76+1];	/*	�ύX�O�Z��2	*/
varchar	TACWK_before_sub_address[60+1];	/*	�ύX�O�⏕�Z��	*/
char	TACWK_before_my_tel_no[20+1];	/*	�ύX�O����d�b�ԍ�	*/
char	TACWK_before_my_fax_no[20+1];	/*	�ύX�O����FAX�ԍ�	*/
char	TACWK_before_contact_telno[20+1];	/*	�ύX�O�A����d�b�ԍ�	*/
char	TACWK_before_work_place_telno[20+1];	/*	�ύX�O�Ζ���d�b�ԍ�	*/
char	TACWK_deal_ctl_info[1+1];	/*	����Ǘ����	*/
char	TACWK_p_ident_request[1+1];	/*	�{�l�m�F���ވ˗���	*/
char	TACWK_p_ident_noreply[1+1];	/*	�{�l�m�F���ޕԑ��s�v	*/
char	TACWK_use_account_reg_end[1+1];	/*	���p�����o�^��	*/
char	TACWK_use_account_reg_hope[1+1];	/*	���p�����o�^��]	*/
char	TACWK_use_account_reg_no[1+1];	/*	���p�����o�^�s�v	*/
char	TACWK_registration_date[16+1];	/*	�o�^��	*/
char	TACWK_registrant[8+1];		/*	�o�^��	*/


short	TACWKi_contactid;		/*	�R���^�N�gID	*/
short	TACWKi_br_no;			/*	�}��	*/
short	TACWKi_contract_no;		/*	�_��Ҕԍ�	*/
short	TACWKi_zip_cd;			/*	�X�֔ԍ�	*/
short	TACWKi_address_kana;		/*	�Z���J�i	*/
short	TACWKi_address_kana1;		/*	�Z���J�i1	*/
short	TACWKi_address_kana2;		/*	�Z���J�i2	*/
short	TACWKi_address_kana3;		/*	�Z���J�i3	*/
short	TACWKi_address1;		/*	�Z��1	*/
short	TACWKi_address2;		/*	�Z��2	*/
short	TACWKi_sub_address;		/*	�⏕�Z��	*/
short	TACWKi_my_tel_no;		/*	����d�b�ԍ�	*/
short	TACWKi_my_fax_no;		/*	����FAX�ԍ�	*/
short	TACWKi_contact_telno;		/*	�A����d�b�ԍ�	*/
short	TACWKi_work_place_telno;	/*	�Ζ���d�b�ԍ�	*/
short	TACWKi_before_zipcd;		/*	�ύX�O�X�֔ԍ�	*/
short	TACWKi_before_address_kana;	/*	�ύX�O�Z���J�i	*/
short	TACWKi_before_address_kana1;	/*	�ύX�O�Z���J�i1	*/
short	TACWKi_before_address_kana2;	/*	�ύX�O�Z���J�i2	*/
short	TACWKi_before_address_kana3;	/*	�ύX�O�Z���J�i3	*/
short	TACWKi_before_address1;		/*	�ύX�O�Z��1	*/
short	TACWKi_before_address2;		/*	�ύX�O�Z��2	*/
short	TACWKi_before_sub_address;	/*	�ύX�O�⏕�Z��	*/
short	TACWKi_before_my_tel_no;	/*	�ύX�O����d�b�ԍ�	*/
short	TACWKi_before_my_fax_no;	/*	�ύX�O����FAX�ԍ�	*/
short	TACWKi_before_contact_telno;	/*	�ύX�O�A����d�b�ԍ�	*/
short	TACWKi_before_work_place_telno;	/*	�ύX�O�Ζ���d�b�ԍ�	*/
short	TACWKi_deal_ctl_info;		/*	����Ǘ����	*/
short	TACWKi_p_ident_request;		/*	�{�l�m�F���ވ˗���	*/
short	TACWKi_p_ident_noreply;		/*	�{�l�m�F���ޕԑ��s�v	*/
short	TACWKi_use_account_reg_end;	/*	���p�����o�^��	*/
short	TACWKi_use_account_reg_hope;	/*	���p�����o�^��]	*/
short	TACWKi_use_account_reg_no;	/*	���p�����o�^�s�v	*/
short	TACWKi_registration_date;	/*	�o�^��	*/
short	TACWKi_registrant;		/*	�o�^��	*/

EXEC SQL END DECLARE SECTION;


/*-- END OF FILE --*/