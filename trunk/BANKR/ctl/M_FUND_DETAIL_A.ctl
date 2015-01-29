-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK・R コンタクトセンター
--
--  TABLE    : TF_個別明細投信口座明細A
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition
--  %01 | 15/01/26 | 土居 康一郎 | 口座番号をＤＢに合わせて8桁でカットする。
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_個別明細投信口座明細A
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    (店番                         CHAR       "NVL(RTRIM(:店番,' '),' ')"
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"
    ,世帯番号                     CHAR       "NVL(RTRIM(:世帯番号,' '),' ')"
    ,個人企業番号                 CHAR       "NVL(RTRIM(:個人企業番号,' '),' ')"
    ,口座番号                     CHAR       "NVL(SUBSTRB(RTRIM(:口座番号,' '),1,8),' ')"
    ,商品ID                       CHAR       "RTRIM(:商品ID,' ')"
    ,銘柄コード                   CHAR       "NVL(RTRIM(:銘柄コード,' '),' ')"
    ,銘柄名                       CHAR       "RTRIM(:銘柄名,' ')"
    ,数量                         CHAR       "NVL(RTRIM(:数量,' '),' ')"
    ,純資産                       CHAR       "NVL(RTRIM(:純資産,' '),' ')"
    ,個別元本                     CHAR       "NVL(RTRIM(:個別元本,' '),' ')"
    ,取得金額                     CHAR       "NVL(RTRIM(:取得金額,' '),' ')"
    ,標準価額                     CHAR       "NVL(RTRIM(:標準価額,' '),' ')"
    ,解約価額                     CHAR       "NVL(RTRIM(:解約価額,' '),' ')"
    ,当初取引日                   CHAR       "RTRIM(:当初取引日,' ')"
    ,最近取引日                   CHAR       "RTRIM(:最近取引日,' ')"
    ,取扱店合計                   CHAR       "NVL(RTRIM(:取扱店合計,' '),' ')"
    ,預り区分                     CHAR       "NVL(RTRIM(:預り区分,' '),' ')"
    ,データ基準日                 CHAR       "NVL(RTRIM(:データ基準日,' '),' ')"
    )
