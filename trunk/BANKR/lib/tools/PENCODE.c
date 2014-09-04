#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MOD 19


int p_encode();
void Usage();
int string_check ( char *buf , int mode );
extern int prohibition_check ( char *buf );

main(ac, av)
int		ac;
char*	av[];
{
	unsigned char result[100];
	unsigned char in_buf[100];
	unsigned char in_ans[100];
	int rc;

	memset(result,0x00,sizeof(result));
	memset(in_buf,0x00,sizeof(in_buf));
	memset(in_ans,0x00,sizeof(in_ans));

	if (ac == 3) {
		/* p_encode (pass_name,result,db_name, user_name) */
		printf("�Í�������p�X���[�h����͂��ĉ�����->");
		fgets(in_buf, sizeof(in_buf), stdin);
		in_buf[strlen(in_buf) - 1] = '\0';
		fflush(stdin);

		/* �p�X���[�h�`�F�b�N */
		/*
		rc = string_check ( in_buf , 1 );
		if ( rc != 0 ) {
			exit ( 1 );
		}
		*/

		printf("db_name=[%s] user_name=[%s] passwd=[%s]���Í������܂�\n", 
					av[1],av[2],in_buf);
		printf("��낵���ł���?->(y/n)");
		fgets(in_ans, sizeof(in_ans), stdin);
		fflush(stdin);
		if ( in_ans[0] == 'y' || in_ans[0] == 'Y' ) {
			rc = p_encode(in_buf,result,av[1],av[2]);
			if ( rc == -1 ) {
				rc = prohibition_check( in_buf );
				printf("\n %c �̓p�X���[�h�Ɏg�p�ł��܂���\n",in_buf[rc]);
				exit(1);
			}

		}
		else {
			printf("�L�����Z������܂���\n");
		}
	} else {
		Usage(av[0]);
		exit(1);
	}

	/* �Í���������`�F�b�N */
	rc = string_check ( result , 2 );
	if ( rc != 0 ) {
		exit ( 1 );
	}

	printf("%s\n",result);

	exit(0);
}

void
Usage(module)
char* module;
{
	printf("%s [db_name, user_name]\n", module);
	
}
int string_check ( buf , mode )
char	*buf;	/* ���������� */
int		mode;	/* ���[�h 1:�p�X���[�h 2:�Í������� */
{
	char *rc;
	int  search_c = '^';


	/* ���� ^ �����݂��邩�`�F�b�N */
	rc = strchr( buf , search_c );
	if ( rc != NULL ) {
		if ( mode == 1 ) {
			printf("\n�p�X���[�h�� ���� ^ �́A�g�p�ł��܂���\n");	
		}
		else {
			printf("\n�Í������ꂽ���ʂ� ���� ^ �������Ă��܂�\n");	
		}
		
		printf("�Ⴄ�p�X���[�h�ɕύX���ĉ�����\n");

		return ( 1 );
	}
	
	
	return ( 0 );
	
}
