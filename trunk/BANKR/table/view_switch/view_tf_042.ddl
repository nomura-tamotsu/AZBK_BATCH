--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK・R コンタクトセンター                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_個別明細流動性預金                                         */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/20 | 土居 康一郎 | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_個別明細流動性預金
    (店番
    ,CIFNO
    ,世帯番号
    ,個人企業番号
    ,科目ID
    ,口座番号
    ,口座口番号
    ,枝番号
    ,最終取引日
    ,税区分ID
    ,口座残高
    ,取扱店部課
    ,口座開設年月日
    ,通証区分ID
    ,最近取引締サイン
    ,金額
    ,マル優限度額
    ,データ基準日
    )
 AS SELECT
    TF_個別明細流動性預金B.店番
    ,TF_個別明細流動性預金B.CIFNO
    ,TF_個別明細流動性預金B.世帯番号
    ,TF_個別明細流動性預金B.個人企業番号
    ,TF_個別明細流動性預金B.科目ID
    ,TF_個別明細流動性預金B.口座番号
    ,TF_個別明細流動性預金B.口座口番号
    ,TF_個別明細流動性預金B.枝番号
    ,TF_個別明細流動性預金B.最終取引日
    ,TF_個別明細流動性預金B.税区分ID
    ,TF_個別明細流動性預金B.口座残高
    ,TF_個別明細流動性預金B.取扱店部課
    ,TF_個別明細流動性預金B.口座開設年月日
    ,TF_個別明細流動性預金B.通証区分ID
    ,TF_個別明細流動性預金B.最近取引締サイン
    ,TF_個別明細流動性預金B.金額
    ,TF_個別明細流動性預金B.マル優限度額
    ,TF_個別明細流動性預金B.データ基準日
 FROM TF_個別明細流動性預金B
;
COMMENT ON COLUMN TF_個別明細流動性預金.店番 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_個別明細流動性預金.CIFNO IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_個別明細流動性預金.世帯番号 IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_個別明細流動性預金.個人企業番号 IS '個人企業番号："99999999999"固定　【未使用】';
COMMENT ON COLUMN TF_個別明細流動性預金.科目ID IS '4桁固定（0パディング）、左詰。科目（2桁）＋預金種類（2桁）';
COMMENT ON COLUMN TF_個別明細流動性預金.口座番号 IS '７桁固定';
COMMENT ON COLUMN TF_個別明細流動性預金.口座口番号 IS '【未使用】';
COMMENT ON COLUMN TF_個別明細流動性預金.枝番号 IS '"00000"固定 【未使用】';
COMMENT ON COLUMN TF_個別明細流動性預金.最終取引日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細流動性預金.税区分ID IS 'TM_税区分.税区分IDを参照。';
COMMENT ON COLUMN TF_個別明細流動性預金.口座残高 IS 'ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細流動性預金.取扱店部課 IS '店(3桁固定)+部(2桁固定)+課(2桁固定)';
COMMENT ON COLUMN TF_個別明細流動性預金.口座開設年月日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_個別明細流動性預金.通証区分ID IS 'TM_通証区分.通証分IDを参照。';
COMMENT ON COLUMN TF_個別明細流動性預金.最近取引締サイン IS '';
COMMENT ON COLUMN TF_個別明細流動性預金.金額 IS '円単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細流動性預金.マル優限度額 IS '円単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細流動性預金.データ基準日 IS '西暦YYYYMMDD';
EXIT;
