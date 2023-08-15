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
# %01 | 23/06/05 | T.TOMINAGA    | WSFC���W���[���̖������y31�s�ځz
#     |          |               | LifeKeeper�R�~���j�P�[�V�����p�X�̊m�F��������ǉ��y40�`68�s�ځz
#     |          |               | LifeKeeper���\�[�XActive/Standby�̊m�F��������ǉ��y78�`99�s�ځz
# %02 | 23/08/14 | T.TOMINAGA    | JP1/HULFT���\�[�X�ǉ������������ߑΉ��i156�s�ځj
#============================================================================
#----------------------------------------------------------------------#
# ComSeviceManage for BANK*R CC  Ver.1.0.0                             #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# Cluster Manage Load Modules                                          #
#----------------------------------------------------------------------#
#
#Import-Module FailoverClusters


#----------------------------------------------------------------------#
# F01.�N���X�^����֐�                                                 #
#----------------------------------------------------------------------#
# F01.1 �N���X�^�X�e�[�^�X�m�F�֐�
# (�T�v)
#  �N���X�^�n�[�g�r�[�g�X�e�[�^�X�m�F�i[ALIVE]�FTrue�j
#----------------------------------------------------------------------#
function global:FC_ClusterStat
{
# �N���X�^�O���[�v�F�n�[�g�r�[�g�X�e�[�^�X�m�F
#   ${FCL_STAT} = (Get-ClusterGroup -Name ${COM_CLST_RSGP01}).State.ToString().ToUpper()
    $flg=0
    if ( ${ENV:COMPUTERNAME} -eq "${COM_CLST_PRI_HOST}") {
        $Server = ${COM_CLST_PRI_HOST}
        $comip = @("${DB_LK_PRI_COMIP1}", "${DB_LK_PRI_COMIP2}")
    } else {
        $Server = ${COM_CLST_ALT_HOST}
        $comip = @("${DB_LK_ALT_COMIP1}", "${DB_LK_ALT_COMIP2}")
    }

    foreach($str_ip in $comip){
        if (& ${DB_LK_CHECK_PATH} -d ${Server} | sls $str_ip | sls ALIVE) { $flg++ }
    }

    if ($flg -eq 2) {
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) Comm Path -- ALL OK"
        return ${True}
    } elseif ($flg -eq 0){
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) Comm Path -- Alert"
        return ${False}
    } else {
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) Comm Path -- Warning "
        return ${False}
    }

}




