#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK-R CC
#
# FILE      : Common Parametes
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Edition
# %01 | 17/02/01 | R.YAMANO      | 保守対応-ログメンテナンス機能改善対応
# %02 | 18/12/05 | K.TAKEICHI    | NASストレージ更改対応
# %03 | 20/07/22 | A.MIYAMOTO    | 本人確認資料保管対応
#============================================================================
#
# ディレクトリ定義
#
# 運用ログディレクトリ
${global:UNYO_DRIVE}   = "D:"
${global:UNYO_MOD_DIR} = "${UNYO_HOME}\shell"
${global:UNYO_DEF_DIR} = "${UNYO_HOME}\shell\def"
${global:UNYO_TMP_DIR} = "${UNYO_HOME}\tmp"
${global:UNYO_FIL_DIR} = "${UNYO_HOME}\file"
${global:UNYO_WRK_DIR} = "${UNYO_HOME}\work"
${global:UNYO_LOG_DIR} = "${UNYO_DRIVE}\logfile\unyo\azbk"
${global:CLUNYO_WORK_DIR} = "${UNYO_WRK_DIR}"
${global:BACKUP_UNYO_LOG_TMP_DIR} = "${CLUNYO_WORK_DIR}\log"
#${global:UNYO_COLLECT_BASE_DIR} = "${UNYO_DRIVE}\work\log"
${global:UNYO_COLLECT_BASE_DIR} = "${UNYO_DRIVE}\logfile"
${global:UNYO_COLLECT_PKG_BANK_R_DIR} = "${UNYO_COLLECT_BASE_DIR}\BANKR"
${global:UNYO_COLLECT_EVENT_LOGS_DIR} = "${UNYO_COLLECT_BASE_DIR}\event"
${global:UNYO_COLLECT_IHS_ACCESS_DIR} = "${UNYO_COLLECT_BASE_DIR}\IHS"
${global:UNYO_COLLECT_IHS_ERRORS_DIR} = "${UNYO_COLLECT_BASE_DIR}\IHS"
#${global:UNYO_DB_FLBKUP_DIR} = "G:\DBBackup\brccazbk\"
${global:UNYO_DB_FLBKUP_DIR} = "G:\BEData\"
${global:UNYO_DB_EXTSND_DIR} = "E:\extdata\snd"
${global:UNYO_DB_EXTRCV_DIR} = "E:\extdata\rcv"
${global:UNYO_DB_EXTSND_BKD} = "${UNYO_DB_EXTSND_DIR}\backup"
${global:UNYO_DB_EXTRCV_BKD} = "${UNYO_DB_EXTRCV_DIR}\backup"
${global:UNYO_SQL_FLBKUP_DIR} = "D:\SQLBackup\"
# 本人確認資料転送用一時ディレクトリ
${global:TMP_REFERENCE_DIR} = "D:\BANKR_CC\image\@@INSTANCENAME@@\reference"
${global:TMP_SAVING_DIR} = "D:\BANKR_CC\image\@@INSTANCENAME@@\saving"
${global:TMP_FAILURES_DIR} = "D:\BANKR_CC\image\@@INSTANCENAME@@\failures"
# 本人確認資料転送用一時ディレクトリ内インスタンスディレクトリ名
${global:INSTANCE_DIR_NAMES} = "brtabazb,brtabtrn"

#----------------------------------------------------------------------
# DATE FORMAT PATTERN
#----------------------------------------------------------------------
${global:COM_DATEFORM00} = "yyyy/MM/dd HH:mm:ss"
${global:COM_DATEFORM01} = "yy/MM/dd HH:mm:ss"
${global:COM_DATEFORM02} = "yyyy/MM/dd"
${global:COM_DATEFORM03} = "yyyyMMddHHmmss"
${global:COM_DATEFORM04} = "yyyyMMdd_HHmmss"
${global:COM_DATEFORM05} = "yyyy-MM-dd"
${global:COM_DATEFORM06} = "yy-MM-dd"
${global:COM_DATEFORM07} = "yyyy_MM_dd"
${global:COM_DATEFORM08} = "yyyyMMdd"
${global:COM_DATEFORM09} = "yyyyMM"
${global:COM_DATEFORM10} = "HH:mm:ss"
${global:COM_DATEFORM11} = "HHmm"
${global:COM_DATEFORM12} = "yyyy-M-d"
${global:COM_DATEFORM13} = "yyyy_M_d"


