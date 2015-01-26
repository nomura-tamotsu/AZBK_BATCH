--/*==========================================================================*/
--/* COPYRIGHT Information Services International-Dentsu, Ltd.                */
--/*==========================================================================*/
--/*                                                                          */
--/* SYSTEM   : BANK�ER �R���^�N�g�Z���^�[                                    */
--/*                                                                          */
--/* FILE     : CREATE VIEW SCRIPT.                                           */
--/* TABLE    : TF_���ё���                                                   */
--/*                                                                          */
--/* Mod   yy/mm/dd   Coder         Comment                                   */
--/*-----+----------+-------------+-------------------------------------------*/
--/* %00 | 15/01/15 | �y�� �N��Y | First Eddition.                           */
--/*==========================================================================*/

CREATE OR REPLACE VIEW TF_���ё���
    (�X��
    ,CIFNO
    ,�l��Ɣԍ�
    ,�l�i�敪
    ,���єԍ�
    ,��������
    ,���������X�V�t���O
    ,�����J�i
    ,�����J�i�X�V�t���O
    ,����
    ,���ʍX�V�t���O
    ,���N����
    ,���N�����X�V�t���O
    ,�Z���R�[�h
    ,�X�֔ԍ�
    ,�⏕�Z��
    ,�Z���ύX�t���O
    ,�⏕�Z���J�i
    ,�Z���J�i�ύX�t���O
    ,����d�b�ԍ�
    ,����d�b�ԍ��X�V�t���O
    ,����FAX�ԍ�
    ,����FAX�ԍ��X�V�t���O
    ,�g�ѓd�b�ԍ�
    ,�g�ѓd�b�ԍ��X�V�t���O
    ,MAIL�A�h���X
    ,MAIL�A�h���X�X�V�t���O
    ,�Ζ��於
    ,�Ζ��於�X�V�t���O
    ,�Ζ��於�J�i
    ,�Ζ��於�J�i�X�V�t���O
    ,�Ζ���d�b�ԍ�
    ,�Ζ���d�b�ԍ��X�V�t���O
    ,�A����Z���R�[�h
    ,�A����X�֔ԍ�
    ,�A����⏕�Z��
    ,�A����Z���ύX�t���O
    ,�A����⏕�Z���J�i
    ,�A����Z���J�i�ύX�t���O
    ,�A����d�b�ԍ�
    ,�A����d�b�ԍ��X�V�t���O
    ,�A����FAX�ԍ�
    ,�A����FAX�ԍ��X�V�t���O
    ,�����A����d�b�ԍ�
    ,�����A����d�b�ԍ��X�V�t���O
    ,����J�n��
    ,���ю�t���O
    ,�s���敪
    ,�X�֕s��
    ,��З�
    ,�d�b�ԍ��ԈႢ
    ,�ړ]
    ,�{�l���S
    ,�ē��敪
    ,�D�ǋ敪
    ,�������
    ,�}���D�\���z
    ,�}���D���p�z
    ,�}�����\���z
    ,�}�������p�z
    ,���s���Z���Y�c��
    ,�a�莑�Y�c���P
    ,�a�莑�Y�c���Q
    ,�a�莑�Y�c���R
    ,�������a���c��
    ,������a���c��
    ,�d�g�a���c��
    ,�O�ݗa���c��
    ,���M�c��
    ,���c��
    ,���X�N���i�c��
    ,�e���o���_��
    ,�e���o���_���
    ,IB�_��
    ,IB�_���ID
    ,IB�_��\���X��
    ,IB�_���\�����Ȗ�
    ,IB�_���\�����ԍ�
    ,IB�_���
    ,IB�_�������
    ,IB�_��ŏI�X�V��
    ,�l�b�g�x�X�_��
    ,�l�b�g�x�X�_���ID
    ,�l�b�g�x�X�_��\���X��
    ,�l�b�g�x�X�_���\�����Ȗ�
    ,�l�b�g�x�X�_���\�������ԍ�
    ,�l�b�g�x�X�_���
    ,�l�b�g�x�X�_�������
    ,�l�b�g�x�X�_��ŏI�X�V��
    ,�z�X�gTM�Ώۋ敪
    ,�z�X�gDM�Ώۋ敪
    ,TM�Ώۋ敪
    ,DM�Ώۋ敪
    ,�E�ƃR�[�h
    ,�N��
    ,�����N�x
    ,����Ǘ����
    ,�S���Җ�
    ,�J�[�h���s�T�C��
    ,����Z���s���{��
    ,����Z���s�撬��
    ,����Z���厚�ʏ�
    ,����Z��������
    ,����Z���Ԓn�C�t
    ,����Z���C�t
    ,����Z���s���{���J�i
    ,����Z���s�撬���J�i
    ,����Z���厚�ʏ̃J�i
    ,����Z�������ڃJ�i
    ,����Z���Ԓn�C�t�J�i
    ,����Z���C�t�J�i
    ,����Z��
    ,����Z���J�i
    ,�A����Z���s���{��
    ,�A����Z���s�撬��
    ,�A����Z���厚�ʏ�
    ,�A����Z��������
    ,�A����Z���Ԓn�C�t
    ,�A����Z���C�t
    ,�A����Z���s���{���J�i
    ,�A����Z���s�撬���J�i
    ,�A����Z���厚�ʏ̃J�i
    ,�A����Z�������ڃJ�i
    ,�A����Z���Ԓn�C�t�J�i
    ,�A����Z���C�t�J�i
    ,�A����Z��
    ,�A����Z���J�i
    ,�f�[�^���
    ,�}���D
    )
 AS SELECT
    TF_���ё���A.�X��
    ,TF_���ё���A.CIFNO
    ,TF_���ё���A.�l��Ɣԍ�
    ,TF_���ё���A.�l�i�敪
    ,TF_���ё���A.���єԍ�
    ,TF_���ё���A.��������
    ,TF_���ё���A.���������X�V�t���O
    ,TF_���ё���A.�����J�i
    ,TF_���ё���A.�����J�i�X�V�t���O
    ,TF_���ё���A.����
    ,TF_���ё���A.���ʍX�V�t���O
    ,TF_���ё���A.���N����
    ,TF_���ё���A.���N�����X�V�t���O
    ,TF_���ё���A.�Z���R�[�h
    ,TF_���ё���A.�X�֔ԍ�
    ,TF_���ё���A.�⏕�Z��
    ,TF_���ё���A.�Z���ύX�t���O
    ,TF_���ё���A.�⏕�Z���J�i
    ,TF_���ё���A.�Z���J�i�ύX�t���O
    ,TF_���ё���A.����d�b�ԍ�
    ,TF_���ё���A.����d�b�ԍ��X�V�t���O
    ,TF_���ё���A.����FAX�ԍ�
    ,TF_���ё���A.����FAX�ԍ��X�V�t���O
    ,TF_���ё���A.�g�ѓd�b�ԍ�
    ,TF_���ё���A.�g�ѓd�b�ԍ��X�V�t���O
    ,TF_���ё���A.MAIL�A�h���X
    ,TF_���ё���A.MAIL�A�h���X�X�V�t���O
    ,TF_���ё���A.�Ζ��於
    ,TF_���ё���A.�Ζ��於�X�V�t���O
    ,TF_���ё���A.�Ζ��於�J�i
    ,TF_���ё���A.�Ζ��於�J�i�X�V�t���O
    ,TF_���ё���A.�Ζ���d�b�ԍ�
    ,TF_���ё���A.�Ζ���d�b�ԍ��X�V�t���O
    ,TF_���ё���A.�A����Z���R�[�h
    ,TF_���ё���A.�A����X�֔ԍ�
    ,TF_���ё���A.�A����⏕�Z��
    ,TF_���ё���A.�A����Z���ύX�t���O
    ,TF_���ё���A.�A����⏕�Z���J�i
    ,TF_���ё���A.�A����Z���J�i�ύX�t���O
    ,TF_���ё���A.�A����d�b�ԍ�
    ,TF_���ё���A.�A����d�b�ԍ��X�V�t���O
    ,TF_���ё���A.�A����FAX�ԍ�
    ,TF_���ё���A.�A����FAX�ԍ��X�V�t���O
    ,TF_���ё���A.�����A����d�b�ԍ�
    ,TF_���ё���A.�����A����d�b�ԍ��X�V�t���O
    ,TF_���ё���A.����J�n��
    ,TF_���ё���A.���ю�t���O
    ,TF_���ё���A.�s���敪
    ,TF_���ё���A.�X�֕s��
    ,TF_���ё���A.��З�
    ,TF_���ё���A.�d�b�ԍ��ԈႢ
    ,TF_���ё���A.�ړ]
    ,TF_���ё���A.�{�l���S
    ,TF_���ё���A.�ē��敪
    ,TF_���ё���A.�D�ǋ敪
    ,TF_���ё���A.�������
    ,TF_���ё���A.�}���D�\���z
    ,TF_���ё���A.�}���D���p�z
    ,TF_���ё���A.�}�����\���z
    ,TF_���ё���A.�}�������p�z
    ,TF_���ё���A.���s���Z���Y�c��
    ,TF_���ё���A.�a�莑�Y�c���P
    ,TF_���ё���A.�a�莑�Y�c���Q
    ,TF_���ё���A.�a�莑�Y�c���R
    ,TF_���ё���A.�������a���c��
    ,TF_���ё���A.������a���c��
    ,TF_���ё���A.�d�g�a���c��
    ,TF_���ё���A.�O�ݗa���c��
    ,TF_���ё���A.���M�c��
    ,TF_���ё���A.���c��
    ,TF_���ё���A.���X�N���i�c��
    ,TF_���ё���A.�e���o���_��
    ,TF_���ё���A.�e���o���_���
    ,TF_���ё���A.IB�_��
    ,TF_���ё���A.IB�_���ID
    ,TF_���ё���A.IB�_��\���X��
    ,TF_���ё���A.IB�_���\�����Ȗ�
    ,TF_���ё���A.IB�_���\�����ԍ�
    ,TF_���ё���A.IB�_���
    ,TF_���ё���A.IB�_�������
    ,TF_���ё���A.IB�_��ŏI�X�V��
    ,TF_���ё���A.�l�b�g�x�X�_��
    ,TF_���ё���A.�l�b�g�x�X�_���ID
    ,TF_���ё���A.�l�b�g�x�X�_��\���X��
    ,TF_���ё���A.�l�b�g�x�X�_���\�����Ȗ�
    ,TF_���ё���A.�l�b�g�x�X�_���\�������ԍ�
    ,TF_���ё���A.�l�b�g�x�X�_���
    ,TF_���ё���A.�l�b�g�x�X�_�������
    ,TF_���ё���A.�l�b�g�x�X�_��ŏI�X�V��
    ,TF_���ё���A.�z�X�gTM�Ώۋ敪
    ,TF_���ё���A.�z�X�gDM�Ώۋ敪
    ,TF_���ё���A.TM�Ώۋ敪
    ,TF_���ё���A.DM�Ώۋ敪
    ,TF_���ё���A.�E�ƃR�[�h
    ,TF_���ё���A.�N��
    ,TF_���ё���A.�����N�x
    ,TF_���ё���A.����Ǘ����
    ,TF_���ё���A.�S���Җ�
    ,TF_���ё���A.�J�[�h���s�T�C��
    ,TF_���ё���A.����Z���s���{��
    ,TF_���ё���A.����Z���s�撬��
    ,TF_���ё���A.����Z���厚�ʏ�
    ,TF_���ё���A.����Z��������
    ,TF_���ё���A.����Z���Ԓn�C�t
    ,TF_���ё���A.����Z���C�t
    ,TF_���ё���A.����Z���s���{���J�i
    ,TF_���ё���A.����Z���s�撬���J�i
    ,TF_���ё���A.����Z���厚�ʏ̃J�i
    ,TF_���ё���A.����Z�������ڃJ�i
    ,TF_���ё���A.����Z���Ԓn�C�t�J�i
    ,TF_���ё���A.����Z���C�t�J�i
    ,TF_���ё���A.����Z��
    ,TF_���ё���A.����Z���J�i
    ,TF_���ё���A.�A����Z���s���{��
    ,TF_���ё���A.�A����Z���s�撬��
    ,TF_���ё���A.�A����Z���厚�ʏ�
    ,TF_���ё���A.�A����Z��������
    ,TF_���ё���A.�A����Z���Ԓn�C�t
    ,TF_���ё���A.�A����Z���C�t
    ,TF_���ё���A.�A����Z���s���{���J�i
    ,TF_���ё���A.�A����Z���s�撬���J�i
    ,TF_���ё���A.�A����Z���厚�ʏ̃J�i
    ,TF_���ё���A.�A����Z�������ڃJ�i
    ,TF_���ё���A.�A����Z���Ԓn�C�t�J�i
    ,TF_���ё���A.�A����Z���C�t�J�i
    ,TF_���ё���A.�A����Z��
    ,TF_���ё���A.�A����Z���J�i
    ,TF_���ё���A.�f�[�^���
    ,TF_���ё���A.�}���D
 FROM TF_���ё���A
;
COMMENT ON COLUMN TF_���ё���.�X�� IS 'TM_�c�ƓX.�X�Ԃ��Q�ƁB';
COMMENT ON COLUMN TF_���ё���.CIFNO IS '�L������10���i�Œ蒷�j';
COMMENT ON COLUMN TF_���ё���.�l��Ɣԍ� IS '�l��Ɣԍ��F"99999999999"�Œ�@�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�l�i�敪 IS '0�F�l�@1�F�@�l�@2�F���Ɛ��l�@�i�O�Œ�j';
COMMENT ON COLUMN TF_���ё���.���єԍ� IS '10���Œ�';
COMMENT ON COLUMN TF_���ё���.�������� IS '�S�p40����';
COMMENT ON COLUMN TF_���ё���.���������X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�����J�i IS '���p�J�i';
COMMENT ON COLUMN TF_���ё���.�����J�i�X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.���� IS '1�F�j��  2�F����  0�F�s��';
COMMENT ON COLUMN TF_���ё���.���ʍX�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.���N���� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_���ё���.���N�����X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�Z���R�[�h IS 'TF_�Z��.�Z���R�[�h���Q�ƁB�Z���R�[�h�������ꍇ��"00000000000"��ݒ�';
COMMENT ON COLUMN TF_���ё���.�X�֔ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.�⏕�Z�� IS '�S�p�̂�50����';
COMMENT ON COLUMN TF_���ё���.�Z���ύX�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�⏕�Z���J�i IS '���p�J�i�̂�60�����@ �����ڃJ�i(40����)+ "���p�X�y�[�X" + �Ԓn�J�i(30����) + "���p�X�y�[�X" + �C�t�J�i�i30�����j���ݒ�i���𒴂���ꍇ��60�����܂ł��ݒ肳���j';
COMMENT ON COLUMN TF_���ё���.�Z���J�i�ύX�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.����d�b�ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.����d�b�ԍ��X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.����FAX�ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.����FAX�ԍ��X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�g�ѓd�b�ԍ� IS '�y���g�p�z�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.�g�ѓd�b�ԍ��X�V�t���O IS '�y���g�p�zBLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.MAIL�A�h���X IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.MAIL�A�h���X�X�V�t���O IS '�y���g�p�zBLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�Ζ��於 IS '';
COMMENT ON COLUMN TF_���ё���.�Ζ��於�X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�Ζ��於�J�i IS '���p�J�i';
COMMENT ON COLUMN TF_���ё���.�Ζ��於�J�i�X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�Ζ���d�b�ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.�Ζ���d�b�ԍ��X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�A����Z���R�[�h IS 'TF_�Z��.�Z���R�[�h���Q�ƁB�Z���R�[�h�������ꍇ��"00000000000"��ݒ�';
COMMENT ON COLUMN TF_���ё���.�A����X�֔ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.�A����⏕�Z�� IS '�S�p50����';
COMMENT ON COLUMN TF_���ё���.�A����Z���ύX�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�A����⏕�Z���J�i IS '���p�J�i';
COMMENT ON COLUMN TF_���ё���.�A����Z���J�i�ύX�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�A����d�b�ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.�A����d�b�ԍ��X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�A����FAX�ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.�A����FAX�ԍ��X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.�����A����d�b�ԍ� IS '�n�C�t���ҏW����';
COMMENT ON COLUMN TF_���ё���.�����A����d�b�ԍ��X�V�t���O IS 'BLANK:���X�V  *:�X�V';
COMMENT ON COLUMN TF_���ё���.����J�n�� IS '����YYYYMMDD�B�������̏ꍇ�͎�t���B';
COMMENT ON COLUMN TF_���ё���.���ю�t���O IS '1�F���ю� 0�F����ȊO';
COMMENT ON COLUMN TF_���ё���.�s���敪 IS '0�F��ʁ@1�F�s���i0�Œ�j';
COMMENT ON COLUMN TF_���ё���.�X�֕s�� IS '0:���̑�  1:�s����';
COMMENT ON COLUMN TF_���ё���.��З� IS '�y���g�p�z0:���̑�  1:��З��@�i0�Œ�j';
COMMENT ON COLUMN TF_���ё���.�d�b�ԍ��ԈႢ IS '�y���g�p�z0:���̑�  1:�d�b�ԍ��ԈႢ�@�i0�Œ�j';
COMMENT ON COLUMN TF_���ё���.�ړ] IS '�y���g�p�z0:���̑�  1:�ړ]�@�i0�Œ�j';
COMMENT ON COLUMN TF_���ё���.�{�l���S IS '0:���̑�  1:���S';
COMMENT ON COLUMN TF_���ё���.�ē��敪 IS '�y���g�p�z0:�ē��v  1:�ē���';
COMMENT ON COLUMN TF_���ё���.�D�ǋ敪 IS '�y���g�p�z0�F�ʏ�  1�FVIP';
COMMENT ON COLUMN TF_���ё���.������� IS '0�F�ʏ�  1�F�������';
COMMENT ON COLUMN TF_���ё���.�}���D�\���z IS '�y���g�p�z�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.�}���D���p�z IS '�y���g�p�z�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.�}�����\���z IS '�y���g�p�z�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.�}�������p�z IS '�y���g�p�z�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.���s���Z���Y�c�� IS '�P��:�~�B �a�莑�Y�c���R';
COMMENT ON COLUMN TF_���ё���.�a�莑�Y�c���P IS '�P��:�~�B������a���c��+���c��';
COMMENT ON COLUMN TF_���ё���.�a�莑�Y�c���Q IS '�P��:�~�B�a�莑�Y�c���P+�������a���c��';
COMMENT ON COLUMN TF_���ё���.�a�莑�Y�c���R IS '�P��:�~�B�a�莑�Y�c��2+�O�ݗa���c��+���M�c��';
COMMENT ON COLUMN TF_���ё���.�������a���c�� IS '�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.������a���c�� IS '�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.�d�g�a���c�� IS '�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.�O�ݗa���c�� IS '�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.���M�c�� IS '�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.���c�� IS '�P��:�~�B';
COMMENT ON COLUMN TF_���ё���.���X�N���i�c�� IS '�P��:�~�B�d�g�a���c���{�O�ݗa���c���{���M�c��';
COMMENT ON COLUMN TF_���ё���.�e���o���_�� IS '0:�Ȃ� 1:�_��@9:���';
COMMENT ON COLUMN TF_���ё���.�e���o���_��� IS 'YYYYMMDD�B�e���o���_��=1�̏ꍇ�_����A:�e���o���_��=9�̏ꍇ����������';
COMMENT ON COLUMN TF_���ё���.IB�_�� IS '0:�Ȃ� 1:�_��@9:���';
COMMENT ON COLUMN TF_���ё���.IB�_���ID IS '10���Œ蒷';
COMMENT ON COLUMN TF_���ё���.IB�_��\���X�� IS '3���Œ蒷';
COMMENT ON COLUMN TF_���ё���.IB�_���\�����Ȗ� IS '4���Œ�B emusc�R�[�h�\.�Ȗ�ID���Q��';
COMMENT ON COLUMN TF_���ё���.IB�_���\�����ԍ� IS '7���Œ蒷';
COMMENT ON COLUMN TF_���ё���.IB�_��� IS '';
COMMENT ON COLUMN TF_���ё���.IB�_������� IS '';
COMMENT ON COLUMN TF_���ё���.IB�_��ŏI�X�V�� IS '';
COMMENT ON COLUMN TF_���ё���.�l�b�g�x�X�_�� IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�l�b�g�x�X�_���ID IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�l�b�g�x�X�_��\���X�� IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�l�b�g�x�X�_���\�����Ȗ� IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�l�b�g�x�X�_���\�������ԍ� IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�l�b�g�x�X�_��� IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�l�b�g�x�X�_������� IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�l�b�g�x�X�_��ŏI�X�V�� IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�z�X�gTM�Ώۋ敪 IS '�A���L���s�d�k�v�ہ@0�FTM�Ώې�@1�FTM�֎~��';
COMMENT ON COLUMN TF_���ё���.�z�X�gDM�Ώۋ敪 IS '�A���L���c�l�v�ہ@0�FDM�Ώې�@1�FDM�֎~��';
COMMENT ON COLUMN TF_���ё���.TM�Ώۋ敪 IS '0�F�Ώ�  1�F�ΏۊO';
COMMENT ON COLUMN TF_���ё���.DM�Ώۋ敪 IS '0�F�Ώ�  1�F�ΏۊO';
COMMENT ON COLUMN TF_���ё���.�E�ƃR�[�h IS '�E�ƃ}�X�^.�E�Ƃ��Q��';
COMMENT ON COLUMN TF_���ё���.�N�� IS '�������f�[�^�Ƃ��Ďg�p�B�~�P�� ZZZZZZZZZZZZZZ9.00';
COMMENT ON COLUMN TF_���ё���.�����N�x IS '�������f�[�^�Ƃ��Ďg�p�BYYYY';
COMMENT ON COLUMN TF_���ё���.����Ǘ���� IS '�O�F�Ȃ��@�P�F�L��';
COMMENT ON COLUMN TF_���ё���.�S���Җ� IS '�S�p�P�Q����';
COMMENT ON COLUMN TF_���ё���.�J�[�h���s�T�C�� IS '0:�P�̃J�[�h�A�v���X�J�[�h�Ȃ��A1:�P�̃J�[�h����A2:�v���X�J�[�h����A3:�P�̃J�[�h�A�v���X�J�[�h����';
COMMENT ON COLUMN TF_���ё���.����Z���s���{�� IS '�S�p�T���� ���l�߁B�Z���̓o�^�������ꍇ�́u�o�^�Ȃ��v���ݒ�B';
COMMENT ON COLUMN TF_���ё���.����Z���s�撬�� IS '�S�p�P�Q���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z���厚�ʏ� IS '�S�p�P�W���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z�������� IS '�S�p�Q�O���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z���Ԓn�C�t IS '�S�p�T�O���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z���C�t IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.����Z���s���{���J�i IS '���p�J�i�P�O���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z���s�撬���J�i IS '���p�J�i�Q�S���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z���厚�ʏ̃J�i IS '���p�J�i�R�U���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z�������ڃJ�i IS '���p�J�i�S�O���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z���Ԓn�C�t�J�i IS '���p�J�i�W�S���� ���l��';
COMMENT ON COLUMN TF_���ё���.����Z���C�t�J�i IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.����Z�� IS '�S�p�W�T�����@���l�߁@����Z���i�s���{���j+����Z���i�s�撬���j+����Z���i�厚�ʏ́j+����Z���i�����ځj+����Z���i�Ԓn�j+����Z���i�C�t�j��A��';
COMMENT ON COLUMN TF_���ё���.����Z���J�i IS '���p�J�i�P�V�O�����@���l�߁@����Z���J�i�i�s���{���j+����Z���J�i�i�s�撬���j+����Z���J�i�i�厚�ʏ́j+����Z���J�i�i�����ځj+����Z���J�i�i�Ԓn�j+����Z���J�i�i�C�t�j��A��';
COMMENT ON COLUMN TF_���ё���.�A����Z���s���{�� IS '�S�p�T���� ���l�߁B';
COMMENT ON COLUMN TF_���ё���.�A����Z���s�撬�� IS '�S�p�P�Q���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z���厚�ʏ� IS '�S�p�P�W���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z�������� IS '�S�p�Q�O���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z���Ԓn�C�t IS '�S�p�T�O���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z���C�t IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�A����Z���s���{���J�i IS '���p�J�i�P�O���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z���s�撬���J�i IS '���p�J�i�Q�S���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z���厚�ʏ̃J�i IS '���p�J�i�R�U���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z�������ڃJ�i IS '���p�J�i�S�O���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z���Ԓn�C�t�J�i IS '���p�J�i�W�S���� ���l��';
COMMENT ON COLUMN TF_���ё���.�A����Z���C�t�J�i IS '�y���g�p�z';
COMMENT ON COLUMN TF_���ё���.�A����Z�� IS '�S�p�W�T�����@���l�߁@����Z���i�s���{���j+����Z���i�s�撬���j+����Z���i�厚�ʏ́j+����Z���i�����ځj+����Z���i�Ԓn�j+����Z���i�C�t�j��A��';
COMMENT ON COLUMN TF_���ё���.�A����Z���J�i IS '���p�J�i�P�V�O�����@���l�߁@����Z���J�i�i�s���{���j+����Z���J�i�i�s�撬���j+����Z���J�i�i�厚�ʏ́j+����Z���J�i�i�����ځj+����Z���J�i�i�Ԓn�j+����Z���J�i�i�C�t�j��A��';
COMMENT ON COLUMN TF_���ё���.�f�[�^��� IS '����YYYYMMDD';
COMMENT ON COLUMN TF_���ё���.�}���D IS '0�F�Ȃ�  1�F����';
EXIT;
