--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK・R コンタクトセンター                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_個別明細外貨預金B                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/* %01 | 15/01/26 | 土居 康一郎 | 1.0次対応                                 */
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
    ,外為取引先番号
    )
 AS SELECT
    TF_個別明細外貨預金B.店番
    ,TF_個別明細外貨預金B.CIFNO
    ,TF_個別明細外貨預金B.世帯番号
    ,TF_個別明細外貨預金B.個人企業番号
    ,TF_個別明細外貨預金B.科目ID
    ,TF_個別明細外貨預金B.口座番号
    ,TF_個別明細外貨預金B.口座口番号
    ,TF_個別明細外貨預金B.枝番号
    ,TF_個別明細外貨預金B.通貨ID
    ,TF_個別明細外貨預金B.原通貨現在残高
    ,TF_個別明細外貨預金B.計数帰属店
    ,TF_個別明細外貨預金B.登録年月日
    ,TF_個別明細外貨預金B.通証区分ID
    ,TF_個別明細外貨預金B.税区分ID
    ,TF_個別明細外貨預金B.最近取引日
    ,TF_個別明細外貨預金B.委任ID
    ,TF_個別明細外貨預金B.預入日
    ,TF_個別明細外貨預金B.満期日
    ,TF_個別明細外貨預金B.スキーム番号
    ,TF_個別明細外貨預金B.入金時実勢相場
    ,TF_個別明細外貨預金B.適用利率
    ,TF_個別明細外貨預金B.優遇幅
    ,TF_個別明細外貨預金B.元本金額
    ,TF_個別明細外貨預金B.円換算レート
    ,TF_個別明細外貨預金B.当時円換算金額
    ,TF_個別明細外貨預金B.実勢相場
    ,TF_個別明細外貨預金B.換算額
    ,TF_個別明細外貨預金B.概算損益
    ,TF_個別明細外貨預金B.データ基準日
    ,TF_個別明細外貨預金B.外為取引先番号
 FROM TF_個別明細外貨預金B
;
COMMENT ON COLUMN TF_個別明細外貨預金.店番 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_個別明細外貨預金.CIFNO IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_個別明細外貨預金.世帯番号 IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_個別明細外貨預金.個人企業番号 IS '個人企業番号："99999999999"固定　【未使用】';
COMMENT ON COLUMN TF_個別明細外貨預金.科目ID IS '3桁固定（0パディング）、業務識別番号（2桁）＋商品区分番号（1桁）';
COMMENT ON COLUMN TF_個別明細外貨預金.口座番号 IS '７桁固定';
COMMENT ON COLUMN TF_個別明細外貨預金.口座口番号 IS '【未使用】';
COMMENT ON COLUMN TF_個別明細外貨預金.枝番号 IS '';
COMMENT ON COLUMN TF_個別明細外貨預金.通貨ID IS 'TM_通貨.通貨IDを参照。 TM_通貨.通貨略称=TMB_通貨.通貨IDとなる';
COMMENT ON COLUMN TF_個別明細外貨預金.原通貨現在残高 IS '外貨単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細外貨預金.計数帰属店 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_個別明細外貨預金.登録年月日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金.通証区分ID IS 'TM_通証区分.通証分IDを参照。';
COMMENT ON COLUMN TF_個別明細外貨預金.税区分ID IS '【未使用】';
COMMENT ON COLUMN TF_個別明細外貨預金.最近取引日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金.委任ID IS 'TM_委任コード.委任IDを参照';
COMMENT ON COLUMN TF_個別明細外貨預金.預入日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金.満期日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金.スキーム番号 IS 'TF_商品.商品IDを参照。6桁固定（0パディング）';
COMMENT ON COLUMN TF_個別明細外貨預金.入金時実勢相場 IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金.適用利率 IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金.優遇幅 IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金.元本金額 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細外貨預金.円換算レート IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金.当時円換算金額 IS '元本金額×円換算レート';
COMMENT ON COLUMN TF_個別明細外貨預金.実勢相場 IS '9999.9999999';
COMMENT ON COLUMN TF_個別明細外貨預金.換算額 IS '円単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細外貨預金.概算損益 IS '-ZZZZZZZZZZZZZZ9.00（当時円換算金額ー概算損益）';
COMMENT ON COLUMN TF_個別明細外貨預金.データ基準日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細外貨預金.外為取引先番号 IS '8桁固定（0パディング）。';
EXIT;
