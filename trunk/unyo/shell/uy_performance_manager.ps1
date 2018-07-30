#============================================================================
#  Copyright　Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK・R－CC
#
# PROGRAM NAME  : パフォーマンス制御処理
#
# MODULE NAME   : uy_performance_manager.ps1
#
# INPUT         : $Args[0] ・・・ 処理種類（start, stop, reboot）
#
# EXIT          : 正常終了 ・・・ NORMAL(0)
#                 異常終了 ・・・ ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 18/07/06 | ISID-IT武市   | First Edition.                            
#============================================================================

# ============================================================================
# 初期処理
# ============================================================================

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "パフォーマンスモニター制御処理"
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

# 引数格納
${PROC_TYPE} = $Args[0]

# 処理判定用変数
${PROC_START}    = "start"
${PROC_STOP}     = "stop"
${PROC_REBOOT}   = "reboot"

# データコレクト名
${COLLECT_NAME}  = "PerformanceInfo"

# logman.exeのパスとコマンド
${LOG_MAN}       = "C:\Windows\System32\logman.exe"
${LOG_MAN_START} = "start"
${LOG_MAN_STOP}  = "stop"
${LOG_MAN_QUERY} = "query"

# 起動状態の文字列
${STATE_STOP}    = "停止"
${STATE_EXEC}    = "実行中"

# コマンド実行結果
${COM_MSG}       = "コマンドは、正しく完了しました。"

#--------------------------------------------
# Function
#--------------------------------------------
# 共通関数
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# ローカル関数
#--------------------------------------------
#============================================================================
# 関数名        LFC_PerfStatusCheck
# 概要          パフォーマンスモニタープロセスチェック処理
#                 ・指定したデータコレクトの状態を取得する。
#                 ・対象のデータコレクトが存在しない場合、
#                   エラーメッセージを出力し、処理しない。
#                 ・ここで、戻り値を標準出力する
# 引数          なし
# 戻り値        ${DCSTATE}[1]        状態（実行中、停止）
# 戻り値型      なし
#============================================================================
function LFC_PerfStatusCheck() {
    # データコレクトの詳細情報を取得する
    ${DCSTATE} = &${LOG_MAN} ${LOG_MAN_QUERY} ${COLLECT_NAME} | Select-String "状態"

    # 取得できたか確認する
    if ( ${DCSTATE}.length -eq 0 ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "データコレクトのステータスの状態が取得できません。"
        EndProcess
    }else {
        # スペースを区切り文字とし、項目名と状態に分割する
        ${DCSTATE} = ${DCSTATE} -split " "

        # 状態を取得する
        ${DCSTATE} =${DCSTATE}[-1]
    }
    return ${DCSTATE} 
    
}

#============================================================================
# 関数名        LFC_PerfCommandCheck
# 概要          コマンド実行結果確認処理
#                 ・logman.exe でコマンド実行した結果を確認し、ログに出力する
# 引数          ${RESULT}      実行結果
#               ${EXE_NAME}    処理名
# 戻り値        なし
# 戻り値型      なし
#============================================================================
function LFC_PerfCommandCheck() {
        #コマンド実行結果確認
        if(${RESULT} -eq ${COM_MSG} ){
            #コマンド実行成功
            ${MESSAGE} = "パフォーマンスモニター"+${EXE_NAME}+"処理が成功しました。"
            FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"

        }else {
            #コマンド実行失敗
            ${MESSAGE} = "パフォーマンスモニター"+${EXE_NAME}+"処理が失敗しました。"
            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
            FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"
            FC_LogWriter ${PRG_EXIT_CODE} "実行結果：${RESULT}"
            EndProcess
        }
}

# ============================================================================
# メイン処理
# ============================================================================
# Start Main Program
InitProcess

