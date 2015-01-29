--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK・R コンタクトセンター                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_顧客プロファイル                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/26 | 土居 康一郎 | 1.0次対応                                 */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_顧客プロファイル
    (店番
    ,CIFNO
    ,登録日
    ,借入適正状況
    ,職業コード
    ,職業備考
    ,年収コード
    ,金融資産コード
    ,運用方針コード
    ,取引動機コード
    ,仕組預金
    ,外貨預金
    ,円建定額年金保険
    ,円建変額年金保険
    ,外貨建年金保険
    ,株式投信
    ,信用先物ワラント
    ,外国証券投信MMF
    ,転換社債
    ,公社債投信MMF
    ,日中連絡先
    ,日中連絡先備考
    ,仕組債
    )
 AS SELECT
    TF_顧客プロファイルB.店番
    ,TF_顧客プロファイルB.CIFNO
    ,TF_顧客プロファイルB.登録日
    ,TF_顧客プロファイルB.借入適正状況
    ,TF_顧客プロファイルB.職業コード
    ,TF_顧客プロファイルB.職業備考
    ,TF_顧客プロファイルB.年収コード
    ,TF_顧客プロファイルB.金融資産コード
    ,TF_顧客プロファイルB.運用方針コード
    ,TF_顧客プロファイルB.取引動機コード
    ,TF_顧客プロファイルB.仕組預金
    ,TF_顧客プロファイルB.外貨預金
    ,TF_顧客プロファイルB.円建定額年金保険
    ,TF_顧客プロファイルB.円建変額年金保険
    ,TF_顧客プロファイルB.外貨建年金保険
    ,TF_顧客プロファイルB.株式投信
    ,TF_顧客プロファイルB.信用先物ワラント
    ,TF_顧客プロファイルB.外国証券投信MMF
    ,TF_顧客プロファイルB.転換社債
    ,TF_顧客プロファイルB.公社債投信MMF
    ,TF_顧客プロファイルB.日中連絡先
    ,TF_顧客プロファイルB.日中連絡先備考
    ,TF_顧客プロファイルB.仕組債
 FROM TF_顧客プロファイルB
;
COMMENT ON COLUMN TF_顧客プロファイル.店番 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_顧客プロファイル.CIFNO IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_顧客プロファイル.登録日 IS '';
COMMENT ON COLUMN TF_顧客プロファイル.借入適正状況 IS '0：問題なし　１：問題あり';
COMMENT ON COLUMN TF_顧客プロファイル.職業コード IS '1:会社員 2：会社役員 3：官公庁・団体職員 4：医師・弁護士等 5：自営業・サービス業 6：教職員 7：農林・水産 8：自由業 9：無職 10：その他 ';
COMMENT ON COLUMN TF_顧客プロファイル.職業備考 IS '備考：全角20文字';
COMMENT ON COLUMN TF_顧客プロファイル.年収コード IS '1：500万円未満 2：500万円以上〜1000万円未満 3：1000万円以上〜3000万円未満 4：3000万円以上〜5000万円未満 5：5000万円以上〜１億円未満 6：１億円以上 ';
COMMENT ON COLUMN TF_顧客プロファイル.金融資産コード IS '1：500万円未満 2：500万円以上〜1000万円未満 3：1000万円以上〜3000万円未満 4：3000万円以上〜5000万円未満 5：5000万円以上〜１億円未満 6：１億円以上〜３億円未満 7：３億円以上〜１０億円未満 8：１０億円以上 ';
COMMENT ON COLUMN TF_顧客プロファイル.運用方針コード IS '1：元本保証 2：安定性重視 3：収益性と安定性のバランス重視 4：収益性重視 ';
COMMENT ON COLUMN TF_顧客プロファイル.取引動機コード IS '1：知人の紹介 2：ダイレクトメール 3：新聞・雑誌・インターネット 4：訪問・電話・店頭による勧誘 ';
COMMENT ON COLUMN TF_顧客プロファイル.仕組預金 IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.外貨預金 IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.円建定額年金保険 IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.円建変額年金保険 IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.外貨建年金保険 IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.株式投信 IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.信用先物ワラント IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.外国証券投信MMF IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.転換社債 IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.公社債投信MMF IS '0：知識・経験なし　1：知識あり・経験なし　2：知識・経験あり';
COMMENT ON COLUMN TF_顧客プロファイル.日中連絡先 IS '市外局番-市内局番-加入者番号';
COMMENT ON COLUMN TF_顧客プロファイル.日中連絡先備考 IS '備考：全角20文字';
COMMENT ON COLUMN TF_顧客プロファイル.仕組債 IS '0：知識・経験なし、1：知識あり・経験なし、2：知識・経験あり';
EXIT;
