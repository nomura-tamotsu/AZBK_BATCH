--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK�ER �R���^�N�g�Z���^�[                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_�ڋq�v���t�@�C��                                           */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/26 | �y�� �N��Y | 1.0���Ή�                                 */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_�ڋq�v���t�@�C��
    (�X��
    ,CIFNO
    ,�o�^��
    ,�ؓ��K����
    ,�E�ƃR�[�h
    ,�E�Ɣ��l
    ,�N���R�[�h
    ,���Z���Y�R�[�h
    ,�^�p���j�R�[�h
    ,������@�R�[�h
    ,�d�g�a��
    ,�O�ݗa��
    ,�~����z�N���ی�
    ,�~���ϊz�N���ی�
    ,�O�݌��N���ی�
    ,�������M
    ,�M�p�敨�������g
    ,�O���،����MMMF
    ,�]���Ѝ�
    ,���Ѝ��MMMF
    ,�����A����
    ,�����A������l
    ,�d�g��
    )
 AS SELECT
    TF_�ڋq�v���t�@�C��A.�X��
    ,TF_�ڋq�v���t�@�C��A.CIFNO
    ,TF_�ڋq�v���t�@�C��A.�o�^��
    ,TF_�ڋq�v���t�@�C��A.�ؓ��K����
    ,TF_�ڋq�v���t�@�C��A.�E�ƃR�[�h
    ,TF_�ڋq�v���t�@�C��A.�E�Ɣ��l
    ,TF_�ڋq�v���t�@�C��A.�N���R�[�h
    ,TF_�ڋq�v���t�@�C��A.���Z���Y�R�[�h
    ,TF_�ڋq�v���t�@�C��A.�^�p���j�R�[�h
    ,TF_�ڋq�v���t�@�C��A.������@�R�[�h
    ,TF_�ڋq�v���t�@�C��A.�d�g�a��
    ,TF_�ڋq�v���t�@�C��A.�O�ݗa��
    ,TF_�ڋq�v���t�@�C��A.�~����z�N���ی�
    ,TF_�ڋq�v���t�@�C��A.�~���ϊz�N���ی�
    ,TF_�ڋq�v���t�@�C��A.�O�݌��N���ی�
    ,TF_�ڋq�v���t�@�C��A.�������M
    ,TF_�ڋq�v���t�@�C��A.�M�p�敨�������g
    ,TF_�ڋq�v���t�@�C��A.�O���،����MMMF
    ,TF_�ڋq�v���t�@�C��A.�]���Ѝ�
    ,TF_�ڋq�v���t�@�C��A.���Ѝ��MMMF
    ,TF_�ڋq�v���t�@�C��A.�����A����
    ,TF_�ڋq�v���t�@�C��A.�����A������l
    ,TF_�ڋq�v���t�@�C��A.�d�g��
 FROM TF_�ڋq�v���t�@�C��A
;
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.CIFNO IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�o�^�� IS '';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�ؓ��K���� IS '0�F���Ȃ��@�P�F��肠��';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�E�ƃR�[�h IS '1:��Ј� 2�F��Ж��� 3�F�������E�c�̐E�� 4�F��t�E�ٌ�m�� 5�F���c�ƁE�T�[�r�X�� 6�F���E�� 7�F�_�сE���Y 8�F���R�� 9�F���E 10�F���̑� ';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�E�Ɣ��l IS '���l�F�S�p20����';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�N���R�[�h IS '1�F500���~���� 2�F500���~�ȏ�`1000���~���� 3�F1000���~�ȏ�`3000���~���� 4�F3000���~�ȏ�`5000���~���� 5�F5000���~�ȏ�`�P���~���� 6�F�P���~�ȏ� ';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.���Z���Y�R�[�h IS '1�F500���~���� 2�F500���~�ȏ�`1000���~���� 3�F1000���~�ȏ�`3000���~���� 4�F3000���~�ȏ�`5000���~���� 5�F5000���~�ȏ�`�P���~���� 6�F�P���~�ȏ�`�R���~���� 7�F�R���~�ȏ�`�P�O���~���� 8�F�P�O���~�ȏ� ';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�^�p���j�R�[�h IS '1�F���{�ۏ� 2�F���萫�d�� 3�F���v���ƈ��萫�̃o�����X�d�� 4�F���v���d�� ';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.������@�R�[�h IS '1�F�m�l�̏Љ� 2�F�_�C���N�g���[�� 3�F�V���E�G���E�C���^�[�l�b�g 4�F�K��E�d�b�E�X���ɂ�銩�U ';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�d�g�a�� IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�O�ݗa�� IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�~����z�N���ی� IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�~���ϊz�N���ی� IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�O�݌��N���ی� IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�������M IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�M�p�敨�������g IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�O���،����MMMF IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�]���Ѝ� IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.���Ѝ��MMMF IS '0�F�m���E�o���Ȃ��@1�F�m������E�o���Ȃ��@2�F�m���E�o������';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�����A���� IS '�s�O�ǔ�-�s���ǔ�-�����Ҕԍ�';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�����A������l IS '���l�F�S�p20����';
COMMENT ON COLUMN TF_�ڋq�v���t�@�C��.�d�g�� IS '0�F�m���E�o���Ȃ��A1�F�m������E�o���Ȃ��A2�F�m���E�o������';
EXIT;
