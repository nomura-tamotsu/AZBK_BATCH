-- 引数1 取得開始年月(yyyy/mm)
-- 引数2 取得終了年月(yyyy/mm)
-- 引数3 保管ファイル名

set pages 50
set line 1000
set verify off
col TABLESPACE_NAME format a15
col "SIZE(MB)"      format a20
col "USED(MB)"      format a20
col "FREE(MB)"      format a20
col "RATE(%)"       format 990.9

-- 保管ファイル名設定
spool D:\logfile\Perf\&3

-- テーブルスペース調査
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


-- 使用状況調査

set pages 200

select to_char(操作日時,'yyyy/mm'),センタID,count(*) from SPV.TH_操作履歴
where 操作日時 >= to_date('&1/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
and   操作日時 < to_date('&2/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
and   機能名 = 'ﾛｸﾞｲﾝ.ｵﾍﾟﾚｰﾀﾛｸﾞｲﾝ'
group by to_char(操作日時,'yyyy/mm'),センタID
order by to_char(操作日時,'yyyy/mm'),センタID;


-- 利用状況調査
select to_char(コール日時,'yyyy/mm'),受付センタID,着信番号,業務区分,count(*) from SPV.TH_コンタクト履歴
where コール日時 >= to_date('&1/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
and   コール日時 < to_date('&2/01 00:00:00','yyyy/mm/dd hh24:mi:ss')
group by to_char(コール日時,'yyyy/mm'),受付センタID,着信番号,業務区分
order by to_char(コール日時,'yyyy/mm'),受付センタID,着信番号,業務区分;

spool OFF


exit;