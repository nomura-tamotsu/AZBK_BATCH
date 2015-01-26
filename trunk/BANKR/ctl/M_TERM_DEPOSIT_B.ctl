-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[
--
--  TABLE    : TF_�ʖ��׌Œ萫�a��B
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | 15/01/22 | �y�� �N��Y | ���������s 1.0�� First Eddition
-- ============================================================================

OPTIONS (direct=true,errors=1000)
LOAD DATA
TRUNCATE
INTO TABLE TF_�ʖ��׌Œ萫�a��B
(
    �X��                POSITION (   1:3   )    CHAR
    ,CIFNO              POSITION (   4:13  )    CHAR
    ,���єԍ�           POSITION (  14:24  )    CHAR
    ,�l��Ɣԍ�       POSITION (  25:35  )    CHAR
    ,�Ȗ�ID             POSITION (  36:41  )    CHAR
    ,�����ԍ�           POSITION (  42:49  )    CHAR
    ,�}�ԍ�             POSITION (  50:56  )    CHAR
    ,�����c��           POSITION (  57:72  )    DECIMAL EXTERNAL
    ,�戵�X����         POSITION (  73:79  )    CHAR
    ,�����J�ݔN����     POSITION (  80:87  )    CHAR
    ,�ʏ؋敪ID         POSITION (  88:89  )    CHAR
    ,�ŋ敪ID           POSITION (  90:91  )    CHAR
    ,���z               POSITION (  92:107 )    DECIMAL EXTERNAL
    ,�a����             POSITION ( 108:115 )    CHAR
    ,������             POSITION ( 116:123 )    CHAR
    ,�a������           POSITION ( 124:128 )    CHAR
    ,����               POSITION ( 129:140 )    DECIMAL EXTERNAL
    ,���iID             POSITION ( 141:150 )    CHAR
    ,�ϔCID             POSITION ( 151:152 )    CHAR
    ,�����\��T�C��     POSITION ( 153:153 )    CHAR
    ,�ŋߎ����         POSITION ( 154:161 )    CHAR
    ,�f�[�^���       POSITION ( 162:169 )    CHAR
    ,�d�g�a��           POSITION ( 170:170 )    CHAR
    )