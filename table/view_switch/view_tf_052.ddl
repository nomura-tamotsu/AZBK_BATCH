--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_�ʖ��׊O�ݗa��                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
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
 FROM TF_�ʖ��׊O�ݗa��B
;
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.CIFNO IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.���єԍ� IS '�L�������V���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�l��Ɣԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�Ȗ�ID IS 'TM_�Ȗ�.�Ȗ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�����ԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�������ԍ� IS '5���Œ�';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�}�ԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�ʉ�ID IS 'TM_�ʉ�.�ʉ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.���ʉ݌��ݎc�� IS '�O�ݒP�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�v���A���X IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�o�^�N���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�ʏ؋敪ID IS 'TM_�ʏ؋敪.�ʏؕ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�ŋ敪ID IS 'TM_�ŋ敪.�ŋ敪ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�ŋߎ���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�ϔCID IS 'TM_�ϔC�R�[�h.�ϔCID���Q��';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�a���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.������ IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�X�L�[���ԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�������������� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�K�p���� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�D���� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.���{���z IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�~���Z���[�g IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�����~���Z���z IS '���{���z�~�~���Z���[�g';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�������� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.���Z�z IS '�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�T�Z���v IS '-ZZZZZZZZZZZZZZ9.00�i�����~���Z���z�[�T�Z���v�j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��B.�f�[�^��� IS '����YYYYMMDD';
EXIT;
