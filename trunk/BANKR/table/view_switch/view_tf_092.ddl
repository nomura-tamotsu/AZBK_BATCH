--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_住所                                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_住所				
    (住所コード				
    ,郵便番号				
    ,住所1				
    ,住所2				
    ,住所1カナ				
    ,住所2カナ				
)				
AS SELECT				
     TF_住所B.住所コード				
     ,TF_住所B.郵便番号				
     ,TF_住所B.住所1				
     ,TF_住所B.住所2				
     ,TF_住所B.住所1カナ				
      ,TF_住所B.住所2カナ				
FROM TF_住所B
;
COMMENT ON COLUMN TF_住所.住所コード IS '';
COMMENT ON COLUMN TF_住所.郵便番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_住所.住所1 IS '';
COMMENT ON COLUMN TF_住所.住所2 IS '';
COMMENT ON COLUMN TF_住所.住所1カナ IS '';
COMMENT ON COLUMN TF_住所.住所2カナ IS '';

EXIT;