#----------------------------------------------------------------------
# LOG WRITER COMMAND
#----------------------------------------------------------------------
${global:COM_DEF_MSGL}       = "MSG file read error or invalid MSGNO."
${global:COM_MSG_FILE}       = "${UNYO_HOME}\file\msg_file"
${global:UNYO_LOG_BASE_FILE} = "${UNYO_LOG_DIR}\error.log"
${global:UNYO_LOG_DAYS_FILE} = "${UNYO_LOG_DIR}\err_"
${global:UNYO_LOG_ACTOUTDIR} = "${UNYO_LOG_DIR}\actlog"


#----------------------------------------------------------------------
# SERVER INFOMATION
#----------------------------------------------------------------------
${global:HOST_NAME} =  hostname
${global:HOST_NMLO} =  hostname | %{ $_.ToLower() }
${global:HOST_TYPE} =  hostname | %{ $_.Substring(6,2).ToUpper() }
${global:USER_NAME} =  ${ENV:USER}

#----------------------------------------------------------------------
# INITIAL PARAMETER
#----------------------------------------------------------------------
${global:DEF_RTNCD_NML} = 0
${global:DEF_RTNCD_ERR} = 9

# 処理待機時間(秒)
${global:COM_WAIT_TIME} = 5
# ループ処理回数
${global:COM_ROOP_CNTS} = 12

# 前日日付ファイル
${global:YESTERDAY_FILE} = "${UNYO_WRK_DIR}\yesterday.date"
# 運用日付ファイル
${global:UNYOUDAYS_FILE} = "${UNYO_WRK_DIR}\unyo.date"


#----------------------------------------------------------------------
# DEFINITION FILE
#----------------------------------------------------------------------
# リネームファイル定義
${RENAME_FILE_DEF}      = "${UNYO_DEF_DIR}\RENAME_LOG_DEF_${HOST_TYPE}.cfg"
# 不要ファイル削除定義
${DELETE_FILE_DEF}      = "${UNYO_DEF_DIR}\DELETE_LOG_DEF_${HOST_TYPE}.cfg"
# 各種ログバックアップ定義
${BACKUP_OTHER_LOG_DEF} = "${UNYO_DEF_DIR}\BACKUP_OTHER_LOG_DEF_${HOST_TYPE}.cfg"
# 監査ログバックアップ定義
${BACKUP_AUDIT_LOG_DEF} = "${UNYO_DEF_DIR}\BACKUP_AUDIT_LOG_DEF_${HOST_TYPE}.cfg"
# DBフルバックアップ転送
#${DBBKUP_DATA_FILE_DEF} = "${UNYO_DEF_DIR}\DBBKUP_DATA_FILE_DEF_${HOST_TYPE}.cfg"
# 配信ファイルメンテナンス
${SENDNM_FILE_DEF}      = "${UNYO_DEF_DIR}\HULFT_SEND_FILE_DEF_${HOST_TYPE}.cfg"
#----------------------------------------------------------------------
# バックアップリラン用定義
# 各種ログバックアップ処理失敗リスト定義
${FAIL_BACKUP_OTHER_LOG_DEF} = "${UNYO_WRK_DIR}\TMP_BACKUP_OTHER_LOG_DEF_${HOST_TYPE}.cfg"
# メンテ用各種ログバックアップ処理失敗リスト定義
${LOGBACKUP_OTHER_RERUN_LST} = "${UNYO_WRK_DIR}\MNT_LOGBACKUP_OTHER_RERUN.lst"
# メンテ用各種ログバックアップ処理失敗リスト定義(TMP)
${LOGBACKUP_OTHER_RERUN_LST_TMP} = "${UNYO_WRK_DIR}\TMP_MNT_LOGBACKUP_OTHER_RERUN.lst"
# 監査ログバックアップ処理リスト定義
${FAIL_BACKUP_AUDIT_LOG_DEF} = "${UNYO_WRK_DIR}\TMP_BACKUP_AUDIT_LOG_DEF_${HOST_TYPE}.cfg"
# メンテ用監査ログバックアップ処理失敗リスト定義
${LOGBACKUP_AUDIT_RERUN_LST} = "${UNYO_WRK_DIR}\MNT_LOGBACKUP_AUDIT_RERUN.lst"
# メンテ用監査ログバックアップ処理失敗リスト定義(TMP)
${LOGBACKUP_AUDIT_RERUN_LST_TMP} = "${UNYO_WRK_DIR}\TMP_MNT_LOGBACKUP_AUDIT_RERUN.lst"
# バックアップリトライ回数上限値(閾値)
${COM_LOGBAKUP_RETRYCOUNT} = 30

