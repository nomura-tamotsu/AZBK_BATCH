/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : �z�X�g�ϐ�(TC_�L�����y�[���ڋq)     TCCC_????         */
/*                                                                          */
/* MODULE NAME      : TC_CampaignCustomer.h                                 */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/06/12 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TCCC_center_id[4+1];					/* �Z���^ID */
	short	TCCCi_center_id;

	char	TCCC_campaign_id[4+1];					/* �L�����y�[��ID */
	short	TCCCi_campaign_id;

	char	TCCC_branch_number[5+1];				/* �X�� */
	short	TCCCi_branch_number;

	char	TCCC_cif_number[10+1];					/* CIFNO */
	short	TCCCi_cif_number;

	varchar	TCCC_call_data_name[32+1];				/* �R�[���f�[�^�� */
	short	TCCCi_call_data_name;

	varchar	TCCC_registration_date[16+1];			/* �o�^�� */
	short	TCCCi_registration_date;

	char	TCCC_registrant[8+1];					/* �o�^�� */
	short	TCCCi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
