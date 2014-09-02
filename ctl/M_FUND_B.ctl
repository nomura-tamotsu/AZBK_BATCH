-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.                   
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD                               
-- ============================================================================
--                                                                             
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[                                      
--                                                                             
--  TABLE    : TF_�ʖ��ד��M����B                                            
--                                                                             
--  Mod   yy/mm/dd   Coder    Comment                                          
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition                              
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_�ʖ��ד��M����B
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (�X��                         CHAR       "NVL(RTRIM(:�X��,' '),' ')"                                
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"                                
    ,���єԍ�                     CHAR       "NVL(RTRIM(:���єԍ�,' '),' ')"                                
    ,�l��Ɣԍ�                 CHAR       "NVL(RTRIM(:�l��Ɣԍ�,' '),' ')"                                
    ,�����ԍ�                     CHAR       "NVL(RTRIM(:�����ԍ�,' '),' ')"                                
    ,�S���҃R�[�h                 CHAR       "NVL(RTRIM(:�S���҃R�[�h,' '),' ')"                                
    ,�S���Җ��J�i                 CHAR       "RTRIM(:�S���Җ��J�i,' ')"                                
    ,�S���Җ�                     CHAR       "RTRIM(:�S���Җ�,' ')"                                
    ,�Ζ���                       CHAR       "RTRIM(:�Ζ���,' ')"                                
    ,��E��                       CHAR       "RTRIM(:��E��,' ')"                                
    ,�U����sID                   CHAR       "RTRIM(:�U����sID,' ')"                                
    ,�U���x�XID                   CHAR       "RTRIM(:�U���x�XID,' ')"                                
    ,�Ȗ�ID                       CHAR       "RTRIM(:�Ȗ�ID,' ')"                                
    ,�U������                     CHAR       "RTRIM(:�U������,' ')"                                
    ,�����݉z                     CHAR       "RTRIM(:�����݉z,' ')"                                
    ,�\���g���x�z                 CHAR       "NVL(RTRIM(:�\���g���x�z,' '),' ')"                                
    ,���p���z                     CHAR       "NVL(RTRIM(:���p���z,' '),' ')"                                
    ,�]�T�g                       CHAR       "NVL(RTRIM(:�]�T�g,' '),' ')"                                
    ,�����J�ݔN����               CHAR       "NVL(RTRIM(:�����J�ݔN����,' '),' ')"                                
    ,�c��                         CHAR       "NVL(RTRIM(:�c��,' '),' ')"                                
    ,�����敪                     CHAR       "NVL(RTRIM(:�����敪,' '),' ')"                                
    ,�抷�D���c���z               CHAR       "NVL(RTRIM(:�抷�D���c���z,' '),' ')"                                
    ,�K�p�I����                   CHAR       "NVL(RTRIM(:�K�p�I����,' '),' ')"                                
    ,�f�[�^���                 CHAR       "NVL(RTRIM(:�f�[�^���,' '),' ')"                                
    )
