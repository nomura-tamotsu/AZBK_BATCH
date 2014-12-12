-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.                   
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD                               
-- ============================================================================
--                                                                             
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[                                      
--                                                                             
--  TABLE    : TF_�Z��A                                                        
--                                                                             
--  Mod   yy/mm/dd   Coder    Comment                                          
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition                              
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_�Z��A
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (�Z���R�[�h                   CHAR       "NVL(RTRIM(:�Z���R�[�h,' '),' ')"                                
    ,�X�֔ԍ�                     CHAR       "NVL(RTRIM(:�X�֔ԍ�,' '),' ')"  
    ,�Z��1�J�i                    CHAR       "NVL(RTRIM(:�Z��1�J�i,' '),' ')"                                
    ,�Z��2�J�i                    CHAR       "NVL(RTRIM(:�Z��2�J�i,' '),' ')"                               
    ,�Z��1                        CHAR       "NVL(RTRIM(:�Z��1,' '),' ')"                                
    ,�Z��2                        CHAR       "NVL(RTRIM(:�Z��2,' '),' ')"                                                             
    )
