--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK・R コンタクトセンター                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_世帯属性                                                   */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/15 | 土居 康一郎 | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_世帯属性
    (店番
    ,CIFNO
    ,個人企業番号
    ,人格区分
    ,世帯番号
    ,氏名漢字
    ,氏名漢字更新フラグ
    ,氏名カナ
    ,氏名カナ更新フラグ
    ,性別
    ,性別更新フラグ
    ,生年月日
    ,生年月日更新フラグ
    ,住所コード
    ,郵便番号
    ,補助住所
    ,住所変更フラグ
    ,補助住所カナ
    ,住所カナ変更フラグ
    ,自宅電話番号
    ,自宅電話番号更新フラグ
    ,自宅FAX番号
    ,自宅FAX番号更新フラグ
    ,携帯電話番号
    ,携帯電話番号更新フラグ
    ,MAILアドレス
    ,MAILアドレス更新フラグ
    ,勤務先名
    ,勤務先名更新フラグ
    ,勤務先名カナ
    ,勤務先名カナ更新フラグ
    ,勤務先電話番号
    ,勤務先電話番号更新フラグ
    ,連絡先住所コード
    ,連絡先郵便番号
    ,連絡先補助住所
    ,連絡先住所変更フラグ
    ,連絡先補助住所カナ
    ,連絡先住所カナ変更フラグ
    ,連絡先電話番号
    ,連絡先電話番号更新フラグ
    ,連絡先FAX番号
    ,連絡先FAX番号更新フラグ
    ,日中連絡先電話番号
    ,日中連絡先電話番号更新フラグ
    ,取引開始日
    ,世帯主フラグ
    ,行員区分
    ,郵便不着
    ,会社寮
    ,電話番号間違い
    ,移転
    ,本人死亡
    ,案内区分
    ,優良区分
    ,未取引先
    ,マル優申告額
    ,マル優利用額
    ,マル特申告額
    ,マル特利用額
    ,当行金融資産残高
    ,預り資産残高１
    ,預り資産残高２
    ,預り資産残高３
    ,流動性預金残高
    ,定期性預金残高
    ,仕組預金残高
    ,外貨預金残高
    ,投信残高
    ,債券残高
    ,リスク商品残高
    ,テレバン契約
    ,テレバン契約日
    ,IB契約
    ,IB契約者ID
    ,IB契約申込店番
    ,IB契約代表口座科目
    ,IB契約代表口座番号
    ,IB契約日
    ,IB契約解除日
    ,IB契約最終更新日
    ,ネット支店契約
    ,ネット支店契約者ID
    ,ネット支店契約申込店番
    ,ネット支店契約代表口座科目
    ,ネット支店契約代表口座口番号
    ,ネット支店契約日
    ,ネット支店契約解除日
    ,ネット支店契約最終更新日
    ,ホストTM対象区分
    ,ホストDM対象区分
    ,TM対象区分
    ,DM対象区分
    ,職業コード
    ,年収
    ,所得年度
    ,取引管理情報
    ,担当者名
    ,カード発行サイン
    ,自宅住所都道府県
    ,自宅住所市区町村
    ,自宅住所大字通称
    ,自宅住所字丁目
    ,自宅住所番地気付
    ,自宅住所気付
    ,自宅住所都道府県カナ
    ,自宅住所市区町村カナ
    ,自宅住所大字通称カナ
    ,自宅住所字丁目カナ
    ,自宅住所番地気付カナ
    ,自宅住所気付カナ
    ,自宅住所
    ,自宅住所カナ
    ,連絡先住所都道府県
    ,連絡先住所市区町村
    ,連絡先住所大字通称
    ,連絡先住所字丁目
    ,連絡先住所番地気付
    ,連絡先住所気付
    ,連絡先住所都道府県カナ
    ,連絡先住所市区町村カナ
    ,連絡先住所大字通称カナ
    ,連絡先住所字丁目カナ
    ,連絡先住所番地気付カナ
    ,連絡先住所気付カナ
    ,連絡先住所
    ,連絡先住所カナ
    ,データ基準日
    ,マル優
    )
 AS SELECT
    TF_世帯属性A.店番
    ,TF_世帯属性A.CIFNO
    ,TF_世帯属性A.個人企業番号
    ,TF_世帯属性A.人格区分
    ,TF_世帯属性A.世帯番号
    ,TF_世帯属性A.氏名漢字
    ,TF_世帯属性A.氏名漢字更新フラグ
    ,TF_世帯属性A.氏名カナ
    ,TF_世帯属性A.氏名カナ更新フラグ
    ,TF_世帯属性A.性別
    ,TF_世帯属性A.性別更新フラグ
    ,TF_世帯属性A.生年月日
    ,TF_世帯属性A.生年月日更新フラグ
    ,TF_世帯属性A.住所コード
    ,TF_世帯属性A.郵便番号
    ,TF_世帯属性A.補助住所
    ,TF_世帯属性A.住所変更フラグ
    ,TF_世帯属性A.補助住所カナ
    ,TF_世帯属性A.住所カナ変更フラグ
    ,TF_世帯属性A.自宅電話番号
    ,TF_世帯属性A.自宅電話番号更新フラグ
    ,TF_世帯属性A.自宅FAX番号
    ,TF_世帯属性A.自宅FAX番号更新フラグ
    ,TF_世帯属性A.携帯電話番号
    ,TF_世帯属性A.携帯電話番号更新フラグ
    ,TF_世帯属性A.MAILアドレス
    ,TF_世帯属性A.MAILアドレス更新フラグ
    ,TF_世帯属性A.勤務先名
    ,TF_世帯属性A.勤務先名更新フラグ
    ,TF_世帯属性A.勤務先名カナ
    ,TF_世帯属性A.勤務先名カナ更新フラグ
    ,TF_世帯属性A.勤務先電話番号
    ,TF_世帯属性A.勤務先電話番号更新フラグ
    ,TF_世帯属性A.連絡先住所コード
    ,TF_世帯属性A.連絡先郵便番号
    ,TF_世帯属性A.連絡先補助住所
    ,TF_世帯属性A.連絡先住所変更フラグ
    ,TF_世帯属性A.連絡先補助住所カナ
    ,TF_世帯属性A.連絡先住所カナ変更フラグ
    ,TF_世帯属性A.連絡先電話番号
    ,TF_世帯属性A.連絡先電話番号更新フラグ
    ,TF_世帯属性A.連絡先FAX番号
    ,TF_世帯属性A.連絡先FAX番号更新フラグ
    ,TF_世帯属性A.日中連絡先電話番号
    ,TF_世帯属性A.日中連絡先電話番号更新フラグ
    ,TF_世帯属性A.取引開始日
    ,TF_世帯属性A.世帯主フラグ
    ,TF_世帯属性A.行員区分
    ,TF_世帯属性A.郵便不着
    ,TF_世帯属性A.会社寮
    ,TF_世帯属性A.電話番号間違い
    ,TF_世帯属性A.移転
    ,TF_世帯属性A.本人死亡
    ,TF_世帯属性A.案内区分
    ,TF_世帯属性A.優良区分
    ,TF_世帯属性A.未取引先
    ,TF_世帯属性A.マル優申告額
    ,TF_世帯属性A.マル優利用額
    ,TF_世帯属性A.マル特申告額
    ,TF_世帯属性A.マル特利用額
    ,TF_世帯属性A.当行金融資産残高
    ,TF_世帯属性A.預り資産残高１
    ,TF_世帯属性A.預り資産残高２
    ,TF_世帯属性A.預り資産残高３
    ,TF_世帯属性A.流動性預金残高
    ,TF_世帯属性A.定期性預金残高
    ,TF_世帯属性A.仕組預金残高
    ,TF_世帯属性A.外貨預金残高
    ,TF_世帯属性A.投信残高
    ,TF_世帯属性A.債券残高
    ,TF_世帯属性A.リスク商品残高
    ,TF_世帯属性A.テレバン契約
    ,TF_世帯属性A.テレバン契約日
    ,TF_世帯属性A.IB契約
    ,TF_世帯属性A.IB契約者ID
    ,TF_世帯属性A.IB契約申込店番
    ,TF_世帯属性A.IB契約代表口座科目
    ,TF_世帯属性A.IB契約代表口座番号
    ,TF_世帯属性A.IB契約日
    ,TF_世帯属性A.IB契約解除日
    ,TF_世帯属性A.IB契約最終更新日
    ,TF_世帯属性A.ネット支店契約
    ,TF_世帯属性A.ネット支店契約者ID
    ,TF_世帯属性A.ネット支店契約申込店番
    ,TF_世帯属性A.ネット支店契約代表口座科目
    ,TF_世帯属性A.ネット支店契約代表口座口番号
    ,TF_世帯属性A.ネット支店契約日
    ,TF_世帯属性A.ネット支店契約解除日
    ,TF_世帯属性A.ネット支店契約最終更新日
    ,TF_世帯属性A.ホストTM対象区分
    ,TF_世帯属性A.ホストDM対象区分
    ,TF_世帯属性A.TM対象区分
    ,TF_世帯属性A.DM対象区分
    ,TF_世帯属性A.職業コード
    ,TF_世帯属性A.年収
    ,TF_世帯属性A.所得年度
    ,TF_世帯属性A.取引管理情報
    ,TF_世帯属性A.担当者名
    ,TF_世帯属性A.カード発行サイン
    ,TF_世帯属性A.自宅住所都道府県
    ,TF_世帯属性A.自宅住所市区町村
    ,TF_世帯属性A.自宅住所大字通称
    ,TF_世帯属性A.自宅住所字丁目
    ,TF_世帯属性A.自宅住所番地気付
    ,TF_世帯属性A.自宅住所気付
    ,TF_世帯属性A.自宅住所都道府県カナ
    ,TF_世帯属性A.自宅住所市区町村カナ
    ,TF_世帯属性A.自宅住所大字通称カナ
    ,TF_世帯属性A.自宅住所字丁目カナ
    ,TF_世帯属性A.自宅住所番地気付カナ
    ,TF_世帯属性A.自宅住所気付カナ
    ,TF_世帯属性A.自宅住所
    ,TF_世帯属性A.自宅住所カナ
    ,TF_世帯属性A.連絡先住所都道府県
    ,TF_世帯属性A.連絡先住所市区町村
    ,TF_世帯属性A.連絡先住所大字通称
    ,TF_世帯属性A.連絡先住所字丁目
    ,TF_世帯属性A.連絡先住所番地気付
    ,TF_世帯属性A.連絡先住所気付
    ,TF_世帯属性A.連絡先住所都道府県カナ
    ,TF_世帯属性A.連絡先住所市区町村カナ
    ,TF_世帯属性A.連絡先住所大字通称カナ
    ,TF_世帯属性A.連絡先住所字丁目カナ
    ,TF_世帯属性A.連絡先住所番地気付カナ
    ,TF_世帯属性A.連絡先住所気付カナ
    ,TF_世帯属性A.連絡先住所
    ,TF_世帯属性A.連絡先住所カナ
    ,TF_世帯属性A.データ基準日
    ,TF_世帯属性A.マル優
 FROM TF_世帯属性A