# 第一引数チェック(文字列チェック)
# パフォーマンスモニター起動
if ( ${PROC_TYPE} -eq ${PROC_START} ) {
    # 開始メッセージ
    FC_LogWriter ${PRG_EXIT_CODE} "パフォーマンスモニター起動処理を開始します。"

    # ステータス取得
    ${STATUS} = LFC_PerfStatusCheck
    
    # 既に起動している場合、停止処理を実行し、インフォメーションログを出力する
    if ( ${STATUS} -eq ${STATE_EXEC} ) {
        #パフォーマンスモニター停止コマンド実行
        ${RESULT} = & ${LOG_MAN} ${LOG_MAN_STOP} ${COLLECT_NAME}
        ${EXE_NAME} = "停止"
        LFC_PerfCommandCheck
    }

    # パフォーマンスモニター起動コマンド実行
    ${RESULT} = & ${LOG_MAN} ${LOG_MAN_START} ${COLLECT_NAME}

    # コマンド実行結果確認
    ${EXE_NAME} = "起動"
    LFC_PerfCommandCheck

    # ステータス取得
    ${STATUS} = LFC_PerfStatusCheck

    # ステータスの確認
    if ( ${STATUS} -eq ${STATE_EXEC} ) {
        FC_LogWriter ${PRG_EXIT_CODE} "パフォーマンスモニターの状態が実行中のステータスです。" 
    }else{
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        ${MESSAGE} = "パフォーマンスモニターの状態が"+${STATUS}+"のステータスです。起動に失敗しました。" 
        outmsg 55 ${PRG_EXIT_CODE} "${MESSAGE}" 
        FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"
        EndProcess
    }

    # 停止メッセージ
    FC_LogWriter ${PRG_EXIT_CODE} "パフォーマンスモニター起動処理を終了します。"

}
# パフォーマンスモニター停止 
elseif ( ${PROC_TYPE} -eq ${PROC_STOP} ) {
    # 開始メッセージ
    FC_LogWriter ${PRG_EXIT_CODE} "パフォーマンスモニター停止処理を開始します"

    # ステータス取得
    ${STATUS} = LFC_PerfStatusCheck
    
    # 既に停止している場合、アラートログ出力のみ実行する
    if ( ${STATUS} -ne ${STATE_EXEC} ) { #停止している場合
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        ${MESSAGE} = "パフォーマンスモニターの状態が"+${STATUS}+"のステータスです。" 
        outmsg 55 ${PRG_EXIT_CODE} "${MESSAGE}" 
        FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"
        EndProcess
    }

    # パフォーマンスモニター停止コマンド実行
    ${RESULT} = & ${LOG_MAN} ${LOG_MAN_STOP} ${COLLECT_NAME}

    # コマンド実行結果確認
    ${EXE_NAME} = "停止"
    LFC_PerfCommandCheck

    # 停止メッセージ
    FC_LogWriter ${PRG_EXIT_CODE} "パフォーマンスモニター停止処理を終了します。"
}
# リブート後パフォーマンスモニター起動 
elseif ( ${PROC_TYPE} -eq ${PROC_REBOOT} ) {
    # 開始メッセージ
    FC_LogWriter ${PRG_EXIT_CODE} "リブート後パフォーマンスモニター起動処理を開始します。"

    # パフォーマンスモニター起動コマンド実行
    ${RESULT} = & ${LOG_MAN} ${LOG_MAN_START} ${COLLECT_NAME}

    # コマンド実行結果確認
    ${EXE_NAME} = "起動"
    LFC_PerfCommandCheck

    # ステータス取得
    ${STATUS} = LFC_PerfStatusCheck

    # ステータスの確認
    if ( ${STATUS} -eq ${STATE_EXEC} ) {
        FC_LogWriter ${PRG_EXIT_CODE} "パフォーマンスモニターの状態が実行中のステータスです。" 
    }else{
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        ${MESSAGE} = "パフォーマンスモニターの状態が"+${STATUS}+"のステータスです。起動に失敗しました。" 
        outmsg 55 ${PRG_EXIT_CODE} "${MESSAGE}" 
        FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"
        EndProcess
    }
    # 停止メッセージ 
    FC_LogWriter ${PRG_EXIT_CODE} "リブート後パフォーマンスモニター起動処理を終了します。"

}
else {
    #引数が指定値（start/stop/reboot）以外の場合、異常終了
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "引数の指定が「${PROC_TYPE}」な為、異常終了します。"
    EndProcess

}
#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
