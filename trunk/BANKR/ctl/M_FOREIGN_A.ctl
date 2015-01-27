-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK・R コンタクトセンター
--
--  TABLE    : TF_個別明細外貨預金A
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+------------+-------------+---------------------------------------------
--  %00 | YYYY/MM/DD | ISID        | First Eddition
--  %01 | 2015/01/23 | 土居 康一郎 | 1.0次対応
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_個別明細外貨預金A
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    (店番                         CHAR       "NVL(RTRIM(:店番,' '),' ')"
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"
    ,外為取引先番号               CHAR       "NVL(RTRIM(:外為取引先番号,' '),' ')"
    ,世帯番号                     CHAR       "NVL(RTRIM(:世帯番号,' '),' ')"
    ,個人企業番号                 CHAR       "NVL(RTRIM(:個人企業番号,' '),' ')"
    ,科目ID                       CHAR       "NVL(RTRIM(:科目ID,' '),' ')"
    ,口座番号                     CHAR       "NVL(RTRIM(:口座番号,' '),' ')"
    ,枝番号                       CHAR       "NVL(RTRIM(:枝番号,' '),' ')"
    ,通貨ID                       CHAR       "NVL(RTRIM(:通貨ID,' '),' ')"
    ,原通貨現在残高               CHAR       "NVL(RTRIM(:原通貨現在残高,' '),' ')"
    ,計数帰属店                   CHAR       "RTRIM(:計数帰属店,' ')"
    ,登録年月日                   CHAR       "RTRIM(:登録年月日,' ')"
    ,通証区分ID                   CHAR       "RTRIM(:通証区分ID,' ')"
    ,税区分ID                     CHAR       "RTRIM(:税区分ID,' ')"
    ,最近取引日                   CHAR       "NVL(RTRIM(:最近取引日,' '),' ')"
    ,委任ID                       CHAR       "NVL(RTRIM(:委任ID,' '),' ')"
    ,預入日                       CHAR       "RTRIM(:預入日,' ')"
    ,満期日                       CHAR       "RTRIM(:満期日,' ')"
    ,スキーム番号                 CHAR       "RTRIM(:スキーム番号,' ')"
    ,入金時実勢相場               CHAR       "NVL(RTRIM(:入金時実勢相場,' '),' ')"
    ,適用利率                     CHAR       "NVL(RTRIM(:適用利率,' '),' ')"
    ,優遇幅                       CHAR       "NVL(RTRIM(:優遇幅,' '),' ')"
    ,元本金額                     CHAR       "NVL(RTRIM(:元本金額,' '),' ')"
    ,円換算レート                 CHAR       "NVL(RTRIM(:円換算レート,' '),' ')"
    ,当時円換算金額               CHAR       "NVL(RTRIM(:当時円換算金額,' '),' ')"
    ,実勢相場                     CHAR       "NVL(RTRIM(:実勢相場,' '),' ')"
    ,換算額                       CHAR       "NVL(RTRIM(:換算額,' '),' ')"
    ,概算損益                     CHAR       "NVL(RTRIM(:概算損益,' '),' ')"
    ,データ基準日                 CHAR       "NVL(RTRIM(:データ基準日,' '),' ')"
    )
