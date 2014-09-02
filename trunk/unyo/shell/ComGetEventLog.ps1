#============================================================================
# COPYRIGHT iSID Dentsu LTD. 2014
# LICENSED MATERIAL - PROGRAM PROPERTY OF ISID
#============================================================================
#
# SYSTEM    : BANK*R CC
#
# FILE      : �C�x���g���O�擾�p���ʊ֐�
#
# ModName   : ComGetEventLog
#
# Condition : UnyoEnv & ComFunction files inclusion
#
#----------------------------------------------------------------------------
# Mod   yy/mm/dd   Coder           Comment
#-----+----------+---------------+-------------------------------------------
# %00 | 14/03/11 | R.YAMANO      | First Eddition
#============================================================================
#----------------------------------------------------------------------#
# ComGetEventLog for BANK*R CC  Ver.1.0.0                              #
#----------------------------------------------------------------------#

#----------------------------------------------------------------------#
# F01.�C�x���g���O�擾����                                             #
#----------------------------------------------------------------------#
# F01.1 Get EventLog output to a CSV File
# (�T�v)
#  �C�x���g���O�擾����(CSV�t�@�C���^��) 
#  �擾�Ώۓ�����00:00�`24:00�Ԃɔ��������C�x���g���O���擾����
#  - ��P�����F�C�x���g���O��� (0,1,2)       (�K�{)
#    (0:�Z�L�����e�B,1:�A�v���P�[�V����,2:�V�X�e��)
#  - ��Q�����F�o�̓t�@�C����(FullPath)       (�K�{)
#  - ��R�����F�擾�Ώۓ���(YYYYMMDD)         (�K�{)
#  (���ӎ���) ���t�@���N�V�����@�\���p�͊Ǘ��Ҍ������K�v
#----------------------------------------------------------------------#
function FC_GetEventLog ( [string] ${LC_EVNCODE},[string] ${LC_CSVNAME}, [string] ${LC_GETDATE} )
{

    # GetEvent �擾����
    # (YYYYMMDD) -> (YYYY/MM/DD)
    ${LC_DATE01}        = ${LC_GETDATE}.Insert(4,"/").Insert(7,"/")
    ${TG_START_GETDATE} = ${LC_DATE01}
    # ${LC_DATE02}        = Get-Date ${LC_DATE01} | %{ $_.AddDays(1) } | %{ $_.ToString(${COM_DATEFORM02}) }
    ${LC_DATE02}        = (Get-Date ${LC_DATE01}).AddDays(1).ToString(${COM_DATEFORM02})
    ${TG_ENDTM_GETDATE} = ${LC_DATE02}
    # �C�x���g���O�擾(Type2)
    ${LC_EVENTS} = Get-EventLog ${COM_EVNTYPE}[${LC_EVNCODE}] -After ${TG_START_GETDATE} -Before ${TG_ENDTM_GETDATE} 

    FC_LogWriter ${DEF_RTNCD_NML} "�Ώۓ���[${TG_START_GETDATE}]�̃C�x���g���O�擾���������{���܂��B"

    # CSV�o��
    ${HEDER_LINE} = "`"" + "���"            + "`"" + ","  + "`"" + "�C�x���g" + "`"" + "," `
                  + "`"" + "���t�Ǝ���"      + "`"" + ","  + "`"" + "�\�[�X"   + "`"" + "," `
                  + "`"" + "�R���s���[�^��"  + "`"" + ","  + "`"" + "�J�e�S��" + "`"" + "," `
                  + "`"" + "���[�U�["        + "`"" + ","  + "`"" + "����"     + "`"" 

    ${HEDER_LINE} | Out-File -FilePath  ${LC_CSVNAME} -Encoding default

    for ( ${i} = 0; ${i} -lt ${LC_EVENTS}.length; ${i}++ )  {
        # �A�J�E���g�̎擾
        ${LC_EVEUSR} = ${LC_EVENTS}[${i}].ReplacementStrings[1] 
        #���s������
        ${LC_EVEMSG} = ${LC_EVENTS}[${i}].Message
        ${LC_EVEMSG} = ${LC_EVEMSG} -replace "`n" , ""
        ${LC_EVEMSG} = ${LC_EVEMSG} -replace "`r" , ""
        # ���t�̌^���ϊ�
        ${LC_EVETIME} = ${LC_EVENTS}[${i}].TimeGenerated
        ${LC_EVETIME} = ${LC_EVETIME} -as [DateTime]
        ${LC_EVETIME} = ${LC_EVETIME}.ToString("yyyy/MM/dd HH:mm:ss")

        ${LC_LINE} = "`"" + ${LC_EVENTS}[${i}].EntryType + "`"" + "," + "`"" + ${LC_EVENTS}[${i}].EventID  + "`"" + "," `
                   + "`"" + ${LC_EVETIME}                + "`"" + "," + "`"" + ${LC_EVENTS}[${i}].Source   + "`"" + "," `
                   + "`"" + ${LC_EVENTS}[$i].MachineName + "`"" + "," + "`"" + ${LC_EVENTS}[${i}].Category + "`"" + "," `
                   + "`"" + ${LC_EVEUSR}                 + "`"" + "," + "`"" + ${LC_EVEMSG} + "`""

        ${LC_LINE} | Out-File -FilePath ${LC_CSVNAME} -Append -encoding default

    }

    FC_LogWriter ${DEF_RTNCD_NML} "�Ώۓ���[${TG_START_GETDATE}]�̃C�x���g���O�擾�������I�����܂��B"

}
