#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# FILE      : 業務バッチ共通定義ファイル
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 13/10/XX | ISID          | First Edition.
# %01 | 14/06/24 | ISID          | Error Code 追加
# %02 | 15/01/14 | 土居　康一郎  | あおぞら銀行 1.0次対応
#============================================================================

# ============================================================================
# 共通 Alias 設定
# ============================================================================
Set-Alias grep Select-String

# ============================================================================
# 共通定義
# ============================================================================
# 終了コード(正常)
$global:RC_OK=0
# 終了コード(異常)
$global:RC_NG=9
# 終了コード(警告)
$global:RC_WARNING=1


# 環境変数取得
$global:COMPUTERNAME=[environment]::getenvironmentvariable("computername")
$global:USERNAME=[environment]::username

$global:USER=$env:user
$global:EMB_HOME=$env:emb_home
$global:DB_UID=$env:db_uid
$global:DB_NAME=$env:db_name
$global:DB_PWD=$env:db_pwd
$global:ORACLE_TNS=$env:oracle_tns

# ============================================================================
# ディレクトリ定義
# ============================================================================
# クラスタログディレクトリ
$global:CLLOG_DIR="E:\CLlog\azbk\BANKRAZB"
# ログディレクトリ
$global:LOG_DIR="$global:CLLOG_DIR\error"
# スクリプトディレクトリ
$global:SCRIPT_DIR="$global:EMB_HOME\ps"
# 一時ファイルディレクトリ
$global:TMP_DIR="$global:EMB_HOME\tmp"
# レポートディレクトリ
$global:REP_LOG_DIR="$global:LOG_DIR\report"
$global:REP_BACKUP_DIR="$global:REP_LOG_DIR\backup"

#外部ファイル送受信ルートディレクトリ
$global:EXTDATA_DIR="E:\extdata"
# 外部ファイル受信ディレクトリ
$global:EXT_LOAD_DIR="$global:EXTDATA_DIR\rcv"
$global:EXT_LOAD_BACKUP_DIR="$global:EXT_LOAD_DIR\backup"
# 外部ファイル送信ディレクトリ
$global:EXT_UPLOAD_DIR="$global:EXTDATA_DIR\snd"
$global:EXT_UPLOAD_BACKUP_DIR="$global:EXT_UPLOAD_DIR\backup"

# 制御ファイル格納ディレクトリ
$global:CTL_FILE_DIR="$global:EMB_HOME\ctl"
# ビューDDL格納ディレクトリ
$global:VIEW_DDL_DIR="$global:EMB_HOME\table\view_switch"
$global:VIEW_DDL_LOG_DIR="$global:VIEW_DDL_DIR\log"


# ============================================================================
# レポートファイル定義
# ============================================================================
# プリンタ印刷フラグ
$global:PRINT_FLAG="OFF"
# プリンタドライバ
$global:PRINT_DRIVER="PQA4"
# バッチ処理レポート
$global:BATCH_REP_FILE_NAME="BATCH_REPORT.log"
# テーブルスペース空き容量レポート
$global:TBL_SPACE_REP_FILE_NAME="TBL_SPACE_REPORT.log"
# 月次データ受信レポート
$global:MONTHLY_DATA_REP_FILE_NAME="MONTHLY_DATA_REPORT.log"

# ============================================================================
# メッセージID定義
# ============================================================================
$global:INFO_MSG=1
$global:START_MSG=40
$global:NORMAL_END_MSG=41
$global:ERROR_END_MSG=45
$global:FILE_NOT_EXIST_MSG=51
$global:FILE_NOT_SEND_MSG=57
$global:UNMATCH_PARAMETER_COUNT_MSG=27
$global:UNMATCH_PARAMETER_COUNT=53
$global:COM_ERROR=55
$global:WARNINGL_END_MSG=56
$global:VIEW_SWITCH_ERROR=5105
$global:NOT_EXECUTE_DAY=1029
$global:EXECUTE_DAY=1030

# Add AZBK %01
$global:LOAD_EXCEED_ERR=5053
$global:LOAD_REFUSAL_WAN=5054
$global:LOAD_FAILURE=5059
$global:ERR_DUPLICATE=5104
$global:LOAD_ERROR_2026=5109


# ============================================================================
# レポートメッセージID定義
# ============================================================================
$global:REP_MSG_I=0
$global:REP_MSG_W=1
$global:REP_MSG_E=2


