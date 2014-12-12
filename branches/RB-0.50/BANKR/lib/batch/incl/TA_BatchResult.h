/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : �z�X�g�ϐ�(TA_�o�b�`��������)     TABR_????           */
/*                                                                          */
/* MODULE NAME      : TA_BatchResult.h                                      */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 09/05/25 | K.Miyahara  | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TABR_processing_start_date[14+1];	/* �����J�n���� */
	short	TABRi_processing_start_date;

	char	TABR_processing_end_date[14+1];		/* �����I������ */
	short	TABRi_processing_end_date;

	varchar	TABR_task_name[30+1];				/* �^�X�N�� */
	short	TABRi_task_name;

	char	TABR_processing_division[1+1];		/* �����敪 */
	short	TABRi_processing_division;

	char	TABR_cycle[1+1];					/* �T�C�N�� */
	short	TABRi_cycle;

	int		TABR_data_count;					/* �f�[�^���� */
	short	TABRi_data_count;

	int		TABR_success_count;					/* ���팏�� */
	short	TABRi_success_count;

	int		TABR_error_count;					/* �G���[���� */
	short	TABRi_error_count;

	char	TABR_status[1+1];					/* �X�e�[�^�X */
	short	TABRi_status;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
