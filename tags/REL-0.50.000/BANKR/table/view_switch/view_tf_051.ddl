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
    TF_�ʖ��׊O�ݗa��A.�X��
    ,TF_�ʖ��׊O�ݗa��A.CIFNO
    ,TF_�ʖ��׊O�ݗa��A.���єԍ�
    ,TF_�ʖ��׊O�ݗa��A.�l��Ɣԍ�
    ,TF_�ʖ��׊O�ݗa��A.�Ȗ�ID
    ,TF_�ʖ��׊O�ݗa��A.�����ԍ�
    ,TF_�ʖ��׊O�ݗa��A.�������ԍ�
    ,TF_�ʖ��׊O�ݗa��A.�}�ԍ�
    ,TF_�ʖ��׊O�ݗa��A.�ʉ�ID
    ,TF_�ʖ��׊O�ݗa��A.���ʉ݌��ݎc��
    ,TF_�ʖ��׊O�ݗa��A.�v���A���X
    ,TF_�ʖ��׊O�ݗa��A.�o�^�N����
    ,TF_�ʖ��׊O�ݗa��A.�ʏ؋敪ID
    ,TF_�ʖ��׊O�ݗa��A.�ŋ敪ID
    ,TF_�ʖ��׊O�ݗa��A.�ŋߎ����
    ,TF_�ʖ��׊O�ݗa��A.�ϔCID
    ,TF_�ʖ��׊O�ݗa��A.�a����
    ,TF_�ʖ��׊O�ݗa��A.������
    ,TF_�ʖ��׊O�ݗa��A.�X�L�[���ԍ�
    ,TF_�ʖ��׊O�ݗa��A.��������������
    ,TF_�ʖ��׊O�ݗa��A.�K�p����
    ,TF_�ʖ��׊O�ݗa��A.�D����
    ,TF_�ʖ��׊O�ݗa��A.���{���z
    ,TF_�ʖ��׊O�ݗa��A.�~���Z���[�g
    ,TF_�ʖ��׊O�ݗa��A.�����~���Z���z
    ,TF_�ʖ��׊O�ݗa��A.��������
    ,TF_�ʖ��׊O�ݗa��A.���Z�z
    ,TF_�ʖ��׊O�ݗa��A.�T�Z���v
    ,TF_�ʖ��׊O�ݗa��A.�f�[�^���
 FROM TF_�ʖ��׊O�ݗa��A
;
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.CIFNO IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.���єԍ� IS '�L�������V���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�l��Ɣԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�Ȗ�ID IS 'TM_�Ȗ�.�Ȗ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�����ԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�������ԍ� IS '5���Œ�';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�}�ԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�ʉ�ID IS 'TM_�ʉ�.�ʉ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.���ʉ݌��ݎc�� IS '�O�ݒP�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�v���A���X IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�o�^�N���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�ʏ؋敪ID IS 'TM_�ʏ؋敪.�ʏؕ�ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�ŋ敪ID IS 'TM_�ŋ敪.�ŋ敪ID���Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�ŋߎ���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�ϔCID IS 'TM_�ϔC�R�[�h.�ϔCID���Q��';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�a���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.������ IS '����YYYYMMDD';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�X�L�[���ԍ� IS '';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�������������� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�K�p���� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�D���� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.���{���z IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�~���Z���[�g IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�����~���Z���z IS '���{���z�~�~���Z���[�g';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�������� IS '9999.9999999';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.���Z�z IS '�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�T�Z���v IS '-ZZZZZZZZZZZZZZ9.00�i�����~���Z���z�[�T�Z���v�j';
COMMENT ON COLUMN TF_�ʖ��׊O�ݗa��A.�f�[�^��� IS '����YYYYMMDD';
EXIT;
