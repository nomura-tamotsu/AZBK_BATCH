#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2020
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 本人確認資料登録参照処理
#
# FILE      : uy_transfer_image.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 20/07/13 | A.MIYAMOTO      | First Eddition
# %01 | 24/04/17 | A.MIYAMOTO      | NAS登録時のエラーレベルをinformationに変更
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
#[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [string]${PRM_ShoriKbn}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_InstanceName}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_FileName_1}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_FileName_2}="x"
)

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "本人確認資料登録参照処理"
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
# リトライ処理制御用変数
${LC_RETRY_COUNT} = 5
${LC_RETRY_WAIT}  = 1

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# NAS本人確認資料保存先フォルダ存在チェック処理
#--------------------------------------------
function LFC_NasDirExistCheckProcess
{
	${script:LOCAL_NAS_IMAGE_DIR} = ${COM_NAS_IMAGE_DIRS} -creplace "@@INSTANCENAME@@", ${PRM_InstanceName}
	if (!(Test-Path ${LOCAL_NAS_IMAGE_DIR})) {
		if (${PRM_ShoriKbn} -eq "regist") {
			# NAS→ローカル一時フォルダ登録時
			# %01 20240417　保守課題対応　START
			#${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			#outmsg 55 ${PRG_EXIT_CODE} "本人確認資料の保存先NAS[${LOCAL_NAS_IMAGE_DIR}]が参照できなかったためファイルを一時フォルダへ退避します。"
			outmsg 1 ${PRG_EXIT_CODE} "本人確認資料の保存先NAS[${LOCAL_NAS_IMAGE_DIR}]が参照できなかったためファイルを一時フォルダへ退避します。"
			# %01 20240417　保守課題対応　END
			FC_LogWriter 1 "本人確認資料の保存先NAS[${LOCAL_NAS_IMAGE_DIR}]が参照できなかったためファイルを一時フォルダへ退避します。"
			# NASへの転送失敗時処理
			LFC_NasTransferFailureProcess

		} elseIf(${PRM_ShoriKbn} -eq "reference") {
			# ローカル一時フォルダ→NAS登録時}
				${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
				outmsg 55 ${PRG_EXIT_CODE} "本人確認資料の保存先NAS[${LOCAL_NAS_IMAGE_DIR}]が参照できなかったため異常終了します。"
				FC_LogWriter 1 "本人確認資料の保存先NAS[${LOCAL_NAS_IMAGE_DIR}]が参照できなかったため異常終了します。"
				EndProcess
		}
	} else {
		if (${PRM_ShoriKbn} -eq "regist") {
			# 登録時のみ登録先のディレクトリ存在チェックを行い存在しない場合は作成する
			${script:LOCAL_OUT_DIR} = ${LOCAL_NAS_IMAGE_DIR} + "\" + ${script:LOCAL_RECEIPTDATE}
			if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
				try {
					FC_LogWriter 0 "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]を作成します。"
					New-Item ${script:LOCAL_OUT_DIR} -ItemType Directory 2>&1 > $null
					${ERR_CODE} = $?
				} catch [Exception] {
					FC_LogWriter 0 "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]の作成処理に失敗しました。"
					${ERR_CODE} = ${False}
				}
				if (!(${ERR_CODE})) {
					for ( ${i} = 1 ; ${i} -le ${LC_RETRY_COUNT} ; ${i}++ ) {
						if ( !${ERR_CODE} ) {
							Start-Sleep -s ${LC_RETRY_WAIT}
						} else {
							break
						}
						if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
							FC_LogWriter 0 "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]の作成をリトライします。"
							New-Item ${script:LOCAL_OUT_DIR} -ItemType Directory 2>&1 > $null
							${ERR_CODE} = $?
						} else {
							FC_LogWriter 0 "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]は別のプロセスにて作成されました。"
							${ERR_CODE} = ${True}
						}
					}
				}
				if (!(${ERR_CODE})) {
					# %01 20240417　保守課題対応　START
					#${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
					#outmsg 55 ${PRG_EXIT_CODE} "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]の作成に失敗した為異常終了します。"
					#FC_LogWriter 1 "本人確認資料の保存先ディレクトリ[${script:LOCAL_OUT_DIR}]の作成に失敗した為異常終了します。"
					#EndProcess
					outmsg 1 ${PRG_EXIT_CODE} "本人確認資料の保存先ディレクトリ[${LOCAL_OUT_DIR}]の作成に失敗した為、ファイルを一時フォルダへ退避します。"
					FC_LogWriter 1 "本人確認資料の保存先ディレクトリ[${LOCAL_OUT_DIR}]の作成に失敗した為、ファイルを一時フォルダへ退避します。"
					# NASへの転送失敗時処理
					LFC_NasTransferFailureProcess
					# %01 20240417　保守課題対応　END
				}
			}
		}
	}
}

