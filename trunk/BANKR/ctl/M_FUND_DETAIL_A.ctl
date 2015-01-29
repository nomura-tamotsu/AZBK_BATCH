-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[
--
--  TABLE    : TF_�ʖ��ד��M��������A
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition
--  %01 | 15/01/26 | �y�� �N��Y | �����ԍ����c�a�ɍ��킹��8���ŃJ�b�g����B
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_�ʖ��ד��M��������A
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    (�X��                         CHAR       "NVL(RTRIM(:�X��,' '),' ')"
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"
    ,���єԍ�                     CHAR       "NVL(RTRIM(:���єԍ�,' '),' ')"
    ,�l��Ɣԍ�                 CHAR       "NVL(RTRIM(:�l��Ɣԍ�,' '),' ')"
    ,�����ԍ�                     CHAR       "NVL(SUBSTRB(RTRIM(:�����ԍ�,' '),1,8),' ')"
    ,���iID                       CHAR       "RTRIM(:���iID,' ')"
    ,�����R�[�h                   CHAR       "NVL(RTRIM(:�����R�[�h,' '),' ')"
    ,������                       CHAR       "RTRIM(:������,' ')"
    ,����                         CHAR       "NVL(RTRIM(:����,' '),' ')"
    ,�����Y                       CHAR       "NVL(RTRIM(:�����Y,' '),' ')"
    ,�ʌ��{                     CHAR       "NVL(RTRIM(:�ʌ��{,' '),' ')"
    ,�擾���z                     CHAR       "NVL(RTRIM(:�擾���z,' '),' ')"
    ,�W�����z                     CHAR       "NVL(RTRIM(:�W�����z,' '),' ')"
    ,��񉿊z                     CHAR       "NVL(RTRIM(:��񉿊z,' '),' ')"
    ,���������                   CHAR       "RTRIM(:���������,' ')"
    ,�ŋߎ����                   CHAR       "RTRIM(:�ŋߎ����,' ')"
    ,�戵�X���v                   CHAR       "NVL(RTRIM(:�戵�X���v,' '),' ')"
    ,�a��敪                     CHAR       "NVL(RTRIM(:�a��敪,' '),' ')"
    ,�f�[�^���                 CHAR       "NVL(RTRIM(:�f�[�^���,' '),' ')"
    )
