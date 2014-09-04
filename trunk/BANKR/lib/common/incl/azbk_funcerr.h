/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* PROGRAM NAME     : 当ファイルは各モジュ－ルの内部関数間の				*/
/*                    エラー・コードを 定義したヘッダー・ファイル			*/
/*                                                                          */
/* MODULE NAME      : azbk_funcerr.h                                        */
/*                                                                          */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/03/27 | ISID        | First Edition.                            */
/*==========================================================================*/
/****************************************************************************/
/*                                                                          */
/*							DECLARE DIVISION								*/
/*                                                                          */
/****************************************************************************/
/*--------------------------------------------------------------------------*/
/*							DEFINE STATEMENTS								*/
/*--------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
/* Macro Function Decralation  i                                             */
/*---------------------------------------------------------------------------*/
#ifndef _APERROR_H
#define _APERROR_H
#ifdef __cplusplus /* __C++ */
extern "C" {
#endif

#define  NO_ERROR                  0x0000            /* No error occurred    */
#define  ERR_CFUNC                 0x0100            /* C Function error code */
#define  ERR_DB                    0x0200            /* DB error code        */
#define  ERR_DATA                  0x0300            /* Data error code      */
/*------------------------------------*/
/* C Function Error Code              */
/*------------------------------------*/
#define  ERR_ENVP_NOT_DEFINED         ERR_CFUNC + 0x0001
#define  ERR_ATTACH_MEM               ERR_CFUNC + 0x0002
#define  ERR_DETTACH_MEM              ERR_CFUNC + 0x0003
#define  ERR_INSUFFICIENT_MEMORY      ERR_CFUNC + 0x0004
#define  ERR_CREATE_KEY               ERR_CFUNC + 0x0005
#define  ERR_GETID                    ERR_CFUNC + 0x0006
#define  ERR_FILE_NOT_FOUND           ERR_CFUNC + 0x0009
#define  ERR_FILE_ACCESS              ERR_CFUNC + 0x0008
#define  ERR_ENVPATH_NOT_FOUND        ERR_CFUNC + 0x0009
#define  ERR_MAKE_DIR                 ERR_CFUNC + 0x000A
#define  ERR_REMOVE_QUEUE             ERR_CFUNC + 0x000B
#define  ERR_LOCK_SEM                 ERR_CFUNC + 0x000C
#define  ERR_UNLOCK_SEM               ERR_CFUNC + 0x000D
#define  ERR_REMOVE_SEM               ERR_CFUNC + 0x000E
#define  ERR_REMOVE_MEM               ERR_CFUNC + 0x000F
#define  ERR_START_PROCESS            ERR_CFUNC + 0x0010
#define  ERR_SEND_QUEUE               ERR_CFUNC + 0x0011
#define  ERR_RECV_QUEUE               ERR_CFUNC + 0x0012
#define  ERR_MALLOC_MEM               ERR_CFUNC + 0x0013

/*------------------------------------*/
/* DB Error Code                      */
/*------------------------------------*/
#define  ERR_DB_CONNECT               ERR_DB + 0x0001
#define  ERR_DB_DISCONNECT            ERR_DB + 0x0002
#define  ERR_DB_COMMIT                ERR_DB + 0x0003
#define  ERR_DB_ROLLBACK              ERR_DB + 0x0004
#define  ERR_DB_SELECT                ERR_DB + 0x0006
#define  ERR_DB_INSERT                ERR_DB + 0x0007
#define  ERR_DB_DELETE                ERR_DB + 0x0008
#define  ERR_DB_CURSOR                ERR_DB + 0x0009
#define  ERR_DB_UPDATE                ERR_DB + 0x0010
#define  ERR_DB_NOTFOUND              ERR_DB + 0x0011
#define  ERR_DB_CONTINUE              ERR_DB + 0x0012
#define  ERR_DB_CERT_SVC_CODE         ERR_DB + 0x0013
#define  ERR_DB_CERT_IN_CODE          ERR_DB + 0x0014
#define  ERR_DB_CERT_OUT_CODE         ERR_DB + 0x0015

/*------------------------------------*/
/* Data Error Code                    */
/*------------------------------------*/
#define  ERR_INVALID_DATA             ERR_DATA + 0x0001
#define  ERR_INVALID_TRXCODE          ERR_DATA + 0x0002
#define  ERR_INVALID_DENBUNCODE       ERR_DATA + 0x0003
#define  ERR_INVALID_LENGTH           ERR_DATA + 0x0004
#define  ERR_INVALID_METHOD           ERR_DATA + 0x0005
#define  ERR_INVALID_APPLID           ERR_DATA + 0x0006
#define  ERR_STATUS_NOT_FOUND         ERR_DATA + 0x0007
#define  ERR_APPLID_NOT_FOUND         ERR_DATA + 0x0008
#define  ERR_TRXNO_NOT_FOUND          ERR_DATA + 0x0009
#define  ERR_DATE_NULL                ERR_DATA + 0x0010
#define  ERR_DATE_LOGICAL             ERR_DATA + 0x0011
#define  ERR_DATE_PERIOD              ERR_DATA + 0x0012
#define  ERR_DATE_LEAPYEAR            ERR_DATA + 0x0013
#define  ERR_INVALID_ACCNT_PIN        ERR_DATA + 0x0014
#define  ERR_INVALID_ACCNT_CNT        ERR_DATA + 0x0015
#define  ERR_NORMAL_END               ERR_DATA + 0x0016
#define  ERR_ABNORMAL_END             ERR_DATA + 0x0017
#define  ERR_REAL                     ERR_DATA + 0x0018
#define  ERR_STRING                   ERR_DATA + 0x0019
/* %01 Add Start */
#define  ERR_LF_NOT_FOUND             ERR_DATA + 0x0020
/* %01 Add End */

/*------------------------------------*/
/* MPN Common Funk Error Code         */
/*------------------------------------*/
#define  WORK_ERR                     1
#define  SYSTEM_ERR                   2
#define  PARAM_ERR                    3

#ifdef __cplusplus

}
#endif /* end __cplusplus    */
#endif /* end _APERROR_H    */