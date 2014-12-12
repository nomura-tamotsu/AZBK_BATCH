/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC (�ڍs�p)                                  */
/*                                                                          */
/* Description      : THB_�Z���ύX                                          */
/*                                                                          */
/* File Name        : TACN_Address_change.h                                 */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/25 | ISID        | First Edition.                            */
/*==========================================================================*/


EXEC SQL BEGIN DECLARE SECTION;

char	TACN_contactid[19+1];		/*	�R���^�N�gID	*/
int	TACN_br_no;			/*	�}��	*/
char	TACN_contract_no[10+1];		/*	�_��Ҕԍ�	*/
char	TACN_tb_reception_date[16+1];	/*	TB��t����	*/
int	TACN_tb_reception_no;		/*	TB��t�ʔ�	*/
char	TACN_attributeid[4+1];		/*	����ID	*/
varchar	TACN_batch_change_before[144+1];	/*	�o�b�`�p�ύX�O	*/
varchar	TACN_change_after1[144+1];	/*	�ύX��1	*/
varchar	TACN_change_after2[144+1];	/*	�ύX��2	*/
varchar	TACN_change_after3[144+1];	/*	�ύX��3	*/
varchar	TACN_change_after4[144+1];	/*	�ύX��4	*/
varchar	TACN_change_before1[144+1];	/*	�ύX�O1	*/
varchar	TACN_change_before2[144+1];	/*	�ύX�O2	*/
varchar	TACN_change_before3[144+1];	/*	�ύX�O3	*/
varchar	TACN_change_before4[144+1];	/*	�ύX�O4	*/
char	TACN_address_cd[15+1];		/*	�Z���R�[�h	*/
char	TACN_deal_ctl_info[1+1];	/*	����Ǘ����	*/
char	TACN_p_ident_request[1+1];	/*	�{�l�m�F���ވ˗���	*/
char	TACN_p_ident_noreply[1+1];	/*	�{�l�m�F���ޕԑ��s�v	*/
char	TACN_use_account_reg_end[1+1];	/*	���p�����o�^��	*/
char	TACN_use_account_reg_hope[1+1];	/*	���p�����o�^��]	*/
char	TACN_use_account_reg_no[1+1];	/*	���p�����o�^�s�v	*/
char	TACN_registration_date[16+1];	/*	�o�^��	*/
char	TACN_registrant[8+1];		/*	�o�^��	*/

short	TACNi_contactid;		/*	�R���^�N�gID	*/
short	TACNi_br_no;			/*	�}��	*/
short	TACNi_contract_no;		/*	�_��Ҕԍ�	*/
short	TACNi_tb_reception_date;	/*	TB��t����	*/
short	TACNi_tb_reception_no;		/*	TB��t�ʔ�	*/
short	TACNi_attributeid;		/*	����ID	*/
short	TACNi_batch_change_before;	/*	�o�b�`�p�ύX�O	*/
short	TACNi_change_after1;		/*	�ύX��1	*/
short	TACNi_change_after2;		/*	�ύX��2	*/
short	TACNi_change_after3;		/*	�ύX��3	*/
short	TACNi_change_after4;		/*	�ύX��4	*/
short	TACNi_change_before1;		/*	�ύX�O1	*/
short	TACNi_change_before2;		/*	�ύX�O2	*/
short	TACNi_change_before3;		/*	�ύX�O3	*/
short	TACNi_change_before4;		/*	�ύX�O4	*/
short	TACNi_address_cd;		/*	�Z���R�[�h	*/
short	TACNi_deal_ctl_info;		/*	����Ǘ����	*/
short	TACNi_p_ident_request;		/*	�{�l�m�F���ވ˗���	*/
short	TACNi_p_ident_noreply;		/*	�{�l�m�F���ޕԑ��s�v	*/
short	TACNi_use_account_reg_end;	/*	���p�����o�^��	*/
short	TACNi_use_account_reg_hope;	/*	���p�����o�^��]	*/
short	TACNi_use_account_reg_no;	/*	���p�����o�^�s�v	*/
short	TACNi_registration_date;	/*	�o�^��	*/
short	TACNi_registrant;		/*	�o�^��	*/

EXEC SQL END DECLARE SECTION;


/*-- END OF FILE --*/

