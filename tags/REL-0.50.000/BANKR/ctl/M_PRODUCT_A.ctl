-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.                   
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD                               
-- ============================================================================
--                                                                             
--  SYSTEM   : BANKER R^NgZ^[                                      
--                                                                             
--  TABLE    : TF_€iA                                                        
--                                                                             
--  Mod   yy/mm/dd   Coder    Comment                                          
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition                              
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_€iA
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (DUMMP     FILLER             CHAR
    ,€iID                       CHAR       "NVL(RTRIM(:€iID,' '),' ')"                                
    ,€iΌ                       CHAR       "NVL(RTRIM(:€iΌ,' '),'@')"                                
    ,€iͺΜ                     CHAR       "NVL(RTRIM(:€iͺΜ,' '),'@')"                                
    )
