-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANKER R^NgZ^[
--
--  TABLE    : TF_ÂÊ¾×OÝaàB
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+------------+-------------+---------------------------------------------
--  %00 | YYYY/MM/DD | ISID        | First Eddition
--  %01 | 2015/01/23 | y NêY | 1.0Î
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_ÂÊ¾×OÝaàB
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    (XÔ                         CHAR       "NVL(RTRIM(:XÔ,' '),' ')"
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"
    ,O×æøæÔ               CHAR       "NVL(RTRIM(:O×æøæÔ,' '),' ')"
    ,¢ÑÔ                     CHAR       "NVL(RTRIM(:¢ÑÔ,' '),' ')"
    ,ÂléÆÔ                 CHAR       "NVL(RTRIM(:ÂléÆÔ,' '),' ')"
    ,ÈÚID                       CHAR       "NVL(RTRIM(:ÈÚID,' '),' ')"
    ,ûÀÔ                     CHAR       "NVL(RTRIM(:ûÀÔ,' '),' ')"
    ,}Ô                       CHAR       "NVL(RTRIM(:}Ô,' '),' ')"
    ,ÊÝID                       CHAR       "NVL(RTRIM(:ÊÝID,' '),' ')"
    ,´ÊÝ»Ýc               CHAR       "NVL(RTRIM(:´ÊÝ»Ýc,' '),' ')"
    ,vA®X                   CHAR       "RTRIM(:vA®X,' ')"
    ,o^Nú                   CHAR       "RTRIM(:o^Nú,' ')"
    ,ÊØæªID                   CHAR       "RTRIM(:ÊØæªID,' ')"
    ,ÅæªID                     CHAR       "RTRIM(:ÅæªID,' ')"
    ,Åßæøú                   CHAR       "NVL(RTRIM(:Åßæøú,' '),' ')"
    ,ÏCID                       CHAR       "NVL(RTRIM(:ÏCID,' '),' ')"
    ,aüú                       CHAR       "RTRIM(:aüú,' ')"
    ,úú                       CHAR       "RTRIM(:úú,' ')"
    ,XL[Ô                 CHAR       "RTRIM(:XL[Ô,' ')"
    ,üàÀ¨ê               CHAR       "NVL(RTRIM(:üàÀ¨ê,' '),' ')"
    ,Kp¦                     CHAR       "NVL(RTRIM(:Kp¦,' '),' ')"
    ,Dö                       CHAR       "NVL(RTRIM(:Dö,' '),' ')"
    ,³{àz                     CHAR       "NVL(RTRIM(:³{àz,' '),' ')"
    ,~·Z[g                 CHAR       "NVL(RTRIM(:~·Z[g,' '),' ')"
    ,~·Zàz               CHAR       "NVL(RTRIM(:~·Zàz,' '),' ')"
    ,À¨ê                     CHAR       "NVL(RTRIM(:À¨ê,' '),' ')"
    ,·Zz                       CHAR       "NVL(RTRIM(:·Zz,' '),' ')"
    ,TZ¹v                     CHAR       "NVL(RTRIM(:TZ¹v,' '),' ')"
    ,f[^îú                 CHAR       "NVL(RTRIM(:f[^îú,' '),' ')"
    )
