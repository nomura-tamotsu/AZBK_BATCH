--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK�ER �R���^�N�g�Z���^�[                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_�ʖ��ח������a��                                         */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/20 | �y�� �N��Y | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_�ʖ��ח������a��
    (�X��
    ,CIFNO
    ,���єԍ�
    ,�l��Ɣԍ�
    ,�Ȗ�ID
    ,�����ԍ�
    ,�������ԍ�
    ,�}�ԍ�
    ,�ŏI�����
    ,�ŋ敪ID
    ,�����c��
    ,�戵�X����
    ,�����J�ݔN����
    ,�ʏ؋敪ID
    ,�ŋߎ�����T�C��
    ,���z
    ,�}���D���x�z
    ,�f�[�^���
    )
 AS SELECT
    TF_�ʖ��ח������a��B.�X��
    ,TF_�ʖ��ח������a��B.CIFNO
    ,TF_�ʖ��ח������a��B.���єԍ�
    ,TF_�ʖ��ח������a��B.�l��Ɣԍ�
    ,TF_�ʖ��ח������a��B.�Ȗ�ID
    ,TF_�ʖ��ח������a��B.�����ԍ�
    ,TF_�ʖ��ח������a��B.�������ԍ�
    ,TF_�ʖ��ח������a��B.�}�ԍ�
    ,TF_�ʖ��ח������a��B.�ŏI�����
    ,TF_�ʖ��ח������a��B.�ŋ敪ID
    ,TF_�ʖ��ח������a��B.�����c��
    ,TF_�ʖ��ח������a��B.�戵�X����
    ,TF_�ʖ��ח������a��B.�����J�ݔN����
    ,TF_�ʖ��ח������a��B.�ʏ؋敪ID
    ,TF_�ʖ��ח������a��B.�ŋߎ�����T�C��
    ,TF_�ʖ��ח������a��B.���z
    ,TF_�ʖ��ח������a��B.�}���D���x�z
    ,TF_�ʖ��ח������a��B.�f�[�^���
 FROM TF_�ʖ��ח������a��B
;
COMMENT ON COLUMN TF_�ʖ��ח������a��.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��ח������a��.CIFNO IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��ח������a��.���єԍ� IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�l��Ɣԍ� IS '�l��Ɣԍ��F"99999999999"�Œ�@�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�Ȗ�ID IS '4���Œ�i0�p�f�B���O�j�A���l�B�Ȗځi2���j�{�a����ށi2���j';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�����ԍ� IS '�V���Œ�';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�������ԍ� IS '�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�}�ԍ� IS '"00000"�Œ� �y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�ŏI����� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�ŋ敪ID IS 'TM_�ŋ敪.�ŋ敪ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�����c�� IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�戵�X���� IS '�X(3���Œ�)+��(2���Œ�)+��(2���Œ�)';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�����J�ݔN���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�ʏ؋敪ID IS 'TM_�ʏ؋敪.�ʏؕ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�ŋߎ�����T�C�� IS '';
COMMENT ON COLUMN TF_�ʖ��ח������a��.���z IS '�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�}���D���x�z IS '�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ח������a��.�f�[�^��� IS '����YYYYMMDD';
EXIT;
