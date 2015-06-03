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
    TF_商品B.商品ID
    ,TF_商品B.商品名
    ,TF_商品B.商品略称
 FROM TF_商品B
;
COMMENT ON COLUMN TF_商品.商品ID IS '商品ID6桁固定';
COMMENT ON COLUMN TF_商品.商品名 IS '一覧表示時使用';
COMMENT ON COLUMN TF_商品.商品略称 IS 'BANK・Rバッチ処理で全角スペース2Bytesを設定';
EXIT;
