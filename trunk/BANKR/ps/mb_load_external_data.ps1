#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : �O���f�[�^�捞
#
# FUNCTION NAME : mb_load_external_data
#
# INPUT         : %1 �E�E�E �R���g���[���t�@�C��
#                 %2 �E�E�E �f�[�^�t�@�C��
#                 %3 �E�E�E BAD�t�@�C��
#                 %4 �E�E�E DISCARD�t�@�C��
#                 %5 �E�E�E ���O�t�@�C��
#
# EXIT          : ����I�� �E�E�E NORMAL  (0)
#                 �x���I�� �E�E�E WARNING (1)
#                 �ُ�I�� �E�E�E ERROR   (9)
#
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/10 | ISID        | First Edition.                            
#============================================================================
#============================================================================
# �֐���        Delete-file
# �T�v          �t�@�C���폜����
# ����          $file_name �t�@�C����
# �߂�l        $RC_OK,$RC_NG
# �߂�l�^      �Ȃ�
#============================================================================
function Delete-file ( [string] $file_name ) {

    #
    # �t�@�C���̑��݊m�F
    #
    if ( -not ( Test-Path $file_name ) ) {
        # ���݂��Ȃ��̂ō폜��������
        return $RC_OK
    }
    
    #
    # �t�@�C�����ʃ`�F�b�N
    #
    $rc = Get-ChildItem  $file_name | Where-Object { -not $_.PSIsContainer} | format-list name
    if ( $rc -eq $null ) {
        # �t�H���_�̏ꍇ�͍폜����
        return $RC_OK
    }

    #
    # �폜���s
    #
    $errorObject = rm -Force  $file_name  2>&1
    
    # �G���[�n���h�����O
    if ( $errorObject -eq $null ) {
        return $RC_OK
    }
    else {
        # �G���[���b�Z�[�W���t�@�C���ɏo��
        echo $errorObject > $TMP_DIR\tempe.log
        return $RC_NG
    }

}


#============================================================================
# �֐���        Extload-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���return�R�[�h��ݒ肷��
#                 powershell�̊֐��ł́Areturn�ł��Ȃ��̂ŁA
#                 �����ŁA�߂�l��W���o�͂���
# ����          �Ȃ�
# �߂�l        $return_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:Extload-End-Function () {

	if ( $return_code -eq $RC_OK ) {
		. $OUTMSG_CMD $NORMAL_END_MSG $return_code $JOB_NAME
	}
	elseif ( $return_code -eq $RC_WARNING ) {
		. $OUTMSG_CMD $WARNINGL_END_MSG $return_code $JOB_NAME
	}
	else {
		. $OUTMSG_CMD $ERROR_END_MSG $return_code $JOB_NAME
	}

	$return_code
	
}


