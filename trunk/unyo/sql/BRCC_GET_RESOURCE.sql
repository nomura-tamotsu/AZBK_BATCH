-- ����1 �擾�J�n�N��(yyyy/mm)
-- ����2 �擾�I���N��(yyyy/mm)
-- ����3 �ۊǃt�@�C����

set pages 50
set line 1000
set verify off
col TABLESPACE_NAME format a15
col "SIZE(MB)"      format a20
col "USED(MB)"      format a20
col "FREE(MB)"      format a20
col "RATE(%)"       format 990.9

-- �ۊǃt�@�C�����ݒ�
spool D:\logfile\Perf\&3

-- �e�[�u���X�y�[�X����
select
  tablespace_name,
  to_char(nvl(total_bytes / 1024 /1024,0),'999,999,999') as "SIZE(MB)",
  to_char(nvl((total_bytes - free_total_bytes) / 1024 / 1024 ,0),'999,999,999') as "USED(MB)",
  to_char(nvl(free_total_bytes/1024 /1024,0),'999,999,999') as "FREE(MB)",
  round(nvl((total_bytes - free_total_bytes) / total_bytes * 100,100),2) as "RATE(%)"
from
  ( select
      tablespace_name,
      sum(bytes) total_bytes
    from
      dba_data_files
    group by
      tablespace_name
  ),
  ( select
      tablespace_name free_tablespace_name,
      sum(bytes) free_total_bytes
    from
      dba_free_space
    group by tablespace_name
  )
where
  tablespace_name = free_tablespace_name(+);


-- �g�p�󋵒���

set pages 200

select to_char(�������,'yyyy/mm'),�Z���^ID,count(*) from SPV.TH_���엚��
where ������� >= to_date('&1/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
and   ������� < to_date('&2/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
and   �@�\�� = '۸޲�.���ڰ�۸޲�'
group by to_char(�������,'yyyy/mm'),�Z���^ID
order by to_char(�������,'yyyy/mm'),�Z���^ID;


-- ���p�󋵒���
select to_char(�R�[������,'yyyy/mm'),��t�Z���^ID,���M�ԍ�,�Ɩ��敪,count(*) from SPV.TH_�R���^�N�g����
where �R�[������ >= to_date('&1/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
and   �R�[������ < to_date('&2/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
group by to_char(�R�[������,'yyyy/mm'),��t�Z���^ID,���M�ԍ�,�Ɩ��敪
order by to_char(�R�[������,'yyyy/mm'),��t�Z���^ID,���M�ԍ�,�Ɩ��敪;

spool OFF


exit;