#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : IHS�N������
#
# FILE      : uy_ihs_start.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | R.YAMANO      | First Eddition
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "IHS�N������"
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
InitProcess

#--------------------------------------------
# IHS�T�[�r�X���擾
#--------------------------------------------
${LC_SERVICE_NAME01} = "${COM_SVCNAME_IHSADM}"
${LC_SERVICE_NAME02} = "${COM_SVCNAME_IHSV85}"

#--------------------------------------------
# IHS (Admin) �N������
#--------------------------------------------
if ( !(FC_SERVICE_MANG ${LC_SERVICE_NAME01} START) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    EndProcess
}
#--------------------------------------------
# IHS �N������
#--------------------------------------------
if ( !(FC_SERVICE_MANG ${LC_SERVICE_NAME02} START) ) {
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    EndProcess
}

#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