#--------------------------------------------
# 必要ファイル・フォルダの存在チェック処理
#--------------------------------------------
function LFC_FileDirExistCheckProcess
{
	if (${PRM_ShoriKbn} -eq "regist") {
		# 転送対象ファイルのフルパスを作成
		${script:LOCAL_TMP_SAVING_DIR} = ${TMP_SAVING_DIR} -creplace "@@INSTANCENAME@@", ${PRM_InstanceName}
		${script:LOCAL_IN_FILE1} = ${LOCAL_TMP_SAVING_DIR} + "\" + ${PRM_FileName_1}
		if (${PRM_FileName_2} -ne "x") {
			${script:LOCAL_IN_FILE2} = ${LOCAL_TMP_SAVING_DIR} + "\" + ${PRM_FileName_2}
		} else {
			${script:LOCAL_IN_FILE2} = "x"
		}
		# 転送対象ファイルのチェック
		if (!(Test-Path ${script:LOCAL_IN_FILE1})) {
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			outmsg 55 ${PRG_EXIT_CODE} "転送対象ファイル[${script:LOCAL_IN_FILE1}]が存在しない為異常終了します。"
			FC_LogWriter 1 "転送対象ファイル[${script:LOCAL_IN_FILE1}]が存在しない為異常終了します。"
			EndProcess
		}
		if (${PRM_FileName_2} -ne "x") {
			if (!(Test-Path ${script:LOCAL_IN_FILE2})) {
				${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
				outmsg 55 ${PRG_EXIT_CODE} "転送対象ファイル[${script:LOCAL_IN_FILE2}]が存在しない為異常終了します。"
				FC_LogWriter 1 "転送対象ファイル[${script:LOCAL_IN_FILE2}]が存在しない為異常終了します。"
				EndProcess
			}
		}
		# 転送先ファイルのフルパスを作成
		${script:LOCAL_OUT_FILE1} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_FileName_1}
		if (${PRM_FileName_2} -ne "x") {
			${script:LOCAL_OUT_FILE2} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_FileName_2}
		} else {
			${script:LOCAL_OUT_FILE2} = "x"
		}
	
	} elseif (${PRM_ShoriKbn} -eq "reference") {
		# 転送先ディレクトリのフルパスを作成
		${script:LOCAL_OUT_DIR} = ${TMP_REFERENCE_DIR} -creplace "@@INSTANCENAME@@", ${PRM_InstanceName}
		# 転送対象ファイルのフルパスを作成
		${script:LOCAL_IN_FILE1} = ${LOCAL_NAS_IMAGE_DIR}  + "\" + ${script:LOCAL_RECEIPTDATE} + "\" + ${PRM_FileName_1}
		if (${PRM_FileName_2} -ne "x") {
			${script:LOCAL_IN_FILE2} = ${LOCAL_NAS_IMAGE_DIR} + "\" + ${script:LOCAL_RECEIPTDATE} + "\" + ${PRM_FileName_2}
		} else {
			${script:LOCAL_IN_FILE2} = "x"
		}
		# 転送先ディレクトリのチェック
		if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			outmsg 55 ${PRG_EXIT_CODE} "転送先ディレクトリ[${script:LOCAL_OUT_DIR}]が存在しない為異常終了します。"
			FC_LogWriter 1 "転送先ディレクトリ[${script:LOCAL_OUT_DIR}]が存在しない為異常終了します。"
			EndProcess
		}
		# 転送対象ファイルのチェック
		if (!(Test-Path ${script:LOCAL_IN_FILE1})) {
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			outmsg 55 ${PRG_EXIT_CODE} "転送対象ファイル[${script:LOCAL_IN_FILE1}]が存在しない為異常終了します。"
			FC_LogWriter 1 "転送対象ファイル[${script:LOCAL_IN_FILE1}]が存在しない為異常終了します。"
			EndProcess
		}
		if (${PRM_FileName_2} -ne "x") {
			if (!(Test-Path ${script:LOCAL_IN_FILE2})) {
				${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
				outmsg 55 ${PRG_EXIT_CODE} "転送対象ファイル[${script:LOCAL_IN_FILE2}]が存在しない為異常終了します。"
				FC_LogWriter 1 "転送対象ファイル[${script:LOCAL_IN_FILE2}]が存在しない為異常終了します。"
				EndProcess
			}
		}
		# 転送先ファイルのフルパスを作成
		${script:LOCAL_OUT_FILE1} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_FileName_1}
		if (${PRM_FileName_2} -ne "x") {
			${script:LOCAL_OUT_FILE2} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_FileName_2}
		} else {
			${script:LOCAL_OUT_FILE2} = "x"
		}
	}
}

