/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM            : Marketbrain                                          */
/*                                                                          */
/* PROGRAM NAME      : errlog                                               */
/*                                                                          */
/* MODULE NAME       : init_sub.c     			                    */
/*                                                                          */
/* FUNCTION          : Error Logging. (Initialization subroutine)           */
/*                                                                          */
/* CALLING MODULE    : None                                                 */
/*                                                                          */
/* CALLED MODULE     : Main Module.                                         */
/*                                                                          */
/* ENTRY POINT       : init_sub                                             */
/*                                                                          */
/* Mod   yy/mm/dd   Coder         Comment                                   */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 94/11/24 | T.Sakurai   | First Eddition.                           */
/* %01 | 14/06/24 | ISID        | ホスト名13桁対応                          */
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
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <signal.h>
#include <errno.h>

#include <string.h>
#include <time.h>

/*--------------------------------------------------------------------------*/
/*  #2                       DEFINE STATEMENTS                              */
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*  #3                        EXTERNAL DECLARES                             */
/*--------------------------------------------------------------------------*/

char    host_name[14]; /* %01 サイズ拡張 */
extern int   log_fd;
extern int   queue_id ;
extern char  nowdate[];
extern char  station[];
extern char  home[];
extern char  msg_path[];
extern char  log_path[];
extern FILE  *window_fd1;
extern FILE  *window_fd2;
extern char  out_window[];

extern int	file_open();
/*--------------------------------------------------------------------------*/
/*  #4                       STRUCT DECLARATIONS                            */
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*  #5                       SUBROUTNE DEFINITION                           */
/*--------------------------------------------------------------------------*/
extern  void    alarm_sub(void);
extern  int    make_table(void);

/****************************************************************************/
/*                                                                          */
/*                            PROCEDURE DIVISION                            */
/*                                                                          */
/****************************************************************************/
init_sub()
{
	/*--------------------------------------------------------------------------*/
	/*  #6                    LOCAL VARIABLE DECLARATIONS                       */
	/*--------------------------------------------------------------------------*/
	FILE    *parm_fd;
	int     ret;
	char    *homedir;
	char    parmfile[128];
	struct tm *tmdat;
	time_t timep;
	char        *a_timep;
	char	*hostname;
	time_t time_d; 
	struct tm *tmdata;
	initchkerr;

	/*戻り値を正常にセット*/
	ret = SUCCESS;

	/* ホスト名を取得セット */

	memset( host_name, '\0', sizeof( host_name ) );

	strcpy(station,"ERRLOG");

	if( ( hostname = (char *)getenv( "COMPUTERNAME" ) ) == NULL ){
		init_err("getenv",errno) ;
		return(IplErr2); 
	}

	strncpy( host_name, hostname, sizeof(host_name) );

	if( ( homedir = (char *)getenv( "HOME" ) ) == NULL ){
		init_err("getenv",errno) ;
		return(IplErr2); 
	}

	strcpy(home,homedir);


	/* パラメ－タファイルのOPEN */
	strcpy(parmfile,homedir);
	strcat(parmfile,"\\file\\ERRLOG.parm");

	parm_fd = fopen (parmfile , "r" );

	if (parm_fd == NULL)
	{
		init_err("open_parm_file",errno) ;
		return(IplErr2); 
	}

	memset(msg_path,'\0',REC_LEN) ;
	memset(log_path,'\0',REC_LEN) ;
	memset(out_window,'\0',REC_LEN) ;

	ret = (int)fgets(msg_path , REC_LEN , parm_fd) ;
	if (ret != Err1)
	{
		ret = (int)fgets(log_path , REC_LEN , parm_fd) ;
	}
	if (ret != Err1)
	{
		ret = (int)fgets(out_window , REC_LEN , parm_fd) ;
	}
	if (ret == Err1)
	{
		init_err("open_init_file",errno) ;
		return(IplErr2); 
	}
	msg_path[strlen(msg_path)-1]='\0' ;
	log_path[strlen(log_path)-1]='\0' ;
	out_window[strlen(out_window)-1]='\0' ;

	fclose(parm_fd) ;

	/*メッセージテーブルを展開する(make_table)*/
	ret = make_table();

	if( ret != SUCCESS )
	{
		return(IplErr2); 
	}


	/* ファイル名をYYYY_MM_DDに変更 */
	timep=time(0);
	tmdat = localtime((const time_t *)&timep);
	a_timep=asctime(tmdat);
	tmdat->tm_mon++;             /* **DLno.15**tm_mon先月の日付けの為+1 */
	nowdate[0] = '.';
	memcpy(&nowdate[1],&a_timep[20],4);
	sprintf(&nowdate[5],"_%02d_%02d", tmdat->tm_mon,tmdat->tm_mday);

	/*ファイルを開く(file_open)*/
	ret = file_open() ;

	if( ret == Err1 )
	{
		return(IplErr2); 
	}

	return(SUCCESS);
}
