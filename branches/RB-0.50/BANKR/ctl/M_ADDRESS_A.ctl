-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.                   
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD                               
-- ============================================================================
--                                                                             
--  SYSTEM   : BANK・R コンタクトセンター                                      
--                                                                             
--  TABLE    : TF_住所A                                                        
--                                                                             
--  Mod   yy/mm/dd   Coder    Comment                                          
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition                              
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_住所A
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (住所コード                   CHAR       "NVL(RTRIM(:住所コード,' '),' ')"                                
    ,郵便番号                     CHAR       "NVL(RTRIM(:郵便番号,' '),' ')"  
    ,住所1カナ                    CHAR       "NVL(RTRIM(:住所1カナ,' '),' ')"                                
    ,住所2カナ                    CHAR       "NVL(RTRIM(:住所2カナ,' '),' ')"                               
    ,住所1                        CHAR       "NVL(RTRIM(:住所1,' '),' ')"                                
    ,住所2                        CHAR       "NVL(RTRIM(:住所2,' '),' ')"                                                             
    )
