-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.                   
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD                               
-- ============================================================================
--                                                                             
--  SYSTEM   : BANKER R^NgZ^[                                      
--                                                                             
--  TABLE    : TF_ÂÊ¾×MûÀB                                            
--                                                                             
--  Mod   yy/mm/dd   Coder    Comment                                          
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition                              
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_ÂÊ¾×MûÀB
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (XÔ                         CHAR       "NVL(RTRIM(:XÔ,' '),' ')"                                
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"                                
    ,¢ÑÔ                     CHAR       "NVL(RTRIM(:¢ÑÔ,' '),' ')"                                
    ,ÂléÆÔ                 CHAR       "NVL(RTRIM(:ÂléÆÔ,' '),' ')"                                
    ,ûÀÔ                     CHAR       "NVL(RTRIM(:ûÀÔ,' '),' ')"                                
    ,SÒR[h                 CHAR       "NVL(RTRIM(:SÒR[h,' '),' ')"                                
    ,SÒ¼Ji                 CHAR       "RTRIM(:SÒ¼Ji,' ')"                                
    ,SÒ¼                     CHAR       "RTRIM(:SÒ¼,' ')"                                
    ,Î±æ                       CHAR       "RTRIM(:Î±æ,' ')"                                
    ,ðE¼                       CHAR       "RTRIM(:ðE¼,' ')"                                
    ,UâsID                   CHAR       "RTRIM(:UâsID,' ')"                                
    ,UxXID                   CHAR       "RTRIM(:UxXID,' ')"                                
    ,ÈÚID                       CHAR       "RTRIM(:ÈÚID,' ')"                                
    ,UûÀ                     CHAR       "RTRIM(:UûÀ,' ')"                                
    ,ÀÝz                     CHAR       "RTRIM(:ÀÝz,' ')"                                
    ,\gÀxz                 CHAR       "NVL(RTRIM(:\gÀxz,' '),' ')"                                
    ,pàz                     CHAR       "NVL(RTRIM(:pàz,' '),' ')"                                
    ,]Tg                       CHAR       "NVL(RTRIM(:]Tg,' '),' ')"                                
    ,ûÀJÝNú               CHAR       "NVL(RTRIM(:ûÀJÝNú,' '),' ')"                                
    ,c                         CHAR       "NVL(RTRIM(:c,' '),' ')"                                
    ,ûÀæª                     CHAR       "NVL(RTRIM(:ûÀæª,' '),' ')"                                
    ,æ·Döcàz               CHAR       "NVL(RTRIM(:æ·Döcàz,' '),' ')"                                
    ,KpI¹ú                   CHAR       "NVL(RTRIM(:KpI¹ú,' '),' ')"                                
    ,f[^îú                 CHAR       "NVL(RTRIM(:f[^îú,' '),' ')"                                
    )
