#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : �p�t�H�[�}���X���䏈��
#
# MODULE NAME   : uy_performance_manager.ps1
#
# INPUT         : $Args[0] �E�E�E ������ށistart, stop, reboot�j
#
# EXIT          : ����I�� �E�E�E NORMAL(0)
#                 �ُ�I�� �E�E�E ERROR (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 18/07/06 | ISID-IT���s   | First Edition.                            
#============================================================================

# ============================================================================
# ��������
# ============================================================================

#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "�p�t�H�[�}���X���j�^�[���䏈��"
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

# �����i�[
${PROC_TYPE} = $Args[0]

# ��������p�ϐ�
${PROC_START}    = "start"
${PROC_STOP}     = "stop"
${PROC_REBOOT}   = "reboot"

# �f�[�^�R���N�g��
${COLLECT_NAME}  = "PerformanceInfo"

# logman.exe�̃p�X�ƃR�}���h
${LOG_MAN}       = "C:\Windows\System32\logman.exe"
${LOG_MAN_START} = "start"
${LOG_MAN_STOP}  = "stop"
${LOG_MAN_QUERY} = "query"

# �N����Ԃ̕�����
${STATE_STOP}    = "��~"
${STATE_EXEC}    = "���s��"

# �R�}���h���s����
${COM_MSG}       = "�R�}���h�́A�������������܂����B"

#--------------------------------------------
# Function
#--------------------------------------------
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# ���[�J���֐�
#--------------------------------------------
#============================================================================
# �֐���        LFC_PerfStatusCheck
# �T�v          �p�t�H�[�}���X���j�^�[�v���Z�X�`�F�b�N����
#                 �E�w�肵���f�[�^�R���N�g�̏�Ԃ��擾����B
#                 �E�Ώۂ̃f�[�^�R���N�g�����݂��Ȃ��ꍇ�A
#                   �G���[���b�Z�[�W���o�͂��A�������Ȃ��B
#                 �E�����ŁA�߂�l��W���o�͂���
# ����          �Ȃ�
# �߂�l        ${DCSTATE}[1]        ��ԁi���s���A��~�j
# �߂�l�^      �Ȃ�
#============================================================================
function LFC_PerfStatusCheck() {
    # �f�[�^�R���N�g�̏ڍ׏����擾����
    ${DCSTATE} = &${LOG_MAN} ${LOG_MAN_QUERY} ${COLLECT_NAME} | Select-String "���"

    # �擾�ł������m�F����
    if ( ${DCSTATE}.length -eq 0 ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "�f�[�^�R���N�g�̃X�e�[�^�X�̏�Ԃ��擾�ł��܂���B"
        EndProcess
    }else {
        # �X�y�[�X����؂蕶���Ƃ��A���ږ��Ə�Ԃɕ�������
        ${DCSTATE} = ${DCSTATE} -split " "

        # ��Ԃ��擾����
        ${DCSTATE} =${DCSTATE}[-1]
    }
    return ${DCSTATE} 
    
}

#============================================================================
# �֐���        LFC_PerfCommandCheck
# �T�v          �R�}���h���s���ʊm�F����
#                 �Elogman.exe �ŃR�}���h���s�������ʂ��m�F���A���O�ɏo�͂���
# ����          ${RESULT}      ���s����
#               ${EXE_NAME}    ������
# �߂�l        �Ȃ�
# �߂�l�^      �Ȃ�
#============================================================================
function LFC_PerfCommandCheck() {
        #�R�}���h���s���ʊm�F
        if(${RESULT} -eq ${COM_MSG} ){
            #�R�}���h���s����
            ${MESSAGE} = "�p�t�H�[�}���X���j�^�["+${EXE_NAME}+"�������������܂����B"
            FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"

        }else {
            #�R�}���h���s���s
            ${MESSAGE} = "�p�t�H�[�}���X���j�^�["+${EXE_NAME}+"���������s���܂����B"
            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
            FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"
            FC_LogWriter ${PRG_EXIT_CODE} "���s���ʁF${RESULT}"
            EndProcess
        }
}

# ============================================================================
# ���C������
# ============================================================================
# Start Main Program
InitProcess

