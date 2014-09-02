#============================================================================
#  Copyright�@Information Services International-Dentsu, Ltd.
#============================================================================
#
# SYSTEM        : BANK�ER�|CC
#
# PROGRAM NAME  : ���b�Z�[�W�o��
#
# MODULE NAME   : outmsg
#
# INPUT         :  $Args[0] �E�E�E ���b�Z�[�W�ԍ�
#                  $Args[1] �E�E�E �G���[�R�[�h
#                  $Args[2] �E�E�E �t������1
#                  $Args[3] �E�E�E �t������2
#                  $Args[4] �E�E�E �t������3
# 
# EXIT          :  ����I�� �E�E�E NORMAL(0)
#                  �ُ�I�� �E�E�E ERROR (9)
# 
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 13/10/XX | ISID        | First Edition.                            
#============================================================================


#============================================================================
# �֐���        Write-Errlog
# �T�v          �G���[���O�������ݏ���
# ����          �Ȃ�
# �߂�l        �Ȃ�
# �߂�l�^      �Ȃ�
#============================================================================
function Write-Errlog () {

	# �u�����N��`(�R���s���[�^���ƃ��b�Z�[�W�̊Ԃ̋�)
	$complen = $COMPUTERNAME.length
	if ( $complen -eq 13 ) {
		$blank_string = "      "
	}
	else {
		$blank_string = "       "
	}

	# DATE�֘A�ϐ���`
	$now       = Get-Date
	$date_char = $now.ToString("yyyy_MM_dd")
	$date      = $now.ToString("yyyy/MM/dd")
	$time      = $now.ToString("HH:mm:ss")

	# �Q�l(�ȉ��̃R�[�h�ł��擾��)
	# $time    = $now.ToLongTimeString()



	# ���O�t�@�C�����Z�b�g����
	#$error_logfile = "$LOG_DIR\err.$DATE_CHAR"

	$error_logfile = "$LogName.$DATE_CHAR"


	# ���t���Z�b�g
	$date_string = $date + " " + $time

	# �o�̓��b�Z�[�W����
	$out_msg = $date_string + " " + $COMPUTERNAME + $blank_string + $out_msg

	# ���b�Z�[�W�ɉ��s�R�[�h�t��
	#$out_msg="`n"+$out_msg+"`n"

	# ���b�Z�[�W�o�͏���
	echo  $out_msg | Out-File -FilePath $error_logfile -Append -Encoding default

}
#============================================================================
# �֐���        Outmsg-Check-Argument
# �T�v          �����`�F�b�N����
# ����          �Ȃ�
# �߂�l        �Ȃ�
# �߂�l�^      �Ȃ�
#============================================================================
function Outmsg-Check-Argument () {

	# �������`�F�b�N
	if ( $msg_no -eq $null ) {

		# �G���[���b�Z�[�W�Z�b�g
		$out_msg="����:���b�Z�[�W�ԍ����w�肳��Ă��܂���B [$OM_BATNAME($USERNAME)]"
		Write-Errlog

		$lc_exit_code=$RC_NG
		Outmsg-End-Function
	}

	# �������`�F�b�N
	if ( $error_code -eq $null ) {

		# �G���[���b�Z�[�W�Z�b�g
		$out_msg="����:�G���[�R�[�h���w�肳��Ă��܂���B [$OM_BATNAME($USERNAME)]" 
		Write-Errlog

		$lc_exit_code=$RC_NG
		Outmsg-End-Function
	}

}

#============================================================================
# �֐���        Outmsg-End-Function
# �T�v          �I������
#                 goto�����g�p�ł��Ȃ��̂ŁA���̊֐���exit�������s��
# ����          �Ȃ�
# �߂�l        $lc_exit_code
# �߂�l�^      �Ȃ�
#============================================================================
function local:Outmsg-End-Function () {
	exit $lc_exit_code	
}

#============================================================================
# ��������
#============================================================================
#
# ���ʃt�@�C���ݒ�
#
$scriptDir = Split-Path $MyInvocation.MyCommand.Path -Parent
$DefFile   = $scriptDir + "\def\EMB_DEF.ps1"
# ���ʃt�@�C�����s�iEMB_DEF.ps1�����s�j
. $DefFile


