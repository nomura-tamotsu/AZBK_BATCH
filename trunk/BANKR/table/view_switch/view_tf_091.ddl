--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_�Z��                                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_�Z��
    (�Z���R�[�h
    ,�X�֔ԍ�
    ,�Z��1
    ,�Z��2
    ,�Z��1�J�i
    ,�Z��2�J�i
    )
 AS SELECT 
    TF_�Z��A.�Z���R�[�h
    ,TF_�Z��A.�X�֔ԍ�
    ,TF_�Z��A.�Z��1
    ,TF_�Z��A.�Z��2
    ,TF_�Z��A.�Z��1�J�i
    ,TF_�Z��A.�Z��2�J�i
 FROM TF_�Z��A
;
COMMENT ON COLUMN TF_�Z��.�Z���R�[�h IS '11���Œ�';
COMMENT ON COLUMN TF_�Z��.�X�֔ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_�Z��.�Z��1 IS '�S�p16����';
COMMENT ON COLUMN TF_�Z��.�Z��2 IS '�S�p30����';
COMMENT ON COLUMN TF_�Z��.�Z��1�J�i IS '���p�J�i32����';
COMMENT ON COLUMN TF_�Z��.�Z��2�J�i IS '���p�J�i60����';
EXIT;