#----------------------------------------------------------------------#
# F01.2 �ғ��m�[�h�m�F�֐�
# (�T�v)
#  �ғ��m�[�h�m�F����(DB�N���X�^IP���\�[�X�������ғ��z�X�g�Ƃ���)
#----------------------------------------------------------------------#
function global:FC_GetOwnerNode
{
    # �N���X�^�O���[�v�F�ғ��m�[�h�m�F
    if ( ${ENV:COMPUTERNAME} -eq ${COM_CLST_PRI_HOST}) {
        $HereServer = ${COM_CLST_PRI_HOST}
        $OverServer = ${COM_CLST_ALT_HOST}
        } else {
        $HereServer = ${COM_CLST_ALT_HOST}
        $OverServer = ${COM_CLST_PRI_HOST}
    }

    # �I���N�����\�[�X�ғ��m�[�h�m�F
    (& ${DB_LK_CHECK_RESOURCE} -R ${DB_LK_RESOURCE1} -a comm -f/ -d ${HereServer}) | `
        & ${DB_LK_CHECK_AWK} -F'/' '{print $1,$4,$7}'| `
            %{ if("$_" -like '* ISP'){
                    ${FCL_ACTNODE} = ${HereServer}
                }else{
                    ${FCL_ACTNODE} = ${OverServer}
                }
    }

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
    Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}[${FC_CLS_BASE_MSG}]���J�n���܂��B"
    #------------------------------------------------------------------#
    # �ғ����@�m�F
    #------------------------------------------------------------------#
    ${RTN_ACT_NODE} = FC_GetOwnerNode
    if ( ${ENV:COMPUTERNAME} -ne ${RTN_ACT_NODE} ) {
        FC_LogWriter ${DEF_RTNCD_NML} "�ҋ@�m�[�h�ׁ̈A[${FC_CLS_BASE_MSG}]���X�L�b�v���܂��B"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})���I�����܂��B"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) �ҋ@�m�[�h�ׁ̈A[${FC_CLS_BASE_MSG}]���X�L�b�v���܂��B"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})���I�����܂��B"
        return ${True}
    }

    #------------------------------------------------------------------#
    # �ҋ@���@�F�X�e�[�^�X�m�F (ALIVE�łȂ��Ɛؑ֕s�\�̈�)
    #------------------------------------------------------------------#
    if ( ${COM_CLST_PRI_HOST} -eq ${RTN_ACT_NODE} ) {
        ${FCL_OTHERNODE_NAME} = ${COM_CLST_ALT_HOST}
    } else {
        ${FCL_OTHERNODE_NAME} = ${COM_CLST_PRI_HOST}
    }

    ${FCL_OTHERNODE_STAT} = ( & ${DB_LK_CHECK_SYSGET} -s ${FCL_OTHERNODE_NAME} )

    if ( ${FCL_OTHERNODE_STAT} -ne "ALIVE" ) {
        FC_LogWriter ${DEF_RTNCD_NML} "�ҋ@�m�[�h�����N���X�^�ؑ։\��Ԃł͂Ȃ��ׁA[${FC_CLS_BASE_MSG}]���X�L�b�v���܂��B"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})���I�����܂��B"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) �ҋ@�m�[�h�����N���X�^�ؑ։\��Ԃł͂Ȃ��ׁA[${FC_CLS_BASE_MSG}]���X�L�b�v���܂��B"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})���I�����܂��B"

        return ${True}
    }


    #------------------------------------------------------------------#
    # �N���X�^�ؑ֏��� �iMain�����j
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})�����{���܂��B"
    Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})�����{���܂��B"
    ${LK_TOP_RESOURCE} = @("${DB_LK_RESOURCE1}", "${DB_LK_RESOURCE2}", "${DB_LK_RESOURCE3}", "${DB_LK_RESOURCE4}, "${DB_LK_RESOURCE5}")
    foreach( $str_LK in ${LK_TOP_RESOURCE}){

        ### LK���\�[�X��~���� ###
        ${LK_RESOURCE_STOP} = (& ${DB_LK_FAILOVER_ACTION} -t ${str_LK} -a remove)
        &{if ( "$?" -eq "True"){
            FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͐���ɒ�~�������܂����B"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͐���ɒ�~�������܂����B"
        } else {
            outmsg 1 ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͒�~�����ňُ�����m���܂����B"
            FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͒�~�����ňُ�����m���܂����B"
            FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X���ُ�I�����܂��B"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͒�~�����ňُ�����m���܂����B"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X���ُ�I�����܂��B"
            EndProcess
            }
        }


        ### LK���\�[�X�N������ ###
        (& ${DB_LK_FAILOVER_EXEC} -d ${FCL_OTHERNODE_NAME} -- ${DB_LK_FAILOVER_ACTION} -t ${str_LK} -a restore) | `
            &{if ( "$?" -eq "True"){
                FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͐���ɐؑւ��܂����B"
                Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) {PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͐���ɐؑւ��܂����B"
            } else {
                outmsg 1 ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͋N�������ňُ�����m���܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͋N�������ňُ�����m���܂����B"
                FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X���ُ�I�����܂��B"
                Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss'))  ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X�͋N�������ňُ�����m���܂����B"
                Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_EXIT_CODE} ${PRG_NAME}(${FC_CLS_BASE_MSG} ${str_LK})���\�[�X���ُ�I�����܂��B"
                EndProcess
            }
        }

        #sleep -s 5

    }


    #------------------------------------------------------------------#
    # �N���X�^�ؑ֌�m�F���� �i�N���X�^�X�e�[�^�X�m�F�j
    #------------------------------------------------------------------#
    FC_LogWriter ${DEF_RTNCD_NML} "�N���X�^�O���[�v[${COM_CLST_RSGP01}]�̃X�e�[�^�X�m�F���J�n���܂��B"
    Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) �N���X�^�O���[�v[${COM_CLST_RSGP01}]�̃X�e�[�^�X�m�F���J�n���܂��B"

    $RESOURCEflg = 0
    ${RTN_ACT_NODE} = FC_GetOwnerNode
    ${LK_ALLRESOURCE_CNTS} = (& ${DB_LK_CHECK_RESOURCE} ).Count

    (& ${DB_LK_CHECK_RESOURCE} -d ${RTN_ACT_NODE} -f/ ) | & ${DB_LK_CHECK_AWK} -F'/' '{print $1,$4,$7}'| `
        %{ if("$_" -like '* ISP'){
            $DB_LK_RESOURCE_STATUS = ( "$_" | & ${DB_LK_CHECK_AWK} '{print $2}')
            $RESOURCEflg++
            FC_LogWriter ${DEF_RTNCD_NML} "���\�[�X[${DB_LK_RESOURCE_STATUS}]�̃X�e�[�^�X�m�F���I�����܂����B"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ���\�[�X[${DB_LK_RESOURCE_STATUS}]�̃X�e�[�^�X�m�F���I�����܂����B"
        }else{
            $DB_LK_RESOURCE_STATUS = ( "$_" | & ${DB_LK_CHECK_AWK} '{print $2}')
            ${PRG_EXIT_CODE} = ${DEF_RTNCD_ERR}
            FC_LogWriter ${PRG_EXIT_CODE} "���\�[�X[${DB_LK_RESOURCE_STATUS}]�̃X�e�[�^�X�m�F�ňُ�I�����܂����B"
            Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ���\�[�X[${DB_LK_RESOURCE_STATUS}]�̃X�e�[�^�X�m�F�ňُ�I�����܂����B"
        }
    }


    if ("$RESOURCEflg"-eq "${LK_ALLRESOURCE_CNTS}") {
        #Write-Host "LK RESOURCE -- ALL OK"
        FC_LogWriter ${DEF_RTNCD_NML} "${PRG_NAME}(${FC_CLS_BASE_MSG})�͑S�Đ���I�����܂����B"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})�͑S�Đ���I�����܂����B"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ���\�[�X�ؑւ�����"
        return ${True}
    } else {
        #Write-Host "LK RESOURCE -- Warning or Alert"
        FC_LogWriter ${PRG_EXIT_CODE} "${PRG_NAME}(${FC_CLS_BASE_MSG})���ُ�I�����܂��B"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ${PRG_NAME}(${FC_CLS_BASE_MSG})���ُ�I�����܂��B"
        Write-Output "$((Get-Date).tostring('yyyy-MM-dd HH:mm:ss')) ���\�[�X�ؑւ���~"
        return ${False}
    }

}
