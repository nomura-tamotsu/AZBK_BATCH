/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM            : Marketbrain                                          */
/*                                                                          */
/* PROGRAM NAME      : errlog                                               */
/*                                                                          */
/* MODULE NAME       : make_table.c   			                    */
/*                                                                          */
/* FUNCTION          : Error Logging. (Making message table subroutine)     */
/*                                                                          */
/* CALLING MODULE    : None                                                 */
/*                                                                          */
/* CALLED MODULE     : Main Module.                                         */
/*                                                                          */
/* ENTRY POINT       : make_table                                           */
/*                                                                          */
/* Mod   yy/mm/dd   Coder         Comment                                   */
/*-----+----------+---------------+-----------------------------------------*/
/* %00 | 94/11/24 | T.Sakurai     | First Eddition.                         */
/* %01 | 07/02/19 | E.Higashimoto | msg_fileからの取得レコードサイズを		*/
/*     |          |               | common.hに定義。						*/
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
#include <stdlib.h>
#include <string.h>

/*--------------------------------------------------------------------------*/
/*  #2                       DEFINE STATEMENTS                              */
/*--------------------------------------------------------------------------*/
/*--------------------------------------------------------------------------*/
/*  #3                        EXTERNAL DECLARES                             */
/*--------------------------------------------------------------------------*/
extern int     log_fd ;
extern char    station[] ;
extern char msg_path[];
extern MSGTBL  MsgTbl;

/*--------------------------------------------------------------------------*/
/*  #4                       STRUCT DECLARATIONS                            */
/*--------------------------------------------------------------------------*/

/****************************************************************************/
/*                                                                          */
/*                            PROCEDURE DIVISION                            */
/*                                                                          */
/****************************************************************************/
make_table()
{
/*--------------------------------------------------------------------------*/
/*  #6                    LOCAL VARIABLE DECLARATIONS                       */
/*--------------------------------------------------------------------------*/
	struct M_EtyRec datstr;
	FILE *fp ;
	char data[1024];
	int len,cnt,counter;
	char *cp,*dp;
	char *datptr[5];

	MsgTbl.Etyno = -1;

	datptr[0] = datstr.text1;
	datptr[1] = datstr.text2;
	datptr[2] = datstr.text3;
	datptr[3] = datstr.text4;

        /*メッセージ定義ファイルをオープンする*/
		fp=fopen(msg_path,"r");
		
        if(fp == NULL)
        {
                printf("INVALID FILE NAME(FILE=%s) PROCESS ERRLOG rc:0\n",
                        msg_path) ;
        	return(Err1);
		}
		counter=0;
        /*メッセージを1つ読む*/
/* %01 mod start */
		/* 	while(fgets(data,120,fp)!=0) */
	while(fgets(data,DEFINE_MSG_REC_LEN,fp)!=0)
/* %01 mod end */
	{
		len=strlen(data);
		if((data[0]<'0')||(data[0]>'9')||(len<=3))
		{
			continue;
		}

		/* Get messege number */
		datstr.msgno =  (data[0] & 0x0f)*10000+
				(data[1] & 0x0f)*1000 +
				(data[2] & 0x0f)*100  +
				(data[3] & 0x0f)*10   +
                (data[4] & 0x0f);

		memset(datptr[0],ZERO,TEXTLENGTH);
		memset(datptr[1],ZERO,TEXTLENGTH);
		memset(datptr[2],ZERO,TEXTLENGTH);
		memset(datptr[3],ZERO,TEXTLENGTH);
		dp = &data[5];
		cnt=0;
		while(len>0)
		{
			cp = (char *)strchr(dp,'&');
			if(cp==NULL){break;}
			memcpy(datptr[cnt],dp,cp-dp);
			*(datptr[cnt]+(cp-dp))=0;
			len -= (cp-dp);
			cp+=4;
			dp=cp;
			cnt++;
		}

		if(len>0)
		{
			strcpy(datptr[cnt],dp);
			cnt++;
		}
		datstr.divtxtno = cnt;

		/* Set Message to Massage Table */
		memcpy(&MTBL(counter),&datstr,sizeof(struct M_EtyRec));
		counter++;
	}
	MsgTbl.Etyno = counter - 1;
	fclose(fp);
        return(SUCCESS);
}
