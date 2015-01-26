-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK・R コンタクトセンター
--
--  TABLE    : TF_個別明細固定性預金B
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | 15/01/22 | 土居 康一郎 | あおぞら銀行 1.0次 First Eddition
-- ============================================================================

OPTIONS (direct=true,errors=1000)
LOAD DATA
TRUNCATE
INTO TABLE TF_個別明細固定性預金B
(
    店番                POSITION (   1:3   )    CHAR
    ,CIFNO              POSITION (   4:13  )    CHAR
    ,世帯番号           POSITION (  14:24  )    CHAR
    ,個人企業番号       POSITION (  25:35  )    CHAR
    ,科目ID             POSITION (  36:41  )    CHAR
    ,口座番号           POSITION (  42:49  )    CHAR
    ,枝番号             POSITION (  50:56  )    CHAR
    ,口座残高           POSITION (  57:72  )    DECIMAL EXTERNAL
    ,取扱店部課         POSITION (  73:79  )    CHAR
    ,口座開設年月日     POSITION (  80:87  )    CHAR
    ,通証区分ID         POSITION (  88:89  )    CHAR
    ,税区分ID           POSITION (  90:91  )    CHAR
    ,金額               POSITION (  92:107 )    DECIMAL EXTERNAL
    ,預入日             POSITION ( 108:115 )    CHAR
    ,満期日             POSITION ( 116:123 )    CHAR
    ,預入期間           POSITION ( 124:128 )    CHAR
    ,利率               POSITION ( 129:140 )    DECIMAL EXTERNAL
    ,商品ID             POSITION ( 141:150 )    CHAR
    ,委任ID             POSITION ( 151:152 )    CHAR
    ,満期予約サイン     POSITION ( 153:153 )    CHAR
    ,最近取引日         POSITION ( 154:161 )    CHAR
    ,データ基準日       POSITION ( 162:169 )    CHAR
    ,仕組預金           POSITION ( 170:170 )    CHAR
    )