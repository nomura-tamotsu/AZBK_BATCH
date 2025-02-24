-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANKER R^NgZ^[
--
--  TABLE    : TF_ΒΚΎΧΕθ«aΰB
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | 15/01/22 | y NκY |  ¨Όηβs 1.0 First Eddition
-- ============================================================================

OPTIONS (direct=true,errors=1000)
LOAD DATA
TRUNCATE
INTO TABLE TF_ΒΚΎΧΕθ«aΰB
(
    XΤ                POSITION (   1:3   )    CHAR
    ,CIFNO              POSITION (   4:13  )    CHAR
    ,’ΡΤ           POSITION (  14:24  )    CHAR
    ,ΒlιΖΤ       POSITION (  25:35  )    CHAR
    ,ΘΪID             POSITION (  36:41  )    CHAR
    ,ϋΐΤ           POSITION (  42:49  )    CHAR
    ,}Τ             POSITION (  50:56  )    CHAR
    ,ϋΐc           POSITION (  57:72  )    DECIMAL EXTERNAL
    ,ζ΅XΫ         POSITION (  73:79  )    CHAR
    ,ϋΐJέNϊ     POSITION (  80:87  )    CHAR
    ,ΚΨζͺID         POSITION (  88:89  )    CHAR
    ,ΕζͺID           POSITION (  90:91  )    CHAR
    ,ΰz               POSITION (  92:107 )    DECIMAL EXTERNAL
    ,aόϊ             POSITION ( 108:115 )    CHAR
    ,ϊϊ             POSITION ( 116:123 )    CHAR
    ,aόϊΤ           POSITION ( 124:128 )    CHAR
    ,¦               POSITION ( 129:140 )    DECIMAL EXTERNAL
    ,€iID             POSITION ( 141:150 )    CHAR
    ,ΟCID             POSITION ( 151:152 )    CHAR
    ,ϊ\ρTC     POSITION ( 153:153 )    CHAR
    ,Είζψϊ         POSITION ( 154:161 )    CHAR
    ,f[^ξϊ       POSITION ( 162:169 )    CHAR
    ,dgaΰ           POSITION ( 170:170 )    CHAR
    )