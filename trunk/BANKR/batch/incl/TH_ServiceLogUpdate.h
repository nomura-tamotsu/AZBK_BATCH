/*==========================================================================*/
/* COPYRIGHT Brainyworks,LTD.                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks                      */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : e-MARKETBRAIN PREMIUM                                 */
/*                                                                          */
/* PROGRAM NAME     : ホスト変数(TH_サービスログ)  移行用                   */
/*                                                                          */
/* MODULE NAME      : TH_ServiceLogUpdate.h                                 */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/06/09 | N.Ogawa     | First Edition.                            */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

	char	TH_service_contactId[19+1];						/* コンタクトID */
	short	THi_service_contactId;

	int 	TH_service_edaNo;								/* 枝番 */
	short	THi_service_edaNo;

	char	TH_service_memberNo[10+1];							/* 契約者番号 */
	short	THi_service_memberNo;

	char	TH_service_serviceId[4+1];						/* サービス種別ID */
	short	THi_service_serviceId;

	char	TH_service_tbDate[8+1];								/* TB受付日付 */
	short	THi_service_tbDate;

	int 	TH_service_tbNo;								/* TB受付通番 */
	short	THi_service_tbNo;

	char	TH_reserve_class[1+1];								/* 先日付区分 */
	short	THi_reserve_class;

	char	TH_hostlink_class[1+1];								/* HOST連動区分 */
	short	THi_hostlink_class;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
