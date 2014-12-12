--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TMB_全銀                                                      */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TMB_全銀
    (銀行番号
    ,銀行名漢字
    ,銀行名カナ
    ,業態ID
    ,銀行適用開始年月日
    ,銀行適用終了年月日
    ,店番
    ,店名漢字
    ,店名カナ
    ,支店適用開始年月日
    ,支店適用終了年月日
    ,登録日
    ,登録者
    )
 AS SELECT 
    TMB_銀行A.銀行番号
    ,TMB_銀行A.銀行名漢字
    ,TMB_銀行A.銀行名カナ
    ,TMB_銀行A.業態ID
    ,TMB_銀行A.適用開始年月日
    ,TMB_銀行A.適用終了年月日
    ,TMB_支店A.店番
    ,TMB_支店A.店名漢字
    ,TMB_支店A.店名カナ
    ,TMB_支店A.適用開始年月日
    ,TMB_支店A.適用終了年月日
    ,TMB_支店A.登録日
    ,TMB_支店A.登録者
 FROM TMB_銀行A,TMB_支店A
 WHERE TMB_銀行A.銀行番号=TMB_支店A.銀行番号;

COMMENT ON COLUMN TMB_全銀.銀行番号 IS 'TMB_業態.業態コードを参照。';
COMMENT ON COLUMN TMB_全銀.銀行名漢字 IS '';
COMMENT ON COLUMN TMB_全銀.銀行名カナ IS '';
COMMENT ON COLUMN TMB_全銀.業態ID IS 'TMB_銀行業態.業態IDを参照。';
COMMENT ON COLUMN TMB_全銀.銀行適用開始年月日 IS '';
COMMENT ON COLUMN TMB_全銀.銀行適用終了年月日 IS '';
COMMENT ON COLUMN TMB_全銀.店番 IS '';
COMMENT ON COLUMN TMB_全銀.店名漢字 IS '';
COMMENT ON COLUMN TMB_全銀.店名カナ IS '';
COMMENT ON COLUMN TMB_全銀.支店適用開始年月日 IS '';
COMMENT ON COLUMN TMB_全銀.支店適用終了年月日 IS '';
COMMENT ON COLUMN TMB_全銀.登録日 IS '';
COMMENT ON COLUMN TMB_全銀.登録者 IS '';
EXIT;
