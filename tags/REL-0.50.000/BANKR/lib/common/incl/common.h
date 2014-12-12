/*==========================================================================*/
/* COPYRIGHT Brainy Works LTD.                                              */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainy Works                     */
/*==========================================================================*/
/*																			*/
/* SYSTEM			: Marketbrain											*/
/*																			*/
/* PROGRAM NAME		: 共通ヘッダ											*/
/*																			*/
/* MODULE NAME		: common.h												*/
/*																			*/
/* FUNCTION			: 														*/
/*																			*/
/* CALLING MODULE	: None													*/
/*																			*/
/* CALLED MODULE	: None													*/
/*																			*/
/* ENTRY POINT		:														*/
/*																			*/
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+---------------+-----------------------------------------*/
/* %01 | 07/02/19 | E.Higashimoto | Modified For SSNB.                      */
/*==========================================================================*/
#include <sys/types.h>

#define DELAY   10
#define READ    "r"
#define WRITE   "w+" 
#define SUCCESS 0
#define NORMAL	0
#define	ERROR	9
#define REC_LEN  128
#define MAX_LENG 10240
#define MSGMAX   10240
#define	IplErr1	-1
#define	IplErr2	-2
#define	Err1	-1
#define	Err2	-2
#define NO_FILE	-1
#define MODE    0666
#define EFINI	while(1)
#define NODIFF	0
/* %01 Change Start */
/*
#define TEXTLENGTH 80
*/
#define TEXTLENGTH 128
/* %01 Change End */
#define ZERO    0
#define MAX_QDATA_LEN       10240+sizeof(struct QUEUE_header)
#define SZOF_QHEADER        sizeof(struct QUEUE_header)
/* %01 Add Start */
#define DEFINE_MSG_REC_LEN 256
/* %01 Add End */

/* ---- msgbuf.mtype ---- */
#define MTYPE_HIGH      9
#define MTYPE_NORMAL    1
#define MTYPE_FIFO      0

struct  QUEUE_header {
    char    QUEUE_target[32]    ;
    char    QUEUE_origin[32]    ;
    int     QUEUE_code          ;
    int     QUEUE_length        ;
};
/* ---- Here is user area ---- */
struct  msg_buffer {
  /*  mtyp_t  mtype                ; */
    char    mtext[MAX_QDATA_LEN] ; 
};
#define QDATA_STOP_BOSS         99
#define QDATA_START_STATION     10
#define QDATA_STOP_STATION      20
#define QDATA_INQUIRE_STATION   30
#define QDATA_EXECUTE_IPL       40
#define QDATA_WINDOW_CHANGE     50
#define QDATA_NORMAL            0
#define QDATA_STOP_OK           21

typedef	struct	_MSGTBL	MSGTBL;

/* %01 Change Start */
/*
struct	M_EtyRec {
	int   msgno;
	int   divtxtno;
	char text1[80];
	char text2[80];
	char text3[80];
	char text4[80];
};
*/
struct	M_EtyRec {
	int   msgno;
	int   divtxtno;
	char text1[TEXTLENGTH];
	char text2[TEXTLENGTH];
	char text3[TEXTLENGTH];
	char text4[TEXTLENGTH];
};
/* %01 Change End */

struct	_MSGTBL {
	int	Etyno;
	struct	M_EtyRec EtyRec[MSGMAX];
};

/* ログ出力 */
struct  log_cons_msg {
        int      msgno;
        int      rtcode;
        char     prm1[4096];
        char     prm2[256];
        char     prm3[256];
};

struct  log_cons_msg *log_cons_p;
#define MTBL(a) MsgTbl.EtyRec[(a)]
#define initchkerr  char dat[256];struct log_cons_msg lcmsg;int mmr=0;
                    
#define errprint(a,b,c,d,e,f) lcmsg.msgno=(a);lcmsg.rtcode=(b);             \
                strcpy(lcmsg.prm1,(c));strcpy(lcmsg.prm2,(d));              \
                strcpy(lcmsg.prm3,(e)); mmr=make_log((char *)&lcmsg,dat,(f)); \
                if((mmr)==0);                  \
                if((mmr)!=0){ fprintf(window_fd1,"%s",dat); fprintf(window_fd2,"%s",dat);}
#define chkerr(a,b,d,e,f,g) if((b)<SUCCESS){errprint((a),errno,(d),(e),(f),(g));}
#define init_err(a,b) time_d=time(NULL);tmdata = localtime(&time_d);           \
                sprintf(dat,"%d:%d:%d   ",tmdata->tm_hour,           \
                                                tmdata->tm_min,            \
                                                tmdata->tm_sec);           \
                sprintf(&dat[10],"[%s] initialize failure station aborted [STATION : ERRLOG ERROR CODE : %d]\n",(a),(b)); \
                if((mmr)==0){printf("%s",dat);}