/************************************************************************/
/*                                                                      */
/*  ���W���[����    :   encode.c                                        */
/*                      DB�p�X���[�h�Í����A������                      */
/*                                                                      */
/*  �@�\            :   DB�p�X���[�h���Í�������(p_encode)              */
/*                      DB�p�X���[�h�𕜍�������(p_decode)              */
/*                                                                      */
/*  ����            :   src     �����Ώە�����(�߽ܰ�ށA�Í���������)   */
/*                  :   dest    ��������(������������A�߽ܰ��)         */
/*                  :   db_nm   DB��(�C���X�^���X��)                    */
/*                  :   user_nm DBհ�ޖ�                                */
/*                                                                      */
/*  �ύX����....                                                        */
/*  date       name          level  contents                            */
/* ---------- -------------- ----- ---------------------------------    */
/*  04/03/16  M.Sogo         L1.0   Initial release.                    */
/*  06/11/01  E.Higashimoto  L1.1   �����Ή��i���ϊ��j.                 */
/*  13/10/10  ISID           L1.2   ���ꕶ���Ή��i�e�[�u���ϊ��j.       */
/*  14/07/01  ISID           L1.3   ���ꕶ���Ή��i^�����Ή��j.          */
/*  14/07/10  ISID           L1.4   �啶�� ���ꕶ���ϊ����W�b�N�C��     */
/************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MOD     19
#define BUFLEN 100

/* L1.2 Add Start */
/* ���ꕶ���e�[�u�� �� */
#define SP_CHAR_NUMBER 21
/* ���ꕶ���e�[�u�� �ϊ��O */
static unsigned char sp_char_src[SP_CHAR_NUMBER] =  {
0x21,0x23,0x24,0x25,0x27,0x28,0x29,0x60,0x2b,0x2d,
0x2f,0x3a,0x3f,0x5b,0x5c,0x5d,0x5f,0x7b,0x7d,0x7e,
0x00
};
/* ���ꕶ���e�[�u�� �ϊ��� */
static unsigned char sp_char_dest[SP_CHAR_NUMBER] =  {
0x2f,0x3a,0x3f,0x5b,0x5c,0x5d,0x5f,0x7b,0x7d,0x7e,
0x21,0x23,0x24,0x25,0x27,0x28,0x29,0x60,0x2b,0x2d,
0x00
};
/* ���ꕶ���ϊ���� */
#define ENCODE 1
#define DECODE 2

/* �p�啶���e�[�u�� �� L1.4 */
#define CAPITAL_LETTER_NUMBER 27

/* �p�啶���e�[�u�� �ϊ��O L1.4 */
static unsigned char capital_letter_src[CAPITAL_LETTER_NUMBER] =  {
0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,
0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,0x52,0x53,0x54,
0x55,0x56,0x57,0x58,0x59,0x5A,0x00
};
/* �p�啶���e�[�u�� �ϊ��� L1.4 */
static unsigned char capital_letter_dest[CAPITAL_LETTER_NUMBER] =  {
0x4B,0x4C,0x4D,0x4E,0x4F,0x50,0x51,0x52,0x53,0x54,
0x41,0x42,0x43,0x44,0x45,0x46,0x47,0x48,0x49,0x4A,
0x5A,0x59,0x58,0x57,0x56,0x55,0x00
};


/* L1.2 Add End */

void reverse();
static int calc();
void lower();
static int is_sp_char();

p_decode(src,dest,db_nm,user_nm)
unsigned char *src;
unsigned char *dest;
unsigned char *db_nm;
unsigned char *user_nm;
{
	int db_cnt;
	int user_cnt;
	int i;
	int val;
	unsigned char set_char;
	int p_len;
	unsigned char src_work[BUFSIZ];
	int rc;


	p_len = (unsigned int)strlen(src);

	if ( p_len == 0 || p_len > BUFLEN) {
		return ( 1 );
	}

	/* �������ϊ� */
	strcpy(src_work, src);
	/*lower(src_work,p_len);*/

	/* ������t�ʒu */
	reverse(src_work,p_len);
	p_len--;
	src_work[p_len] = 0x00;

	/* cnt �v�Z */
	db_cnt = calc(db_nm,strlen(db_nm));
	user_cnt = calc(user_nm,strlen(user_nm));

	/* val �v�Z */
	val = ( db_cnt + user_cnt ) % MOD;
	if ( val == 0 ) {
		val = 5;
	}

	for ( i = 0; i < p_len ; i++) {
/* L1.1 Change Start */
		if( src_work[i] >= '0' && src_work[i] <= '9' ){
			dest[i] = src_work[i];
			continue;
		}	
/* L1.1 Change End */

/* L1.4 Chage Start */
		if( src_work[i] >= 'A' && src_work[i] <= 'Z' ){
			rc = is_capital_letter ( &src_work[i],  DECODE );
			dest[i] = capital_letter_src[rc];
			continue;
		}

		if( src_work[i] >= 'a' && src_work[i] <= 'z' ){
			set_char = src_work[i] - val;
			if ( set_char < 'a' ) {
				set_char += 'z' - 'a' + 1;
			}

			dest[i] = set_char;
			continue;
		}
/* L1.4 Chage End */

/* L1.2 Add Start */
		rc = is_sp_char( &src_work[i], DECODE );
		if( rc >= 0 ) {
			dest[i] = sp_char_src[rc];
			continue;
		}
		else {
			return ( -1 );
		}

/* L1.2 Add End */


	}

	return ( 0 );


}
p_encode(src,dest,db_nm,user_nm)
unsigned char *src;
unsigned char *dest;
unsigned char *db_nm;
unsigned char *user_nm;
{

	int db_cnt;
	int user_cnt;
	int i;
	int val;
	unsigned char set_char;
	int p_len;
	unsigned char src_work[BUFSIZ];
	int rc;

	p_len = (unsigned int)strlen(src);

	if ( p_len == 0 || p_len > BUFLEN) {
		return ( 1 );
	}

	/* �������ϊ� */
	strcpy(src_work, src);
	/*lower(src_work,p_len);*/

	/* ������t�ʒu */
	reverse(src_work,p_len);

	/* cnt �v�Z */
	db_cnt = calc(db_nm,strlen(db_nm));
	user_cnt = calc(user_nm,strlen(user_nm));
	

	/* val �v�Z */
	val = ( db_cnt + user_cnt ) % MOD;
	if ( val == 0 ) {
		val = 5;
	}

	dest[0] = 'a' + val - 1;

	for ( i = 0; i < p_len ; i++) {
		

/* L1.1 Change Start */
		if( src_work[i] >= '0' && src_work[i] <= '9' ){
			dest[i+1] = src_work[i];
			continue;
		}	
/* L1.1 Change End */

/* L1.4 Chage Start */
		if( src_work[i] >= 'A' && src_work[i] <= 'Z' ){
			rc = is_capital_letter ( &src_work[i],  ENCODE );
			dest[i+1] = capital_letter_dest[rc];
			continue;
		}	

		if( src_work[i] >= 'a' && src_work[i] <= 'z' ){
			set_char = src_work[i] + val;
			if ( set_char > 'z' ) {
				set_char -= 'z' ;
				set_char += ('a' - 1 );
			}
			dest[i+1] = set_char;
			continue;
		}
/* L1.4 Chage End */

/* L1.2 Add Start */
		rc = is_sp_char( &src_work[i], ENCODE );
		if( rc >= 0 ) {
			dest[i+1] = sp_char_dest[rc];
			continue;
		}
		else {
			return ( -1 );
		}
/* L1.2 Add End */

		
	}

	return ( 0 );
}

