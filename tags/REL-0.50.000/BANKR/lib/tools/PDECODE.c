#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

#define MOD 19

int p_decode();
void Usage();

main(ac, av)
int		ac;
char*	av[];
{
	unsigned char result[100];
	unsigned char in_buf[100];
	unsigned char in_ans[100];
	unsigned char *str4;		/* �����o�b�t�@	*/


	memset(result,0x00,sizeof(result));
	memset(in_buf,0x00,sizeof(in_buf));
	memset(in_ans,0x00,sizeof(in_ans));

	if (ac == 3) {

		if( ( str4 = (unsigned char *)getenv("DB_PWD") ) == (char *)NULL ){
			printf("���ϐ��FDB_PWD���擾�ł��܂���ł���\n");
			exit ( 9 );

		}
		strcpy ( in_buf, str4 );

		p_decode(in_buf,result,av[1],av[2]);

	}
	
	else if (ac == 4) {
		if ( !memcmp( av[3], "tool", 4 )) {
			
			printf("����������p�X���[�h����͂��ĉ�����->");
			fgets(in_buf, sizeof(in_buf), stdin);
			in_buf[strlen(in_buf) - 1] = '\0';
			fflush(stdin);

			printf("db_name=[%s] user_name=[%s] passwd=[%s]�𕜍������܂�\n", 
					av[1],av[2],in_buf);
			printf("��낵���ł���?->(y/n)");
			fgets(in_ans, sizeof(in_ans), stdin);
			fflush(stdin);
			if ( in_ans[0] == 'y' || in_ans[0] == 'Y' ) {
				p_decode(in_buf,result,av[1],av[2]);
			}
			else {
				printf("�L�����Z������܂���\n");
			}
		}
		else {
			printf("��3������ tool �ł͂���܂���\n");
			printf("�L�����Z������܂���\n");

		}
	}

	else {
		Usage(av[0]);
		exit(1);
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