;
COMMENT ON COLUMN TF_世帯属性.店番 IS 'TM_営業店.店番を参照。';
COMMENT ON COLUMN TF_世帯属性.CIFNO IS '有効桁数10桁（固定長）';
COMMENT ON COLUMN TF_世帯属性.個人企業番号 IS '個人企業番号："99999999999"固定　【未使用】';
COMMENT ON COLUMN TF_世帯属性.人格区分 IS '0：個人　1：法人　2：事業性個人　（０固定）';
COMMENT ON COLUMN TF_世帯属性.世帯番号 IS '10桁固定';
COMMENT ON COLUMN TF_世帯属性.氏名漢字 IS '全角40文字';
COMMENT ON COLUMN TF_世帯属性.氏名漢字更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.氏名カナ IS '半角カナ';
COMMENT ON COLUMN TF_世帯属性.氏名カナ更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.性別 IS '1：男性  2：女性  0：不明';
COMMENT ON COLUMN TF_世帯属性.性別更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.生年月日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_世帯属性.生年月日更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.住所コード IS 'TF_住所.住所コードを参照。住所コードが無い場合は"00000000000"を設定';
COMMENT ON COLUMN TF_世帯属性.郵便番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.補助住所 IS '全角のみ50文字';
COMMENT ON COLUMN TF_世帯属性.住所変更フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.補助住所カナ IS '半角カナのみ60文字　 字丁目カナ(40文字)+ "半角スペース" + 番地カナ(30文字) + "半角スペース" + 気付カナ（30文字）が設定（桁を超える場合は60文字までが設定される）';
COMMENT ON COLUMN TF_世帯属性.住所カナ変更フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.自宅電話番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.自宅電話番号更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.自宅FAX番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.自宅FAX番号更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.携帯電話番号 IS '【未使用】ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.携帯電話番号更新フラグ IS '【未使用】BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.MAILアドレス IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.MAILアドレス更新フラグ IS '【未使用】BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.勤務先名 IS '';
COMMENT ON COLUMN TF_世帯属性.勤務先名更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.勤務先名カナ IS '半角カナ';
COMMENT ON COLUMN TF_世帯属性.勤務先名カナ更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.勤務先電話番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.勤務先電話番号更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.連絡先住所コード IS 'TF_住所.住所コードを参照。住所コードが無い場合は"00000000000"を設定';
COMMENT ON COLUMN TF_世帯属性.連絡先郵便番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.連絡先補助住所 IS '全角50文字';
COMMENT ON COLUMN TF_世帯属性.連絡先住所変更フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.連絡先補助住所カナ IS '半角カナ';
COMMENT ON COLUMN TF_世帯属性.連絡先住所カナ変更フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.連絡先電話番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.連絡先電話番号更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.連絡先FAX番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.連絡先FAX番号更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.日中連絡先電話番号 IS 'ハイフン編集あり';
COMMENT ON COLUMN TF_世帯属性.日中連絡先電話番号更新フラグ IS 'BLANK:未更新  *:更新';
COMMENT ON COLUMN TF_世帯属性.取引開始日 IS '西暦YYYYMMDD。未取引先の場合は受付日。';
COMMENT ON COLUMN TF_世帯属性.世帯主フラグ IS '1：世帯主 0：それ以外';
COMMENT ON COLUMN TF_世帯属性.行員区分 IS '0：一般　1：行員（0固定）';
COMMENT ON COLUMN TF_世帯属性.郵便不着 IS '0:その他  1:不着先';
COMMENT ON COLUMN TF_世帯属性.会社寮 IS '【未使用】0:その他  1:会社寮　（0固定）';
COMMENT ON COLUMN TF_世帯属性.電話番号間違い IS '【未使用】0:その他  1:電話番号間違い　（0固定）';
COMMENT ON COLUMN TF_世帯属性.移転 IS '【未使用】0:その他  1:移転　（0固定）';
COMMENT ON COLUMN TF_世帯属性.本人死亡 IS '0:その他  1:死亡';
COMMENT ON COLUMN TF_世帯属性.案内区分 IS '【未使用】0:案内要  1:案内否';
COMMENT ON COLUMN TF_世帯属性.優良区分 IS '【未使用】0：通常  1：VIP';
COMMENT ON COLUMN TF_世帯属性.未取引先 IS '0：通常  1：未取引先';
COMMENT ON COLUMN TF_世帯属性.マル優申告額 IS '【未使用】単位:円。';
COMMENT ON COLUMN TF_世帯属性.マル優利用額 IS '【未使用】単位:円。';
COMMENT ON COLUMN TF_世帯属性.マル特申告額 IS '【未使用】単位:円。';
COMMENT ON COLUMN TF_世帯属性.マル特利用額 IS '【未使用】単位:円。';
COMMENT ON COLUMN TF_世帯属性.当行金融資産残高 IS '単位:円。 預り資産残高３';
COMMENT ON COLUMN TF_世帯属性.預り資産残高１ IS '単位:円。定期性預金残高+債券残高';
COMMENT ON COLUMN TF_世帯属性.預り資産残高２ IS '単位:円。預り資産残高１+流動性預金残高';
COMMENT ON COLUMN TF_世帯属性.預り資産残高３ IS '単位:円。預り資産残高2+外貨預金残高+投信残高';
COMMENT ON COLUMN TF_世帯属性.流動性預金残高 IS '単位:円。';
COMMENT ON COLUMN TF_世帯属性.定期性預金残高 IS '単位:円。';
COMMENT ON COLUMN TF_世帯属性.仕組預金残高 IS '単位:円。';
COMMENT ON COLUMN TF_世帯属性.外貨預金残高 IS '単位:円。';
COMMENT ON COLUMN TF_世帯属性.投信残高 IS '単位:円。';
COMMENT ON COLUMN TF_世帯属性.債券残高 IS '単位:円。';
COMMENT ON COLUMN TF_世帯属性.リスク商品残高 IS '単位:円。仕組預金残高＋外貨預金残高＋投信残高';
COMMENT ON COLUMN TF_世帯属性.テレバン契約 IS '0:なし 1:契約　9:解約';
COMMENT ON COLUMN TF_世帯属性.テレバン契約日 IS 'YYYYMMDD。テレバン契約=1の場合契約日、:テレバン契約=9の場合解約日を示す';
COMMENT ON COLUMN TF_世帯属性.IB契約 IS '0:なし 1:契約　9:解約';
COMMENT ON COLUMN TF_世帯属性.IB契約者ID IS '10桁固定長';
COMMENT ON COLUMN TF_世帯属性.IB契約申込店番 IS '3桁固定長';
COMMENT ON COLUMN TF_世帯属性.IB契約代表口座科目 IS '4桁固定。 emuscコード表.科目IDを参照';
COMMENT ON COLUMN TF_世帯属性.IB契約代表口座番号 IS '7桁固定長';
COMMENT ON COLUMN TF_世帯属性.IB契約日 IS '';
COMMENT ON COLUMN TF_世帯属性.IB契約解除日 IS '';
COMMENT ON COLUMN TF_世帯属性.IB契約最終更新日 IS '';
COMMENT ON COLUMN TF_世帯属性.ネット支店契約 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.ネット支店契約者ID IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.ネット支店契約申込店番 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.ネット支店契約代表口座科目 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.ネット支店契約代表口座口番号 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.ネット支店契約日 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.ネット支店契約解除日 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.ネット支店契約最終更新日 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.ホストTM対象区分 IS '連絡広告ＴＥＬ要否　0：TM対象先　1：TM禁止先';
COMMENT ON COLUMN TF_世帯属性.ホストDM対象区分 IS '連絡広告ＤＭ要否　0：DM対象先　1：DM禁止先';
COMMENT ON COLUMN TF_世帯属性.TM対象区分 IS '0：対象  1：対象外';
COMMENT ON COLUMN TF_世帯属性.DM対象区分 IS '0：対象  1：対象外';
COMMENT ON COLUMN TF_世帯属性.職業コード IS '職業マスタ.職業を参照';
COMMENT ON COLUMN TF_世帯属性.年収 IS '未取引先データとして使用。円単位 ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_世帯属性.所得年度 IS '未取引先データとして使用。YYYY';
COMMENT ON COLUMN TF_世帯属性.取引管理情報 IS '０：なし　１：有り';
COMMENT ON COLUMN TF_世帯属性.担当者名 IS '全角１２文字';
COMMENT ON COLUMN TF_世帯属性.カード発行サイン IS '0:単体カード、プラスカードなし、1:単体カードあり、2:プラスカードあり、3:単体カード、プラスカードあり';
COMMENT ON COLUMN TF_世帯属性.自宅住所都道府県 IS '全角５文字 左詰め。住所の登録が無い場合は「登録なし」が設定。';
COMMENT ON COLUMN TF_世帯属性.自宅住所市区町村 IS '全角１２文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所大字通称 IS '全角１８文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所字丁目 IS '全角２０文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所番地気付 IS '全角５０文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所気付 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.自宅住所都道府県カナ IS '半角カナ１０文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所市区町村カナ IS '半角カナ２４文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所大字通称カナ IS '半角カナ３６文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所字丁目カナ IS '半角カナ４０文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所番地気付カナ IS '半角カナ８４文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.自宅住所気付カナ IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.自宅住所 IS '全角８５文字　左詰め　自宅住所（都道府県）+自宅住所（市区町村）+自宅住所（大字通称）+自宅住所（字丁目）+自宅住所（番地）+自宅住所（気付）を連結';
COMMENT ON COLUMN TF_世帯属性.自宅住所カナ IS '半角カナ１７０文字　左詰め　自宅住所カナ（都道府県）+自宅住所カナ（市区町村）+自宅住所カナ（大字通称）+自宅住所カナ（字丁目）+自宅住所カナ（番地）+自宅住所カナ（気付）を連結';
COMMENT ON COLUMN TF_世帯属性.連絡先住所都道府県 IS '全角５文字 左詰め。';
COMMENT ON COLUMN TF_世帯属性.連絡先住所市区町村 IS '全角１２文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所大字通称 IS '全角１８文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所字丁目 IS '全角２０文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所番地気付 IS '全角５０文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所気付 IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.連絡先住所都道府県カナ IS '半角カナ１０文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所市区町村カナ IS '半角カナ２４文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所大字通称カナ IS '半角カナ３６文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所字丁目カナ IS '半角カナ４０文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所番地気付カナ IS '半角カナ８４文字 左詰め';
COMMENT ON COLUMN TF_世帯属性.連絡先住所気付カナ IS '【未使用】';
COMMENT ON COLUMN TF_世帯属性.連絡先住所 IS '全角８５文字　左詰め　自宅住所（都道府県）+自宅住所（市区町村）+自宅住所（大字通称）+自宅住所（字丁目）+自宅住所（番地）+自宅住所（気付）を連結';
COMMENT ON COLUMN TF_世帯属性.連絡先住所カナ IS '半角カナ１７０文字　左詰め　自宅住所カナ（都道府県）+自宅住所カナ（市区町村）+自宅住所カナ（大字通称）+自宅住所カナ（字丁目）+自宅住所カナ（番地）+自宅住所カナ（気付）を連結';
COMMENT ON COLUMN TF_世帯属性.データ基準日 IS '西暦YYYYMMDD';
COMMENT ON COLUMN TF_世帯属性.マル優 IS '0：なし  1：あり';
EXIT;