void reverse(buf,len)
unsigned char *buf;
int len;
{
	int i;
	int j;
	unsigned char buf2[BUFLEN];

	memset( buf2, 0x00, sizeof(buf2) );

	for ( j = 0,i = len -1;i >= 0; i--,j++ ) {
		buf2[j] = buf[i];
	}

	memcpy( buf, buf2, len );

}

static int calc(buf,len)
unsigned char *buf;
int len;
{
	int cnt=0;
	int i;

	for ( i = 0;i < len; i++ ) {
		cnt+= buf[i] - 'A' + 1;		/* L1.3 'a'->'A' */
	}

	return ( cnt );

}

/* �������ϊ� */
void lower(buf,len)
unsigned char *buf;
int len;
{
	int i;

	for ( i = 0;i < len; i++) {
		buf[i] = tolower(buf[i]);
	}
}

/* L1.2 Add Start */
/* ���ꕶ���`�F�b�N */
static int is_sp_char( check_char , kind )
unsigned char *check_char; /* �`�F�b�N���� */
int kind;  		 /* ENCODE,DECODE ��� */
{
	int i;
	unsigned char *compare_str;

	if ( kind == ENCODE ) {
		/* encode�̃e�[�u�����Z�b�g */
		compare_str = sp_char_src;
	}
	else {
		/* decode�̃e�[�u�����Z�b�g */
		compare_str = sp_char_dest;
	}

	/* �`�F�b�N����������  */
	for(i = 0 ;i < SP_CHAR_NUMBER; i++ ) {
		if ( check_char[0] == compare_str[i] ) {
			/* ���������ꍇ���̔z��̏��Ԃ����^�[�� */
			return ( i ) ;
		}
	}

	/* ������Ȃ������ꍇ */
	return ( -1 );
}
/* L1.2 Add End */
/* L1.4 Add Start */
/* �p�啶���`�F�b�N */
static int is_capital_letter( check_char , kind )
unsigned char *check_char; /* �`�F�b�N���� */
int kind;  		 /* ENCODE,DECODE ��� */
{
	int i;
	unsigned char *compare_str;

	if ( kind == ENCODE ) {
		/* encode�̃e�[�u�����Z�b�g */
		compare_str = capital_letter_src;
	}
	else {
		/* decode�̃e�[�u�����Z�b�g */
		compare_str = capital_letter_dest;
	}

	/* �`�F�b�N����������  */
	for(i = 0 ;i < CAPITAL_LETTER_NUMBER; i++ ) {
		if ( check_char[0] == compare_str[i] ) {
			/* ���������ꍇ���̔z��̏��Ԃ����^�[�� */
			return ( i ) ;
		}
	}

	/* ������Ȃ������ꍇ */
	return ( -1 );
}


/* �֎~�����`�F�b�N */
int prohibition_check( char *buf )
{
	int i;
	int j;
	int len;

	len = (unsigned int ) strlen( buf );

	for ( i = 0 ; i < len; i++ ) {
		if ( buf[i] >= '0' && buf[i] <='9' ) {
			continue;
		}
		if ( buf[i] >= 'a' && buf[i] <='z' ) {
			continue;
		}
		if ( buf[i] >= 'A' && buf[i] <='Z' ) {
			continue;
		}
		for ( j = 0; j < SP_CHAR_NUMBER; j++ ) {
			if ( buf[i] == sp_char_src[j]) {
				continue;
			}
		}

		return ( i ) ;
		
	}
	

	return ( -1 );

}
/* L1.4 Add End */