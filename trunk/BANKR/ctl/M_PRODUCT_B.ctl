-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.                   
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD                               
-- ============================================================================
--                                                                             
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[                                      
--                                                                             
--  TABLE    : TF_���iB                                                        
--                                                                             
--  Mod   yy/mm/dd   Coder    Comment                                          
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition                              
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_���iB
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (DUMMP     FILLER             CHAR
    ,���iID                       CHAR       "NVL(RTRIM(:���iID,' '),' ')"                                
    ,���i��                       CHAR       "NVL(RTRIM(:���i��,' '),'�@')"                                
    ,���i����                     CHAR       "NVL(RTRIM(:���i����,' '),'�@')"                                
    )
