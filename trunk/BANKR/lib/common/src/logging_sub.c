/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM            : Marketbrain                                          */
/*                                                                          */
/* PROGRAM NAME      : errlog                                               */
/*                                                                          */
/* MODULE NAME       : logging_sub.c   			                    */
/*                                                                          */
/* FUNCTION          : Error Logging. (Logging subroutine)                  */
/*                                                                          */
/* CALLING MODULE    : None                                                 */
/*                                                                          */
/* CALLED MODULE     : Main Module.                                         */
/*                                                                          */
/* ENTRY POINT       : logging_sub                                          */
/*                                                                          */
/* Mod   yy/mm/dd   Coder         Comment                                   */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 94/11/24 | T.Sakurai   | First Eddition.                           */
/*==========================================================================*/
/****************************************************************************/
/*                                                                          */
/*                            DECLARE DIVISION                              */
/*                                                                          */
/****************************************************************************/

/*--------------------------------------------------------------------------*/
/*  #1                       INCLUDE STATEMENTS                             */
/*--------------------------------------------------------------------------*/
#include "common.h"
#include "msg.h"
#include <stdio.h>
#include <signal.h>
#include <errno.h>
#include <string.h>

/*--------------------------------------------------------------------------*/
/*  #2                       DEFINE STATEMENTS                              */
/*--------------------------------------------------------------------------*/
#define conoff	248
typedef	struct log_cons_msg CNSMSG;
/*--------------------------------------------------------------------------*/
/*  #3                        EXTERNAL DECLARES                             */
/*--------------------------------------------------------------------------*/
extern  char    nowdate[];
extern  int     log_fd;
extern  char    station[];
extern  char    from_st[];
extern  FILE    *window_fd;
extern  char	out_window[REC_LEN];
extern  void    alarm_sub(void);

extern  int make_log();
extern  int file_write();

/*--------------------------------------------------------------------------*/
/*  #4                       STRUCT DECLARATIONS                            */
/*--------------------------------------------------------------------------*/

/****************************************************************************/
/*                                                                          */
/*                            PROCEDURE DIVISION                            */
/*                                                                          */
/****************************************************************************/
logging_sub(char *msg)
/* char *msg;             　受信したメッセージ */
{
/*--------------------------------------------------------------------------*/
/*  #6                    LOCAL VARIABLE DECLARATIONS                       */
/*--------------------------------------------------------------------------*/
	CNSMSG	*conmsg;
	char	prtmsg[10240];
	int ret;
	int length = 0;

	conmsg    = (CNSMSG *)msg;
	/*メッセージを構築する(make_log)*/
	make_log(conmsg,prtmsg,from_st);

	/*ファイルに書き出す(file_write)*/
    length = strlen(prtmsg);
    ret = file_write(prtmsg,length);

	return(SUCCESS);
}

