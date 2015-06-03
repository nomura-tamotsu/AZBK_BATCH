--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_���i                                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_���i
    (���iID
    ,���i��
    ,���i����
    )
 AS SELECT 
    TF_���iA.���iID
    ,TF_���iA.���i��
    ,TF_���iA.���i����
 FROM TF_���iA
;
COMMENT ON COLUMN TF_���i.���iID IS '���iID6���Œ�';
COMMENT ON COLUMN TF_���i.���i�� IS '�ꗗ�\�����g�p';
COMMENT ON COLUMN TF_���i.���i���� IS 'BANK�ER�o�b�`�����őS�p�X�y�[�X2Bytes��ݒ�';
EXIT;
