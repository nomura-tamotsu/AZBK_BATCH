--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK�ER �R���^�N�g�Z���^�[                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_�ʖ��׌Œ萫�a��                                         */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/22 | �y�� �N��Y | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_�ʖ��׌Œ萫�a��
    (�X��
    ,CIFNO
    ,���єԍ�
    ,�l��Ɣԍ�
    ,�Ȗ�ID
    ,�����ԍ�
    ,�������ԍ�
    ,�}�ԍ�
    ,���iID
    ,�a����
    ,�ŋ敪ID
    ,���z
    ,����
    ,������
    ,�����c��
    ,�戵�X����
    ,�����J�ݔN����
    ,�ʏ؋敪ID
    ,�a������
    ,�ϔCID
    ,�����\��T�C��
    ,�ŋߎ����
    ,�f�[�^���
    ,�d�g�a��
    )
 AS SELECT
    TF_�ʖ��׌Œ萫�a��A.�X��
    ,TF_�ʖ��׌Œ萫�a��A.CIFNO
    ,TF_�ʖ��׌Œ萫�a��A.���єԍ�
    ,TF_�ʖ��׌Œ萫�a��A.�l��Ɣԍ�
    ,TF_�ʖ��׌Œ萫�a��A.�Ȗ�ID
    ,TF_�ʖ��׌Œ萫�a��A.�����ԍ�
    ,TF_�ʖ��׌Œ萫�a��A.�������ԍ�
    ,TF_�ʖ��׌Œ萫�a��A.�}�ԍ�
    ,TF_�ʖ��׌Œ萫�a��A.���iID
    ,TF_�ʖ��׌Œ萫�a��A.�a����
    ,TF_�ʖ��׌Œ萫�a��A.�ŋ敪ID
    ,TF_�ʖ��׌Œ萫�a��A.���z
    ,TF_�ʖ��׌Œ萫�a��A.����
    ,TF_�ʖ��׌Œ萫�a��A.������
    ,TF_�ʖ��׌Œ萫�a��A.�����c��
    ,TF_�ʖ��׌Œ萫�a��A.�戵�X����
    ,TF_�ʖ��׌Œ萫�a��A.�����J�ݔN����
    ,TF_�ʖ��׌Œ萫�a��A.�ʏ؋敪ID
    ,TF_�ʖ��׌Œ萫�a��A.�a������
    ,TF_�ʖ��׌Œ萫�a��A.�ϔCID
    ,TF_�ʖ��׌Œ萫�a��A.�����\��T�C��
    ,TF_�ʖ��׌Œ萫�a��A.�ŋߎ����
    ,TF_�ʖ��׌Œ萫�a��A.�f�[�^���
    ,TF_�ʖ��׌Œ萫�a��A.�d�g�a��
 FROM TF_�ʖ��׌Œ萫�a��A
;
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.CIFNO IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.���єԍ� IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�l��Ɣԍ� IS '�l��Ɣԍ��F"99999999999"�Œ�@�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�Ȗ�ID IS '4���Œ�i0�p�f�B���O�j�A���l�B�Ȗځi2���j�{�a����ށi2���j';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�����ԍ� IS '�V���Œ�';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�������ԍ� IS '�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�}�ԍ� IS '7���Œ�i0�p�f�B���O�j';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.���iID IS 'TF_���i.���iID���Q�ƁB6���Œ�i0�p�f�B���O�j';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�a���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�ŋ敪ID IS 'TM_�ŋ敪.�ŋ敪ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.���z IS '';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.���� IS '';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.������ IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�����c�� IS '�Œ�l0';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�戵�X���� IS '�X(3���Œ�)+��(2���Œ�)+��(2���Œ�)';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�����J�ݔN���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�ʏ؋敪ID IS 'TM_�ʏ؋敪.�ʏؕ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�a������ IS '���P�ʁi999.9�j';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�ϔCID IS 'TM_�ϔC�R�[�h.�ϔCID���Q��';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�����\��T�C�� IS '0�F�\��o�^�Ȃ��A1�F�\��o�^�ς݁B�f�[�^���Ȃ��ꍇ�́A1Bytes�̔��p�X�y�[�X�B';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�ŋߎ���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�f�[�^��� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׌Œ萫�a��.�d�g�a�� IS '1�F�d�g�a�� 0�F����ȊO';
EXIT;
