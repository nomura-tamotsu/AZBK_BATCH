-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[
--
--  TABLE    : TF_�ʖ��׊O�ݗa��A
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+------------+-------------+---------------------------------------------
--  %00 | YYYY/MM/DD | ISID        | First Eddition
--  %01 | 2015/01/23 | �y�� �N��Y | 1.0���Ή�
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_�ʖ��׊O�ݗa��A
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
    (�X��                         CHAR       "NVL(RTRIM(:�X��,' '),' ')"
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"
    ,�O�׎����ԍ�               CHAR       "NVL(RTRIM(:�O�׎����ԍ�,' '),' ')"
    ,���єԍ�                     CHAR       "NVL(RTRIM(:���єԍ�,' '),' ')"
    ,�l��Ɣԍ�                 CHAR       "NVL(RTRIM(:�l��Ɣԍ�,' '),' ')"
    ,�Ȗ�ID                       CHAR       "NVL(RTRIM(:�Ȗ�ID,' '),' ')"
    ,�����ԍ�                     CHAR       "NVL(RTRIM(:�����ԍ�,' '),' ')"
    ,�}�ԍ�                       CHAR       "NVL(RTRIM(:�}�ԍ�,' '),' ')"
    ,�ʉ�ID                       CHAR       "NVL(RTRIM(:�ʉ�ID,' '),' ')"
    ,���ʉ݌��ݎc��               CHAR       "NVL(RTRIM(:���ʉ݌��ݎc��,' '),' ')"
    ,�v���A���X                   CHAR       "RTRIM(:�v���A���X,' ')"
    ,�o�^�N����                   CHAR       "RTRIM(:�o�^�N����,' ')"
    ,�ʏ؋敪ID                   CHAR       "RTRIM(:�ʏ؋敪ID,' ')"
    ,�ŋ敪ID                     CHAR       "RTRIM(:�ŋ敪ID,' ')"
    ,�ŋߎ����                   CHAR       "NVL(RTRIM(:�ŋߎ����,' '),' ')"
    ,�ϔCID                       CHAR       "NVL(RTRIM(:�ϔCID,' '),' ')"
    ,�a����                       CHAR       "RTRIM(:�a����,' ')"
    ,������                       CHAR       "RTRIM(:������,' ')"
    ,�X�L�[���ԍ�                 CHAR       "RTRIM(:�X�L�[���ԍ�,' ')"
    ,��������������               CHAR       "NVL(RTRIM(:��������������,' '),' ')"
    ,�K�p����                     CHAR       "NVL(RTRIM(:�K�p����,' '),' ')"
    ,�D����                       CHAR       "NVL(RTRIM(:�D����,' '),' ')"
    ,���{���z                     CHAR       "NVL(RTRIM(:���{���z,' '),' ')"
    ,�~���Z���[�g                 CHAR       "NVL(RTRIM(:�~���Z���[�g,' '),' ')"
    ,�����~���Z���z               CHAR       "NVL(RTRIM(:�����~���Z���z,' '),' ')"
    ,��������                     CHAR       "NVL(RTRIM(:��������,' '),' ')"
    ,���Z�z                       CHAR       "NVL(RTRIM(:���Z�z,' '),' ')"
    ,�T�Z���v                     CHAR       "NVL(RTRIM(:�T�Z���v,' '),' ')"
    ,�f�[�^���                 CHAR       "NVL(RTRIM(:�f�[�^���,' '),' ')"
    )
