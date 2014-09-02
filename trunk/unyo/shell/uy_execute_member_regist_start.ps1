#============================================================================
#  COPYRIGHT iSiD LTD. 2014
#  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
#============================================================================
#
# SYSTEM    : BANK*R PREMIA 
#
# FILE      : �_��҃t�@�C���捞���s
#
# FILE      : uy_execute_member_regist_start.ps1
#
# INPUT     :
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %01 | 14/05/14 | N.OGAWA       | First Eddition
# %02 | 14/06/10 | R.YAMANO      | First Eddition Fix
#============================================================================
#--------------------------------------------
# Environment Variable Setting
#--------------------------------------------
${global:UNYO_HOME} = ${ENV:UNYO_HOME}
${MOD_NAME}         = $MyInvocation.MyCommand.Name
${PRG_NAME}         = "�_��҃t�@�C���捞���s"
${PRG_EXIT_CODE}    = 0

#--------------------------------------------
#  Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\UnyoEnv.ps1

#--------------------------------------------
#  Java Variable definition
#--------------------------------------------
. ${UNYO_HOME}\shell\def\ExecuteMemberRegistEnv.ps1

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
# MAIN
#--------------------------------------------
# Start Main Program
InitProcess

#--------------------------------------------
# �擾��T�[�o�����`�F�b�N
#--------------------------------------------
if ( !(Test-Connection ${COM_DBSV_VHOST} -quiet) ) {
    # �ڑ��s�\�ׁ̈A�����𒆎~���܂��B
    ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
    outmsg 55 ${PRG_EXIT_CODE} "�t�@�C���擾��T�[�o[${COM_DBSV_VHOST}]�ɐڑ��ł��Ȃ��ׁA�����𒆎~���܂��B"
    FC_LogWriter ${DEF_RTNCD_NML} "�t�@�C���擾��T�[�o[${COM_DBSV_VHOST}]�ɐڑ��ł��Ȃ��ׁA�����𒆎~���܂��B"
    EndProcess
}

#--------------------------------------------
# �_��҃t�@�C���擾����
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "�_��҃t�@�C���擾�������J�n���܂��B"
for ( ${GET_FILE_COUNT} = 0 ; ${GET_FILE_COUNT} -lt ${BR_TRG_EN_FILE00}.length ; ${GET_FILE_COUNT}++ ) {

    ${TG_FILE_ENAME} = ${BR_TRG_EN_FILE00}[${GET_FILE_COUNT}]
    ${TG_FILE_JNAME} = ${BR_TRG_JP_FILE00}[${GET_FILE_COUNT}]
    ${ST_FILE_ENAME} = ${BR_SET_EN_FILE00}[${GET_FILE_COUNT}]

    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]���m�F���܂��B"

    ${TG_FULLPATH_FNAME} = "${BR_GET_FILEDIR00}\${TG_FILE_ENAME}"
    ${ST_FULLPATH_FNAME} = "${BR_SET_FILEDIR00}\${ST_FILE_ENAME}"

    if ( !(Test-Path ${TG_FULLPATH_FNAME}) ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${TG_FILE_ENAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]�͑��݂��Ȃ��ׁA�����𒆎~���܂��B"
        EndProcess
    }

    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]���m�F���܂����B�t�@�C���擾�������J�n���܂��B"
    ${RTN_CPY_TEMP} = Copy-Item ${TG_FULLPATH_FNAME} ${ST_FULLPATH_FNAME} -Recurse
    ${RTN_CPY_CODE} = $?
    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]�̎擾����������I�����܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]�̎擾�����ɂăG���[�����������ׁA�����𒆎~���܂��B"
        FC_LogWriter ${PRG_EXIT_CODE} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]�̎擾�����ɂăG���[�����������ׁA�����𒆎~���܂��B"
        EndProcess
    }

}
FC_LogWriter ${DEF_RTNCD_NML} "�_��҃t�@�C���擾�������I�����܂��B"


#--------------------------------------------
# �_��҃t�@�C���捞���s�R�}���h�擾
#--------------------------------------------
${COM_RESERVE_CMDLINE} = "${COM_WAS_CMND_JAVA} "
${LC_CLPATH_00} = "${BR_JAVA_CLPATH01};${BR_JAVA_CLPATH02}"
${LC_CLNAME_00} = "${BR_JAVA_CLFILE01}"
${LC_SECPRP_00} = "`"${BR_JAVA_SECPRP01}`" `"${BR_JAVA_SECPRP02}`" `"${BR_JAVA_SECPRP03}`" `"${BR_JAVA_SECPRP04}`" `"${BR_JAVA_SECPRP05}`""


#--------------------------------------------
# �������s
#--------------------------------------------
try {
    Invoke-Expression "${COM_WAS_CMND_JAVA} ${LC_SECPRP_00} -DeMBSV=1 -classpath '${LC_CLPATH_00}' ${LC_CLNAME_00}"
    if ( ${LASTEXITCODE} -eq 0 ) {
        # ���s���ʁF����
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}�ɐ������܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}�Ɏ��s���܂����B"
    }
} catch [Exception] {
    ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
    FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}�ɂĈُ킪�������܂����B"
    EndProcess
}


#--------------------------------------------
# �_��҃t�@�C���o�b�N�A�b�v����
#--------------------------------------------
FC_LogWriter ${DEF_RTNCD_NML} "�_��҃t�@�C���o�b�N�A�b�v�������J�n���܂��B"
for ( ${GET_FILE_COUNT} = 0 ; ${GET_FILE_COUNT} -lt ${BR_TRG_EN_FILE00}.length ; ${GET_FILE_COUNT}++ ) {

    ${TG_FILE_ENAME} = ${BR_TRG_EN_FILE00}[${GET_FILE_COUNT}]
    ${TG_FILE_JNAME} = ${BR_TRG_JP_FILE00}[${GET_FILE_COUNT}]
    ${TG_BKUP_TIMES} = Get-Date -format "${COM_DATEFORM03}"

    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]���m�F���܂��B"

    ${TG_FULLPATH_FNAME} = "${BR_GET_FILEDIR00}\${TG_FILE_ENAME}"
    ${BK_FULLPATH_FNAME} = "${BR_GET_FILEDIR00}\backup\${TG_FILE_ENAME}.${TG_BKUP_TIMES}"

    if ( !(Test-Path ${TG_FULLPATH_FNAME}) ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 51 ${PRG_EXIT_CODE} "${TG_FILE_ENAME}"
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]�͑��݂��Ȃ��ׁA�����𒆎~���܂��B"
        EndProcess
    }

    FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]���m�F���܂����B�o�b�N�A�b�v�擾�������J�n���܂��B"
    ${RTN_CPY_TEMP} = Move-Item ${TG_FULLPATH_FNAME} ${BK_FULLPATH_FNAME} -Force
    ${RTN_CPY_CODE} = $?

    if ( ${RTN_CPY_CODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]�̃o�b�N�A�b�v����������I�����܂����B"
    } else {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 55 ${PRG_EXIT_CODE} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]�̃o�b�N�A�b�v�����ɂăG���[�����������ׁA�����𒆎~���܂��B"
        FC_LogWriter ${PRG_EXIT_CODE} "[${TG_FILE_JNAME}(${TG_FILE_ENAME})]�̎擾�����ɂăG���[�����������ׁA�����𒆎~���܂��B"
        EndProcess
    }

}
FC_LogWriter ${DEF_RTNCD_NML} "�_��҃t�@�C���o�b�N�A�b�v�擾�������I�����܂��B"


#--------------------------------------------
# End Main Program
#--------------------------------------------
EndProcess
