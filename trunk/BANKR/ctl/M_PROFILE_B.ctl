-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK・R コンタクトセンター
--
--  TABLE    : TF_顧客プロファイルB
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+------------+-------------+---------------------------------------------
--  %00 | 15/01/28   | 土居 康一郎 | あおぞら銀行 1.0次 First Eddition
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
INTO TABLE TF_顧客プロファイルB
(
 店番                POSITION (  1:  3) CHAR
,CIFNO               POSITION (  4: 13) CHAR
,登録日              POSITION ( 14: 21) CHAR
,借入適正状況        POSITION ( 22: 22) CHAR
,職業コード          POSITION ( 23: 24) CHAR
,職業備考            POSITION ( 25: 64) CHAR
,年収コード          POSITION ( 65: 66) CHAR
,金融資産コード      POSITION ( 67: 68) CHAR
,運用方針コード      POSITION ( 69: 70) CHAR
,取引動機コード      POSITION ( 71: 72) CHAR
,仕組預金            POSITION ( 73: 73) CHAR
,外貨預金            POSITION ( 74: 74) CHAR
,円建定額年金保険    POSITION ( 75: 75) CHAR
,円建変額年金保険    POSITION ( 76: 76) CHAR
,外貨建年金保険      POSITION ( 77: 77) CHAR
,株式投信            POSITION ( 78: 78) CHAR
,信用先物ワラント    POSITION ( 79: 79) CHAR
,外国証券投信MMF     POSITION ( 80: 80) CHAR
,転換社債            POSITION ( 81: 81) CHAR
,公社債投信MMF       POSITION ( 82: 82) CHAR
,仕組債              POSITION ( 83: 83) CHAR
,日中連絡先          POSITION ( 84:103) CHAR
,日中連絡先備考      POSITION (104:143) CHAR
    )
