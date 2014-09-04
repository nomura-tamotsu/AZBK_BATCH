/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : �z�X�g�ϐ�(TH_�T�[�r�X���O)  �ڍs�p                   */
/*                                                                          */
/* MODULE NAME      : TH_ServiceLogUpdate.h                                 */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/09 | N.Ogawa     | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TH_service_contactId[19+1];						/* �R���^�N�gID */
	short	THi_service_contactId;

	int 	TH_service_edaNo;								/* �}�� */
	short	THi_service_edaNo;

	char	TH_service_memberNo[10+1];							/* �_��Ҕԍ� */
	short	THi_service_memberNo;

	char	TH_service_serviceId[4+1];						/* �T�[�r�X���ID */
	short	THi_service_serviceId;

	char	TH_service_tbDate[8+1];								/* TB��t���t */
	short	THi_service_tbDate;

	int 	TH_service_tbNo;								/* TB��t�ʔ� */
	short	THi_service_tbNo;

	char	TH_reserve_class[1+1];								/* ����t�敪 */
	short	THi_reserve_class;

	char	TH_hostlink_class[1+1];								/* HOST�A���敪 */
	short	THi_hostlink_class;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
