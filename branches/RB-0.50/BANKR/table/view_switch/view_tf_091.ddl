--/*==========================================================================*/
--/* Copyright�@Information Services International-Dentsu, Ltd.               */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK�ER�|CC                                                   */
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

COMMENT ON COLUMN TF_�Z��.�Z���R�[�h IS '';
COMMENT ON COLUMN TF_�Z��.�X�֔ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_�Z��.�Z��1 IS '';
COMMENT ON COLUMN TF_�Z��.�Z��2 IS '';
COMMENT ON COLUMN TF_�Z��.�Z��1�J�i IS '';
COMMENT ON COLUMN TF_�Z��.�Z��2�J�i IS '';
EXIT;
