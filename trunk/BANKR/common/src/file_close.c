/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM            : Marketbrain                                          */
/*                                                                          */
/* PROGRAM NAME      : errlog                                               */
/*                                                                          */
/* MODULE NAME       : file_close.c   			                    */
/*                                                                          */
/* FUNCTION          : Error Logging. (Close file subroutine)               */
/*                                                                          */
/* CALLING MODULE    : None                                                 */
/*                                                                          */
/* CALLED MODULE     : Main Module.                                         */
/*                                                                          */
/* ENTRY POINT       : file_close                                           */
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
#include <errno.h>
#include <string.h>

/*--------------------------------------------------------------------------*/
/*  #2                       DEFINE STATEMENTS                              */
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*  #3                        EXTERNAL DECLARES                             */
/*--------------------------------------------------------------------------*/
extern char log_path[];
extern char station[] ;
extern char from_st[];
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
file_close()

{
/*--------------------------------------------------------------------------*/
/*  #6                    LOCAL VARIABLE DECLARATIONS                       */
/*--------------------------------------------------------------------------*/
	int ret;
	initchkerr;
	
        if(window_fd1 != NULL)
        {
	        /*�t�@�C�������()*/
			ret = fclose(window_fd1);
			if(ret == EOF){
				ret = Err1;	
				chkerr(m$file_close,ret,log_path,"","",station)
		
			}
		}

		if(window_fd2 != NULL)
        {
			ret = fclose(window_fd2);
			if(ret == EOF){
				ret = Err1;	
				chkerr(m$file_close,ret,log_path,"","",station)
		
			}
        }
        return(SUCCESS);
}

