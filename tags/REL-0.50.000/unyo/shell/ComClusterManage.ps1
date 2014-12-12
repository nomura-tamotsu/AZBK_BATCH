#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �N���X�^����֐�
#
# ModName   : ComClusterManage
#
# Condition : UnyoEnv & ComFunction files inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Eddition
#============================================================================
#----------------------------------------------------------------------#
# ComSeviceManage for BANK*R CC  Ver.1.0.0                             #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Cluster Manage Load Modules                                          #
#----------------------------------------------------------------------#
Import-Module FailoverClusters


#----------------------------------------------------------------------#
# F01.�N���X�^����֐�                                                 #
#----------------------------------------------------------------------#
# F01.1 �N���X�^�X�e�[�^�X�m�F�֐�
# (�T�v)
#  �N���X�^�X�e�[�^�X�m�F�i[Online]�FTrue�j
#----------------------------------------------------------------------#
function global:FC_ClusterStat
{
    # �N���X�^�O���[�v�F�X�e�[�^�X�m�F
    ${FCL_STAT} = (Get-ClusterGroup -Name ${COM_CLST_RSGP01}).State.ToString().ToUpper()

    if ( ${FCL_STAT} -eq "ONLINE" ) {
        return ${True}
    } else {
        return ${False}
    }

}

#----------------------------------------------------------------------#
# F01.2 �ғ��m�[�h�m�F�֐�
# (�T�v)
#  �ғ��m�[�h�m�F����
#----------------------------------------------------------------------#
function global:FC_GetOwnerNode
{
    # �N���X�^�O���[�v�F�ғ��m�[�h�m�F
    ${FCL_ACTNODE} = (Get-ClusterGroup -Name ${COM_CLST_RSGP01}).OwnerNode.ToString().ToLower()

    echo ${FCL_ACTNODE}

}


#----------------------------------------------------------------------#
# F01.32 �N���X�^�ؑ֊֐�
# (�T�v)
#  �N���X�^�ؑ֏��� (�ҋ@���@�֐ؑցj
#----------------------------------------------------------------------#
function global:FC_MoveCluster
{
    ${FC_CLS_BASE_MSG} = "�N���X�^�ؑ֏���"

    FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}[${FC_CLS_BASE_MSG}]���J�n���܂��B"
    #------------------------------------------------------------------#
    # �ғ����@�m�F
    #------------------------------------------------------------------#
    ${RTN_ACT_NODE} = FC_GetOwnerNode
    if ( ${HOST_NMLO} -ne ${RTN_ACT_NODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "�ҋ@�m�[�h�ׁ̈A[${FC_CLS_BASE_MSG}]���X�L�b�v���܂��B"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})���I�����܂��B"
        return ${True}
    }

    #------------------------------------------------------------------#
    # �ҋ@���@�F�X�e�[�^�X�m�F (UP�łȂ��Ɛؑ֕s�\�̈�)
    #------------------------------------------------------------------#
    ${FCL_OTHERNODE_NAME} = (Get-ClusterNode | Select-String -NotMatch -Pattern "${HOST_NMLO}").ToString()
    ${FCL_OTHERNODE_STAT} = (Get-ClusterNode -Name ${FCL_OTHERNODE_NAME}).State.ToString().ToUpper()
    if ( ${FCL_OTHERNODE_STAT} -ne "UP" ) {
        FC_LogWriter ${DEF_RTNCD_NML} "�ҋ@�m�[�h�����N���X�^�ؑ։\��Ԃł͂Ȃ��ׁA[${FC_CLS_BASE_MSG}]���X�L�b�v���܂��B"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})���I�����܂��B"
        return ${True}
    }

    #------------------------------------------------------------------#
    # �N���X�^�ؑ֏��� �iMain�����j
    #------------------------------------------------------------------#
    try {
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})�����{���܂��B"
        ${RTN_MOVECLUSTER_CODE} = Move-ClusterGroup -Name ${COM_CLST_RSGP01} -Node ${FCL_OTHERNODE_NAME} -Wait ${COM_CLST_FCOUNT}
        if ( !(${RTN_MOVECLUSTER_CODE}) ) {
            ${PRG_EXIT_CODE}    = ${DEF_RTNCD_ERR}
            outmsg 1 ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})�ɂăG���[���������܂����B"
            FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})�ɂăG���[���������܂����B"
            FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})���ُ�I�����܂��B"
            EndProcess
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})�͐���I�����܂����B"
        }
    } catch [Exception] {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        outmsg 1 ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})�ɂăG���[���������܂����B"
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})�ɂăG���[���������܂����B"
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})���ُ�I�����܂��B"
        EndProcess
    }

    #------------------------------------------------------------------#
    # �N���X�^�ؑ֌�m�F���� �i�N���X�^�X�e�[�^�X�m�F�j
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "�N���X�^�O���[�v[${COM_CLST_RSGP01}]�̃X�e�[�^�X�m�F���J�n���܂��B"
    for ( ${i} = 1 ; ${i} -le ${COM_CLRP_CNTS} ; ${i}++ ) {
        Start-Sleep -s ${COM_CLWT_TIME}
        if ( FC_ClusterStat -ne ${True} ) {
            FC_LogWriter ${DEF_RTNCD_NML} "�N���X�^�O���[�v[${COM_CLST_RSGP01}]�̃X�e�[�^�X�m�F���ł�(${i}���)�B"
        } else {
            FC_LogWriter ${DEF_RTNCD_NML} "�N���X�^�O���[�v[${COM_CLST_RSGP01}]�̃X�e�[�^�X�m�F���I�����܂����B"
            FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})�͑S�Đ���I�����܂����B"
            return ${True}
        }
    }
    if ( ${i} -eq ${COM_CLRP_CNTS} ) {
        ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
        FC_LogWriter ${PRG_EXIT_CODE} "�N���X�^�O���[�v[${COM_CLST_RSGP01}]�̃X�e�[�^�X�m�F�ňُ�I�����܂����B"
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})���ُ�I�����܂��B"
        return ${False}
    }

}
