-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.                   
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD                               
-- ============================================================================
--                                                                             
--  SYSTEM   : BANK・R コンタクトセンター                                      
--                                                                             
--  TABLE    : TF_商品B                                                        
--                                                                             
--  Mod   yy/mm/dd   Coder    Comment                                          
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition                              
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_商品B
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (DUMMP     FILLER             CHAR
    ,商品ID                       CHAR       "NVL(RTRIM(:商品ID,' '),' ')"                                
    ,商品名                       CHAR       "NVL(RTRIM(:商品名,' '),'　')"                                
    ,商品略称                     CHAR       "NVL(RTRIM(:商品略称,' '),'　')"                                
    )
