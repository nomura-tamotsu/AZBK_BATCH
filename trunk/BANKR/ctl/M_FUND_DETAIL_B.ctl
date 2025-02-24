-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANKER R^NgZ^[
--
--  TABLE    : TF_ΒΚΎΧMϋΐΎΧB
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition
--  %01 | 15/01/26 | y NκY | ϋΐΤπcaΙνΉΔ8ΕJbg·ιB
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_ΒΚΎΧMϋΐΎΧB
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    (XΤ                         CHAR       "NVL(RTRIM(:XΤ,' '),' ')"
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"
    ,’ΡΤ                     CHAR       "NVL(RTRIM(:’ΡΤ,' '),' ')"
    ,ΒlιΖΤ                 CHAR       "NVL(RTRIM(:ΒlιΖΤ,' '),' ')"
    ,ϋΐΤ                     CHAR       "NVL(SUBSTRB(RTRIM(:ϋΐΤ,' '),1,8),' ')"
    ,€iID                       CHAR       "RTRIM(:€iID,' ')"
    ,ΑΏR[h                   CHAR       "NVL(RTRIM(:ΑΏR[h,' '),' ')"
    ,ΑΏΌ                       CHAR       "RTRIM(:ΑΏΌ,' ')"
    ,Κ                         CHAR       "NVL(RTRIM(:Κ,' '),' ')"
    ,Y                       CHAR       "NVL(RTRIM(:Y,' '),' ')"
    ,ΒΚ³{                     CHAR       "NVL(RTRIM(:ΒΚ³{,' '),' ')"
    ,ζΎΰz                     CHAR       "NVL(RTRIM(:ζΎΰz,' '),' ')"
    ,WΏz                     CHAR       "NVL(RTRIM(:WΏz,' '),' ')"
    ,πρΏz                     CHAR       "NVL(RTRIM(:πρΏz,' '),' ')"
    ,ζψϊ                   CHAR       "RTRIM(:ζψϊ,' ')"
    ,Είζψϊ                   CHAR       "RTRIM(:Είζψϊ,' ')"
    ,ζ΅Xv                   CHAR       "NVL(RTRIM(:ζ΅Xv,' '),' ')"
    ,aθζͺ                     CHAR       "NVL(RTRIM(:aθζͺ,' '),' ')"
    ,f[^ξϊ                 CHAR       "NVL(RTRIM(:f[^ξϊ,' '),' ')"
    )