#--------------------------------------------
# NAS←→一時フォルダ間のファイルコピー処理
#--------------------------------------------
function LFC_NasLocalFileCopyProcess  ( [boolean] ${LOCAL_EVACUATION_FLG} )
{
	try {
		FC_LogWriter 0 "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]を[${script:LOCAL_OUT_FILE1}]にコピーします。"
		Copy-Item ${script:LOCAL_IN_FILE1} ${script:LOCAL_OUT_FILE1} -Recurse
		${ERR_CODE} = $?
		if ((${ERR_CODE}) -and (${script:LOCAL_IN_FILE2} -ne "x")) {
			FC_LogWriter 0 "本人確認資料ファイル[${script:LOCAL_IN_FILE2}]を[${script:LOCAL_OUT_FILE2}]にコピーします。"
			Copy-Item ${script:LOCAL_IN_FILE2} ${script:LOCAL_OUT_FILE2} -Recurse
			${ERR_CODE} = $?
		}
	} catch [Exception] {
		FC_LogWriter 0 "本人確認資料ファイルのコピー処理に失敗しました。"
		${ERR_CODE} = ${False}
	}
	if (!(${ERR_CODE})) {
		for ( ${i} = 1 ; ${i} -le ${LC_RETRY_COUNT} ; ${i}++ ) {
			if ( !${ERR_CODE} ) {
				Start-Sleep -s ${LC_RETRY_WAIT}
			} else {
				break
			}
			FC_LogWriter 0 "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]を[${script:LOCAL_OUT_FILE1}]へのコピー処理をリトライします。"
			Copy-Item ${script:LOCAL_IN_FILE1} ${script:LOCAL_OUT_FILE1} -Recurse
			${ERR_CODE} = $?
			if ((${ERR_CODE}) -and (${script:LOCAL_IN_FILE2} -ne "x")) {
				FC_LogWriter 0 "本人確認資料ファイル[${script:LOCAL_IN_FILE2}]を[${script:LOCAL_OUT_FILE2}]へのコピー処理をリトライします。"
				Copy-Item ${script:LOCAL_IN_FILE2} ${script:LOCAL_OUT_FILE2} -Recurse
				${ERR_CODE} = $?
			}
		}
	}
	if (!(${ERR_CODE})) {
		if (${PRM_ShoriKbn} -eq "regist" -and ${LOCAL_EVACUATION_FLG} ) {
			# %01 20240417　保守課題対応　START
			#${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			# %01 20240417　保守課題対応　END
			if (${PRM_FileName_2} -ne "x") {
				# %01 20240417　保守課題対応　START
				#outmsg 55 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]のNAS転送に失敗した為ファイルを一時フォルダへ退避します。"
				outmsg 1 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]のNAS転送に失敗した為ファイルを一時フォルダへ退避します。"
				# %01 20240417　保守課題対応　END
				FC_LogWriter 1 "本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]のNAS転送に失敗した為ファイルを一時フォルダへ退避します。"
			} else {
				# %01 20240417　保守課題対応　START
				#outmsg 55 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]のNAS転送に失敗した為ファイルを一時フォルダへ退避します。"
				outmsg 1 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]のNAS転送に失敗した為ファイルを一時フォルダへ退避します。"
				# %01 20240417　保守課題対応　END
				FC_LogWriter 1 "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]のNAS転送に失敗した為ファイルを一時フォルダへ退避します。"
			}
			# NASへの転送失敗時処理
			LFC_NasTransferFailureProcess
			
		} elseif (${PRM_ShoriKbn} -eq "reference" -or !(${LOCAL_EVACUATION_FLG}) ) {
			${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
			if (${PRM_FileName_2} -ne "x") {
				outmsg 55 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]のコピーに失敗した為異常終了します。"
				FC_LogWriter 1 "本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]のコピーに失敗した為異常終了します。"
			} else {
				outmsg 55 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]のコピーに失敗した為異常終了します。"
				FC_LogWriter 1 "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]のコピーに失敗した為異常終了します。"
			}
			EndProcess
		}
	}
}

