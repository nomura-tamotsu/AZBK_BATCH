#============================================================================
#  COPYRIGHT iSiD LTD. 2015
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : ���[�J��DB�N������
#
# FILE      : uy_localoracle_start.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 15/11/11 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Get Parameter Information
#--------------------------------------------
[CmdletBinding()]
Param(
    [Parameter(Mandatory=$false)]
    [Alias("sid")]
    [string]${PRM_TGSID}="x",
    [Parameter(ValueFromRemainingArguments=$true)]
    [string]${PRM_OTHERS}="x"
)
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "���[�J��DB�N������"
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
${ACT_FLAG}         = "H:\DBFiles"
${ACT_CUNT}         = 0
# ���g���C�����p�ϐ�
${LC_RETRY_MAXCOUNT} = 15
${LC_RETRY_WAITTIME} = 60
# ���g���C�����p�ϐ�(TEST�p)
#${ACT_FLAG}         = "D:\DBFiles"
#${LC_RETRY_MAXCOUNT} = 3
#${LC_RETRY_WAITTIME} = 5

#--------------------------------------------
# Local Env SubSetting
#--------------------------------------------
# �{�Ԋ� �ǉ��C���X�^���X
${LC_SVCNAME_11} = "OracleServiceBRCCAZBK"
# �{�Ԋ� �ǉ��C���X�^���X���X�i�[
${LC_SVCNAME_12} = "OracleOraDb11g_home1TNSListenerAZBK_LSNR"
#--------------------------------------------
# ���C�� �ǉ��C���X�^���X
${LC_SVCNAME_21} = "OracleServiceBANKRTRN"
# ���C�� �ǉ��C���X�^���X���X�i�[
${LC_SVCNAME_22} = "OracleOraDb11g_home1TNSListenerTRNG_LSNR"

#--------------------------------------------
# Function
#--------------------------------------------
# ���ʊ֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComFunction.ps1

#--------------------------------------------
# �T�[�r�X����֐�
#--------------------------------------------
. ${UNYO_HOME}\shell\ComSeviceManage.ps1

#--------------------------------------------
# MAIN
#--------------------------------------------
# Start Main Program
#--------------------------------------------
InitProcess

#--------------------------------------------
# Parameter Check
#--------------------------------------------
# ORACLE�C���X�^���X��ʃ`�F�b�N (SID)
# �T�[�r�X���擾
#--------------------------------------------
if (${PRM_OTHERS} -ne "x") {
    ${PRG_EXIT_CODE}     = ${DEF_RTNCD_ERR}
    outmsg 53 ${PRG_EXIT_CODE}
    FC_LogWriter ${PRG_EXIT_CODE} "�����̐�������������܂���B�w��\�Ȉ�����1�ł��B"
    EndProcess
}
switch("${PRM_TGSID}") {
    "BANKRAZB" { ${TG_SVCNAME_ORACLE} = "${LC_SVCNAME_11}" ; ${TG_SVCNAME_LISTENER} = "${LC_SVCNAME_12}" ; break }
    "BANKRTRN" { ${TG_SVCNAME_ORACLE} = "${LC_SVCNAME_21}" ; ${TG_SVCNAME_LISTENER} = "${LC_SVCNAME_22}" ; break }
    default    { 
                 ${PRG_EXIT_CODE}     = ${DEF_RTNCD_ERR}
                 outmsg 54 ${PRG_EXIT_CODE}
                 FC_LogWriter ${PRG_EXIT_CODE} "�����̓��e������������܂���B�w��\�Ȉ�����[BANKRAZB]��[BANKRTRN]�݂̂ł��B"
                 EndProcess
               }
}

#--------------------------------------------
# ACTIVE Server Check
#--------------------------------------------
# ���[�J��DB�ғ����@�`�F�b�N����
#--------------------------------------------
for ( ${i} = 1 ; ${i} -lt ${LC_RETRY_MAXCOUNT} ; ${i}++ ) {
    if ( !(Test-Path ${ACT_FLAG}) ) {
        FC_LogWriter ${DEF_RTNCD_NML} "�ғ����@�`�F�b�N�����ł�(${i}���)�B"
        Start-Sleep -s ${LC_RETRY_WAITTIME}
    } else {
        FC_LogWriter ${DEF_RTNCD_NML} "�ғ����@�ł��邱�Ƃ��m�F���܂����B"
        FC_LogWriter ${DEF_RTNCD_NML} "�ғ����@�`�F�b�N�������I�����܂��B"
        break
    }
}
if ( ${i} -eq ${LC_RETRY_MAXCOUNT} ) {
    FC_LogWriter ${DEF_RTNCD_NML} "�ғ����@�`�F�b�N�����ōő僊�g���C��(${i}��)�ɒB���܂����B"
    FC_LogWriter ${DEF_RTNCD_NML} "�ғ����@�ł͂Ȃ�����${PRG_NAME}���I�����܂��B"
    EndProcess
}

#--------------------------------------------
# Service STOP
#--------------------------------------------
# ���[�J��DB(Oracle�C���X�^���X)�N������
#--------------------------------------------
if ( !(FC_SERVICE_MANG ${TG_SVCNAME_ORACLE} START) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    EndProcess
}

#--------------------------------------------
# ���[�J��DB(Oracle���X�i�[)�N������
#--------------------------------------------
if ( !(FC_SERVICE_MANG ${TG_SVCNAME_LISTENER} START) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    EndProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
