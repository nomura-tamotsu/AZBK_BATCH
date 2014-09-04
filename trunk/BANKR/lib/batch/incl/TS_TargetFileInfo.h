/*==========================================================================*/
/* Copyright　Information Services International-Dentsu, Ltd.   　          */
/*==========================================================================*/
/*                                                                          */
/* SYSTEM           : BANK・R－CC                                           */
/*                                                                          */
/* Description      : TS_対象ファイル情報                                   */
/*                                                                          */
/* File Name        :TS_TargetFileInfo.h                                    */
/*                                                                          */
/* Mod   yy/mm/dd   Coder           Comment                                 */
/*-----+----------+-------------+-------------------------------------------*/
/* %00 | 2006/12/26 | Toll-Irie         | First Edition.                    */
/*==========================================================================*/

EXEC SQL BEGIN DECLARE SECTION;

    varchar      TSTF_target_file_name[32+1];       /* 対象ファイル名 */
    short       TSTFi_target_file_name;
    varchar      TSTF_file_name_for_indication[32+1];       /* 表示用ファイル名 */
    short       TSTFi_file_name_for_indication;
    varchar      TSTF_proviso_name[48+1];       /* 条件名 */
    short       TSTFi_proviso_name;
    varchar      TSTF_parent_target_file_name[32+1];        /* 親対象ファイル名 */
    short       TSTFi_parent_target_file_name;
    varchar      TSTF_tm_file_name[32+1];       /* TMファイル名 */
    short       TSTFi_tm_file_name;
    varchar      TSTF_creation_date[16+1];      /* 作成日付 */
    short       TSTFi_creation_date;
    char         TSTF_data_division[1+1];       /* データ区分 */
    short       TSTFi_data_division;
    varchar      TSTF_memo1[34+1];      /* メモ1 */
    short       TSTFi_memo1;
    varchar      TSTF_memo2[34+1];      /* メモ2 */
    short       TSTFi_memo2;
    varchar      TSTF_memo3[34+1];      /* メモ3 */
    short       TSTFi_memo3;
    varchar      TSTF_memo4[34+1];      /* メモ4 */
    short       TSTFi_memo4;
    char         TSTF_campaign_flag[1+1];       /* キャンペーンフラグ */
    short       TSTFi_campaign_flag;
    int      TSTF_record_count;     /* レコード数 */
    short       TSTFi_record_count;
    int      TSTF_target_household_count;       /* 対象世帯数 */
    short       TSTFi_target_household_count;
    char         TSTF_table_division[1+1];      /* テーブル区分 */
    short       TSTFi_table_division;
    char         TSTF_search_division[1+1];     /* 検索区分 */
    short       TSTFi_search_division;
    char         TSTF_maturity_flag[1+1];       /* 満期フラグ */
    short       TSTFi_maturity_flag;
    char         TSTF_external_flag[1+1];       /* 外部フラグ */
    short       TSTFi_external_flag;
    char         TSTF_base_proviso_setting[1+1];        /* 基本条件設定 */
    short       TSTFi_base_proviso_setting;
    varchar      TSTF_maturity_start_date[16+1];        /* 満期開始日 */
    short       TSTFi_maturity_start_date;
    varchar      TSTF_maturity_end_date[16+1];      /* 満期終了日 */
    short       TSTFi_maturity_end_date;
    char         TSTF_former_file_division[1+1];        /* 元ファイル区分 */
    short       TSTFi_former_file_division;
    char         TSTF_extraction_division[1+1];     /* 抽出区分 */
    short       TSTFi_extraction_division;
    char         TSTF_center_id[4+1];       /* センタID */
    short       TSTFi_center_id;
    char         TSTF_delete_flag[1+1];     /* 削除フラグ */
    short       TSTFi_delete_flag;
    varchar      TSTF_registration_date[16+1];      /* 登録日 */
    short       TSTFi_registration_date;
    char         TSTF_registrant[8+1];      /* 登録者 */
    short       TSTFi_registrant;

EXEC SQL END DECLARE SECTION;

/*-- END OF FILE --*/
