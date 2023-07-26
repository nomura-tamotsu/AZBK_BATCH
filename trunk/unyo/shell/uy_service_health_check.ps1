#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2016
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �^�p�ێ� ���u�[�g���G���[���m����
#
# ModName   : uy_service_health_check
#
# Condition : UnyoEnv & ComFunction files inclusion
#
#----------------------------------------------------------------------------
# AP�ċN�����ABANKR���������ł̂c�a�A�N�Z�X�G���[�����m�A�n�r�̃C�x���g���O��
# �G���[�̎|���o�͂��邱�ƂŊĎ��}�����ԓ���NIMSOFT�ɏ�Q�����m������B
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 17/11/20 | K.TAKEICHI    | First Eddition
# %01 | 23/07/25 | K.DOI         | �A�v����ՍX���Ή��i���m���b�Z�[�W�ǉ��j
#============================================================================
#----------------------------------------------------------------------#
# GetPerfMonitor for BANK*R CC  Ver.1.0.0                              #
#----------------------------------------------------------------------#
#--------------------------------------------
# Get Parameter Information

# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "���u�[�g���G���[���m����"
${PRG_EXIT_CODE}    = 0
${EVENT_SRC}        = "HealthCheckAP"
${EVENT_ID}         = 100

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
# Local Env Setting
#--------------------------------------------
${script:LC_TGFILES} = "D:\BANKR_CC\logs\biz\bankrazb\eMBTraceFile"
#----------------------------------------------------------------------#
# Function
#----------------------------------------------------------------------#
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#----------------------------------------------------------------------#
# �C�x���g���O�o�͏���(����)
#----------------------------------------------------------------------#
function global:EventLog_Output
{
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    if ([System.Diagnostics.EventLog]::SourceExists(${EVENT_SRC}) -eq $false){
        New-EventLog -LogName Application -Source ${EVENT_SRC} 
    }    
    Write-EventLog -LogName Application -EntryType Error -Source ${EVENT_SRC} -EventId ${EVENT_ID} -Message ${EVENT_MSG} -Category 0
    EndProcess
}
#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess
#----------------------------------------------------------------------#
# 1.�m�F�Ώۃt�@�C�����݃`�F�b�N (eMBTraceFile)
#----------------------------------------------------------------------#
if ( !(Test-Path ${LC_TGFILES}) ) {
    # ���݂��Ȃ��׏����𒆎~���܂��B
    ${EVENT_MSG} = "���O�t�@�C��[eMBTraceFile]�����݂��܂���B"
    EventLog_Output
}
#----------------------------------------------------------------------#
# 2.���O��́ieMBTraceFile�j
#----------------------------------------------------------------------#       
# JavaSP �t���[�����[�N���m �c�a�A�N�Z�X�G���[
if (Get-Content ${LC_TGFILES} | Select-String -Pattern "�R�l�N�V�����v�[�����O���R�l�N�V�������擾�ł��܂���ł���" -Encoding default -Quiet ) {
    ${EVENT_MSG} = "�R�l�N�V�����v�[�����O���R�l�N�V�������擾�ł��܂���ł����B"
    EventLog_Output
}

# %01 �A�v����ՍX�� Add Start
# EBJ �r�W�l�X���W�b�N���m �c�a�A�N�Z�X�G���[(���ۂɎ��s���Ă���̂�SELECT��SQL)
if (Get-Content ${LC_TGFILES} | Select-String -Pattern "�r�p�k�łh�m�r�d�q�s�G���[���������܂����B" -Encoding default -Quiet ) {
    ${EVENT_MSG} = "�r�p�k�ŃG���[���������܂����B"
    EventLog_Output
}

# EBJ  �t���[�����[�N���m �c�a�A�N�Z�X�G���[
if (Get-Content ${LC_TGFILES} | Select-String -Pattern "�f�[�^�x�[�X�A�N�Z�X�Ɏ��s���܂����B" -Encoding default -Quiet ) {
    ${EVENT_MSG} = "�f�[�^�x�[�X�A�N�Z�X�Ɏ��s���܂����B"
    EventLog_Output
}
# %01 �A�v����ՍX�� Add End

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess