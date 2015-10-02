--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_�ʖ��ד��M��������                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_�ʖ��ד��M��������
    (�X��
    ,CIFNO
    ,���єԍ�
    ,�l��Ɣԍ�
    ,�����ԍ�
    ,���iID
    ,�����R�[�h
    ,������
    ,����
    ,�����Y
    ,�ʌ��{
    ,�擾���z
    ,��񉿊z
    ,�W�����z
    ,���������
    ,�ŋߎ����
    ,�戵�X���v
    ,�a��敪
    ,�f�[�^���
    )
 AS SELECT 
    TF_�ʖ��ד��M��������B.�X��
    ,TF_�ʖ��ד��M��������B.CIFNO
    ,TF_�ʖ��ד��M��������B.���єԍ�
    ,TF_�ʖ��ד��M��������B.�l��Ɣԍ�
    ,TF_�ʖ��ד��M��������B.�����ԍ�
    ,TF_�ʖ��ד��M��������B.���iID
    ,TF_�ʖ��ד��M��������B.�����R�[�h
    ,TF_�ʖ��ד��M��������B.������
    ,TF_�ʖ��ד��M��������B.����
    ,TF_�ʖ��ד��M��������B.�����Y
    ,TF_�ʖ��ד��M��������B.�ʌ��{
    ,TF_�ʖ��ד��M��������B.�擾���z
    ,TF_�ʖ��ד��M��������B.��񉿊z
    ,TF_�ʖ��ד��M��������B.�W�����z
    ,TF_�ʖ��ד��M��������B.���������
    ,TF_�ʖ��ד��M��������B.�ŋߎ����
    ,TF_�ʖ��ד��M��������B.�戵�X���v
    ,TF_�ʖ��ד��M��������B.�a��敪
    ,TF_�ʖ��ד��M��������B.�f�[�^���
 FROM TF_�ʖ��ד��M��������B
;
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.CIFNO IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.���єԍ� IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�l��Ɣԍ� IS '�l��Ɣԍ��F"99999999999"�Œ�@�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�����ԍ� IS '7���Œ�i0�p�f�B���O�j';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.���iID IS '�y���g�p�z';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�����R�[�h IS '�t�@���h�R�[�h8���Œ�';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.������ IS '������';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.���� IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�����Y IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�ʌ��{ IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�擾���z IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.��񉿊z IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�W�����z IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.��������� IS '';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�ŋߎ���� IS '';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�戵�X���v IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�a��敪 IS '0�F��ʗa��@1�F����a��@2�FNISA�a��';
COMMENT ON COLUMN TF_�ʖ��ד��M��������.�f�[�^��� IS '';
EXIT;
