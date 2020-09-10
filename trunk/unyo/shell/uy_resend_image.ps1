#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2020
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 本人確認資料再送処理
#
# FILE      : uy_resend_image.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 20/07/20 A.MIYAMOTO      | First Eddition
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "本人確認資料再送処理"
${PRG_EXIT_CODE}    = 0
#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${LOG_FLAG}         = 1
${ACT_TIME}         = Get-Date -format "${COM_DATEFORM03}"
${ACT_FILE}         = "${UNYO_LOG_ACTOUTDIR}/${MOD_NAME}.log.${ACT_TIME}"

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# 必要フォルダの存在チェック処理
#--------------------------------------------
function LFC_DirExistCheckProcess
{
	# 処理対象のフォルダのパス
	${script:LOCAL_IN_DIR} = ${TMP_FAILURES_DIR} -creplace "@@INSTANCENAME@@", ${script:LOCAL_INSTANCE_DIR_NAME}
	# 処理対象フォルダの存在チェック
	if (!(Test-Path ${script:LOCAL_IN_DIR})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "本人確認資料の転送対象フォルダ[${script:LOCAL_IN_DIR}]が存在しない為異常終了します。"
		FC_LogWriter 1 "本人確認資料の転送対象フォルダ[${script:LOCAL_IN_DIR}]が存在しない為異常終了します。"
		EndProcess
	}
	
	# 転送先のIMAGEフォルダのパス
	${script:LOCAL_NAS_IMAGE_DIRS} = ${COM_NAS_IMAGE_DIRS} -creplace "@@INSTANCENAME@@", ${script:LOCAL_INSTANCE_DIR_NAME}
	# 処理対象フォルダの存在チェック
	if (!(Test-Path ${script:LOCAL_NAS_IMAGE_DIRS})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "本人確認資料の転送先フォルダ[${script:LOCAL_NAS_IMAGE_DIRS}]が存在しない為異常終了します。"
		FC_LogWriter 1 "本人確認資料の転送先フォルダ[${script:LOCAL_NAS_IMAGE_DIRS}]が存在しない為異常終了します。"
		EndProcess
	}
}

#-------------------------------------------------------
# NAS本人確認資料保存先フォルダ存在チェック及び生成処理
#-------------------------------------------------------
function LFC_NasDirExistCheckProcess
{
	if($LOCAL_IN_FILE.PSIsContainer) {
		# フォルダの場合の処理(何もしない)
	} else {
		# ファイルの場合の処理
		if(${LOCAL_IN_FILE}.Name.Length -le 9) {
			# ファイル名の文字長が9文字以下の場合エラー「XXXXXX.jpg」以下だと受付日付を取得する際にエラーとなるため
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			outmsg 55 ${PRG_EXIT_CODE} "ファイル[$LOCAL_IN_FILE]の名称が不正な為異常終了します。"
			FC_LogWriter 1 "ファイル[$LOCAL_IN_FILE]の名称が不正な為異常終了します。"
			EndProcess
		} else {
			# 受付日付
			${script:LOCAL_RECEIPTDATE} = ${LOCAL_IN_FILE}.Name.Substring(0, 6)
		}
		# 転送先フォルダのパス
		${script:LOCAL_OUT_DIR} = ${LOCAL_NAS_IMAGE_DIRS} + "\" + ${script:LOCAL_RECEIPTDATE}
		if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
			try {
				# 転送先フォルダが存在しない場合作成
				FC_LogWriter 0 "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]を作成します。"
				New-Item ${script:LOCAL_OUT_DIR} -ItemType Directory 2>&1 > $null
				${ERR_CODE} = $?
			} catch [Exception] {
				${ERR_CODE} = ${False}
			}
			if (!(${ERR_CODE})) {
				${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
				outmsg 55 ${PRG_EXIT_CODE} "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]の作成に失敗した為異常終了します。"
				FC_LogWriter 1 "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]の作成に失敗した為異常終了します。"
				EndProcess
			}
		}
	}
}


#--------------------------------------------
# 対象ファイルのコピー処理
#--------------------------------------------
function LFC_NasLocalFileCopyProcess
{
		
	# 対象ファイルパス作成
	${script:LOCAL_IN_FILE} = ${script:LOCAL_IN_DIR} + "\" + ${LOCAL_IN_FILE}.Name
	# 転送先ファイルパス作成
	${script:LOCAL_OUT_FILE} = ${script:LOCAL_OUT_DIR} + "\" + ${LOCAL_IN_FILE}.Name
		
	try {
		FC_LogWriter 0 "本人確認資料ファイル[${script:LOCAL_IN_FILE}]をNAS保存先[${script:LOCAL_OUT_FILE}]にコピーします。"
		Copy-Item ${script:LOCAL_IN_FILE} ${script:LOCAL_OUT_FILE} -Recurse
		${ERR_CODE} = $?
	} catch [Exception] {
		${ERR_CODE} = ${False}
	}
	if (!(${ERR_CODE})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE}]のコピーに失敗した為異常終了します。"
		FC_LogWriter 1 "本人確認資料ファイル[${script:LOCAL_IN_FILE}]のコピーに失敗した為異常終了します。"
		EndProcess
	}
}


#--------------------------------------------
# 転送対象ファイル削除処理
#--------------------------------------------
function LFC_InFileDeleteProcess
{
	try {
		FC_LogWriter 0 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE}]を削除します。"
		Remove-Item ${script:LOCAL_IN_FILE} -Recurse 2>&1 > $null
		${ERR_CODE} = $?
	} catch [Exception] {
		${ERR_CODE} = ${False}
	}
	if (!(${ERR_CODE})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE}]の削除に失敗した為異常終了します。"
		FC_LogWriter 1 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE}]の削除に失敗した為異常終了します。"
		EndProcess
	}
}


#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
#--------------------------------------------
InitProcess

# 処理対象フォルダを取得（brtabazb,brtabtrn）
${script:LOCAL_INSTANCE_DIR_NAMES} = ${INSTANCE_DIR_NAMES} -split ","

# 処理対象となるフォルダ分ループ
foreach(${script:LOCAL_INSTANCE_DIR_NAME} in ${script:LOCAL_INSTANCE_DIR_NAMES} ) {
	# 必要フォルダの存在チェック処理
	LFC_DirExistCheckProcess
	
	# 対象フォルダ内ファイル・フォルダのリストを取得する。
	${script:LOCAL_IN_FILES}  = Get-ChildItem ${script:LOCAL_IN_DIR}
	
	# 処理対象となるファイル分ループ
	foreach(${script:LOCAL_IN_FILE} in ${script:LOCAL_IN_FILES} ) {
		# NAS本人確認資料保存先フォルダ存在チェック及び生成処理
		LFC_NasDirExistCheckProcess
		
		# 対象ファイルのコピー処理
		LFC_NasLocalFileCopyProcess
		
		# 対象ファイルの削除処理
		LFC_InFileDeleteProcess
	}
} 


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