#--------------------------------------------
# 転送対象ファイル削除処理
#--------------------------------------------
function LFC_InFileDeleteProcess
{
	try {
		FC_LogWriter 0 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE1}]を削除します。"
		Remove-Item ${script:LOCAL_IN_FILE1} -Recurse 2>&1 > $null
		${ERR_CODE} = $?
		if ((${ERR_CODE}) -and (${script:LOCAL_IN_FILE2} -ne "x")) {
			FC_LogWriter 0 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE2}]を削除します。"
			Remove-Item ${script:LOCAL_IN_FILE2} -Recurse 2>&1 > $null
			${ERR_CODE} = $?
		}
	} catch [Exception] {
		FC_LogWriter 0 "一時フォルダの本人確認資料ファイルの削除処理に失敗しました。"
		${ERR_CODE} = ${False}
	}
	if (!(${ERR_CODE})) {
		for ( ${i} = 1 ; ${i} -le ${LC_RETRY_COUNT} ; ${i}++ ) {
			if ( !${ERR_CODE} ) {
				Start-Sleep -s ${LC_RETRY_WAIT}
			} else {
				break
			}
			FC_LogWriter 0 "一時フォルダの本人確認資料ファイルの削除処理をリトライします。"
			if ((Test-Path ${script:LOCAL_IN_FILE1})) {
				FC_LogWriter 0 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE1}]の削除処理をリトライします。"
				Remove-Item ${script:LOCAL_IN_FILE1} -Recurse 2>&1 > $null
				${ERR_CODE} = $?
			} else {
				FC_LogWriter 0 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE1}]は別のプロセスにて削除されました。"
				${ERR_CODE} = ${True}
			}
			if ((${ERR_CODE}) -and (${script:LOCAL_IN_FILE2} -ne "x")) {
				if ((Test-Path ${script:LOCAL_IN_FILE2})) {
					FC_LogWriter 0 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE2}]の削除処理をリトライします。"
					Remove-Item ${script:LOCAL_IN_FILE2} -Recurse 2>&1 > $null
					${ERR_CODE} = $?
				} else {
					FC_LogWriter 0 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE2}]は別のプロセスにて削除されました。"
					${ERR_CODE} = ${True}
				}
			}
		}
	}
	if (!(${ERR_CODE})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		if (${PRM_FileName_2} -ne "x") {
			outmsg 55 ${PRG_EXIT_CODE} "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]の削除に失敗した為異常終了します。"
			FC_LogWriter 1 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]の削除に失敗した為異常終了します。"
		} else {
			outmsg 55 ${PRG_EXIT_CODE} "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE1}]の削除に失敗した為異常終了します。"
			FC_LogWriter 1 "一時フォルダの本人確認資料ファイル[${script:LOCAL_IN_FILE1}]の削除に失敗した為異常終了します。"
		}
		EndProcess
	}
}