#============================================================================
# �֐���        mb_load_external_data
# �T�v          �O���f�[�^�捞���C��
#                 
# ����          : %1 �E�E�E �R���g���[���t�@�C��
#                 %2 �E�E�E �f�[�^�t�@�C��
#                 %3 �E�E�E BAD�t�@�C��
#                 %4 �E�E�E DISCARD�t�@�C��
#                 %5 �E�E�E ���O�t�@�C��
#
# �߂�l        : ����I�� �E�E�E NORMAL  (0)
#                 �x���I�� �E�E�E WARNING (1)
#                 �ُ�I�� �E�E�E ERROR   (9)
#
# �߂�l�^      �Ȃ�
#============================================================================
function mb_load_external_data ( $control_file, $data_file, $bad_file, $discard_file, $log_file ) {


        # ============================================================================
        # ��������
        # ============================================================================

        #
        # ���ʃt�@�C���ݒ�
        #
        $DefFile   = $EMB_HOME + "\ps\def\EMB_DEF.ps1"
        # ���ʃt�@�C�����s�iEMB_DEF.ps1�����s�j
        . $DefFile

        # �R�}���h���Z�b�g
        $OUTMSG_CMD    = $EMB_HOME + "\ps\outmsg.ps1"


        # �������Z�b�g
        $local:BATNAME  = $MyInvocation.MyCommand.Name
        $local:JOB_NAME = "�O���f�[�^�捞"

        # return_code������
        $local:return_code = $RC_OK


        # �J�n���b�Z�[�W
        . $OUTMSG_CMD $START_MSG $RC_OK $JOB_NAME

        #-----------------------------------------
        # �����̃`�F�b�N
        #-----------------------------------------
	$local:arg_info = $null

	# �����̕K�{�`�F�b�N
	if ( $control_file -eq $null ) {
		$arg_info = "��P���� �R���g���[���t�@�C��"
	}
	elseif ( $data_file    -eq $null ) {
		$arg_info = "��Q���� �f�[�^�t�@�C��"
	}
	elseif ( $bad_file     -eq $null ) {
		$arg_info = "��R���� �s�ǃt�@�C��"
	}	
	elseif ( $discard_file -eq $null ) {
		$arg_info = "��S���� �p���t�@�C��"
	}
	elseif ( $log_file     -eq $null ) {
		$arg_info = "��T���� ���O�t�@�C��"
	}

	#
	# �G���[�̏ꍇ���b�Z�[�W�o��
	#
	if ( $arg_info -ne $null ) {
	    . $OUTMSG_CMD $UNMATCH_PARAMETER_COUNT_MSG $RC_NG $arg_info
	    $return_code = $RC_NG
            Extload-End-Function
            return
	}



        # ============================================================================
        # ���C������
        # ============================================================================

        # integer �ϐ�������
        $local:num        = 0
        $local:num_read   = 0
        $local:num_skip   = 0
        $local:num_load   = 0
        $local:num_reject = 0
        $local:num_delete = 0
        $local:num_commit = 0
        $local:kensu      = 0

        # �t�@�C���̑��݊m�F
        if ( -not ( Test-Path $control_file ) ) {
            . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $control_file
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        if ( -not ( Test-Path $data_file ) ) {
            . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $data_file
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }



        # DB�p�X���[�h�̕�����
        $DB_PWD_DECODE = PDECODE $DB_NAME $DB_UID
        if ( $ORACLE_TNS -ne $null ) {
            $DB_PWD_DECODE=$DB_PWD_DECODE + "@" + $ORACLE_TNS
        }


        # �t�@�C���폜
        $rc = Delete-file ( $bad_file     )
        $rc = Delete-file ( $discard_file )
        $rc = Delete-file ( $log_file     )


	#-------------------------------------------------------------------------------
	# �_�C���N�g���[�h�����s
	#-------------------------------------------------------------------------------
	$sqllload_cmd = "sqlldr"
	$load_arg     = "$DB_UID/$DB_PWD_DECODE CONTROL=$control_file,DATA=$data_file,BAD=$bad_file,DISCARD=$discard_file,LOG=$log_file"

	#-------------------------------------------------------------------------------
	# $sqllload_cmd �Ƃ����A�v�������� $load_arg �Ŏ��s���A�I������܂őҋ@
	#-------------------------------------------------------------------------------
	$load_process = Start-Process $sqllload_cmd $load_arg  -PassThru -Wait -WindowStyle  Hidden
	#-------------------------------------------------------------------------------
	# �I���R�[�h�̎擾
	#-------------------------------------------------------------------------------
	$load_ret = $load_process.ExitCode
	#-------------------------------------------------------------------------------
	# ���\�[�X�̔j��
	#-------------------------------------------------------------------------------
	$load_process.Close()


	#-------------------------------------------------------------------------------
        # ���[�h�̃G���[�`�F�b�N����
	#-------------------------------------------------------------------------------
        $local:result_str=""
        # ���O�t�@�C�������݂��܂���
        if ( -not ( Test-Path $log_file ) ) {
            . $OUTMSG_CMD $FILE_NOT_EXIST_MSG $RC_NG $log_file
            . $OUTMSG_CMD $COM_ERROR $RC_NG "sqlldr�R�}���h�ŃG���[�������������A���O ���쐬�ł��܂���ł���"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }


        #echo  "�ő�G���[�����𒴂��܂���" | Out-File -FilePath $log_file -Append -Encoding default
        $result_str = Get-Content $log_file | grep "�ő�G���[�����𒴂��܂���"
        if ( $result_str -ne $null ) {
            . $OUTMSG_CMD $LOAD_EXCEED_ERR $RC_NG
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        #echo  "���[�h����~���܂���" | Out-File -FilePath $log_file -Append -Encoding default
        $result_str = Get-Content $log_file | grep "���[�h����~���܂���"
        if ( $result_str -ne $null ) {
            . $OUTMSG_CMD $LOAD_FAILURE $RC_NG
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        #echo  "�d������L�[������܂�" | Out-File -FilePath $log_file -Append -Encoding default
        $result_str = Get-Content $log_file | grep "�d������L�[������܂�"
        if ( $result_str -ne $null ) {

            . $OUTMSG_CMD $ERR_DUPLICATE $RC_NG 
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        #echo  "Loader-2026" | Out-File -FilePath $log_file -Append -Encoding default
        $result_str = Get-Content $log_file | grep "Loader-2026"
        if ( $result_str -ne $null ) {
            . $OUTMSG_CMD $LOAD_ERROR_2026 $RC_NG
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }




	#-------------------------------------------------------------------------------
        # ���[�h�����̃`�F�b�N����
	#-------------------------------------------------------------------------------
        $local:result_str=""

        $result_str = Get-Content $log_file | grep "�ǂݍ��܂ꂽ�_�����R�[�h"
        if ( $result_str -ne $null ) {
            # �������ҏW�[�����܂ł̕�����S�č폜
            $tmp_str=$result_str -replace ".* ",""
            #���l�^�ɕϊ�
            $rc=[int]::TryParse($tmp_str, [ref]$num_read)
        }
        else {
            . $OUTMSG_CMD $COM_ERROR $RC_NG "���O�t�@�C�����s���ł��B(�ǂݍ��܂ꂽ�_�����R�[�h������܂���)"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        $result_str = Get-Content $log_file | grep "�X�L�b�v���ꂽ�_�����R�[�h"
        if ( $result_str -ne $null ) {
            # �������ҏW�[�����܂ł̕�����S�č폜
            $tmp_str=$result_str -replace ".* ",""
            #���l�^�ɕϊ�
            $rc=[int]::TryParse($tmp_str, [ref]$num_skip)
        }
        else {
            . $OUTMSG_CMD $COM_ERROR $RC_NG "���O�t�@�C�����s���ł��B(�X�L�b�v���ꂽ�_�����R�[�h������܂���)"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        $result_str = Get-Content $log_file | grep "���ۂ��ꂽ�_�����R�[�h"
        if ( $result_str -ne $null ) {
            # �������ҏW�[�����܂ł̕�����S�č폜
            $tmp_str=$result_str -replace ".* ",""
            #���l�^�ɕϊ�
            $rc=[int]::TryParse($tmp_str, [ref]$num_reject)
        }
        else {
            . $OUTMSG_CMD $COM_ERROR $RC_NG "���O�t�@�C�����s���ł��B(���ۂ��ꂽ�_�����R�[�h������܂���)"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }

        $result_str = Get-Content $log_file | grep "�p�����ꂽ�_�����R�[�h"
        if ( $result_str -ne $null ) {
            # �������ҏW�[�����܂ł̕�����S�č폜
            $tmp_str=$result_str -replace ".* ",""
            #���l�^�ɕϊ�
            $rc=[int]::TryParse($tmp_str, [ref]$num_delete)
        }
        else {
            . $OUTMSG_CMD $COM_ERROR $RC_NG "���O�t�@�C�����s���ł��B(�p�����ꂽ�_�����R�[�h������܂���)"
            $return_code = $RC_NG
            Extload-End-Function
	    return
        }




        $num_load   = $num_read - $num_skip - $num_reject - $num_delete
        $num_commit = $num_load
        $num        = $num_skip + $num_reject + $num_delete


        #
        # �x���L��
        #
        if ( $num -gt 0 ) {
            # �O���f�[�^���[�h�ŋ��ۂ��ꂽ���R�[�h������܂�
            . $OUTMSG_CMD $LOAD_REFUSAL_WAN $RC_OK $num
            . $OUTMSG_CMD $INFO_MSG $RC_OK "�O���f�[�^�̓������I�����܂����B�y$CONTROL_FILE�z"

            $return_code = $RC_OK

            $load_ret = "TRUE"

            Extload-End-Function
	    return 

        }

        #
        # ���[�h�ŃG���[���������ꍇ
        #   �i��L�G���[�n���h�����O�ɊY�����Ȃ��ꍇ�j
        #
        if ( $load_ret -ne $RC_OK ) {
                . $OUTMSG_CMD $COM_ERROR $RC_NG "sqlldr�R�}���h�ŃG���[���������܂���"
                $return_code = $RC_NG
                Extload-End-Function
	        return 
        }

         . $OUTMSG_CMD $INFO_MSG $RC_OK "�O���f�[�^�̓���������I�����܂����B�y$CONTROL_FILE�z"

	#
	# ����I������
	#
        Extload-End-Function
	return


}
