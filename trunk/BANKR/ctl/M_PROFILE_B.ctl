-- ============================================================================
--  COPYRIGHT INFORMATION SERVICES INTERNATIONAL-DENTSU,LTD.
--  LICENSED MATERIAL - PROGRAM PROPERTY OF iSiD
-- ============================================================================
--
--  SYSTEM   : BANK�ER �R���^�N�g�Z���^�[
--
--  TABLE    : TF_�ڋq�v���t�@�C��B
--
--  Mod   yy/mm/dd   Coder    Comment
-- -----+------------+-------------+---------------------------------------------
--  %00 | 15/01/28   | �y�� �N��Y | ���������s 1.0�� First Eddition
-- ============================================================================

OPTIONS (direct=true,errors=100)
LOAD DATA
TRUNCATE
INTO TABLE TF_�ڋq�v���t�@�C��B
(
 �X��                POSITION (  1:  3) CHAR
,CIFNO               POSITION (  4: 13) CHAR
,�o�^��              POSITION ( 14: 21) CHAR
,�ؓ��K����        POSITION ( 22: 22) CHAR
,�E�ƃR�[�h          POSITION ( 23: 24) CHAR
,�E�Ɣ��l            POSITION ( 25: 64) CHAR
,�N���R�[�h          POSITION ( 65: 66) CHAR
,���Z���Y�R�[�h      POSITION ( 67: 68) CHAR
,�^�p���j�R�[�h      POSITION ( 69: 70) CHAR
,������@�R�[�h      POSITION ( 71: 72) CHAR
,�d�g�a��            POSITION ( 73: 73) CHAR
,�O�ݗa��            POSITION ( 74: 74) CHAR
,�~����z�N���ی�    POSITION ( 75: 75) CHAR
,�~���ϊz�N���ی�    POSITION ( 76: 76) CHAR
,�O�݌��N���ی�      POSITION ( 77: 77) CHAR
,�������M            POSITION ( 78: 78) CHAR
,�M�p�敨�������g    POSITION ( 79: 79) CHAR
,�O���،����MMMF     POSITION ( 80: 80) CHAR
,�]���Ѝ�            POSITION ( 81: 81) CHAR
,���Ѝ��MMMF       POSITION ( 82: 82) CHAR
,�d�g��              POSITION ( 83: 83) CHAR
,�����A����          POSITION ( 84:103) CHAR
,�����A������l      POSITION (104:143) CHAR
    )
