/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : �z�X�g�ϐ�(TA_�o�b�`�������ʏڍ�)     TABD_????       */
/*                                                                          */
/* MODULE NAME      : TA_BatchResultDetail.h                                */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/05/26 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TABD_processing_start_date[14+1];	/* �����J�n���� */
	short	TABDi_processing_start_date;

	varchar	TABD_task_name[30+1];				/* �^�X�N�� */
	short	TABDi_task_name;

	int		TABD_sequence;						/* SEQ */
	short	TABDi_sequence;

	varchar	TABD_reason[20+1];					/* ���R */
	short	TABDi_reason;

	varchar	TABD_data[256+1];					/* �f�[�^ */
	short	TDBDi_data;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
