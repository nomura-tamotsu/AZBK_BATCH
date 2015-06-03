--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_�ʖ��ד��M����                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_�ʖ��ד��M����
    (�X��
    ,CIFNO
    ,���єԍ�
    ,�l��Ɣԍ�
    ,�����ԍ�
    ,�S���҃R�[�h
    ,�S���Җ��J�i
    ,�S���Җ�
    ,�Ζ���
    ,��E��
    ,�U����sID
    ,�U���x�XID
    ,�Ȗ�ID
    ,�U������
    ,�����݉z
    ,�\���g���x�z
    ,���p���z
    ,�]�T�g
    ,�����J�ݔN����
    ,�c��
    ,�����敪
    ,�抷�D���c���z
    ,�K�p�I����
    ,�f�[�^���
    )
 AS SELECT 
    TF_�ʖ��ד��M����A.�X��
    ,TF_�ʖ��ד��M����A.CIFNO
    ,TF_�ʖ��ד��M����A.���єԍ�
    ,TF_�ʖ��ד��M����A.�l��Ɣԍ�
    ,TF_�ʖ��ד��M����A.�����ԍ�
    ,TF_�ʖ��ד��M����A.�S���҃R�[�h
    ,TF_�ʖ��ד��M����A.�S���Җ��J�i
    ,TF_�ʖ��ד��M����A.�S���Җ�
    ,TF_�ʖ��ד��M����A.�Ζ���
    ,TF_�ʖ��ד��M����A.��E��
    ,TF_�ʖ��ד��M����A.�U����sID
    ,TF_�ʖ��ד��M����A.�U���x�XID
    ,TF_�ʖ��ד��M����A.�Ȗ�ID
    ,TF_�ʖ��ד��M����A.�U������
    ,TF_�ʖ��ד��M����A.�����݉z
    ,TF_�ʖ��ד��M����A.�\���g���x�z
    ,TF_�ʖ��ד��M����A.���p���z
    ,TF_�ʖ��ד��M����A.�]�T�g
    ,TF_�ʖ��ד��M����A.�����J�ݔN����
    ,TF_�ʖ��ד��M����A.�c��
    ,TF_�ʖ��ד��M����A.�����敪
    ,TF_�ʖ��ד��M����A.�抷�D���c���z
    ,TF_�ʖ��ד��M����A.�K�p�I����
    ,TF_�ʖ��ד��M����A.�f�[�^���
 FROM TF_�ʖ��ד��M����A
;
COMMENT ON COLUMN TF_�ʖ��ד��M����.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��ד��M����.CIFNO IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��ד��M����.���єԍ� IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�l��Ɣԍ� IS '�l��Ɣԍ��F"99999999999"�Œ�@�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�����ԍ� IS '7���Œ�i0�p�f�B���O�j';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�S���҃R�[�h IS '�戵�S���҃R�[�h�B';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�S���Җ��J�i IS '�戵�S���Җ��J�i�B';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�S���Җ� IS '�戵�S���Җ������B';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�Ζ��� IS '�Ζ��於�́i�S�p�j';
COMMENT ON COLUMN TF_�ʖ��ד��M����.��E�� IS '�S�p';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�U����sID IS '�U����s�R�[�h�@4���Œ�';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�U���x�XID IS '�U���x�X�R�[�h�@3���Œ�';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�Ȗ�ID IS '1:���ʁA2:�����A4:���~�a���A9:���̑�';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�U������ IS '�U�������@7���Œ�';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�����݉z IS '�������� 999-9-9999999 (�X��3���Œ�i0�p�f�B���O�j + "-" + �Ȗ�1���Œ�iNo13�̉Ȗځj + "-" + �����ԍ�7���Œ�(0�p�f�B���O) + "-")';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�\���g���x�z IS '�}���D�\���g���x�z�B�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M����.���p���z IS '�}���D�̎�n���p���z+�ݓ����p���z�B�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�]�T�g IS '�}���D�́i��n���x�z+�ݓ����x�z)-(��n���p���z+�ݓ����p���z�j�B�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�����J�ݔN���� IS '';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�c�� IS '�捇�v���z ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�����敪 IS '0�F���o�^�i��ʌ����j�@1�F���򒥎��@2�F�m��\���@3�FNISA�{���o�^�@4�FNISA�{���򒥎��@5�FNISA�{�m��\��';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�抷�D���c���z IS '';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�K�p�I���� IS '';
COMMENT ON COLUMN TF_�ʖ��ד��M����.�f�[�^��� IS '';
EXIT;
