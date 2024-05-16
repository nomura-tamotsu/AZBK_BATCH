#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2020
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : 本人確認資料タスクスケジューラ起動処理
#
# FILE      : uy_transfer_image.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 20/10/09 | A.MIYAMOTO      | First Eddition
# %01 | 24/04/17 | A.MIYAMOTO      | 参照時のタイムアウト値を20秒から60秒へ変更
#============================================================================

#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
#[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [string]${PRM_1}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_2}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_3}="x",
    [Parameter(Mandatory=$false)]
    [string]${PRM_4}="x"
)

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
# リトライ処理制御用変数
# %01 20240417　保守課題対応　START
#${LC_RETRY_COUNT} = 20
${LC_RETRY_COUNT} = 60
# %01 20240417　保守課題対応　END
${LC_RETRY_WAIT}  = 1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
#--------------------------------------------
# タスクスケジューラのサービス取得
$TaskService = New-Object -ComObject schedule.service
# タスクスケジューラのサービス接続
$TaskService.Connect()
# タスクスケジューラのジョブフォルダ取得
$Folder=$TaskService.GetFolder("\")
# タスクスケジューラのジョブ取得
$Task=$Folder.GetTask("本人確認資料登録参照")
# タスクスケジューラを起動する際のパラメータ設定
[String[]]$Param=${PRM_1},${PRM_2},${PRM_3},${PRM_4}
# タスクスケジューラ実行
$Task.Run($Param)

# 参照処理の場合のみ転送ファイルの存在チェック実施
if (${PRM_1} -eq "reference" ) {
	# 参照時フォルダのパスを生成
	${script:LOCAL_OUT_DIR} = ${TMP_REFERENCE_DIR} -creplace "@@INSTANCENAME@@", ${PRM_2}
	# 本人確認資料ファイル1のパス
	${script:LOCAL_OUT_FILE1} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_3}
	# 本人確認資料ファイル2のパス
	${script:LOCAL_OUT_FILE2} = "x"
	if (${PRM_4} -ne "x") {
		${script:LOCAL_OUT_FILE2} = ${script:LOCAL_OUT_DIR}  + "\" + ${PRM_4}
	} else {
		${script:LOCAL_OUT_FILE2} = "x"
	}

	# ${LC_RETRY_WAIT}に指定している間隔で転送されるファイルの存在チェックを実施する
	for ( ${i} = 1 ; ${i} -le ${LC_RETRY_COUNT} ; ${i}++ ) {
		# スリープ
		Start-Sleep -s ${LC_RETRY_WAIT}
		if (${script:LOCAL_OUT_FILE2} -eq "x") {
			if ( (Test-Path ${script:LOCAL_OUT_FILE1}) ) {
				# ファイルが存在（転送完了）していたら、1秒スリープ後正常終了
				Start-Sleep -s ${LC_RETRY_WAIT}
				exit 0
			} else {
				# ファイルが存在しない場合（転送中）の場合、何もせずにループ処理続行
			}
		} else {
			if ( (Test-Path ${script:LOCAL_OUT_FILE1}) -and (Test-Path ${script:LOCAL_OUT_FILE2}) ) {
				# ファイルが存在（転送完了）していたら、1秒スリープ後正常終了
				Start-Sleep -s ${LC_RETRY_WAIT}
				exit 0
			} else {
				# ファイルが存在しない場合（転送中）の場合、何もせずにループ処理続行
			}
		}
	}
	# ファイルが存在しないままループを抜けた（転送中・転送失敗など）場合、異常終了
	exit 9
}
