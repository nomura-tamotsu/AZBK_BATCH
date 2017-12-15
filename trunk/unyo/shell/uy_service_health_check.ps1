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
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 17/11/20 | K.TAKEICHI    | First Eddition
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
if (Get-Content ${LC_TGFILES} | Select-String -Pattern "�R�l�N�V�����v�[�����O���R�l�N�V�������擾�ł��܂���ł���" -Encoding default -Quiet ) {
    ${EVENT_MSG} = "�R�l�N�V�����v�[�����O���R�l�N�V�������擾�ł��܂���ł����B"
    EventLog_Output
}
#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess