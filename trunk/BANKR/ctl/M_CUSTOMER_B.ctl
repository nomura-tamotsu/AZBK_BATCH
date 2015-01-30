-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK・R コンタクトセンター
--
--  TABLE    : TF_顧客属性B
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+----------+-------------+---------------------------------------------
--  %00 | 15/01/14 | 土居 康一郎 | あおぞら銀行 1.0次 First Eddition
--  %01 | 15/01/21 | 土居 康一郎 | ファイル上の長さより有効桁が少ない項目の切り出し位置を修正
--  %02 | 15/01/29 | 土居 康一郎 | 連絡先補助住所 100→60Bytesに修正
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
INTO TABLE TF_顧客属性B
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
補助住所カナ            POSITION ( 327:426 )    CHAR,
自宅電話番号            POSITION ( 447:461 )    CHAR,
自宅FAX番号             POSITION ( 467:481 )    CHAR,
携帯電話番号            POSITION ( 487:501 )    CHAR,
MAILアドレス            POSITION ( 507:556 )    CHAR,
勤務先名                POSITION ( 557:636 )    CHAR,
勤務先名カナ            POSITION ( 637:676 )    CHAR,
勤務先電話番号          POSITION ( 717:731 )    CHAR,
連絡先住所コード        POSITION ( 737:747 )    CHAR,
連絡先郵便番号          POSITION ( 748:757 )    CHAR,
連絡先補助住所          POSITION ( 758:817 )    CHAR,
連絡先補助住所カナ      POSITION ( 818:917 )    CHAR,
連絡先電話番号          POSITION ( 938:952 )    CHAR,
連絡先FAX番号           POSITION ( 958:972 )    CHAR,
日中連絡先電話番号      POSITION ( 978:992 )    CHAR,
取引開始日              POSITION ( 998:1005)    CHAR,
世帯主フラグ            POSITION (1006:1006)    CHAR,
ホストTM対象区分        POSITION (1007:1007)    CHAR,
ホストDM対象区分        POSITION (1008:1008)    CHAR,
行員区分                POSITION (1009:1009)    CHAR,
郵便不着                POSITION (1010:1010)    CHAR,
会社寮                  POSITION (1011:1011)    CHAR,
電話番号間違い          POSITION (1012:1012)    CHAR,
移転                    POSITION (1013:1013)    CHAR,
本人死亡                POSITION (1014:1014)    CHAR,
当行金融資産残高        POSITION (1015:1030)    DECIMAL EXTERNAL,
預り資産残高１          POSITION (1031:1046)    DECIMAL EXTERNAL,
預り資産残高２          POSITION (1047:1062)    DECIMAL EXTERNAL,
預り資産残高３          POSITION (1063:1078)    DECIMAL EXTERNAL,
流動性預金残高          POSITION (1079:1094)    DECIMAL EXTERNAL,
定期性預金残高          POSITION (1095:1110)    DECIMAL EXTERNAL,
仕組預金残高            POSITION (1111:1126)    DECIMAL EXTERNAL,
外貨預金残高            POSITION (1127:1142)    DECIMAL EXTERNAL,
投信残高                POSITION (1143:1158)    DECIMAL EXTERNAL,
債券残高                POSITION (1159:1174)    DECIMAL EXTERNAL,
リスク商品残高          POSITION (1175:1190)    DECIMAL EXTERNAL,
IB契約                  POSITION (1191:1191)    CHAR,
IB契約者ID              POSITION (1192:1207)    CHAR,
IB契約申込店番          POSITION (1208:1210)    CHAR,
IB契約代表口座科目      POSITION (1211:1214)    CHAR,
IB契約代表口座番号      POSITION (1215:1221)    CHAR,
IB契約日                POSITION (1222:1229)    CHAR,
IB契約解除日            POSITION (1230:1237)    CHAR,
IB契約最終更新日        POSITION (1238:1245)    CHAR,
職業コード              POSITION (1246:1249)    CHAR,
年収                    POSITION (1250:1264)    CHAR,
所得年度                POSITION (1265:1268)    CHAR,
取引管理情報            POSITION (1269:1269)    CHAR,
担当者名                POSITION (1270:1293)    CHAR,
カード発行サイン        POSITION (1294:1294)    CHAR,
自宅住所都道府県        POSITION (1295:1304)    CHAR,
自宅住所市区町村        POSITION (1305:1328)    CHAR,
自宅住所大字通称        POSITION (1329:1364)    CHAR,
自宅住所字丁目          POSITION (1365:1404)    CHAR,
自宅住所番地気付        POSITION (1405:1504)    CHAR,
自宅住所都道府県カナ    POSITION (1505:1514)    CHAR,
自宅住所市区町村カナ    POSITION (1515:1538)    CHAR,
自宅住所大字通称カナ    POSITION (1539:1574)    CHAR,
自宅住所字丁目カナ      POSITION (1575:1614)    CHAR,
自宅住所番地気付カナ    POSITION (1615:1698)    CHAR,
自宅住所                POSITION (1699:1868)    CHAR,
自宅住所カナ            POSITION (1869:2043)    CHAR,
連絡先住所都道府県      POSITION (2044:2053)    CHAR,
連絡先住所市区町村      POSITION (2054:2077)    CHAR,
連絡先住所大字通称      POSITION (2078:2113)    CHAR,
連絡先住所字丁目        POSITION (2114:2153)    CHAR,
連絡先住所番地気付      POSITION (2154:2253)    CHAR,
連絡先住所都道府県カナ  POSITION (2254:2263)    CHAR,
連絡先住所市区町村カナ  POSITION (2264:2287)    CHAR,
連絡先住所大字通称カナ  POSITION (2288:2323)    CHAR,
連絡先住所字丁目カナ    POSITION (2324:2363)    CHAR,
連絡先住所番地気付カナ  POSITION (2364:2447)    CHAR,
連絡先住所              POSITION (2448:2617)    CHAR,
連絡先住所カナ          POSITION (2618:2792)    CHAR,
データ基準日            POSITION (2793:2800)    CHAR,
マル優                  POSITION (2801:2801)    CHAR,
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
