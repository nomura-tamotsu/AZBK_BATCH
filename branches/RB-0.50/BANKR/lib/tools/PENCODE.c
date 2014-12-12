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
		printf("暗号化するパスワードを入力して下さい->");
		fgets(in_buf, sizeof(in_buf), stdin);
		in_buf[strlen(in_buf) - 1] = '\0';
		fflush(stdin);

		/* パスワードチェック */
		/*
		rc = string_check ( in_buf , 1 );
		if ( rc != 0 ) {
			exit ( 1 );
		}
		*/

		printf("db_name=[%s] user_name=[%s] passwd=[%s]を暗号化します\n", 
					av[1],av[2],in_buf);
		printf("よろしいですか?->(y/n)");
		fgets(in_ans, sizeof(in_ans), stdin);
		fflush(stdin);
		if ( in_ans[0] == 'y' || in_ans[0] == 'Y' ) {
			rc = p_encode(in_buf,result,av[1],av[2]);
			if ( rc == -1 ) {
				rc = prohibition_check( in_buf );
				printf("\n %c はパスワードに使用できません\n",in_buf[rc]);
				exit(1);
			}

		}
		else {
			printf("キャンセルされました\n");
		}
	} else {
		Usage(av[0]);
		exit(1);
	}

	/* 暗号化文字列チェック */
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
char	*buf;	/* 検査文字列 */
int		mode;	/* モード 1:パスワード 2:暗号化文字 */
{
	char *rc;
	int  search_c = '^';


	/* 文字 ^ が存在するかチェック */
	rc = strchr( buf , search_c );
	if ( rc != NULL ) {
		if ( mode == 1 ) {
			printf("\nパスワードに 文字 ^ は、使用できません\n");	
		}
		else {
			printf("\n暗号化された結果に 文字 ^ が入っています\n");	
		}
		
		printf("違うパスワードに変更して下さい\n");

		return ( 1 );
	}
	
	
	return ( 0 );
	
}
