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
	unsigned char *str4;		/* 文字バッファ	*/


	memset(result,0x00,sizeof(result));
	memset(in_buf,0x00,sizeof(in_buf));
	memset(in_ans,0x00,sizeof(in_ans));

	if (ac == 3) {

		if( ( str4 = (unsigned char *)getenv("DB_PWD") ) == (char *)NULL ){
			printf("環境変数：DB_PWDが取得できませんでした\n");
			exit ( 9 );

		}
		strcpy ( in_buf, str4 );

		p_decode(in_buf,result,av[1],av[2]);

	}
	
	else if (ac == 4) {
		if ( !memcmp( av[3], "tool", 4 )) {
			
			printf("復号化するパスワードを入力して下さい->");
			fgets(in_buf, sizeof(in_buf), stdin);
			in_buf[strlen(in_buf) - 1] = '\0';
			fflush(stdin);

			printf("db_name=[%s] user_name=[%s] passwd=[%s]を復号化します\n", 
					av[1],av[2],in_buf);
			printf("よろしいですか?->(y/n)");
			fgets(in_ans, sizeof(in_ans), stdin);
			fflush(stdin);
			if ( in_ans[0] == 'y' || in_ans[0] == 'Y' ) {
				p_decode(in_buf,result,av[1],av[2]);
			}
			else {
				printf("キャンセルされました\n");
			}
		}
		else {
			printf("第3引数が tool ではありません\n");
			printf("キャンセルされました\n");

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

