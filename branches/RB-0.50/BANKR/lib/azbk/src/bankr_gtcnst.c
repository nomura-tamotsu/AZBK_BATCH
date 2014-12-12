/*==========================================================================*/
/* Copyright�@Information Services International-Dentsu, Ltd.   �@          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK�ER�|CC                                           */
/*                                                                          */
/* PROGRAM NAME     : ���ʏ����@�@�@�@�@                                    */
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
/*    �����n���ꂽ������̑Ώۃo�C�g���܂ł������܂��͕��������_���Ƃ��ĉ��� */
/*    �ł��邩�ǂ������`�F�b�N���A���ʂ�Ԃ��B��s����󔒂͖��������B     */
/*                                                                           */
/*    ���Ӂj�����n����镶����̒����͈̔͂�NULL����������ƏI�[�ƌ��Ȃ��A   */
/*    �����܂łŐ����܂��͕��������_���Ƃ��ĉ��߂ł��邩�ۂ��Ō��ʂ�Ԃ��B   */
/*                                                                           */
/* Arguments:                                                                */
/*  Type/Length   Name        I/O  Content                                   */
/* ------------  ------------ --- --------------------------------------     */
/*    char*      szInString   IN  �������ׂ�������                           */
/*    int        iLength      IN  ������̒���                               */
/* Files:                                                                    */
/*    None                                                                   */
/* Tables:                                                                   */
/*    None                                                                   */
/* Return Code:                                                              */
/*    NO_ERROR     :����                                                     */
/*    ERR_REAL     :����                                                     */
/*    ERR_STRING   :���l�ȊO                                                 */
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
/*   �o�b�t�@���Ɋi�[���ꂽ�����𐔒l�ϊ�����B                              */
/*   �����Ɏw��ł���͍̂ő�R�P�o�C�g�ŁA����ȏ�� abort ����B           */
/* Arguments:                                                                */
/*   Type/Name                I/O  Content                                   */
/* -------------------------- --- --------------------------------------     */
/*  const char* buf           IN   �ϊ��Ώۂ��܂ރo�b�t�@                    */
/*  unsigned int len          IN   �ϊ��Ώۂ̃o�C�g�� ( < 32 )               */
/* Files :                                                                   */
/*    None                                                                   */
/* Tables:                                                                   */
/*    None                                                                   */
/* Return Code:                                                              */
/*   long/long long �ϊ�����                                                 */
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

        return strtol( tmp, NULL, 10 ); /* strtoll��strtol() */

}
/*****************************************************************************/
/* Function Name:                                                            */
/*   char* FcNumbertoString ( long Digit, int Len )                          */
/* Modified by:                                                              */
/*                                                                           */
/* Description:                                                              */
/*    ���l�i�����j������o�b�t�@���Ŏw�茅���̕�����ɕϊ����|�C���^��Ԃ��B */
/*    ���l�̌����͂R�P���ȓ��A����ȏ�̓G���[�ƂȂ�B                       */
/*    �I�[�i�ϊ������{�P�o�C�g�ځj�ɂ�NULL��t�����Ă���B                   */
/*    ���ʕ�����͉E�l�ɂȂ��Ă���B                                         */
/* Arguments:                                                                */
/*   Name        Type/Length  I/O  Content                                   */
/* ------------  ------------ --- --------------------------------------     */
/*  long lDigit               IN   �ϊ��Ώې��l                              */
/*  int  iLength              IN   �ϊ����ʂ̌���                            */
/* Files :                                                                   */
/*    None                                                                   */
/* Tables:                                                                   */
/*    None                                                                   */
/* Return Code:                                                              */
/*    �ϊ�����������̃A�h���X�B�I�[�ɂ�NULL��t�����Ă���B                 */
/*    �܂��� NULL �i�G���[�������j                                           */
/*****************************************************************************/
char * FcNumbertoString ( long lDigit, int  iLength ) {

    static char     sBuffer[ 32 ];
    char*           sPointer;

    /* Check Length */
    if( iLength <= 0 || 31 < iLength ) return NULL;

    sprintf( sBuffer, "%.*ld", iLength, lDigit );

    return sBuffer;
}