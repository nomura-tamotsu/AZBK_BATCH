/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM            : Marketbrain                                          */
/*                                                                          */
/* PROGRAM NAME      : errlog                                               */
/*                                                                          */
/* MODULE NAME       : file_open.c   			                    */
/*                                                                          */
/* FUNCTION          : Error Logging. (Open file subroutine)                */
/*                                                                          */
/* CALLING MODULE    : None                                                 */
/*                                                                          */
/* CALLED MODULE     : Main Module.                                         */
/*                                                                          */
/* ENTRY POINT       : file_open                                            */
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
#include <errno.h>
#include <string.h>
#include <stdio.h>

/*--------------------------------------------------------------------------*/
/*  #2                       DEFINE STATEMENTS                              */
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*  #3                        EXTERNAL DECLARES                             */
/*--------------------------------------------------------------------------*/
extern char nowdate[] ;
extern char log_path[] ;
extern char out_window[];
extern char station[] ;
extern FILE *window_fd1;
extern FILE *window_fd2;
extern int make_log();

/*--------------------------------------------------------------------------*/
/*  #4                       STRUCT DECLARATIONS                            */
/*--------------------------------------------------------------------------*/

/****************************************************************************/
/*                                                                          */
/*                            PROCEDURE DIVISION                            */
/*                                                                          */
/****************************************************************************/
file_open()

{
	/*--------------------------------------------------------------------------*/
	/*  #6                    LOCAL VARIABLE DECLARATIONS                       */
	/*--------------------------------------------------------------------------*/
	char pathname[128] ;

	initchkerr;

	/*　パス名作成　err.99-99-99 */
	memset(pathname,'\0',REC_LEN) ;
	strcpy(pathname,log_path) ;
	strcat(pathname,nowdate) ;

	window_fd1 = fopen(pathname,"a");
	
	if( window_fd1 == NULL )
	{
		errprint(m$file_open,
		    errno,
		    pathname,
		    "",
		    "",
		    station);
		return(Err1);
	}

	memset(pathname,'\0',REC_LEN) ;
	strcpy(pathname,out_window) ;

	window_fd2 = fopen(pathname,"a");
	
	if( window_fd2 == NULL )
	{
		errprint(m$file_open,
		    errno,
		    pathname,
		    "",
		    "",
		    station);
		return(Err1);
	}

	return(SUCCESS);
}
