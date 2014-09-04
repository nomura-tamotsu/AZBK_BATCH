
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned int magic;
  };
  typedef struct sql_cursor sql_cursor;
  typedef struct sql_cursor SQL_CURSOR;
#endif /* SQL_CRSR */

/* Thread Safety */
typedef void * sql_context;
typedef void * SQL_CONTEXT;

/* Object support */
struct sqltvn
{
  unsigned char *tvnvsn; 
  unsigned short tvnvsnl; 
  unsigned char *tvnnm;
  unsigned short tvnnml; 
  unsigned char *tvnsnm;
  unsigned short tvnsnml;
};
typedef struct sqltvn sqltvn;

struct sqladts
{
  unsigned int adtvsn; 
  unsigned short adtmode; 
  unsigned short adtnum;  
  sqltvn adttvn[1];       
};
typedef struct sqladts sqladts;

static struct sqladts sqladt = {
  1,1,0,
};

/* Binding to PL/SQL Records */
struct sqltdss
{
  unsigned int tdsvsn; 
  unsigned short tdsnum; 
  unsigned char *tdsval[1]; 
};
typedef struct sqltdss sqltdss;
static struct sqltdss sqltds =
{
  1,
  0,
};

/* File name & Package Name */
struct sqlcxp
{
  unsigned short fillen;
           char  filnam[43];
};
static const struct sqlcxp sqlfpn =
{
    42,
    "d:\\azbk\\BANKR\\lib\\common\\src\\db_connect.pc"
};


static unsigned int sqlctx = 1824074891;


static struct sqlexd {
   unsigned int   sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   occurs;
      const short *cud;
   unsigned char  *sqlest;
      const char  *stmt;
   sqladts *sqladtp;
   sqltdss *sqltdsp;
            void  **sqphsv;
   unsigned int   *sqphsl;
            int   *sqphss;
            void  **sqpind;
            int   *sqpins;
   unsigned int   *sqparm;
   unsigned int   **sqparc;
   unsigned short  *sqpadto;
   unsigned short  *sqptdso;
   unsigned int   sqlcmax;
   unsigned int   sqlcmin;
   unsigned int   sqlcincr;
   unsigned int   sqlctimeout;
   unsigned int   sqlcnowait;
              int   sqfoff;
   unsigned int   sqcmod;
   unsigned int   sqfmod;
            void  *sqhstv[4];
   unsigned int   sqhstl[4];
            int   sqhsts[4];
            void  *sqindv[4];
            int   sqinds[4];
   unsigned int   sqharm[4];
   unsigned int   *sqharc[4];
   unsigned short  sqadto[4];
   unsigned short  sqtdso[4];
} sqlstm = {12,4};

