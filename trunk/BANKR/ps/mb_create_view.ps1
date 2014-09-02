#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : VIEW�ؑ�
#
# FUNCTION NAME : mb_create_view
#
# INPUT         : $Args[0] �E�E�E �r���[DDL���ʎq(view_tf_??)
#               : $Args[1] �E�E�E �r���[�Q�Ɛ掯�ʎq( 1:A or 2:B )
#
# EXIT          :  ����I�� �E�E�E NORMAL(0)
#                  �ُ�I�� �E�E�E ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/14 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# �֐���        mb_create_view-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���return�R�[�h��ݒ肷��
#                 powershell�̊֐��ł́Areturn�ł��Ȃ��̂ŁA
#                 �����ŁA�߂�l��W���o�͂���
# ����          �Ȃ�
# �߂�l        $return_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:mb_create_view-End-Function () {
	
	if ( $return_code -eq $RC_OK ) {

		. $OUTMSG_CMD $NORMAL_END_MSG $return_code $JOB_NAME
	}
	else {

		. $OUTMSG_CMD $ERROR_END_MSG $return_code $JOB_NAME
	}

	$return_code
	
}

function mb_create_view (�@$view_ddl_base , $view_ddl_suffix ) {


        #============================================================================
        # ��������
        #============================================================================
        #
        # ���ʃt�@�C���ݒ�
        #
        $DefFile   = $EMB_HOME + "\ps\def\EMB_DEF.ps1"
        # ���ʃt�@�C�����s�iEMB_DEF.ps1�����s�j
        . $DefFile

        # �R�}���h���Z�b�g
        $OUTMSG_CMD    = $EMB_HOME + "\ps\outmsg.ps1"

        # �������Z�b�g
        $local:BATNAME  = "mb_create_view"
        $local:JOB_NAME = "VIEW�ؑ�"

        #
        # exit�R�[�h������
        #
        $local:return_code = $RC_OK


        # �J�n���b�Z�[�W
        #. $OUTMSG_CMD $INFO_MSG $RC_OK "*****�r���[�ؑ֏���*****"
        . $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME


        #
        # �����̃`�F�b�N
        #
	# �������`�F�b�N
	if ( $view_ddl_base -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "�r���[DDL���ʎq���w�肳��Ă��܂���"
		$return_code = $RC_NG
		mb_create_view-End-Function
		return 

	}


	# �������`�F�b�N
	if ( $view_ddl_suffix -eq $null ) {
        	. $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG "�r���[�Q�Ɛ掯�ʎq���w�肳��Ă��܂���"
		$return_code = $RC_NG
		mb_create_view-End-Function
		return 
	}


        # ============================================================================
        # ���C������
        # ============================================================================

        #
        # �t�@�C�����쐬�@DDL�t�@�C��(FullPATH)
        #
        $local:view_ddl_file = $VIEW_DDL_DIR + "\" + $view_ddl_base + $view_ddl_suffix + ".ddl"
	$local:view_ddl_file_cmd = "@" + $VIEW_DDL_DIR + "\" + $view_ddl_base + $view_ddl_suffix + ".ddl"
     
        #
        # �t�@�C�����݃`�F�b�N
        #
        if ( -not ( Test-Path $view_ddl_file ) ) {
                . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $view_ddl_file
                $return_code = $RC_NG
                mb_create_view-End-Function
		return 
        }

        #
        # ���O�t�@�C�����쐬�@DDL���s���O�t�@�C��(FullPATH)
        #
        $local:view_ddl_log = $VIEW_DDL_LOG_DIR + "\" + $view_ddl_base + $view_ddl_suffix + ".log"


        # DB�p�X���[�h�̕�����
        $DB_PWD_DECODE = PDECODE $DB_NAME $DB_UID
        if ( $ORACLE_TNS -ne $null ) {
            $DB_PWD_DECODE=$DB_PWD_DECODE + "@" + $ORACLE_TNS
        }

        #
        # ���O�t�@�C���폜
        #
        $errorObject = rm -Force  $view_ddl_log  2>&1


        #
        # �r���[�쐬�����s
        #
        $rc = sqlplus $DB_UID/$DB_PWD_DECODE  $view_ddl_file_cmd > $view_ddl_log
        $ret=$?
        if ( $ret -ne "TRUE" ) {
                . $OUTMSG_CMD $COM_ERROR $RC_NG "sqlplus�ŃG���[���������܂���"
                $return_code=$RC_NG
                mb_create_view-End-Function
		return
        }


        #
        # ���O�t�@�C�������݂��܂���
        #
        if ( -not ( Test-Path $view_ddl_log ) ) {
            . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $view_ddl_log
            . $OUTMSG_CMD $COM_ERROR $RC_NG "sqlplus�R�}���h�ŃG���[�������������A���O ���쐬�ł��܂���ł���"
            $return_code = $RC_NG
            mb_create_view-End-Function
	    return
        }


        #
        # ���O����G���[�`�F�b�N "ORA-" ����
        #
        $local:error_string = "ORA-"
        $local:result_str = Get-Content $view_ddl_log | grep $error_string
        if ( $result_str -ne $null ) {
                . $OUTMSG_CMD $VIEW_SWITCH_ERROR $RC_NG

	        #-------------------------------------------------
                # ���O�t�@�C������ύX�@�J�n
                #-------------------------------------------------

                # DATE�֘A�ϐ���`
                $now   = Get-Date
                $date  = $now.ToString("yyyyMMdd")
                $time  = $now.ToString("HHmmss")

                # �t�@�C�����̂ݎ擾
                $local:new_file_name = split-path $view_ddl_log  -Leaf
                $local:path_name = Split-Path $view_ddl_log -parent


                # �V�t�@�C�����쐬
                $local:new_file_name = $path_name + "\" + $new_file_name + "." + $date +$time

                # Move ���s
                $rc = Move-Item $view_ddl_log $new_file_name -force 2>&1
                $ret=$?
                if ( $ret -ne "TRUE" ) {
                        . $OUTMSG_CMD $COM_ERROR $RC_NG "���O�t�@�C���̃��l�[���ŃG���[�� �������܂���"
                        $return_code = $RC_NG
                        mb_create_view-End-Function
			return
                }
		#-------------------------------------------------
                # ���O�t�@�C������ύX�@�I��
                #-------------------------------------------------

                $return_code=$RC_NG
                mb_create_view-End-Function
		return
        }

	#
	# ����I������
	#
        mb_create_view-End-Function

	return
}

