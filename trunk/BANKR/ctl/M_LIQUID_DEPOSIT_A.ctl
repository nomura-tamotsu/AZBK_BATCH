-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[
--
--  TABLE    : TF_�ʖ��ח������a��A
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | 15/01/14 | �y�� �N��Y | ���������s 1.0�� First Eddition
-- ============================================================================

OPTIONS (direct=true,errors=1000)
LOAD DATA
TRUNCATE
INTO TABLE TF_�ʖ��ח������a��A
(
    �X��                POSITION (   1:3   )    CHAR
    ,CIFNO              POSITION (   4:13  )    CHAR
    ,���єԍ�           POSITION (  14:24  )    CHAR
    ,�l��Ɣԍ�       POSITION (  25:35  )    CHAR
    ,�Ȗ�ID             POSITION (  36:41  )    CHAR
    ,�����ԍ�           POSITION (  42:49  )    CHAR
    ,�}�ԍ�             POSITION (  50:54  )    CHAR
    ,�����c��           POSITION (  55:70  )    DECIMAL EXTERNAL
    ,�戵�X����         POSITION (  71:77  )    CHAR
    ,�����J�ݔN����     POSITION (  78:85  )    CHAR
    ,�ʏ؋敪ID         POSITION (  86:87  )    CHAR
    ,�ŋ敪ID           POSITION (  88:89  )    CHAR
    ,�ŏI�����         POSITION (  90:97  )    CHAR
    ,�ŋߎ�����T�C��   POSITION (  98:98  )    CHAR
    ,���z               POSITION (  99:114 )    CHAR
    ,�}���D���x�z       POSITION ( 115:130 )    DECIMAL EXTERNAL
    ,�f�[�^���       POSITION ( 131:138 )    CHAR
    )
