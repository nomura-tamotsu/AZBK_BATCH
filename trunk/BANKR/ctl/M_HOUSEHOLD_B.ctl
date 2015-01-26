-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK・R コンタクトセンター
--
--  TABLE    : TF_世帯属性B
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | 15/01/14 | 土居 康一郎 | あおぞら銀行 1.0次 First Eddition
--  %01 | 15/01/21 | 土居 康一郎 | ファイル上の長さより有効桁が少ない項目の切り出し位置を修正
-- ============================================================================

OPTIONS (direct=true,errors=1000)
LOAD DATA
TRUNCATE
INTO TABLE TF_世帯属性B
(
店番                    POSITION (   1:3   )    CHAR,
CIFNO                   POSITION (   4:13  )    CHAR,
個人企業番号            POSITION (  14:24  )    CHAR,
人格区分                POSITION (  25:25  )    CHAR,
世帯番号                POSITION (  26:36  )    CHAR,
氏名漢字                POSITION (  37:116 )    CHAR,
氏名カナ                POSITION ( 117:156 )    CHAR,
性別                    POSITION ( 197:197 )    CHAR,
生年月日                POSITION ( 198:205 )    CHAR,
住所コード              POSITION ( 206:216 )    CHAR,
郵便番号                POSITION ( 217:226 )    CHAR,
補助住所                POSITION ( 227:326 )    CHAR,
補助住所カナ            POSITION ( 327:386 )    CHAR,
自宅電話番号            POSITION ( 447:461 )    CHAR,
自宅FAX番号             POSITION ( 467:481 )    CHAR,
携帯電話番号            POSITION ( 487:501 )    CHAR,
MAILアドレス            POSITION ( 507:556 )    CHAR,
勤務先名                POSITION ( 557:636 )    CHAR,
勤務先名カナ            POSITION ( 637:676 )    CHAR,
勤務先電話番号          POSITION ( 717:731 )    CHAR,
連絡先住所コード        POSITION ( 737:747 )    CHAR,
連絡先郵便番号          POSITION ( 748:757 )    CHAR,
連絡先補助住所          POSITION ( 758:857 )    CHAR,
連絡先補助住所カナ      POSITION ( 858:917 )    CHAR,
連絡先電話番号          POSITION ( 978:992 )    CHAR,
連絡先FAX番号           POSITION ( 998:1012)    CHAR,
日中連絡先電話番号      POSITION (1018:1032)    CHAR,
取引開始日              POSITION (1038:1045)    CHAR,
世帯主フラグ            POSITION (1046:1046)    CHAR,
ホストTM対象区分        POSITION (1047:1047)    CHAR,
ホストDM対象区分        POSITION (1048:1048)    CHAR,
行員区分                POSITION (1049:1049)    CHAR,
郵便不着                POSITION (1050:1050)    CHAR,
会社寮                  POSITION (1051:1051)    CHAR,
電話番号間違い          POSITION (1052:1052)    CHAR,
移転                    POSITION (1053:1053)    CHAR,
本人死亡                POSITION (1054:1054)    CHAR,
当行金融資産残高        POSITION (1055:1070)    DECIMAL EXTERNAL,
預り資産残高１          POSITION (1071:1086)    DECIMAL EXTERNAL,
預り資産残高２          POSITION (1087:1102)    DECIMAL EXTERNAL,
預り資産残高３          POSITION (1103:1118)    DECIMAL EXTERNAL,
流動性預金残高          POSITION (1119:1134)    DECIMAL EXTERNAL,
定期性預金残高          POSITION (1135:1150)    DECIMAL EXTERNAL,
仕組預金残高            POSITION (1151:1166)    DECIMAL EXTERNAL,
外貨預金残高            POSITION (1167:1182)    DECIMAL EXTERNAL,
投信残高                POSITION (1183:1198)    DECIMAL EXTERNAL,
債券残高                POSITION (1199:1214)    DECIMAL EXTERNAL,
リスク商品残高          POSITION (1215:1230)    DECIMAL EXTERNAL,
IB契約                  POSITION (1231:1231)    CHAR,
IB契約者ID              POSITION (1232:1247)    CHAR,
IB契約申込店番          POSITION (1248:1250)    CHAR,
IB契約代表口座科目      POSITION (1251:1254)    CHAR,
IB契約代表口座番号      POSITION (1255:1261)    CHAR,
IB契約日                POSITION (1262:1269)    CHAR,
IB契約解除日            POSITION (1270:1277)    CHAR,
IB契約最終更新日        POSITION (1278:1285)    CHAR,
職業コード              POSITION (1286:1289)    CHAR,
年収                    POSITION (1290:1304)    CHAR,
所得年度                POSITION (1305:1308)    CHAR,
取引管理情報            POSITION (1309:1309)    CHAR,
担当者名                POSITION (1310:1333)    CHAR,
カード発行サイン        POSITION (1334:1334)    CHAR,
自宅住所都道府県        POSITION (1335:1344)    CHAR,
自宅住所市区町村        POSITION (1345:1368)    CHAR,
自宅住所大字通称        POSITION (1369:1404)    CHAR,
自宅住所字丁目          POSITION (1405:1444)    CHAR,
自宅住所番地気付        POSITION (1445:1544)    CHAR,
自宅住所都道府県カナ    POSITION (1545:1554)    CHAR,
自宅住所市区町村カナ    POSITION (1555:1578)    CHAR,
自宅住所大字通称カナ    POSITION (1579:1614)    CHAR,
自宅住所字丁目カナ      POSITION (1615:1654)    CHAR,
自宅住所番地気付カナ    POSITION (1655:1738)    CHAR,
自宅住所                POSITION (1739:1908)    CHAR,
自宅住所カナ            POSITION (1909:2083)    CHAR,
連絡先住所都道府県      POSITION (2084:2093)    CHAR,
連絡先住所市区町村      POSITION (2094:2117)    CHAR,
連絡先住所大字通称      POSITION (2118:2153)    CHAR,
連絡先住所字丁目        POSITION (2154:2193)    CHAR,
連絡先住所番地気付      POSITION (2194:2293)    CHAR,
連絡先住所都道府県カナ  POSITION (2294:2303)    CHAR,
連絡先住所市区町村カナ  POSITION (2304:2327)    CHAR,
連絡先住所大字通称カナ  POSITION (2328:2363)    CHAR,
連絡先住所字丁目カナ    POSITION (2364:2403)    CHAR,
連絡先住所番地気付カナ  POSITION (2404:2487)    CHAR,
連絡先住所              POSITION (2488:2657)    CHAR,
連絡先住所カナ          POSITION (2658:2832)    CHAR,
データ基準日            POSITION (2833:2840)    CHAR,
マル優                  POSITION (2841:2841)    CHAR,
氏名漢字更新フラグ      CONSTANT ' ',
氏名カナ更新フラグ      CONSTANT ' ',
性別更新フラグ          CONSTANT ' ',
生年月日更新フラグ      CONSTANT ' ',
住所変更フラグ          CONSTANT ' ',
住所カナ変更フラグ      CONSTANT ' ',
自宅電話番号更新フラグ  CONSTANT ' ',
自宅FAX番号更新フラグ   CONSTANT ' ',
携帯電話番号更新フラグ  CONSTANT ' ',
MAILアドレス更新フラグ  CONSTANT ' ',
勤務先名更新フラグ      CONSTANT ' ',
勤務先名カナ更新フラグ  CONSTANT ' ',
勤務先電話番号更新フラグ    CONSTANT ' ',
連絡先住所カナ変更フラグ    CONSTANT ' ',
連絡先住所変更フラグ        CONSTANT ' ',
連絡先電話番号更新フラグ    CONSTANT ' ',
連絡先FAX番号更新フラグ     CONSTANT ' ',
日中連絡先電話番号更新フラグ    CONSTANT ' ',
案内区分                CONSTANT '0',
優良区分                CONSTANT '0',
未取引先                CONSTANT '0',
TM対象区分              CONSTANT '0',
DM対象区分              CONSTANT '0',
テレバン契約            CONSTANT '0'
    )
