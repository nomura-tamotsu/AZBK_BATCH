--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_個別明細外貨預金                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_個別明細外貨預金
    (店番
    ,CIFNO
    ,世帯番号
    ,個人企業番号
    ,科目ID
    ,口座番号
    ,口座口番号
    ,枝番号
    ,通貨ID
    ,原通貨現在残高
    ,計数帰属店
    ,登録年月日
    ,通証区分ID
    ,税区分ID
    ,最近取引日
    ,委任ID
    ,預入日
    ,満期日
    ,スキーム番号
    ,入金時実勢相場
    ,適用利率
    ,優遇幅
    ,元本金額
    ,円換算レート
    ,当時円換算金額
    ,実勢相場
    ,換算額
    ,概算損益
    ,データ基準日
    )
 AS SELECT 
    TF_個別明細外貨預金A.店番
    ,TF_個別明細外貨預金A.CIFNO
    ,TF_個別明細外貨預金A.世帯番号
    ,TF_個別明細外貨預金A.個人企業番号
    ,TF_個別明細外貨預金A.科目ID
    ,TF_個別明細外貨預金A.口座番号
    ,TF_個別明細外貨預金A.口座口番号
    ,TF_個別明細外貨預金A.枝番号
    ,TF_個別明細外貨預金A.通貨ID
    ,TF_個別明細外貨預金A.原通貨現在残高
    ,TF_個別明細外貨預金A.計数帰属店
    ,TF_個別明細外貨預金A.登録年月日
    ,TF_個別明細外貨預金A.通証区分ID
    ,TF_個別明細外貨預金A.税区分ID
    ,TF_個別明細外貨預金A.最近取引日
    ,TF_個別明細外貨預金A.委任ID
    ,TF_個別明細外貨預金A.預入日
    ,TF_個別明細外貨預金A.満期日
    ,TF_個別明細外貨預金A.スキーム番号
    ,TF_個別明細外貨預金A.入金時実勢相場
    ,TF_個別明細外貨預金A.適用利率
    ,TF_個別明細外貨預金A.優遇幅
    ,TF_個別明細外貨預金A.元本金額
    ,TF_個別明細外貨預金A.円換算レート
    ,TF_個別明細外貨預金A.当時円換算金額
    ,TF_個別明細外貨預金A.実勢相場
    ,TF_個別明細外貨預金A.換算額
    ,TF_個別明細外貨預金A.概算損益
    ,TF_個別明細外貨預金A.データ基準日
 FROM TF_個別明細外貨預金A
;
COMMENT ON COLUMN TF_個別明細外貨預金A.店番 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_個別明細外貨預金A.CIFNO IS '';
COMMENT ON COLUMN TF_個別明細外貨預金A.世帯番号 IS '有効桁数７桁（固定長）';
COMMENT ON COLUMN TF_個別明細外貨預金A.個人企業番号 IS '';
COMMENT ON COLUMN TF_個別明細外貨預金A.科目ID IS 'TM_科目.科目IDを参照。';
COMMENT ON COLUMN TF_個別明細外貨預金A.口座番号 IS '';
COMMENT ON COLUMN TF_個別明細外貨預金A.口座口番号 IS '5桁固定';
COMMENT ON COLUMN TF_個別明細外貨預金A.枝番号 IS '';
COMMENT ON COLUMN TF_個別明細外貨預金A.通貨ID IS 'TM_通貨.通貨IDを参照。';
COMMENT ON COLUMN TF_個別明細外貨預金A.原通貨現在残高 IS '外貨単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細外貨預金A.計数帰属店 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_個別明細外貨預金A.登録年月日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金A.通証区分ID IS 'TM_通証区分.通証分IDを参照。';
COMMENT ON COLUMN TF_個別明細外貨預金A.税区分ID IS 'TM_税区分.税区分IDを参照。';
COMMENT ON COLUMN TF_個別明細外貨預金A.最近取引日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金A.委任ID IS 'TM_委任コード.委任IDを参照';
COMMENT ON COLUMN TF_個別明細外貨預金A.預入日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金A.満期日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金A.スキーム番号 IS '';
COMMENT ON COLUMN TF_個別明細外貨預金A.入金時実勢相場 IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金A.適用利率 IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金A.優遇幅 IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金A.元本金額 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細外貨預金A.円換算レート IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金A.当時円換算金額 IS '元本金額×円換算レート';
COMMENT ON COLUMN TF_個別明細外貨預金A.実勢相場 IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金A.換算額 IS '円単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細外貨預金A.概算損益 IS '-ZZZZZZZZZZZZZZ9.00（当時円換算金額ー概算損益）';
COMMENT ON COLUMN TF_個別明細外貨預金A.データ基準日 IS '西暦YYYYMMDD';
EXIT;