#
# exit�R�[�h������
#
$local:lc_exit_code = $RC_OK
$global:msg_text = ""

#
# �����ޔ�
#
$msg_no     = $Args[0]
$error_code = $Args[1]
$parm1      = $Args[2]
$parm2      = $Args[3]
$parm3      = $Args[4]


#
# ���[�J���ϐ���`
#
$ErrlogPram = "$EMB_HOME\file\ERRLOG.parm"

# �t�@�C���ǂݍ���
$lines = get-content $ErrlogPram
foreach ( $line in $lines ) {
	$cnt++
	if ( $cnt -eq 1 ) {
		$MsgFileName = $line
	}
	if ( $cnt -eq 2 ) {
		$LogName = $line
		break
	}
}

#$MsgFileName = "$EMB_HOME\file\msg_file"

#�o�b�`����ʕϐ��Ŏg�p
$OM_BATNAME = $BATNAME


#
# �����̃`�F�b�N
#
Outmsg-Check-Argument

#============================================================================
# ���C������
#============================================================================

#
# ���b�Z�[�W�ԍ��쐬(5�� 0-Padding)
#
$msg_no = "{0:00000}" -f $msg_no

#
# ����������쐬(�擪��^��t��)
#
$search_str = "^" + $msg_no

#
# �w�胁�b�Z�[�W�ԍ��̃��b�Z�[�W���擾
#
# ���b�Z�[�W�t�@�C�����當���񌟍�
$result_str = Get-Content $MsgFileName | grep $search_str 


#
# ������𕪉����Ă��ꂼ��ϐ��ɃZ�b�g
#
# 1.����
$ary_str  = $result_str -split " "
# 2.���b�Z�[�WID�Z�b�g
$msg_id   = $ary_str[0]
# 3.���b�Z�[�W�s�Z�b�g
$msg_line = $ary_str[1]
# 4.���b�Z�[�W���i�ŏ��̃g�[�N��)�Z�b�g
$msg_text = $ary_str[2]

# 5.���b�Z�[�WID�Z�b�g (�c��j�Z�b�g
for ( $i = 3 ; $ary_str[$i] -ne $null ; $i++ ) {
	$msg_text = $msg_text + " " + $ary_str[$i];
}



#
# ���b�Z�[�W�t�@�C���ɊY���ԍ������݂��Ȃ��ꍇ
#
if ($msg_id -eq $null) {
	$out_msg="���b�Z�[�W�t�@�C�� �Ǎ��G���[ ���� ���b�Z�[�W�ԍ����s���ł��B (msgno : $msg_no) [$OM_BATNAME($USERNAME)]" 
	Write-Errlog

	$lc_exit_code=$RC_NG
	Outmsg-End-Function

}

#
# ���b�Z�[�WID�ҏW(8���ɕҏW)
#
$msg_id = $msg_id.SubString(5,8)

#
# �ϕ����u��
#
#  �������u��
if ( $parm1 -ne $null ) {
	$msg_text = $msg_text -replace "&a1&", $parm1
}
else {
	$msg_text = $msg_text -replace "&a1&", " "
}

#  �������u��
if ( $parm2 -ne $null ) {
	$msg_text = $msg_text -replace "&a2&", $parm2
}
else {
	$msg_text = $msg_text -replace "&a2&", " "
}

#  ��O�����u��
if ( $parm3 -ne $null ) {
	$msg_text = $msg_text -replace "&a3&", $parm3
}
else {
	$msg_text = $msg_text -replace "&a3&", " "
}


#
# �G���[�R�[�h�Z�b�g
#
if ( $error_code -eq $RC_OK ) {
	$msg_error_code = ""
}
else {
	$msg_error_code = $error_code
}


#
# ���b�Z�[�W�o��
#
$out_msg = "$msg_id $msg_line $msg_text [$OM_BATNAME($USER)] $msg_error_code"
Write-Errlog


Outmsg-End-Function