# ============================================================================
# 定例処理定義
# ============================================================================
# 未取引先顧客ファイル
$global:NO_DEAL_IMP_DATA="D_MITORIHIKI_IMP.dat"
$global:NO_DEAL_IMP_COUNT="K_MITORIHIKI_IMP.dat"
# 未取引先消込ファイル
$global:NO_DEAL_CLR_DATA="D_MITORIHIKI_CLR.dat"
$global:NO_DEAL_CLR_COUNT="K_MITORIHIKI_CLR.dat"
# EBMコールデータファイル
$global:EBM_DATA="D_EBM.dat"
$global:EBM_COUNT="K_EBM.dat"
# 未取引先抽出ファイル
$global:NO_DEAL_EXP_DATA="D_MITORIHIKI_EXP.dat"
$global:NO_DEAL_EXP_COUNT="K_MITORIHIKI_EXP.dat"

# ============================================================================
# HULFT送信定義
# ============================================================================
$global:HulftConfig="$global:EMB_HOME\file\HULFT.conf"
$global:FileIdLength=3
$global:ClassCRM="C"
$global:ClassHOST="H"
$global:ClassIB="I"
$global:FolderCRM="crm"
$global:FolderHOST="host"
$global:FolderIB="ib"

# ============================================================================
# 月次/週次/日次データ定義
# ============================================================================
# 月次配置完了ファイル(転送完了ファイル)
$global:MONTHLY_END_FILE="$global:EXT_LOAD_DIR\M_END.dat"
# 週次配置完了ファイル(転送完了ファイル)
$global:WEEKLY_END_FILE="$global:EXT_LOAD_DIR\W_END.dat"
# 日次配置完了ファイル(転送完了ファイル)
$global:DAILY_END_FILE="$global:EXT_LOAD_DIR\D_END.dat"

# 各データファイル名(拡張子なし)
$global:M_END_BASE="M_END"
$global:M_ADDRESS_BASE="M_Z07"              # 住所ファイル
$global:M_BANK_BASE="W_BBR"         # 全銀データ（金融機関支店ファイル）


$global:M_FOREIGN_BASE       ="D_KGS"       # 外貨預金ファイル
$global:M_FUND_BASE          ="D_Z05"       # 投信データファイル
$global:M_FUND_DETAIL_BASE   ="D_KTM"           # 投信明細データファイル
$global:M_PRODUCT_BASE       ="D_PRD"           # 商品ファイル

$global:M_CUSTOMER_BASE      ="D_ZKS"       # 顧客属性ファイル
$global:M_HOUSEHOLD_BASE     ="D_SZS"       # 世帯属性ファイル
$global:M_TERM_DEPOSIT_BASE    ="D_KKS"     # 定期性預金ファイル
$global:M_LIQUID_DEPOSIT_BASE  ="D_KRS"     # 流動性預金ファイル
# $global:M_DEBENTURE_BASE     ="D_KSS"     # 債券差分ファイル (1.0次にて 削除)
$global:M_PERSONNEL_BASE     ="D_JIF"       # 人事情報ファイル
$global:M_PROFILE_BASE       ="D_PRO"       # 顧客プロファイル
$global:M_BHISTORY_BASE      ="D_LGD"       # 営業店コンタクト履歴ファイル

$global:M_OPEINFO_BASE       ="S_IB1"       # オペレータ情報ファイル
# $global:M_CONTRACT_BASE      ="S_CZU"       # テレバン契約属性ファイル (1.0次にて 削除)
$global:M_CONTACT_BASE       ="S_LCU"       # コンタクト履歴ファイル
$global:M_TB_CONTRACT_BASE   ="S_TB1"       # テレバン契約情報ファイル (1.0次 追加)
$global:M_TB_ACCOUNT_BASE    ="S_TB2"       # テレバン契約口座情報ファイル (1.0次 追加)


# 未使用
$global:M_K_ZOKUSEI_BASE="M_K_ZOKUSEI"
$global:M_K_ZANDAKA_BASE="M_K_ZANDAKA"
$global:M_K_HENDO_BASE="M_K_HENDO"
$global:M_S_ZOKUSEI_BASE="M_S_ZOKUSEI"
$global:M_S_ZANDAKA_BASE="M_S_ZANDAKA"
$global:M_S_HENDO_BASE="M_S_HENDO"
$global:M_M_RYUDO_BASE="M_M_RYUDO"
$global:M_M_TEIKI_BASE="M_M_TEIKI"
$global:M_M_LOAN_BASE="M_M_LOAN"



