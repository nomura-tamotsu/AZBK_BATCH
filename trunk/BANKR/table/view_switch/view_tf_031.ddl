--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK・R コンタクトセンター                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_個別明細固定性預金                                         */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/22 | 土居 康一郎 | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_個別明細固定性預金
    (店番
    ,CIFNO
    ,世帯番号
    ,個人企業番号
    ,科目ID
    ,口座番号
    ,口座口番号
    ,枝番号
    ,商品ID
    ,預入日
    ,税区分ID
    ,金額
    ,利率
    ,満期日
    ,口座残高
    ,取扱店部課
    ,口座開設年月日
    ,通証区分ID
    ,預入期間
    ,委任ID
    ,満期予約サイン
    ,最近取引日
    ,データ基準日
    ,仕組預金
    )
 AS SELECT
    TF_個別明細固定性預金A.店番
    ,TF_個別明細固定性預金A.CIFNO
    ,TF_個別明細固定性預金A.世帯番号
    ,TF_個別明細固定性預金A.個人企業番号
    ,TF_個別明細固定性預金A.科目ID
    ,TF_個別明細固定性預金A.口座番号
    ,TF_個別明細固定性預金A.口座口番号
    ,TF_個別明細固定性預金A.枝番号
    ,TF_個別明細固定性預金A.商品ID
    ,TF_個別明細固定性預金A.預入日
    ,TF_個別明細固定性預金A.税区分ID
    ,TF_個別明細固定性預金A.金額
    ,TF_個別明細固定性預金A.利率
    ,TF_個別明細固定性預金A.満期日
    ,TF_個別明細固定性預金A.口座残高
    ,TF_個別明細固定性預金A.取扱店部課
    ,TF_個別明細固定性預金A.口座開設年月日
    ,TF_個別明細固定性預金A.通証区分ID
    ,TF_個別明細固定性預金A.預入期間
    ,TF_個別明細固定性預金A.委任ID
    ,TF_個別明細固定性預金A.満期予約サイン
    ,TF_個別明細固定性預金A.最近取引日
    ,TF_個別明細固定性預金A.データ基準日
    ,TF_個別明細固定性預金A.仕組預金
 FROM TF_個別明細固定性預金A
;
COMMENT ON COLUMN TF_個別明細固定性預金.店番 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_個別明細固定性預金.CIFNO IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_個別明細固定性預金.世帯番号 IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_個別明細固定性預金.個人企業番号 IS '個人企業番号："99999999999"固定　【未使用】';
COMMENT ON COLUMN TF_個別明細固定性預金.科目ID IS '4桁固定（0パディング）、左詰。科目（2桁）＋預金種類（2桁）';
COMMENT ON COLUMN TF_個別明細固定性預金.口座番号 IS '７桁固定';
COMMENT ON COLUMN TF_個別明細固定性預金.口座口番号 IS '【未使用】';
COMMENT ON COLUMN TF_個別明細固定性預金.枝番号 IS '7桁固定（0パディング）';
COMMENT ON COLUMN TF_個別明細固定性預金.商品ID IS 'TF_商品.商品IDを参照。6桁固定（0パディング）';
COMMENT ON COLUMN TF_個別明細固定性預金.預入日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細固定性預金.税区分ID IS 'TM_税区分.税区分IDを参照。';
COMMENT ON COLUMN TF_個別明細固定性預金.金額 IS '';
COMMENT ON COLUMN TF_個別明細固定性預金.利率 IS '';
COMMENT ON COLUMN TF_個別明細固定性預金.満期日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細固定性預金.口座残高 IS '固定値0';
COMMENT ON COLUMN TF_個別明細固定性預金.取扱店部課 IS '店(3桁固定)+部(2桁固定)+課(2桁固定)';
COMMENT ON COLUMN TF_個別明細固定性預金.口座開設年月日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細固定性預金.通証区分ID IS 'TM_通証区分.通証分IDを参照。';
COMMENT ON COLUMN TF_個別明細固定性預金.預入期間 IS '月単位（999.9）';
COMMENT ON COLUMN TF_個別明細固定性預金.委任ID IS 'TM_委任コード.委任IDを参照';
COMMENT ON COLUMN TF_個別明細固定性預金.満期予約サイン IS '0：予約登録なし、1：予約登録済み。データがない場合は、1Bytesの半角スペース。';
COMMENT ON COLUMN TF_個別明細固定性預金.最近取引日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細固定性預金.データ基準日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細固定性預金.仕組預金 IS '1：仕組預金 0：それ以外';
EXIT;