/* SQLLIB Prototypes */
extern void sqlcxt (void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlcx2t(void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlbuft(void **, char *);
extern void sqlgs2t(void **, char *);
extern void sqlorat(void **, unsigned int *, void *);

/* Forms Interface */
static const int IAPSUCC = 0;
static const int IAPFAIL = 1403;
static const int IAPFTL  = 535;
extern void sqliem(unsigned char *, signed int *);

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,838,0,0,
5,0,0,0,0,0,27,151,0,0,4,4,0,1,0,1,9,0,0,1,9,0,0,1,10,0,0,1,10,0,0,
};


/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM		 	: Marketbrain											*/
/*                                                                          */
/* PROGRAM NAME		: データベース接続 										*/
/*                                                                          */
/* MODULE NAME		: db_connect.pc						                    */
/*                                                                          */
/* FUNCTION			: 環境変数 "DB_UID","DB_PWD" を取得しデータベースに		*/
/*                    接続する。											*/
/*					  パスワードは 環境変数 "DBNAME" を使って複合化			*/
/*                                                                          */
/* CALLING MODULE	: Pro*C Programs.	                                    */
/*                                                                          */
/* CALLED MODULE	: None										            */
/*                                                                          */
/* ENTRY POINT		: db_connect											*/
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+---------------+-----------------------------------------*/
/* %00 | 94/11/11 | E.Higashimoto | First Eddition.                         */
/* %01 | 07/11/01 | E.Higashimoto | Modified for TMB.						*/
/* %02 | 08/11/20 | K.Miyahara    | Modified for IBK.						*/
/*==========================================================================*/
/****************************************************************************/
/*                                                                          */
/*							DECLARE DIVISION								*/
/*                                                                          */
/****************************************************************************/
/*--------------------------------------------------------------------------*/
/*							INCLUDE STATEMENTS								*/
/*--------------------------------------------------------------------------*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "msg.h"
/*--------------------------------------------------------------------------*/
/*							DEFINE STATEMENTS								*/
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*							EXTERNAL DECLARES								*/
/*--------------------------------------------------------------------------*/
extern int send_err();
extern int errhandler();
extern int p_decode();
extern int G_POSITION;
extern char G_STATION[];
extern char G_KOKYAKU_KEY[];

/*--------------------------------------------------------------------------*/
/*							STRUCT DECLARATIONS								*/
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*							SUBROUTNE DEFINITION							*/
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*						INCLUDE STATEMENTS (Pro*C)							*/
/*--------------------------------------------------------------------------*/
/* EXEC SQL INCLUDE mbproc.h;
 */ 
/*==========================================================================*/
/* COPYRIGHT KANEBO LTD. 1994                                               */
/* LICENSED MATERIAL - PROGRAM PROPERTY OF KANEBO                           */
/*==========================================================================*/
/*																			*/
/* SYSTEM			: Marketbrain											*/
/*																			*/
/* PROGRAM NAME		: Pro*C共通ヘッダ										*/
/*																			*/
/* MODULE NAME		: mbporc.h  			   			                    */
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
/* %00 | 94/11/14 | E.Higashimoto | First Eddition.                         */
/*==========================================================================*/
/****************************************************************************/
/*                                                                          */
/*							DECLARE DIVISION								*/
/*                                                                          */
/****************************************************************************/
/*--------------------------------------------------------------------------*/
/*							INCLUSE STATEMENTS								*/
/*--------------------------------------------------------------------------*/
/* EXEC SQL INCLUDE sqlca.h;
 */ 
/*
 * $Header: sqlca.h 24-apr-2003.12:50:58 mkandarp Exp $ sqlca.h 
 */

/* Copyright (c) 1985, 2003, Oracle Corporation.  All rights reserved.  */
 
/*
NAME
  SQLCA : SQL Communications Area.
FUNCTION
  Contains no code. Oracle fills in the SQLCA with status info
  during the execution of a SQL stmt.
NOTES
  **************************************************************
  ***                                                        ***
  *** This file is SOSD.  Porters must change the data types ***
  *** appropriately on their platform.  See notes/pcport.doc ***
  *** for more information.                                  ***
  ***                                                        ***
  **************************************************************

  If the symbol SQLCA_STORAGE_CLASS is defined, then the SQLCA
  will be defined to have this storage class. For example:
 
    #define SQLCA_STORAGE_CLASS extern
 
  will define the SQLCA as an extern.
 
  If the symbol SQLCA_INIT is defined, then the SQLCA will be
  statically initialized. Although this is not necessary in order
  to use the SQLCA, it is a good pgming practice not to have
  unitialized variables. However, some C compilers/OS's don't
  allow automatic variables to be init'd in this manner. Therefore,
  if you are INCLUDE'ing the SQLCA in a place where it would be
  an automatic AND your C compiler/OS doesn't allow this style
  of initialization, then SQLCA_INIT should be left undefined --
  all others can define SQLCA_INIT if they wish.

  If the symbol SQLCA_NONE is defined, then the SQLCA variable will
  not be defined at all.  The symbol SQLCA_NONE should not be defined
  in source modules that have embedded SQL.  However, source modules
  that have no embedded SQL, but need to manipulate a sqlca struct
  passed in as a parameter, can set the SQLCA_NONE symbol to avoid
  creation of an extraneous sqlca variable.
 
MODIFIED
    lvbcheng   07/31/98 -  long to int
    jbasu      12/12/94 -  Bug 217878: note this is an SOSD file
    losborne   08/11/92 -  No sqlca var if SQLCA_NONE macro set 
  Clare      12/06/84 - Ch SQLCA to not be an extern.
  Clare      10/21/85 - Add initialization.
  Bradbury   01/05/86 - Only initialize when SQLCA_INIT set
  Clare      06/12/86 - Add SQLCA_STORAGE_CLASS option.
*/
 
#ifndef SQLCA
#define SQLCA 1
 
struct   sqlca
         {
         /* ub1 */ char    sqlcaid[8];
         /* b4  */ int     sqlabc;
         /* b4  */ int     sqlcode;
         struct
           {
           /* ub2 */ unsigned short sqlerrml;
           /* ub1 */ char           sqlerrmc[70];
           } sqlerrm;
         /* ub1 */ char    sqlerrp[8];
         /* b4  */ int     sqlerrd[6];
         /* ub1 */ char    sqlwarn[8];
         /* ub1 */ char    sqlext[8];
         };

#ifndef SQLCA_NONE 
#ifdef   SQLCA_STORAGE_CLASS
SQLCA_STORAGE_CLASS struct sqlca sqlca
#else
         struct sqlca sqlca
#endif
 
#ifdef  SQLCA_INIT
         = {
         {'S', 'Q', 'L', 'C', 'A', ' ', ' ', ' '},
         sizeof(struct sqlca),
         0,
         { 0, {0}},
         {'N', 'O', 'T', ' ', 'S', 'E', 'T', ' '},
         {0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0},
         {0, 0, 0, 0, 0, 0, 0, 0}
         }
#endif
         ;
#endif
 
#endif
 
/* end SQLCA */

/*--------------------------------------------------------------------------*/
/*							DEFINE STATEMENTS								*/
/*--------------------------------------------------------------------------*/
#define ORA_NOF		1403				/* ORACLE_CODE( DATA NOT FOUND )	*/
#define ORA_NULL	-1					/* NULL値の場合の標識変数の値		*/
#define ORA_NOT_NULL 0					/* NOT NULL値の場合の標識変数の値	*/


/*--------------------------------------------------------------------------*/
/*							EXTERNAL DECLARES								*/
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*							STRUCT DECLARATIONS								*/
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/*							SUBROUTNE DEFINITION							*/
/*--------------------------------------------------------------------------*/


/****************************************************************************/
/*                                                                          */
/*							PROCEDURE DIVISION								*/
/*                                                                          */
/****************************************************************************/
int db_connect( void )
{
/*--------------------------------------------------------------------------*/
/*						HOST VARIABLE DECLARATIONS (Pro*C)					*/
/*--------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	/* varchar		userid[42]; */ 
struct { unsigned short len; unsigned char arr[42]; } userid;
							/* ユーザーID			*/
	/* varchar		password[42]; */ 
struct { unsigned short len; unsigned char arr[42]; } password;
						/* パスワード			*/
/* EXEC SQL END DECLARE SECTION; */ 


/*--------------------------------------------------------------------------*/
/*						LOCAL VARIABLE DECLARATIONS							*/
/*--------------------------------------------------------------------------*/
	char			*str;						/* 文字バッファ				*/
	char			*str1;						/* 文字バッファ				*/
	char			*str2;						/* 文字バッファ				*/
	char			*str3;						/* 文字バッファ				*/
	char			*str4;						/* 文字バッファ				*/
	char uid[100];
	char pwd[100];
	char result[100];

/*--------------------------------------------------------------------------*/
/*		MAIN ROUTINE														*/
/*--------------------------------------------------------------------------*/

	/* EXEC SQL WHENEVER SQLERROR DO errhandler(); */ 


/*-----		環境変数取得             ---------------------------------------*/

	memset(uid,0x00,sizeof(uid));
	memset(pwd,0x00,sizeof(pwd));
	memset(result,0x00,sizeof(result));

	if( ( str = (char *)getenv("MBENV_KOKYAKU_KEY") ) == (char *)NULL ){
		send_err( m$getenv, -1, "MBENV_KOKYAKU_KEY", NULL, NULL, G_STATION );
		return(-1);
	}
	strcpy( G_KOKYAKU_KEY, str );

	if( ( str1 = (char *)getenv("DB_NAME") ) == (char *)NULL ){
		send_err( m$getenv, -1, "DB_NAME", NULL, NULL, G_STATION ) ;
		return(-1);
	}

	if( ( str2 = (char *)getenv("DB_UID") ) == (char *)NULL ){
		send_err( m$getenv, -1, "DB_UID", NULL, NULL, G_STATION ) ;
		return(-1);
	}

	strcpy( (char *)userid.arr, str2 );
	if( ( str3 = (char *)getenv("ORACLE_TNS") ) == (char *)NULL ){
		userid.len = strlen( (char *)userid.arr );
    } else {
		strcat( (char *)userid.arr, "@" );
		strcat( (char *)userid.arr, str3 );
		userid.len = strlen( (char *)userid.arr );
	}

	if( ( str4 = (char *)getenv("DB_PWD") ) == (char *)NULL ){
		send_err( m$getenv, -1, "DB_PWD", NULL, NULL, G_STATION ) ;
		return(-1);

	}

/*AIX用にテンポラリ対応 削除*/
	/*
	while (strlen(str1) <= strlen(str4) -1) {
		strcat(&str1[strlen(str1)], "x");
	}
	*/


	/* 複合化 */
	p_decode(str4,result,str1,str2);

	strcpy( (char *)password.arr, result );
	password.len = strlen( (char *)password.arr );

/*-----		DB接続             -----------------------------------------*/
	/* EXEC SQL CONNECT :userid IDENTIFIED BY :password; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )10;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)4352;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (         void  *)&userid;
 sqlstm.sqhstl[0] = (unsigned int  )44;
 sqlstm.sqhsts[0] = (         int  )44;
 sqlstm.sqindv[0] = (         void  *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (         void  *)&password;
 sqlstm.sqhstl[1] = (unsigned int  )44;
 sqlstm.sqhsts[1] = (         int  )44;
 sqlstm.sqindv[1] = (         void  *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlstm.sqlcmax = (unsigned int )100;
 sqlstm.sqlcmin = (unsigned int )2;
 sqlstm.sqlcincr = (unsigned int )1;
 sqlstm.sqlctimeout = (unsigned int )0;
 sqlstm.sqlcnowait = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) errhandler();
}



	if( sqlca.sqlcode < 0 ) { 
		return(-1);

	}
	return(0);

}
