/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM            : Marketbrain                                          */
/*                                                                          */
/* PROGRAM NAME      : Common Subroutine                                    */
/*                                                                          */
/* MODULE NAME       : send_err.o     			                    */
/*                                                                          */
/* FUNCTION          : Send error message to error logging process.         */
/*                                                                          */
/* CALLING MODULE    : All Programs.                                        */
/*                                                                          */
/* CALLED MODULE     : None					            */
/*                                                                          */
/* ENTRY POINT       : send_err                                             */
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
#include <string.h>
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include  "common.h"
#include "msg.h"

/*--------------------------------------------------------------------------*/
/*  #2                       DEFINE STATEMENTS                              */
/*--------------------------------------------------------------------------*/
#define     NORMAL_DATA     0 
#define     ERRLOG          "ERRLOG"

/*--------------------------------------------------------------------------*/
/*  #3                        EXTERNAL DECLARES                             */
/*--------------------------------------------------------------------------*/
char    nowdate[15];
char    home[128];
char    station[32];
char    msg_path[128];
char    log_path[128];
char    from_st[32];
FILE    *window_fd1;
FILE    *window_fd2;
MSGTBL  MsgTbl;
char	out_window[REC_LEN];

extern char* changeIntoWinDir();
extern int init_sub();
extern int logging_sub();
extern int make_log();
extern int term_sub();
/*--------------------------------------------------------------------------*/
/*  #4                       STRUCT DECLARATIONS                            */
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*  #5                       SUBROUTNE DEFINITION                           */ 
/*--------------------------------------------------------------------------*/

/****************************************************************************/
/*                                                                          */
/*                            PROCEDURE DIVISION                            */
/*                                                                          */
/****************************************************************************/
send_err(int no,int rtn, char *para1, char *para2, char *para3, char *origin)
/* int      no      メッセ－ジＮＯ          */
/* int      rtn     エラ－コ－ド            */
/* char     *para1  パラメ－タ１            */
/* char     *para2  パラメ－タ２            */
/* char     *para3  パラメ－タ３            */
/* char     *origin 送信元                  */
{
/*--------------------------------------------------------------------------*/
/*  #6                    LOCAL VARIABLE DECLARATIONS                       */
/*--------------------------------------------------------------------------*/

    int     ret ;
    struct  log_cons_msg    log_buf ;
    struct  msg_buffer      msgbf ;
    char    *user;
	initchkerr;

/*--------------------------------------------------------------------------*/
/*      MAIN ROUTINE                                                        */
/*--------------------------------------------------------------------------*/

	/*初期化(init_sub)*/
	memset(station,'\0',strlen(station));	
	ret = init_sub();

	switch( ret ){
		case SUCCESS:
			if( window_fd1 != NULL && window_fd2 != NULL ){
				
			    if( ( user = (char *)getenv( "USER" ) ) == NULL ){
			        printf("[ERRLOG] %s getenv error !! errno=%d\n",user,errno);
			        return(-1);
			    }

			    /* ログ出力元(ユーザ名)を設定 */
			    strcpy(from_st, origin);
			    strcat(from_st, " (");
			    strcat(from_st, user);
			    strcat(from_st, ")");
				
				
			    log_buf.msgno = no ;
			    log_buf.rtcode = rtn ;

				/* 出力ログメッセージにパラメータを設定 */
				if(para1 != NULL){
				    strcpy(log_buf.prm1,para1) ;
				}else if(para1 ==NULL){
					strcpy(log_buf.prm1,"") ;
				}
				if(para2 != NULL){
				    strcpy(log_buf.prm2,para2) ;
				}else if(para2 ==NULL){
					strcpy(log_buf.prm2,"") ;
				}
				if(para3 != NULL){
				    strcpy(log_buf.prm3,para3) ;
				}else if(para3 ==NULL){
					strcpy(log_buf.prm3,"") ;
				}
			    
			    memcpy(msgbf.mtext,
			           (char *)&log_buf,
			           sizeof(struct log_cons_msg));

				/* ログ出力実行 */
				ret = logging_sub(msgbf.mtext);

				if (ret != SUCCESS) /*異常終了*/
				{
					/*終了処理()*/
					errprint(m$abort_station,0,"","","",station);
					term_sub();
					exit(-1);
				}
				/*終了処理()*/
				term_sub();
				return(0);
			}
			
		case IplErr1: 
			exit(-1);
		case IplErr2: 
			/*終了処理()*/
			term_sub();
			exit(-1);
	}
	
	return(0);
	
}

char * changeIntoWinDir(char path[]){ 
	
	int cnt = 0;
	int length = strlen(path);
	
	for(cnt = 0; length > 0 ;length--){
		if(path[length-1]=='/'){
			path[length-1] = '\\';
		}
	}
	return path;
}