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
    TMB_��sB.��s�ԍ�
    ,TMB_��sB.��s������
    ,TMB_��sB.��s���J�i
    ,TMB_��sB.�Ƒ�ID
    ,TMB_��sB.�K�p�J�n�N����
    ,TMB_��sB.�K�p�I���N����
    ,TMB_�x�XB.�X��
    ,TMB_�x�XB.�X������
    ,TMB_�x�XB.�X���J�i
    ,TMB_�x�XB.�K�p�J�n�N����
    ,TMB_�x�XB.�K�p�I���N����
    ,TMB_�x�XB.�o�^��
    ,TMB_�x�XB.�o�^��
 FROM TMB_��sB,TMB_�x�XB
 WHERE TMB_��sB.��s�ԍ�=TMB_�x�XB.��s�ԍ�;

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
