--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_商品                                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_商品
    (商品ID
    ,商品名
    ,商品略称
    )
 AS SELECT 
    TF_商品A.商品ID
    ,TF_商品A.商品名
    ,TF_商品A.商品略称
 FROM TF_商品A
;
COMMENT ON COLUMN TF_商品.商品ID IS '';
COMMENT ON COLUMN TF_商品.商品名 IS '';
COMMENT ON COLUMN TF_商品.商品略称 IS '';
EXIT;
