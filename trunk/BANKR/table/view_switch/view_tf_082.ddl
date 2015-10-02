--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_個別明細投信口座明細                                       */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_個別明細投信口座明細
    (店番
    ,CIFNO
    ,世帯番号
    ,個人企業番号
    ,口座番号
    ,商品ID
    ,銘柄コード
    ,銘柄名
    ,数量
    ,純資産
    ,個別元本
    ,取得金額
    ,解約価額
    ,標準価額
    ,当初取引日
    ,最近取引日
    ,取扱店合計
    ,預り区分
    ,データ基準日
    )
 AS SELECT 
    TF_個別明細投信口座明細B.店番
    ,TF_個別明細投信口座明細B.CIFNO
    ,TF_個別明細投信口座明細B.世帯番号
    ,TF_個別明細投信口座明細B.個人企業番号
    ,TF_個別明細投信口座明細B.口座番号
    ,TF_個別明細投信口座明細B.商品ID
    ,TF_個別明細投信口座明細B.銘柄コード
    ,TF_個別明細投信口座明細B.銘柄名
    ,TF_個別明細投信口座明細B.数量
    ,TF_個別明細投信口座明細B.純資産
    ,TF_個別明細投信口座明細B.個別元本
    ,TF_個別明細投信口座明細B.取得金額
    ,TF_個別明細投信口座明細B.解約価額
    ,TF_個別明細投信口座明細B.標準価額
    ,TF_個別明細投信口座明細B.当初取引日
    ,TF_個別明細投信口座明細B.最近取引日
    ,TF_個別明細投信口座明細B.取扱店合計
    ,TF_個別明細投信口座明細B.預り区分
    ,TF_個別明細投信口座明細B.データ基準日
 FROM TF_個別明細投信口座明細B
;
COMMENT ON COLUMN TF_個別明細投信口座明細.店番 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_個別明細投信口座明細.CIFNO IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_個別明細投信口座明細.世帯番号 IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_個別明細投信口座明細.個人企業番号 IS '個人企業番号："99999999999"固定　【未使用】';
COMMENT ON COLUMN TF_個別明細投信口座明細.口座番号 IS '7桁固定（0パディング）';
COMMENT ON COLUMN TF_個別明細投信口座明細.商品ID IS '【未使用】';
COMMENT ON COLUMN TF_個別明細投信口座明細.銘柄コード IS 'ファンドコード8桁固定';
COMMENT ON COLUMN TF_個別明細投信口座明細.銘柄名 IS '銘柄名';
COMMENT ON COLUMN TF_個別明細投信口座明細.数量 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座明細.純資産 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座明細.個別元本 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座明細.取得金額 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座明細.解約価額 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座明細.標準価額 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座明細.当初取引日 IS '';
COMMENT ON COLUMN TF_個別明細投信口座明細.最近取引日 IS '';
COMMENT ON COLUMN TF_個別明細投信口座明細.取扱店合計 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座明細.預り区分 IS '0：一般預り　1：特定預り　2：NISA預り';
COMMENT ON COLUMN TF_個別明細投信口座明細.データ基準日 IS '';
EXIT;
