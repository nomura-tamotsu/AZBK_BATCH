--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TMB_�S��                                                      */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TMB_�S��
    (��s�ԍ�
    ,��s������
    ,��s���J�i
    ,�Ƒ�ID
    ,��s�K�p�J�n�N����
    ,��s�K�p�I���N����
    ,�X��
    ,�X������
    ,�X���J�i
    ,�x�X�K�p�J�n�N����
    ,�x�X�K�p�I���N����
    ,�o�^��
    ,�o�^��
    )
 AS SELECT 
    TMB_��sA.��s�ԍ�
    ,TMB_��sA.��s������
    ,TMB_��sA.��s���J�i
    ,TMB_��sA.�Ƒ�ID
    ,TMB_��sA.�K�p�J�n�N����
    ,TMB_��sA.�K�p�I���N����
    ,TMB_�x�XA.�X��
    ,TMB_�x�XA.�X������
    ,TMB_�x�XA.�X���J�i
    ,TMB_�x�XA.�K�p�J�n�N����
    ,TMB_�x�XA.�K�p�I���N����
    ,TMB_�x�XA.�o�^��
    ,TMB_�x�XA.�o�^��
 FROM TMB_��sA,TMB_�x�XA
 WHERE TMB_��sA.��s�ԍ�=TMB_�x�XA.��s�ԍ�;

COMMENT ON COLUMN TMB_�S��.��s�ԍ� IS 'TMB_�Ƒ�.�ƑԃR�[�h���Q�ƁB';
COMMENT ON COLUMN TMB_�S��.��s������ IS '';
COMMENT ON COLUMN TMB_�S��.��s���J�i IS '';
COMMENT ON COLUMN TMB_�S��.�Ƒ�ID IS 'TMB_��s�Ƒ�.�Ƒ�ID���Q�ƁB';
COMMENT ON COLUMN TMB_�S��.��s�K�p�J�n�N���� IS '';
COMMENT ON COLUMN TMB_�S��.��s�K�p�I���N���� IS '';
COMMENT ON COLUMN TMB_�S��.�X�� IS '';
COMMENT ON COLUMN TMB_�S��.�X������ IS '';
COMMENT ON COLUMN TMB_�S��.�X���J�i IS '';
COMMENT ON COLUMN TMB_�S��.�x�X�K�p�J�n�N���� IS '';
COMMENT ON COLUMN TMB_�S��.�x�X�K�p�I���N���� IS '';
COMMENT ON COLUMN TMB_�S��.�o�^�� IS '';
COMMENT ON COLUMN TMB_�S��.�o�^�� IS '';
EXIT;
