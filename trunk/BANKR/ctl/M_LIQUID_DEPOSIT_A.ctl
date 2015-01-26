-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK・R コンタクトセンター
--
--  TABLE    : TF_個別明細流動性預金A
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | 15/01/14 | 土居 康一郎 | あおぞら銀行 1.0次 First Eddition
-- ============================================================================

OPTIONS (direct=true,errors=1000)
LOAD DATA
TRUNCATE
INTO TABLE TF_個別明細流動性預金A
(
    店番                POSITION (   1:3   )    CHAR
    ,CIFNO              POSITION (   4:13  )    CHAR
    ,世帯番号           POSITION (  14:24  )    CHAR
    ,個人企業番号       POSITION (  25:35  )    CHAR
    ,科目ID             POSITION (  36:41  )    CHAR
    ,口座番号           POSITION (  42:49  )    CHAR
    ,枝番号             POSITION (  50:54  )    CHAR
    ,口座残高           POSITION (  55:70  )    DECIMAL EXTERNAL
    ,取扱店部課         POSITION (  71:77  )    CHAR
    ,口座開設年月日     POSITION (  78:85  )    CHAR
    ,通証区分ID         POSITION (  86:87  )    CHAR
    ,税区分ID           POSITION (  88:89  )    CHAR
    ,最終取引日         POSITION (  90:97  )    CHAR
    ,最近取引締サイン   POSITION (  98:98  )    CHAR
    ,金額               POSITION (  99:114 )    CHAR
    ,マル優限度額       POSITION ( 115:130 )    DECIMAL EXTERNAL
    ,データ基準日       POSITION ( 131:138 )    CHAR
    )