#--------------------------------------------
# NASへの転送失敗時処理
#--------------------------------------------
function LFC_NasTransferFailureProcess
{
	# 保存先ディレクトリをNAS転送失敗時の一時フォルダに変更
	${script:LOCAL_OUT_DIR} = ${TMP_FAILURES_DIR}  -creplace "@@INSTANCENAME@@", ${PRM_InstanceName}
	# 転送先ディレクトリのチェック
	if (!(Test-Path ${script:LOCAL_OUT_DIR})) {
		${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
		outmsg 55 ${PRG_EXIT_CODE} "転送先ディレクトリ[${script:LOCAL_OUT_DIR}]が存在しない為異常終了します。"
		FC_LogWriter 1 "転送先ディレクトリ[${script:LOCAL_OUT_DIR}]が存在しない為異常終了します。"
		EndProcess
	}
	# 必要ファイル・フォルダの存在チェック処理呼び出し
	LFC_FileDirExistCheckProcess
	# NAS←→一時フォルダ間のファイルコピー処理
	LFC_NasLocalFileCopyProcess ($FALSE)
	# 転送対象ファイル削除処理（regist処理のみ）
	LFC_InFileDeleteProcess
	
	# %01 20240417　保守課題対応　START
	#${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	# %01 20240417　保守課題対応　END
	if (${PRM_FileName_2} -ne "x") {
		# %01 20240417　保守課題対応　START
		#outmsg 55 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]のNAS転送に失敗した為ファイルを一時フォルダ[${script:LOCAL_OUT_DIR}]へ退避しました。"
		outmsg 1 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]のNAS転送に失敗した為ファイルを一時フォルダ[${script:LOCAL_OUT_DIR}]へ退避しました。"
		# %01 20240417　保守課題対応　END
		FC_LogWriter 1 "本人確認資料ファイル[${script:LOCAL_IN_FILE1}][${script:LOCAL_IN_FILE2}]のNAS転送に失敗した為ファイルを一時フォルダ[${script:LOCAL_OUT_DIR}]へ退避しました。"
	} else {
		# %01 20240417　保守課題対応　START
		#outmsg 55 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]のNAS転送に失敗した為ファイルを一時フォルダ[${script:LOCAL_OUT_DIR}]へ退避しました。"
		outmsg 1 ${PRG_EXIT_CODE} "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]のNAS転送に失敗した為ファイルを一時フォルダ[${script:LOCAL_OUT_DIR}]へ退避しました。"
		# %01 20240417　保守課題対応　END
		FC_LogWriter 1 "本人確認資料ファイル[${script:LOCAL_IN_FILE1}]のNAS転送に失敗した為ファイルを一時フォルダ[${script:LOCAL_OUT_DIR}]へ退避しました。"
	}
	EndProcess
}

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
#--------------------------------------------
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# 処理区分
if (${PRM_ShoriKbn} -ne "regist" -and ${PRM_ShoriKbn} -ne "reference") {
	${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	outmsg 55 ${PRG_EXIT_CODE} "処理区分に誤りがある為異常終了します。"
	FC_LogWriter 1 "処理区分に誤りがある為異常終了します。"
	EndProcess
}
# インスタンス名
if (${PRM_InstanceName} -ne "brtabazb" -and ${PRM_InstanceName} -ne "brtabtrn") {
	${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	outmsg 55 ${PRG_EXIT_CODE} "インスタンス名に誤りがある為異常終了します。"
	FC_LogWriter 1 "インスタンス名に誤りがある為異常終了します。"
	EndProcess
}
# ファイル名1
if (${PRM_FileName_1} -eq "x") {
	${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	outmsg 55 ${PRG_EXIT_CODE} "ファイル名の指定に誤りがある為異常終了します。"
	FC_LogWriter 1 "ファイル名の指定に誤りがある為異常終了します。"
	EndProcess
} elseIf(${PRM_FileName_1}.Length -le 9) {
	${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
	outmsg 55 ${PRG_EXIT_CODE} "ファイル名の指定に誤りがある為異常終了します。"
	FC_LogWriter 1 "ファイル名の指定に誤りがある為異常終了します。"
	EndProcess
} else {
	# 受付日付
	${script:LOCAL_RECEIPTDATE} = ${PRM_FileName_1}.Substring(0, 6)
}

#--------------------------------------------
# NAS本人確認資料保存先フォルダ存在チェック
#--------------------------------------------
LFC_NasDirExistCheckProcess

#--------------------------------------------
# 必要ファイル・フォルダの存在チェック処理
#--------------------------------------------
LFC_FileDirExistCheckProcess

#--------------------------------------------
# NAS←→一時フォルダ間のファイルコピー処理
#--------------------------------------------
LFC_NasLocalFileCopyProcess ($TRUE)

#--------------------------------------------
# 転送対象ファイル削除処理（regist処理のみ）
#--------------------------------------------
if (${PRM_ShoriKbn} -eq "regist") {
	LFC_InFileDeleteProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