# �������`�F�b�N(������`�F�b�N)
# �p�t�H�[�}���X���j�^�[�N��
if ( ${PROC_TYPE} -eq ${PROC_START} ) {
    # �J�n���b�Z�[�W
    FC_LogWriter ${PRG_EXIT_CODE} "�p�t�H�[�}���X���j�^�[�N���������J�n���܂��B"

    # �X�e�[�^�X�擾
    ${STATUS} = LFC_PerfStatusCheck
    
    # ���ɋN�����Ă���ꍇ�A��~���������s���A�C���t�H���[�V�������O���o�͂���
    if ( ${STATUS} -eq ${STATE_EXEC} ) {
        #�p�t�H�[�}���X���j�^�[��~�R�}���h���s
        ${RESULT} = & ${LOG_MAN} ${LOG_MAN_STOP} ${COLLECT_NAME}
        ${EXE_NAME} = "��~"
        LFC_PerfCommandCheck
    }

    # �p�t�H�[�}���X���j�^�[�N���R�}���h���s
    ${RESULT} = & ${LOG_MAN} ${LOG_MAN_START} ${COLLECT_NAME}

    # �R�}���h���s���ʊm�F
    ${EXE_NAME} = "�N��"
    LFC_PerfCommandCheck

    # �X�e�[�^�X�擾
    ${STATUS} = LFC_PerfStatusCheck

    # �X�e�[�^�X�̊m�F
    if ( ${STATUS} -eq ${STATE_EXEC} ) {
        FC_LogWriter ${PRG_EXIT_CODE} "�p�t�H�[�}���X���j�^�[�̏�Ԃ����s���̃X�e�[�^�X�ł��B" 
    }else{
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        ${MESSAGE} = "�p�t�H�[�}���X���j�^�[�̏�Ԃ�"+${STATUS}+"�̃X�e�[�^�X�ł��B�N���Ɏ��s���܂����B" 
        outmsg 55 ${PRG_EXIT_CODE} "${MESSAGE}" 
        FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"
        EndProcess
    }

    # ��~���b�Z�[�W
    FC_LogWriter ${PRG_EXIT_CODE} "�p�t�H�[�}���X���j�^�[�N���������I�����܂��B"

}
# �p�t�H�[�}���X���j�^�[��~ 
elseif ( ${PROC_TYPE} -eq ${PROC_STOP} ) {
    # �J�n���b�Z�[�W
    FC_LogWriter ${PRG_EXIT_CODE} "�p�t�H�[�}���X���j�^�[��~�������J�n���܂�"

    # �X�e�[�^�X�擾
    ${STATUS} = LFC_PerfStatusCheck
    
    # ���ɒ�~���Ă���ꍇ�A�A���[�g���O�o�͂̂ݎ��s����
    if ( ${STATUS} -ne ${STATE_EXEC} ) { #��~���Ă���ꍇ
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        ${MESSAGE} = "�p�t�H�[�}���X���j�^�[�̏�Ԃ�"+${STATUS}+"�̃X�e�[�^�X�ł��B" 
        outmsg 55 ${PRG_EXIT_CODE} "${MESSAGE}" 
        FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"
        EndProcess
    }

    # �p�t�H�[�}���X���j�^�[��~�R�}���h���s
    ${RESULT} = & ${LOG_MAN} ${LOG_MAN_STOP} ${COLLECT_NAME}

    # �R�}���h���s���ʊm�F
    ${EXE_NAME} = "��~"
    LFC_PerfCommandCheck

    # ��~���b�Z�[�W
    FC_LogWriter ${PRG_EXIT_CODE} "�p�t�H�[�}���X���j�^�[��~�������I�����܂��B"
}
# ���u�[�g��p�t�H�[�}���X���j�^�[�N�� 
elseif ( ${PROC_TYPE} -eq ${PROC_REBOOT} ) {
    # �J�n���b�Z�[�W
    FC_LogWriter ${PRG_EXIT_CODE} "���u�[�g��p�t�H�[�}���X���j�^�[�N���������J�n���܂��B"

    # �p�t�H�[�}���X���j�^�[�N���R�}���h���s
    ${RESULT} = & ${LOG_MAN} ${LOG_MAN_START} ${COLLECT_NAME}

    # �R�}���h���s���ʊm�F
    ${EXE_NAME} = "�N��"
    LFC_PerfCommandCheck

    # �X�e�[�^�X�擾
    ${STATUS} = LFC_PerfStatusCheck

    # �X�e�[�^�X�̊m�F
    if ( ${STATUS} -eq ${STATE_EXEC} ) {
        FC_LogWriter ${PRG_EXIT_CODE} "�p�t�H�[�}���X���j�^�[�̏�Ԃ����s���̃X�e�[�^�X�ł��B" 
    }else{
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        ${MESSAGE} = "�p�t�H�[�}���X���j�^�[�̏�Ԃ�"+${STATUS}+"�̃X�e�[�^�X�ł��B�N���Ɏ��s���܂����B" 
        outmsg 55 ${PRG_EXIT_CODE} "${MESSAGE}" 
        FC_LogWriter ${PRG_EXIT_CODE} "${MESSAGE}"
        EndProcess
    }
    # ��~���b�Z�[�W 
    FC_LogWriter ${PRG_EXIT_CODE} "���u�[�g��p�t�H�[�}���X���j�^�[�N���������I�����܂��B"

}
else {
    #�������w��l�istart/stop/reboot�j�ȊO�̏ꍇ�A�ُ�I��
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "�����̎w�肪�u${PROC_TYPE}�v�ȈׁA�ُ�I�����܂��B"
    EndProcess

}
#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
