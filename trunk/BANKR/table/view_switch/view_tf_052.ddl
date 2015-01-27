--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK�ER �R���^�N�g�Z���^�[                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_�ʖ��׊O�ݗa��B                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/* %01 | 15/01/26 | �y�� �N��Y | 1.0���Ή�                                 */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_�ʖ��׊O�ݗa��
    (�X��
    ,CIFNO
    ,���єԍ�
    ,�l��Ɣԍ�
    ,�Ȗ�ID
    ,�����ԍ�
    ,�������ԍ�
    ,�}�ԍ�
    ,�ʉ�ID
    ,���ʉ݌��ݎc��
    ,�v���A���X
    ,�o�^�N����
    ,�ʏ؋敪ID
    ,�ŋ敪ID
    ,�ŋߎ����
    ,�ϔCID
    ,�a����
    ,������
    ,�X�L�[���ԍ�
    ,��������������
    ,�K�p����
    ,�D����
    ,���{���z
    ,�~���Z���[�g
    ,�����~���Z���z
    ,��������
    ,���Z�z
    ,�T�Z���v
    ,�f�[�^���
    ,�O�׎����ԍ�
    )
 AS SELECT
    TF_�ʖ��׊O�ݗa��B.�X��
    ,TF_�ʖ��׊O�ݗa��B.CIFNO
    ,TF_�ʖ��׊O�ݗa��B.���єԍ�
    ,TF_�ʖ��׊O�ݗa��B.�l��Ɣԍ�
    ,TF_�ʖ��׊O�ݗa��B.�Ȗ�ID
    ,TF_�ʖ��׊O�ݗa��B.�����ԍ�
    ,TF_�ʖ��׊O�ݗa��B.�������ԍ�
    ,TF_�ʖ��׊O�ݗa��B.�}�ԍ�
    ,TF_�ʖ��׊O�ݗa��B.�ʉ�ID
    ,TF_�ʖ��׊O�ݗa��B.���ʉ݌��ݎc��
    ,TF_�ʖ��׊O�ݗa��B.�v���A���X
    ,TF_�ʖ��׊O�ݗa��B.�o�^�N����
    ,TF_�ʖ��׊O�ݗa��B.�ʏ؋敪ID
    ,TF_�ʖ��׊O�ݗa��B.�ŋ敪ID
    ,TF_�ʖ��׊O�ݗa��B.�ŋߎ����
    ,TF_�ʖ��׊O�ݗa��B.�ϔCID
    ,TF_�ʖ��׊O�ݗa��B.�a����
    ,TF_�ʖ��׊O�ݗa��B.������
    ,TF_�ʖ��׊O�ݗa��B.�X�L�[���ԍ�
    ,TF_�ʖ��׊O�ݗa��B.��������������
    ,TF_�ʖ��׊O�ݗa��B.�K�p����
    ,TF_�ʖ��׊O�ݗa��B.�D����
    ,TF_�ʖ��׊O�ݗa��B.���{���z
    ,TF_�ʖ��׊O�ݗa��B.�~���Z���[�g
    ,TF_�ʖ��׊O�ݗa��B.�����~���Z���z
    ,TF_�ʖ��׊O�ݗa��B.��������
    ,TF_�ʖ��׊O�ݗa��B.���Z�z
    ,TF_�ʖ��׊O�ݗa��B.�T�Z���v
    ,TF_�ʖ��׊O�ݗa��B.�f�[�^���
    ,TF_�ʖ��׊O�ݗa��B.�O�׎����ԍ�
 FROM TF_�ʖ��׊O�ݗa��B
;
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.CIFNO IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.���єԍ� IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�l��Ɣԍ� IS '�l��Ɣԍ��F"99999999999"�Œ�@�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�Ȗ�ID IS '3���Œ�i0�p�f�B���O�j�A�Ɩ����ʔԍ��i2���j�{���i�敪�ԍ��i1���j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�����ԍ� IS '�V���Œ�';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�������ԍ� IS '�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�}�ԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�ʉ�ID IS 'TM_�ʉ�.�ʉ�ID���Q�ƁB TM_�ʉ�.�ʉݗ���=TMB_�ʉ�.�ʉ�ID�ƂȂ�';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.���ʉ݌��ݎc�� IS '�O�ݒP�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�v���A���X IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�o�^�N���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�ʏ؋敪ID IS 'TM_�ʏ؋敪.�ʏؕ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�ŋ敪ID IS '�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�ŋߎ���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�ϔCID IS 'TM_�ϔC�R�[�h.�ϔCID���Q��';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�a���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.������ IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�X�L�[���ԍ� IS 'TF_���i.���iID���Q�ƁB6���Œ�i0�p�f�B���O�j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�������������� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�K�p���� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�D���� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.���{���z IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�~���Z���[�g IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�����~���Z���z IS '���{���z�~�~���Z���[�g';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�������� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.���Z�z IS '�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�T�Z���v IS '-ZZZZZZZZZZZZZZ9.00�i�����~���Z���z�[�T�Z���v�j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�f�[�^��� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��.�O�׎����ԍ� IS '8���Œ�i0�p�f�B���O�j�B';
EXIT;