# 各ビューDDL名(拡張子なし)
$global:SQL_VIEW_ADDRESS_BASE="view_tf_09"
$global:SQL_VIEW_JBANK_BASE="view_tmb_07"
$global:SQL_VIEW_FOREIGN_BASE="view_tf_05"
$global:SQL_VIEW_FUND_BASE="view_tf_07"
$global:SQL_VIEW_FUND_DETAIL_BASE="view_tf_08"
$global:SQL_VIEW_PRODUCT_BASE="view_tf_10"
$global:SQL_VIEW_CUSTOMER_BASE="view_tf_01"  # TF_顧客属性　(1.0次 追加)
$global:SQL_VIEW_HOUSEHOLD_BASE="view_tf_02"    # TF_世帯属性　(1.0次 追加)
$global:SQL_VIEW_TERM_DEPOSIT_BASE="view_tf_03"    # TF_個別明細固定性預金　(1.0次 追加)
$global:SQL_VIEW_LIQUID_DEPOSIT_BASE="view_tf_04"    # TF_個別明細流動性預金　(1.0次 追加)


# 未使用
$global:SQL_VIEW_KOKYAKU_BASE="view_tf_01"
$global:SQL_VIEW_LOAN_BASE=""


# ビュー識別子
$global:VIEW_A=1
$global:VIEW_B=2
$global:TABLE_SUFFIX_A="A"
$global:TABLE_SUFFIX_B="B"
# SQL*Loaderエラーコード
$global:LOADER_ERROR=1

#
# ビュー名称
#
$global:CUSTOMER_BASE_VIEWNAME   ="TF_顧客属性"                  # (1.0次 追加)
$global:HOUSEHOLD_BASE_VIEWNAME ="TF_世帯属性"                  # (1.0次 追加)
$global:TERM_DEPOSIT_BASE_VIEWNAME ="TF_個別明細固定性預金" 　  # (1.0次 追加)
$global:LIQUID_DEPOSIT_BASE_VIEWNAME ="TF_個別明細流動性預金"   # (1.0次 追加)

$global:ADDRESS_VIEWNAME="TF_住所"
$global:JBANK_VIEWNAME="TMB_全銀"
$global:JBANK_BASE_TBNAME ="TMB_銀行"
$global:JBANK_BASE_TBNAME2="TMB_支店"

$global:FOREIGN_VIEWNAME="TF_個別明細外貨預金"
$global:FUND_VIEWNAME="TF_個別明細投信口座"
$global:FUND_DETAIL_VIEWNAME="TF_個別明細投信口座明細"
$global:PRODUCT_VIEWNAME="TF_商品"

# $global:CUTOMER_BASE_TBNAME   ="TF_顧客属性"   (1.0次 VIEWに変更)
# $global:HOUSEHOLD_BASE_TBNAME ="TF_世帯属性"   (1.0次 VIEWに変更)
# $global:TERM_DEPOSIT_BASE_TBNAME ="TF_個別明細固定性預金"    (1.0次 VIEWに変更)
# $global:LIQUID_DEPOSIT_BASE_TBNAME ="TF_個別明細流動性預金"  (1.0次 VIEWに変更)
# $global:DEBENTURE_BASE_TBNAME ="TF_個別明細債券" (1.0次 削除)
$global:PERSONNEL_BASE_TBNAME ="TM_ユーザ"
$global:PROFILE_BASE_TBNAME ="TF_顧客プロファイル"
$global:BHISTROY_BASE_TBNAME ="TH_営業店履歴"



# ============================================================================
# 操作履歴バックアップ用定義
# ============================================================================
$global:AUDIT_OPE_DIR="$global:CLLOG_DIR\audit\opelog"
$global:OPE_BACKUP_FROM=0000
$global:OPE_BACKUP_TO=2300
$global:OPE_BACKUP_SLEEP=30
$global:OPE_EXP_BASE="$global:AUDIT_OPE_DIR\ope_history.dump"


$global:OPE_LOG_FILE="$global:TMP_DIR\ope_history.log"
$global:RETENTION_PERIOD=6

