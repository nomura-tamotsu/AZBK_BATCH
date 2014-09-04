/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM            : Marketbrain                                          */
/*                                                                          */
/* PROGRAM NAME      : errlog                                               */
/*                                                                          */
/* MODULE NAME       : file_write.c   			                    */
/*                                                                          */
/* FUNCTION          : Error Logging. (Write file subroutine)               */
/*                                                                          */
/* CALLING MODULE    : None                                                 */
/*                                                                          */
/* CALLED MODULE     : Main Module.                                         */
/*                                                                          */
/* ENTRY POINT       : file_write                                           */
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
#include <stdio.h>
#include <string.h>
#include <errno.h>
#include "msg.h"
#include "common.h"
/*--------------------------------------------------------------------------*/
/*  #2                       DEFINE STATEMENTS                              */
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*  #3                        EXTERNAL DECLARES                             */
/*--------------------------------------------------------------------------*/
extern char log_path[];
extern char station[];
extern char from_st[];
extern FILE *window_fd1;
extern FILE *window_fd2;
extern char host_name[];
extern int make_log();

/*--------------------------------------------------------------------------*/
/*  #4                       STRUCT DECLARATIONS                            */
/*--------------------------------------------------------------------------*/

/****************************************************************************/
/*                                                                          */
/*                            PROCEDURE DIVISION                            */
/*                                                                          */
/****************************************************************************/
file_write(char *msg,int len)
/* char *msg;            出力メッセージ   */
/* int   len;            メッセージの長さ */
{
/*--------------------------------------------------------------------------*/
/*  #6                    LOCAL VARIABLE DECLARATIONS                       */
/*--------------------------------------------------------------------------*/
	int ret;
	char w_msg[10240+12];
	initchkerr;

	if( msg == NULL )
	{
		printf("No message PROCESS ERRLOG\n");
		
		if(window_fd1 != NULL)
		{
			fprintf(window_fd1,"No message PROCESS ERRLOG\n");
		}
		if(window_fd2 != NULL)
		{
			fprintf(window_fd1,"No message PROCESS ERRLOG\n");
		}
		return(Err1);
	}

    if( window_fd1 ==NULL)
    {
	errprint(m$file_write,0,log_path,"","",station);
            return(Err1);
    }
    if( window_fd2 ==NULL)
    {
	errprint(m$file_write,0,log_path,"","",station);
            return(Err1);
    }

	/*ファイルに書き込む(BOScall)*/
	memset( w_msg, '\0',sizeof(w_msg));

	sprintf(w_msg, "%s", msg );
	
	ret =fprintf(window_fd1,w_msg);
	ret =fprintf(window_fd2,w_msg);
	
	chkerr(m$file_write,ret,log_path,"","",station);
        return(SUCCESS);
}