#----------------------------------------------------------------------
# EVENT LOG
#----------------------------------------------------------------------
# イベントログ種別
${global:COM_EVNTYPE} = "Security","Application","System"
# イベントログ出力ファイルフォーム(event_sec_運用日付.log)
${global:COM_EVENT_LOGFILE} = "event_sec","event_apl","event_sys"
# 最大取得日数
${global:COM_EVENT_LOGDAYS} = 7
# イベントログ作成履歴ファイル
${global:COM_EVENT_CKDATE_FILE} = "${UNYO_WRK_DIR}\CKDate_EventLog.flg"

#----------------------------------------------------------------------
# CLUSTER INFO
#----------------------------------------------------------------------
# CLUSTER VIRTUAL HOST (SERVICE HOST)
${global:COM_DBSV_VHOST}  = "fcctbsdbpw01"
# MSFC Cluster Resorce Group
${global:COM_CLST_RSGP01} = "FCCTBSDBPW01"
${global:COM_CLST_FCOUNT} = 120
# 処理待機時間(秒)
${global:COM_CLWT_TIME}   = 10
# ループ処理回数
${global:COM_CLRP_CNTS}   = 18

#----------------------------------------------------------------------
# NAS Strage INFO
#----------------------------------------------------------------------
# NAS 本番
#${global:COM_NAS_HOST_NAME}  = "fccnasdds01-wx"
${global:COM_NAS_HOST_NAME}  = "fccnasdds11-bw"
${global:COM_NAS_BASE_DIRS}  = "\\${COM_NAS_HOST_NAME}\dd_tbs_pw"
# NAS 開発
#${global:COM_NAS_HOST_NAME}  = "fccnasdds01-wx"
#${global:COM_NAS_BASE_DIRS}  = "\\${COM_NAS_HOST_NAME}\dd_tbs_dw"
# NAS 転送
# 処理待機時間(秒)
${global:COM_NASWT_TIME}   = 60
# ループ処理回数
${global:COM_NASLP_CNTS}   = 60
# 本人確認資料保存先ディレクトリ
${global:COM_NAS_IMAGE_DIRS}  = "${global:COM_NAS_BASE_DIRS}\Image\@@INSTANCENAME@@"

#----------------------------------------------------------------------
# SERVICE NAME
#----------------------------------------------------------------------
# IBM WebSphere Application Server V8.5
${global:COM_SVCNAME_WASV85} = "IBMWAS85Service - @@SVRNM@@_brccazbk"
# IBM HTTP Server V8.5
${global:COM_SVCNAME_IHSADM} = "IBMHTTPAdministrationforWebSphereApplicationServerV8.5brccazbk"
${global:COM_SVCNAME_IHSV85} = "IBMHTTPServer8.5brccazbk"
# IBM WebSphere MQ V7.5
${global:COM_SVCNAME_MQSV75} = "MQ_Installation1"
# HULFT
${global:COM_SVCNAME_HULFTS} = "HULFT"
# Oracle Instance
${global:COM_SVCNAME_ORAINS_HONBAN} = "OracleServiceBRCCAZBK"
${global:COM_SVCNAME_ORALSN_HONBAN} = "OracleOraDb11g_home1TNSListenerFslfcctbsdbpw01"
${global:COM_SVCNAME_ORAINS_TRAING} = "OracleServiceBRCCAZBK"
${global:COM_SVCNAME_ORALSN_TRAING} = "OracleOraDb11g_home1TNSListenerFslfcctbsdbpw01"

#----------------------------------------------------------------------
# BackupExec INFO
#----------------------------------------------------------------------
# DB Backup JOB
${global:COM_FULLBKUP_JOBS} = "DB_Backup-Full"
# DB Backup JOB ACTION FLAG
${global:COM_FULLBKUP_FLAG} = "DB_Backup-Full_END.flg"

#----------------------------------------------------------------------
# WAS JAVA COMMAND
#----------------------------------------------------------------------
# WAS BASE
${global:COM_WAS_BASE_DIRS} = "D:\Product\IBM\WebSphere\AppServer"
${global:COM_WAS_BASE_URLS} = "D:/Product/IBM\WebSphere/AppServer"
# Java 1.7 
${global:COM_WAS_CMND_JAVA} = "${COM_WAS_BASE_DIRS}\java_1.7_64\bin\java"

