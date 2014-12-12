--/*==========================================================================*/
--/* COPYRIGHT Brainyworks LTD. 2001,2008                                     */
--/* LICENSED MATERIAL - PROGRAM PROPERTY OF Brainyworks LTD.                 */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : e-MARKETBRAIN                                                 */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_個別明細投信口座                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | YY/MM/DD |             | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_個別明細投信口座
    (店番
    ,CIFNO
    ,世帯番号
    ,個人企業番号
    ,口座番号
    ,担当者コード
    ,担当者名カナ
    ,担当者名
    ,勤務先
    ,役職名
    ,振込銀行ID
    ,振込支店ID
    ,科目ID
    ,振込口座
    ,当座貸越
    ,申告枠限度額
    ,利用金額
    ,余裕枠
    ,口座開設年月日
    ,残高
    ,口座区分
    ,乗換優遇残金額
    ,適用終了日
    ,データ基準日
    )
 AS SELECT 
    TF_個別明細投信口座B.店番
    ,TF_個別明細投信口座B.CIFNO
    ,TF_個別明細投信口座B.世帯番号
    ,TF_個別明細投信口座B.個人企業番号
    ,TF_個別明細投信口座B.口座番号
    ,TF_個別明細投信口座B.担当者コード
    ,TF_個別明細投信口座B.担当者名カナ
    ,TF_個別明細投信口座B.担当者名
    ,TF_個別明細投信口座B.勤務先
    ,TF_個別明細投信口座B.役職名
    ,TF_個別明細投信口座B.振込銀行ID
    ,TF_個別明細投信口座B.振込支店ID
    ,TF_個別明細投信口座B.科目ID
    ,TF_個別明細投信口座B.振込口座
    ,TF_個別明細投信口座B.当座貸越
    ,TF_個別明細投信口座B.申告枠限度額
    ,TF_個別明細投信口座B.利用金額
    ,TF_個別明細投信口座B.余裕枠
    ,TF_個別明細投信口座B.口座開設年月日
    ,TF_個別明細投信口座B.残高
    ,TF_個別明細投信口座B.口座区分
    ,TF_個別明細投信口座B.乗換優遇残金額
    ,TF_個別明細投信口座B.適用終了日
    ,TF_個別明細投信口座B.データ基準日
 FROM TF_個別明細投信口座B
;
COMMENT ON COLUMN TF_個別明細投信口座.店番 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_個別明細投信口座.CIFNO IS '';
COMMENT ON COLUMN TF_個別明細投信口座.世帯番号 IS '有効桁数７桁（固定長）';
COMMENT ON COLUMN TF_個別明細投信口座.個人企業番号 IS '';
COMMENT ON COLUMN TF_個別明細投信口座.口座番号 IS '（＝CIFNO）';
COMMENT ON COLUMN TF_個別明細投信口座.担当者コード IS '取扱担当者コード。';
COMMENT ON COLUMN TF_個別明細投信口座.担当者名カナ IS '取扱担当者名カナ。';
COMMENT ON COLUMN TF_個別明細投信口座.担当者名 IS '取扱担当者名漢字。';
COMMENT ON COLUMN TF_個別明細投信口座.勤務先 IS '勤務先名称（全角）';
COMMENT ON COLUMN TF_個別明細投信口座.役職名 IS '全角';
COMMENT ON COLUMN TF_個別明細投信口座.振込銀行ID IS '振込銀行コード';
COMMENT ON COLUMN TF_個別明細投信口座.振込支店ID IS '振込支店コード';
COMMENT ON COLUMN TF_個別明細投信口座.科目ID IS '1:普通、2:当座、4:貯蓄預金、9:その他';
COMMENT ON COLUMN TF_個別明細投信口座.振込口座 IS '振込口座';
COMMENT ON COLUMN TF_個別明細投信口座.当座貸越 IS '引落口座（CIFコード25桁）';
COMMENT ON COLUMN TF_個別明細投信口座.申告枠限度額 IS 'マル優申告枠限度額。円単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座.利用金額 IS 'マル優の受渡利用金額+累投利用金額。円単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座.余裕枠 IS 'マル優の（受渡限度額+累投限度額)-(受渡利用金額+累投利用金額）。円単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座.口座開設年月日 IS '';
COMMENT ON COLUMN TF_個別明細投信口座.残高 IS '先合計金額 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_個別明細投信口座.口座区分 IS '0：未登録（一般口座）　1：源泉徴収　2：確定申告';
COMMENT ON COLUMN TF_個別明細投信口座.乗換優遇残金額 IS '';
COMMENT ON COLUMN TF_個別明細投信口座.適用終了日 IS '';
COMMENT ON COLUMN TF_個別明細投信口座.データ基準日 IS '';
EXIT;
