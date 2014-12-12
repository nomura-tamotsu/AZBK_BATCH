-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
-- 
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[
-- 
--  FILE     : �Z��
-- 
--  Mod   yy/mm/dd   Coder	  Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | 14/03/17 | ISID        | First Eddition For Aosora Bank.
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_�Z��B
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (�Z���R�[�h                   CHAR       "NVL(RTRIM(:�Z���R�[�h,' '),' ')"                                
    ,�X�֔ԍ�                     CHAR       "NVL(RTRIM(:�X�֔ԍ�,' '),' ')"  
    ,�Z��1�J�i                    CHAR       "NVL(RTRIM(:�Z��1�J�i,' '),' ')"                                
    ,�Z��2�J�i                    CHAR       "NVL(RTRIM(:�Z��2�J�i,' '),' ')"                               
    ,�Z��1                        CHAR       "NVL(RTRIM(:�Z��1,' '),' ')"                                
    ,�Z��2                        CHAR       "NVL(RTRIM(:�Z��2,' '),' ')"                                                             
    )
