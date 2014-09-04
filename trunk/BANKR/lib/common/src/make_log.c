/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM            : Marketbrain                                          */
/*                                                                          */
/* PROGRAM NAME      : errlog                                               */
/*                                                                          */
/* MODULE NAME       : make_log.c                                           */
/*                                                                          */
/* FUNCTION          : Error Logging. (Making output message subroutine)    */
/*                                                                          */
/* CALLING MODULE    : None                                                 */
/*                                                                          */
/* CALLED MODULE     : Main Module.                                         */
/*                                                                          */
/* ENTRY POINT       : make_log                                             */
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
#include "msg.h"
#include <errno.h>
#include <stdio.h>
#include <string.h>

#include <time.h>

/*--------------------------------------------------------------------------*/
/*  #2                       DEFINE STATEMENTS                              */
/*--------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------*/
/*  #3                        EXTERNAL DECLARES                             */
/*--------------------------------------------------------------------------*/
extern MSGTBL  MsgTbl;
extern char   *sys_errlist[];
extern int     sys_nerr;
extern char    host_name[];

/*--------------------------------------------------------------------------*/
/*  #4                       STRUCT DECLARATIONS                            */
/*--------------------------------------------------------------------------*/

/****************************************************************************/
/*                                                                          */
/*                            PROCEDURE DIVISION                            */
/*                                                                          */
/****************************************************************************/
make_log(char *rcvm,char *mssg ,char *procn)
/* char *rcvm;           　受信したメッセージ　*/
/* char *mssg;           　生成されたメッセージ*/
/* char *procn;            プロセス名          */
{
/*--------------------------------------------------------------------------*/
/*  #6                    LOCAL VARIABLE DECLARATIONS                       */
/*--------------------------------------------------------------------------*/
    char    *m1,*m2,*m3,*m4,*p1,*p2,*p3;
    int    cnt;
	time_t time_ds;
        struct tm *tmdat;
    struct log_cons_msg *rcvmsg;
    rcvmsg = ( struct log_cons_msg * )rcvm;

    time(&time_ds);
    tmdat = localtime((const time_t*)&time_ds);
    sprintf(mssg, "%04d/%02d/%02d %02d:%02d:%02d  ",
                    1900+tmdat->tm_year,tmdat->tm_mon+1,tmdat->tm_mday,
                    tmdat->tm_hour,tmdat->tm_min,tmdat->tm_sec);
    mssg +=20;

	sprintf (mssg, "%-18s ", host_name);	/* %01 Change */

    mssg +=19;								/* %01 Change */

    cnt=0;
    while(cnt<=MsgTbl.Etyno)
    {
        if(MTBL(cnt).msgno==rcvmsg->msgno)
        {
            break;
        }
        cnt++;
    }

    if((MsgTbl.Etyno<0) || (cnt > MsgTbl.Etyno))
    {
        sprintf(mssg,
                "MSG file read error or invalid MSGNO.(msgno : %d)\n",
                rcvmsg->msgno);
                mssg+= (strlen(mssg)-1) ;
                    sprintf(mssg," [STATION : %s]\n" ,procn ) ;
        return(SUCCESS);
    }
    
    m1 = MTBL(cnt).text1;
    m2 = MTBL(cnt).text2;
    m3 = MTBL(cnt).text3;
    m4 = MTBL(cnt).text4;
    p1 = rcvmsg->prm1;
    p2 = rcvmsg->prm2;
    p3 = rcvmsg->prm3;

    switch(MTBL(cnt).divtxtno)
    {
        case 1:
                /*メッセージを生成する*/
                sprintf(mssg,"%s",m1);
                break;
        case 2:
                /*メッセージを生成する*/
                sprintf(mssg,"%s%s%s",m1,p1,m2);
                break;
        case 3:
                /*メッセージを生成する*/
                sprintf(mssg,"%s%s%s%s%s",m1,p1,m2,p2,m3);
                break;
        case 4:
                /*メッセージを生成する*/
                sprintf(mssg,"%s%s%s%s%s%s%s",m1,p1,m2,p2,m3,p3,m4);
                break;
        default:
                /*メッセージを生成する*/
                sprintf(mssg,"Message number or data error.\n");
                rcvmsg->rtcode=0;
    }
    mssg+= (strlen(mssg)-1) ;
    if (rcvmsg->rtcode != 0) {
        sprintf(mssg," [%s] {%d}\n" ,procn , rcvmsg->rtcode);
    } else {
        sprintf(mssg," [%s]\n" ,procn);
    }

    return(SUCCESS);
}
