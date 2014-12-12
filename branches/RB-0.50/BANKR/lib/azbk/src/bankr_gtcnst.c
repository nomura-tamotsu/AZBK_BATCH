/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* PROGRAM NAME     : 共通処理　　　　　                                    */
/*                                                                          */
/*                                                                          */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 14/03/27 | ISID        | First Edition.                            */
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
#include "azbk_funcerr.h"
/*---------------------------------------------------------------------------*/
/* Standard include specification                                            */
/*---------------------------------------------------------------------------*/
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <ctype.h>
#include <sys/types.h>
#include <fcntl.h>
#include <errno.h>

/*****************************************************************************/
/* Function Name:                                                            */
/*    FcCheckNumber( CHAR *szInString, int iLength )                         */
/* Modified by:                                                              */
/*                                                                           */
/* Description:                                                              */
/*    引き渡された文字列の対象バイト数までが整数または浮動小数点数として解釈 */
/*    できるかどうかをチェックし、結果を返す。先行する空白は無視される。     */
/*                                                                           */
/*    注意）引き渡される文字列の長さの範囲にNULL文字があると終端と見なし、   */
/*    そこまでで整数または浮動小数点数として解釈できるか否かで結果を返す。   */
/*                                                                           */
/* Arguments:                                                                */
/*  Type/Length   Name        I/O  Content                                   */
/* ------------  ------------ --- --------------------------------------     */
/*    char*      szInString   IN  検査すべき文字列                           */
/*    int        iLength      IN  文字列の長さ                               */
/* Files:                                                                    */
/*    None                                                                   */
/* Tables:                                                                   */
/*    None                                                                   */
/* Return Code:                                                              */
/*    NO_ERROR     :整数                                                     */
/*    ERR_REAL     :実数                                                     */
/*    ERR_STRING   :数値以外                                                 */
/*****************************************************************************/
unsigned long FcCheckNumber ( char * szString, int iLength  ) {

    int i;
    int a;
    int stat = 0;

    /* State Transition Diagram                              */
    /* 0:start, 1:sign, 2:digit-1, 3:dot, 4:digit-2, 9:error */

    for( i = 0; i < iLength; i++ ) {
        if( stat == 9 ) break;
        if(( a = szString[ i ] ) == '\0' ) break;
        switch( stat ) {
            case 0:
                if      ( isdigit( a ) )         stat = 2;
                else if ( a != ' ' )             stat = 9;
                break;
            case 1:
                if      ( isdigit( a ) )         stat = 2;
                else                             stat = 9;
                break;
            case 2:
                if      ( a == '.' )             stat = 3;
                else if ( !isdigit( a ) )        stat = 9;
                break;
            case 3:
                if      ( isdigit( a ) )         stat = 4;
                else                             stat = 9;
                break;
            case 4:
                if      ( !isdigit( a ) )        stat = 9;
                break;
            default:
                                                 stat = 9;
                break;
        } /* endswitch */
    }
    if      ( stat == 2 ) return NO_ERROR;
    else if ( stat == 4 ) return ERR_REAL;
    else                  return ERR_STRING;
}
/*****************************************************************************/
/* Function Name:                                                            */
/* long FcStringtoInteger( const char* buf, unsigned int len )               */
/* long long FcStringtoLonglong( const char* buf, unsigned int len )         */
/* Modified by:                                                              */
/*                                                                           */
/* Description:                                                              */
/*   バッファ中に格納された整数を数値変換する。                              */
/*   長さに指定できるのは最大３１バイトで、それ以上は abort する。           */
/* Arguments:                                                                */
/*   Type/Name                I/O  Content                                   */
/* -------------------------- --- --------------------------------------     */
/*  const char* buf           IN   変換対象を含むバッファ                    */
/*  unsigned int len          IN   変換対象のバイト数 ( < 32 )               */
/* Files :                                                                   */
/*    None                                                                   */
/* Tables:                                                                   */
/*    None                                                                   */
/* Return Code:                                                              */
/*   long/long long 変換結果                                                 */
/*****************************************************************************/
long FcStringtoInteger( const char* buf, unsigned int len )
{
        char    tmp[ 32 ];

        if( len > 31 ) abort();
        if( !buf ) abort();

        strncpy( tmp, buf, len );
        tmp[ len ] = '\0';

        return atoi( tmp );
}
long long FcStringtoLonglong( const char* buf, unsigned int len )
{
        char    tmp[ 32 ];

        if( len > 31 ) abort();
        if( !buf ) abort();

        strncpy( tmp, buf, len );
        tmp[ len ] = '\0';

        return strtol( tmp, NULL, 10 ); /* strtoll→strtol() */

}
/*****************************************************************************/
/* Function Name:                                                            */
/*   char* FcNumbertoString ( long Digit, int Len )                          */
/* Modified by:                                                              */
/*                                                                           */
/* Description:                                                              */
/*    数値（整数）を内部バッファ内で指定桁数の文字列に変換しポインタを返す。 */
/*    数値の桁数は３１桁以内、それ以上はエラーとなる。                       */
/*    終端（変換桁数＋１バイト目）にはNULLを付加している。                   */
/*    結果文字列は右詰になっている。                                         */
/* Arguments:                                                                */
/*   Name        Type/Length  I/O  Content                                   */
/* ------------  ------------ --- --------------------------------------     */
/*  long lDigit               IN   変換対象数値                              */
/*  int  iLength              IN   変換結果の桁数                            */
/* Files :                                                                   */
/*    None                                                                   */
/* Tables:                                                                   */
/*    None                                                                   */
/* Return Code:                                                              */
/*    変換した文字列のアドレス。終端にはNULLを付加している。                 */
/*    または NULL （エラー発生時）                                           */
/*****************************************************************************/
char * FcNumbertoString ( long lDigit, int  iLength ) {

    static char     sBuffer[ 32 ];
    char*           sPointer;

    /* Check Length */
    if( iLength <= 0 || 31 < iLength ) return NULL;

    sprintf( sBuffer, "%.*ld", iLength, lDigit );

    return sBuffer;
}