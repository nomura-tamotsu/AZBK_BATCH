-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.                   
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD                               
-- ============================================================================
--                                                                             
--  SYSTEM   : BANK・R コンタクトセンター                                      
--                                                                             
--  TABLE    : TF_個別明細投信口座B                                            
--                                                                             
--  Mod   yy/mm/dd   Coder    Comment                                          
-- -----+----------+-------------+---------------------------------------------
--  %00 | YY/MM/DD | ISID        | First Eddition                              
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
PRESERVE BLANKS
INTO TABLE TF_個別明細投信口座B
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' 
    (店番                         CHAR       "NVL(RTRIM(:店番,' '),' ')"                                
    ,CIFNO                        CHAR       "NVL(RTRIM(:CIFNO,' '),' ')"                                
    ,世帯番号                     CHAR       "NVL(RTRIM(:世帯番号,' '),' ')"                                
    ,個人企業番号                 CHAR       "NVL(RTRIM(:個人企業番号,' '),' ')"                                
    ,口座番号                     CHAR       "NVL(RTRIM(:口座番号,' '),' ')"                                
    ,担当者コード                 CHAR       "NVL(RTRIM(:担当者コード,' '),' ')"                                
    ,担当者名カナ                 CHAR       "RTRIM(:担当者名カナ,' ')"                                
    ,担当者名                     CHAR       "RTRIM(:担当者名,' ')"                                
    ,勤務先                       CHAR       "RTRIM(:勤務先,' ')"                                
    ,役職名                       CHAR       "RTRIM(:役職名,' ')"                                
    ,振込銀行ID                   CHAR       "RTRIM(:振込銀行ID,' ')"                                
    ,振込支店ID                   CHAR       "RTRIM(:振込支店ID,' ')"                                
    ,科目ID                       CHAR       "RTRIM(:科目ID,' ')"                                
    ,振込口座                     CHAR       "RTRIM(:振込口座,' ')"                                
    ,当座貸越                     CHAR       "RTRIM(:当座貸越,' ')"                                
    ,申告枠限度額                 CHAR       "NVL(RTRIM(:申告枠限度額,' '),' ')"                                
    ,利用金額                     CHAR       "NVL(RTRIM(:利用金額,' '),' ')"                                
    ,余裕枠                       CHAR       "NVL(RTRIM(:余裕枠,' '),' ')"                                
    ,口座開設年月日               CHAR       "NVL(RTRIM(:口座開設年月日,' '),' ')"                                
    ,残高                         CHAR       "NVL(RTRIM(:残高,' '),' ')"                                
    ,口座区分                     CHAR       "NVL(RTRIM(:口座区分,' '),' ')"                                
    ,乗換優遇残金額               CHAR       "NVL(RTRIM(:乗換優遇残金額,' '),' ')"                                
    ,適用終了日                   CHAR       "NVL(RTRIM(:適用終了日,' '),' ')"                                
    ,データ基準日                 CHAR       "NVL(RTRIM(:データ基準日,' '),' ')"                                
    )
