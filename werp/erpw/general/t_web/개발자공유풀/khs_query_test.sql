select
	max(t1.LAST_DDL_TIME)
From	t1 ,t3
where	t1.owner = t3.owner
and		t1.object_name = t3.table_name
/


select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		rownum < 2
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		distinct
		t3.owner,t3.table_name
	from	t3
)
/






select
	max(t1.LAST_DDL_TIME)
From	t1
where	Not exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		rownum < 2
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	Not exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) Not in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) Not in 
(
	select
		t3.owner,t3.table_name
	from	t3
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) Not in 
(
	select
		distinct
		t3.owner,t3.table_name
	from	t3
)
/







select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
	and		rownum < 2
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t3.owner = 'SYS'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		distinct
		t3.owner,t3.table_name
	from	t3
	where	t3.owner = 'SYS'
)
/









select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
	and		rownum < 2
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		distinct
		t3.owner,t3.table_name
	from	t3
	where	t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		rownum < 2
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		distinct
		t3.owner,t3.table_name
	from	t3
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
/
select
	max(t1.LAST_DDL_TIME)
From	t1 ,t3
where	t1.owner = t3.owner
and		t1.object_name = t3.table_name
and		t1.owner = 'SYS'
and		t1.object_name = 'ACCESS$'
/





select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.column_name = 'TABLE_NAME'
	and		rownum < 2
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.column_name = 'TABLE_NAME'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.column_name = 'TABLE_NAME'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t3.column_name = 'TABLE_NAME'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in 
(
	select
		distinct
		t3.owner,t3.table_name
	from	t3
	where	t3.column_name = 'TABLE_NAME'
)
/
select
	max(t1.LAST_DDL_TIME)
From	t1 ,t3
where	t1.owner = t3.owner
and		t1.object_name = t3.table_name
and		t3.column_name = 'TABLE_NAME'
/
select	/*+RULE*/
	max(t1.LAST_DDL_TIME)
From	t1 ,t3
where	t1.owner = t3.owner
and		t1.object_name = t3.table_name
and		t3.column_name = 'TABLE_NAME'
/




TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 09:29:52 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 09:29:52 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_2632.trc
Sort options: default
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************
alter session set sql_trace = true
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        1      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  rownum < 2
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      2.31       7.21      26150     529131          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      2.31       7.21      26150     529131          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
30376   FILTER
259392    TABLE ACCESS FULL T1
29912    COUNT STOPKEY
29912     INDEX RANGE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.65       5.60      26353      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.65       5.60      26353      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.75       5.74      26598      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.75       5.74      26598      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.59       5.50      26353      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.59       5.51      26353      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
distinct
t3.owner,t3.table_name
from t3
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.71       5.89      26353      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.71       5.89      26353      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
alter session set sql_trace = false
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        6      0.00       0.00          0          0          0           0
Execute      7      0.00       0.00          0          0          0           0
Fetch       10      5.03      29.96     131807     635207          0           5
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       23      5.03      29.97     131807     635207          0           5
Misses in library cache during parse: 5
OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      0      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        0      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
7  user  SQL statements in session.
0  internal SQL statements in session.
7  SQL statements in session.
********************************************************************************
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_2632.trc
Trace file compatibility: 9.00.01
Sort options: default
2  sessions in tracefile.
7  user  SQL statements in trace file.
0  internal SQL statements in trace file.
7  SQL statements in trace file.
7  unique SQL statements in trace file.
162  lines in trace file.

PL/SQL 처리가 정상적으로 완료되었습니다.









TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 09:38:48 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 09:38:48 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_2632.trc
Sort options: default
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************
alter session set sql_trace = true
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  rownum < 2
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      2.31       7.21      26150     529131          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      2.31       7.21      26150     529131          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
30376   FILTER
259392    TABLE ACCESS FULL T1
29912    COUNT STOPKEY
29912     INDEX RANGE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.65       5.60      26353      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.65       5.60      26353      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.75       5.74      26598      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.75       5.74      26598      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.59       5.50      26353      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.59       5.51      26353      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
distinct
t3.owner,t3.table_name
from t3
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.71       5.89      26353      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.71       5.89      26353      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
alter session set sql_trace = false
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        3      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        6      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where Not exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  rownum < 2
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        4      4.51      14.84      52426    1058262          0           2
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        8      4.51      14.84      52426    1058262          0           2
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
229016   FILTER
259392    TABLE ACCESS FULL T1
29912    COUNT STOPKEY
29912     INDEX RANGE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where Not exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.01       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        4      4.40      14.42      51864    1058262          0           2
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        8      4.42      14.42      51864    1058262          0           2
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
229016   FILTER
259392    TABLE ACCESS FULL T1
29912    INDEX RANGE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) Not in
(
select
t3.owner,t3.table_name
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.01       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        4      4.23      18.11      51873    1058262          0           2
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        8      4.25      18.12      51873    1058262          0           2
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
229016   FILTER
259392    TABLE ACCESS FULL T1
29912    INDEX RANGE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) Not in
(
select
t3.owner,t3.table_name
from t3
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        4      1.51      17.59      55736      53038          0           2
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        8      1.51      17.59      55736      53038          0           2
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
229016   HASH JOIN ANTI
259392    TABLE ACCESS FULL T1
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) Not in
(
select
distinct
t3.owner,t3.table_name
from t3
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        4      1.65      17.24      55767      53038          0           2
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        8      1.65      17.24      55767      53038          0           2
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
229016   HASH JOIN ANTI
259392    TABLE ACCESS FULL T1
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
********************************************************************************
OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse       18      0.03       0.01          0          0          0           0
Execute     21      0.00       0.00          0          0          0           0
Fetch       30     21.35     112.19     399473    3916069          0          15
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       69     21.39     112.20     399473    3916069          0          15
Misses in library cache during parse: 10
OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      0      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        0      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
21  user  SQL statements in session.
0  internal SQL statements in session.
21  SQL statements in session.
********************************************************************************
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_2632.trc
Trace file compatibility: 9.00.01
Sort options: default
3  sessions in tracefile.
35  user  SQL statements in trace file.
0  internal SQL statements in trace file.
21  SQL statements in trace file.
12  unique SQL statements in trace file.
424  lines in trace file.

PL/SQL 처리가 정상적으로 완료되었습니다.









TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 09:47:40 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 09:47:40 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_2504.trc
Sort options: default
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************
alter session set sql_trace = true
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 74
********************************************************************************
select null
from
dual
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          3          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          3          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 74
Rows     Row Source Operation
-------  ---------------------------------------------------
1  TABLE ACCESS FULL DUAL
********************************************************************************
begin sys.dbms_application_info.set_module('PL/SQL Developer', :action); end;

call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           1
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 74
********************************************************************************
begin
if :enable = 0 then
sys.dbms_output.disable;
else
sys.dbms_output.enable(:size);
end if;
end;
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           1
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           1
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 74
********************************************************************************
begin :id := sys.dbms_transaction.local_transaction_id; end;
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           2
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0          0          0           2
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 74
********************************************************************************
select 'x'
from
dual
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        1      0.00       0.00          0          3          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          3          0           1
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 74
Rows     Row Source Operation
-------  ---------------------------------------------------
1  TABLE ACCESS FULL DUAL
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.owner = 'SYS'
and  rownum < 2
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      1.42       6.63      26274     232523          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      1.42       6.63      26274     232523          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
19432   FILTER
259392    TABLE ACCESS FULL T1
19432    COUNT STOPKEY
19432     FILTER
19432      INDEX RANGE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.owner = 'SYS'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.01       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.50       6.23      26897      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.51       6.23      26897      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
205000   HASH JOIN
107808    TABLE ACCESS FULL T1
25641    INDEX FAST FULL SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.owner = 'SYS'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.56       7.28      27387      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.56       7.28      27387      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
205000   HASH JOIN
107808    TABLE ACCESS FULL T1
25641    INDEX FAST FULL SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
where t3.owner = 'SYS'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.70       6.30      26897      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.70       6.30      26897      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
205000   HASH JOIN
107808    TABLE ACCESS FULL T1
25641    INDEX FAST FULL SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
distinct
t3.owner,t3.table_name
from t3
where t3.owner = 'SYS'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.01       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.48       6.08      26897      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.50       6.08      26897      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
205000   HASH JOIN
107808    TABLE ACCESS FULL T1
25641    INDEX FAST FULL SCAN PK_T3 (object id 37136)
********************************************************************************
alter session set sql_trace = false
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse       12      0.03       0.00          0          0          0           0
Execute     14      0.00       0.00          0          0          0           4
Fetch       12      3.67      32.54     134352     338605          0           7
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       38      3.70      32.55     134352     338605          0          11
Misses in library cache during parse: 7
OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      0      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        0      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
14  user  SQL statements in session.
0  internal SQL statements in session.
14  SQL statements in session.
********************************************************************************
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_2504.trc
Trace file compatibility: 9.00.01
Sort options: default
3  sessions in tracefile.
21  user  SQL statements in trace file.
0  internal SQL statements in trace file.
14  SQL statements in trace file.
12  unique SQL statements in trace file.
240  lines in trace file.

PL/SQL 처리가 정상적으로 완료되었습니다.












TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 10:04:59 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 10:04:59 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_1988.trc
Sort options: default
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************
alter session set sql_trace = true
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        1      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
	and		rownum < 2
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.53       6.01      26266      26307          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.53       6.01      26266      26307          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   FILTER
259392    TABLE ACCESS FULL T1
8    COUNT STOPKEY
8     FILTER
8      INDEX RANGE SCAN PK_T3 (object id 37136)


SQL> @utlxpls

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

--------------------------------------------------------------------
| Id  | Operation            |  Name       | Rows  | Bytes | Cost  |
--------------------------------------------------------------------
|   0 | SELECT STATEMENT     |             |     1 |    37 |    46 |
|   1 |  SORT AGGREGATE      |             |     1 |    37 |       |
|*  2 |   FILTER             |             |       |       |       |
|   3 |    TABLE ACCESS FULL | T1          |  1621 | 59977 |    44 |
|*  4 |    COUNT STOPKEY     |             |       |       |       |
|*  5 |     FILTER           |             |       |       |       |
|*  6 |      INDEX RANGE SCAN| PK_T3       |     1 |    19 |     2 |

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------
--------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   2 - filter( EXISTS (SELECT /*+ */ 0 FROM "T3" "T3" WHERE :B1='
              ACCESS$' AND :B2='SYS' AND ROWNUM<2 AND "T3"."TABLE
              _NAME"=:B3 AND "T3"."OWNER"=:B4))
   4 - filter(ROWNUM<2)
   5 - filter(:B1='ACCESS$' AND :B2='SYS')
   6 - access("T3"."OWNER"=:B1 AND "T3"."TABLE_NAME"=:B2)

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

Note: cpu costing is off

24 개의 행이 선택되었습니다.


********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   MERGE JOIN CARTESIAN
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    BUFFER SORT
1     FIRST ROW
1      INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)


PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------

------------------------------------------------------------------------------
| Id  | Operation                      |  Name       | Rows  | Bytes | Cost  |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT               |             |     1 |    56 |     3 |
|   1 |  SORT AGGREGATE                |             |     1 |    56 |       |
|   2 |   MERGE JOIN CARTESIAN         |             |    10 |   560 |     3 |
|   3 |    TABLE ACCESS BY INDEX ROWID | T1          |     1 |    37 |     2 |
|*  4 |     INDEX RANGE SCAN           | IX_T1       |     1 |       |     1 |
|   5 |    BUFFER SORT                 |             |    12 |   228 |     1 |
|   6 |     FIRST ROW                  |             |    12 |   228 |     1 |

PLAN_TABLE_OUTPUT
--------------------------------------------------------------------------------
|*  7 |      INDEX RANGE SCAN (MIN/MAX)| PK_T3       |    12 |       |     1 |
------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("T1"."OWNER"='SYS' AND "T1"."OBJECT_NAME"='ACCESS$')
   7 - access("T3"."OWNER"='SYS' AND "T3"."TABLE_NAME"='ACCESS$')

Note: cpu costing is off

21 개의 행이 선택되었습니다.



********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         21          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         21          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   NESTED LOOPS
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    FIRST ROW
8     INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------
| Id  | Operation                     |  Name       | Rows  | Bytes | Cost  |
-----------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |             |     1 |    56 |     3 |
|   1 |  SORT AGGREGATE               |             |     1 |    56 |       |
|   2 |   NESTED LOOPS                |             |     1 |    56 |     3 |
|   3 |    TABLE ACCESS BY INDEX ROWID| T1          |     1 |    37 |     2 |
|*  4 |     INDEX RANGE SCAN          | IX_T1       |     1 |       |     1 |
|   5 |    FIRST ROW                  |             |     1 |    19 |     1 |
|*  6 |     INDEX RANGE SCAN (MIN/MAX)| PK_T3       |     1 |       |     1 |

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("T1"."OWNER"='SYS' AND "T1"."OBJECT_NAME"='ACCESS$')
   6 - access("T3"."OWNER"='SYS' AND "T3"."TABLE_NAME"='ACCESS$')
       filter("T1"."OWNER"="T3"."OWNER" AND "T1"."OBJECT_NAME"="T3"."TABLE
              _NAME")

Note: cpu costing is off

22 개의 행이 선택되었습니다.



********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   MERGE JOIN CARTESIAN
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    BUFFER SORT
1     FIRST ROW
1      INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)


PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
| Id  | Operation                      |  Name       | Rows  | Bytes | Cost  |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT               |             |     1 |    56 |     3 |
|   1 |  SORT AGGREGATE                |             |     1 |    56 |       |
|   2 |   MERGE JOIN CARTESIAN         |             |    10 |   560 |     3 |
|   3 |    TABLE ACCESS BY INDEX ROWID | T1          |     1 |    37 |     2 |
|*  4 |     INDEX RANGE SCAN           | IX_T1       |     1 |       |     1 |
|   5 |    BUFFER SORT                 |             |    12 |   228 |     1 |
|   6 |     FIRST ROW                  |             |    12 |   228 |     1 |

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------
|*  7 |      INDEX RANGE SCAN (MIN/MAX)| PK_T3       |    12 |       |     1 |
------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("T1"."OWNER"='SYS' AND "T1"."OBJECT_NAME"='ACCESS$')
   7 - access("T3"."OWNER"='SYS' AND "T3"."TABLE_NAME"='ACCESS$')

Note: cpu costing is off

21 개의 행이 선택되었습니다.



********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in
(
	select
		distinct
		t3.owner,t3.table_name
	from	t3
	where	t3.owner = 'SYS'
	and		t3.table_name = 'ACCESS$'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   MERGE JOIN CARTESIAN
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    BUFFER SORT
1     FIRST ROW
1      INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
| Id  | Operation                      |  Name       | Rows  | Bytes | Cost  |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT               |             |     1 |    56 |     3 |
|   1 |  SORT AGGREGATE                |             |     1 |    56 |       |
|   2 |   MERGE JOIN CARTESIAN         |             |    10 |   560 |     3 |
|   3 |    TABLE ACCESS BY INDEX ROWID | T1          |     1 |    37 |     2 |
|*  4 |     INDEX RANGE SCAN           | IX_T1       |     1 |       |     1 |
|   5 |    BUFFER SORT                 |             |    12 |   228 |     1 |
|   6 |     FIRST ROW                  |             |    12 |   228 |     1 |

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------
|*  7 |      INDEX RANGE SCAN (MIN/MAX)| PK_T3       |    12 |       |     1 |
------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("T1"."OWNER"='SYS' AND "T1"."OBJECT_NAME"='ACCESS$')
   7 - access("T3"."OWNER"='SYS' AND "T3"."TABLE_NAME"='ACCESS$')

Note: cpu costing is off

21 개의 행이 선택되었습니다.



********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
	and		rownum < 2
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   TABLE ACCESS BY INDEX ROWID T1
8    INDEX RANGE SCAN IX_T1 (object id 37132)
1     COUNT STOPKEY
1      INDEX RANGE SCAN PK_T3 (object id 37136)


PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

----------------------------------------------------------------------------
| Id  | Operation                    |  Name       | Rows  | Bytes | Cost  |
----------------------------------------------------------------------------
|   0 | SELECT STATEMENT             |             |     1 |    37 |     2 |
|   1 |  SORT AGGREGATE              |             |     1 |    37 |       |
|   2 |   TABLE ACCESS BY INDEX ROWID| T1          |     1 |    37 |     2 |
|*  3 |    INDEX RANGE SCAN          | IX_T1       |     1 |       |     1 |
|*  4 |     COUNT STOPKEY            |             |       |       |       |
|*  5 |      INDEX RANGE SCAN        | PK_T3       |     1 |    19 |     2 |
----------------------------------------------------------------------------

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   3 - access("SYS_ALIAS_2"."OWNER"='SYS' AND "SYS_ALIAS_2"."OBJECT_NAME"
              ='ACCESS$')
       filter( EXISTS (SELECT /*+ */ 0 FROM "T3" "T3" WHERE ROWNUM<2 AND
              "T3"."TABLE_NAME"=:B1 AND "T3"."OWNER"=:B2))
   4 - filter(ROWNUM<2)
   5 - access("T3"."OWNER"=:B1 AND "T3"."TABLE_NAME"=:B2)


PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------
Note: cpu costing is off

23 개의 행이 선택되었습니다.


********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	exists
(
	select
		Null
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   MERGE JOIN CARTESIAN
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    BUFFER SORT
1     FIRST ROW
1      INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
| Id  | Operation                      |  Name       | Rows  | Bytes | Cost  |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT               |             |     1 |    56 |     3 |
|   1 |  SORT AGGREGATE                |             |     1 |    56 |       |
|   2 |   MERGE JOIN CARTESIAN         |             |    10 |   560 |     3 |
|   3 |    TABLE ACCESS BY INDEX ROWID | T1          |     1 |    37 |     2 |
|*  4 |     INDEX RANGE SCAN           | IX_T1       |     1 |       |     1 |
|   5 |    BUFFER SORT                 |             |    12 |   228 |     1 |
|   6 |     FIRST ROW                  |             |    12 |   228 |     1 |

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------
|*  7 |      INDEX RANGE SCAN (MIN/MAX)| PK_T3       |    12 |       |     1 |
------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("T1"."OWNER"='SYS' AND "T1"."OBJECT_NAME"='ACCESS$')
   7 - access("T3"."OWNER"='SYS' AND "T3"."TABLE_NAME"='ACCESS$')

Note: cpu costing is off

21 개의 행이 선택되었습니다.

SQL> 

********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in
(
	select
		t3.owner,t3.table_name
	from	t3
	where	t1.owner = t3.owner
	and		t1.object_name = t3.table_name
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         21          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         21          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   NESTED LOOPS
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    FIRST ROW
8     INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------
| Id  | Operation                     |  Name       | Rows  | Bytes | Cost  |
-----------------------------------------------------------------------------
|   0 | SELECT STATEMENT              |             |     1 |    56 |     3 |
|   1 |  SORT AGGREGATE               |             |     1 |    56 |       |
|   2 |   NESTED LOOPS                |             |     1 |    56 |     3 |
|   3 |    TABLE ACCESS BY INDEX ROWID| T1          |     1 |    37 |     2 |
|*  4 |     INDEX RANGE SCAN          | IX_T1       |     1 |       |     1 |
|   5 |    FIRST ROW                  |             |     1 |    19 |     1 |
|*  6 |     INDEX RANGE SCAN (MIN/MAX)| PK_T3       |     1 |       |     1 |

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("T1"."OWNER"='SYS' AND "T1"."OBJECT_NAME"='ACCESS$')
   6 - access("T1"."OWNER"="T3"."OWNER" AND "T1"."OBJECT_NAME"="T3"."TABLE
              _NAME")
       filter("T3"."OWNER"='SYS' AND "T3"."TABLE_NAME"='ACCESS$')

Note: cpu costing is off

22 개의 행이 선택되었습니다.



********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in
(
	select
		t3.owner,t3.table_name
	from	t3
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   MERGE JOIN CARTESIAN
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    BUFFER SORT
1     FIRST ROW
1      INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)
********************************************************************************
select
	max(t1.LAST_DDL_TIME)
From	t1
where	(t1.owner,t1.object_name ) in
(
	select
		distinct
		t3.owner,t3.table_name
	from	t3
)
and	t1.owner = 'SYS'
and	t1.object_name = 'ACCESS$'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   MERGE JOIN CARTESIAN
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    BUFFER SORT
1     FIRST ROW
1      INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)
********************************************************************************
alter session set sql_trace = false
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse       11      0.00       0.01          0          0          0           0
Execute     12      0.00       0.00          0          0          0           0
Fetch       20      0.53       6.01      26266      26440          0          10
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       43      0.53       6.02      26266      26440          0          10
Misses in library cache during parse: 10
OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      0      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        0      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
12  user  SQL statements in session.
0  internal SQL statements in session.
12  SQL statements in session.
********************************************************************************
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_1988.trc
Trace file compatibility: 9.00.01
Sort options: default
1  session in tracefile.
12  user  SQL statements in trace file.
0  internal SQL statements in trace file.
12  SQL statements in trace file.
12  unique SQL statements in trace file.
293  lines in trace file.

PL/SQL 처리가 정상적으로 완료되었습니다.







TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 10:31:08 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 10:31:08 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_296.trc
Sort options: default
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************
alter session set sql_trace = true
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        1      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1 ,t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.57       6.36      26474      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.57       6.36      26474      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
alter session set sql_trace = false
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          0          0           0
Fetch        2      0.57       6.36      26474      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        7      0.57       6.36      26474      26519          0           1
Misses in library cache during parse: 1
OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      0      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        0      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
3  user  SQL statements in session.
0  internal SQL statements in session.
3  SQL statements in session.
********************************************************************************
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_296.trc
Trace file compatibility: 9.00.01
Sort options: default
1  session in tracefile.
3  user  SQL statements in trace file.
0  internal SQL statements in trace file.
3  SQL statements in trace file.
3  unique SQL statements in trace file.
50  lines in trace file.

PL/SQL 처리가 정상적으로 완료되었습니다.









TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 10:36:34 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 10:36:34 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_296.trc
Sort options: default
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************
alter session set sql_trace = true
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1 ,t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.57       6.36      26474      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.57       6.36      26474      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
alter session set sql_trace = false
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1 ,t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t1.owner = 'SYS'
and  t1.object_name = 'ACCESS$'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   MERGE JOIN CARTESIAN
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    BUFFER SORT
1     FIRST ROW
1      INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)


PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------
| Id  | Operation                      |  Name       | Rows  | Bytes | Cost  |
------------------------------------------------------------------------------
|   0 | SELECT STATEMENT               |             |     1 |    56 |     3 |
|   1 |  SORT AGGREGATE                |             |     1 |    56 |       |
|   2 |   MERGE JOIN CARTESIAN         |             |    10 |   560 |     3 |
|   3 |    TABLE ACCESS BY INDEX ROWID | T1          |     1 |    37 |     2 |
|*  4 |     INDEX RANGE SCAN           | IX_T1       |     1 |       |     1 |
|   5 |    BUFFER SORT                 |             |    12 |   228 |     1 |
|   6 |     FIRST ROW                  |             |    12 |   228 |     1 |

PLAN_TABLE_OUTPUT
----------------------------------------------------------------------------------------------------
|*  7 |      INDEX RANGE SCAN (MIN/MAX)| PK_T3       |    12 |       |     1 |
------------------------------------------------------------------------------

Predicate Information (identified by operation id):
---------------------------------------------------

   4 - access("T1"."OWNER"='SYS' AND "T1"."OBJECT_NAME"='ACCESS$')
   7 - access("T3"."OWNER"='SYS' AND "T3"."TABLE_NAME"='ACCESS$')

Note: cpu costing is off

21 개의 행이 선택되었습니다.


********************************************************************************
OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        4      0.00       0.00          0          0          0           0
Execute      6      0.00       0.00          0          0          0           0
Fetch        4      0.57       6.36      26474      26532          0           2
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       14      0.57       6.36      26474      26532          0           2
Misses in library cache during parse: 2
OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      0      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        0      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
6  user  SQL statements in session.
0  internal SQL statements in session.
6  SQL statements in session.
********************************************************************************
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_296.trc
Trace file compatibility: 9.00.01
Sort options: default
2  sessions in tracefile.
9  user  SQL statements in trace file.
0  internal SQL statements in trace file.
6  SQL statements in trace file.
4  unique SQL statements in trace file.
102  lines in trace file.

PL/SQL 처리가 정상적으로 완료되었습니다.










TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 10:43:55 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 10:43:55 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_296.trc
Sort options: default
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************
alter session set sql_trace = true
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        3      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1 ,t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.57       6.36      26474      26519          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.57       6.36      26474      26519          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
312264   HASH JOIN
38629    INDEX FAST FULL SCAN PK_T3 (object id 37136)
259392    TABLE ACCESS FULL T1
********************************************************************************
alter session set sql_trace = false
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        3      0.00       0.00          0          0          0           0
Execute      3      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        6      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1 ,t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t1.owner = 'SYS'
and  t1.object_name = 'ACCESS$'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.00       0.00          0         13          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0         13          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
8   MERGE JOIN CARTESIAN
8    TABLE ACCESS BY INDEX ROWID T1
8     INDEX RANGE SCAN IX_T1 (object id 37132)
8    BUFFER SORT
1     FIRST ROW
1      INDEX RANGE SCAN (MIN/MAX) PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.column_name = 'TABLE_NAME'
and  rownum < 2
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      1.85       8.33      26271     529091          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      1.85       8.33      26271     529091          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   FILTER
259392    TABLE ACCESS FULL T1
2288    COUNT STOPKEY
2288     INDEX UNIQUE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.column_name = 'TABLE_NAME'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.90       7.70      26271     285685          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.90       7.71      26271     285685          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   NESTED LOOPS
259392    TABLE ACCESS FULL T1
2288    INDEX UNIQUE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.column_name = 'TABLE_NAME'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.95       0.42      26271     285685          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.95       0.42      26271     285685          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   NESTED LOOPS
259392    TABLE ACCESS FULL T1
2288    INDEX UNIQUE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
where t3.column_name = 'TABLE_NAME'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      1.04       7.16      26271     285685          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      1.04       7.16      26271     285685          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   NESTED LOOPS
259392    TABLE ACCESS FULL T1
2288    INDEX UNIQUE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
distinct
t3.owner,t3.table_name
from t3
where t3.column_name = 'TABLE_NAME'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.96       7.61      26271     285685          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.96       7.61      26271     285685          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   NESTED LOOPS
259392    TABLE ACCESS FULL T1
2288    INDEX UNIQUE SCAN PK_T3 (object id 37136)
********************************************************************************
OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse       10      0.00       0.00          0          0          0           0
Execute     13      0.00       0.00          0          0          0           0
Fetch       14      6.31      37.61     157829    1698363          0           7
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       37      6.31      37.62     157829    1698363          0           7
Misses in library cache during parse: 7
OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      0      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        0      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
13  user  SQL statements in session.
0  internal SQL statements in session.
13  SQL statements in session.
********************************************************************************
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_296.trc
Trace file compatibility: 9.00.01
Sort options: default
3  sessions in tracefile.
22  user  SQL statements in trace file.
0  internal SQL statements in trace file.
13  SQL statements in trace file.
9  unique SQL statements in trace file.
247  lines in trace file.

PL/SQL 처리가 정상적으로 완료되었습니다.






TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 13:22:51 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
TKPROF: Release 9.2.0.1.0 - Production on 금 Mar 4 13:22:51 2005
Copyright (c) 1982, 2002, Oracle Corporation.  All rights reserved.
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_1588.trc
Sort options: default
********************************************************************************
count    = number of times OCI procedure was executed
cpu      = cpu time in seconds executing
elapsed  = elapsed time in seconds executing
disk     = number of physical reads of buffers from disk
query    = number of buffers gotten for consistent read
current  = number of buffers gotten in current mode (usually for update)
rows     = number of rows processed by the fetch or execute call
********************************************************************************
alter session set sql_trace = true
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        2      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1 ,t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.column_name = 'TABLE_NAME'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        4      0.07       4.00        711       6366          0           2
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        8      0.07       4.00        711       6366          0           2
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   TABLE ACCESS BY INDEX ROWID T1
2575    NESTED LOOPS
286     INDEX FAST FULL SCAN PK_T3 (object id 37136)
2288     INDEX RANGE SCAN IX_T1 (object id 37132)
********************************************************************************
select /*+RULE*/
max(t1.LAST_DDL_TIME)
From t1 ,t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.column_name = 'TABLE_NAME'
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.01       0.00          0          0          0           0
Fetch        4      0.04       0.14        121       6152          0           2
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        8      0.06       0.14        121       6152          0           2
Misses in library cache during parse: 1
Optimizer goal: RULE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   TABLE ACCESS BY INDEX ROWID T1
2575    NESTED LOOPS
286     TABLE ACCESS BY INDEX ROWID T3
286      INDEX RANGE SCAN IX_T3C (object id 37137)
2288     INDEX RANGE SCAN IX_T1 (object id 37132)
********************************************************************************
alter session set sql_trace = false
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        2      0.00       0.00          0          0          0           0
Execute      2      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
Optimizer goal: CHOOSE
Parsing user id: 85
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.column_name = 'TABLE_NAME'
and  rownum < 2
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      1.89       6.57      26005     529091          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      1.89       6.57      26005     529091          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   FILTER
259392    TABLE ACCESS FULL T1
2288    COUNT STOPKEY
2288     INDEX UNIQUE SCAN PK_T3 (object id 37136)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where exists
(
select
Null
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.column_name = 'TABLE_NAME'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.01       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.01       0.01          0       3183          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.03       0.01          0       3183          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   TABLE ACCESS BY INDEX ROWID T1
2575    NESTED LOOPS
286     INDEX FAST FULL SCAN PK_T3 (object id 37136)
2288     INDEX RANGE SCAN IX_T1 (object id 37132)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
where t1.owner = t3.owner
and  t1.object_name = t3.table_name
and  t3.column_name = 'TABLE_NAME'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.01       0.01          0       3183          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.01       0.01          0       3183          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   TABLE ACCESS BY INDEX ROWID T1
2575    NESTED LOOPS
286     INDEX FAST FULL SCAN PK_T3 (object id 37136)
2288     INDEX RANGE SCAN IX_T1 (object id 37132)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
t3.owner,t3.table_name
from t3
where t3.column_name = 'TABLE_NAME'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.03       0.01          0       3183          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.03       0.01          0       3183          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   TABLE ACCESS BY INDEX ROWID T1
2575    NESTED LOOPS
286     INDEX FAST FULL SCAN PK_T3 (object id 37136)
2288     INDEX RANGE SCAN IX_T1 (object id 37132)
********************************************************************************
select
max(t1.LAST_DDL_TIME)
From t1
where (t1.owner,t1.object_name ) in
(
select
distinct
t3.owner,t3.table_name
from t3
where t3.column_name = 'TABLE_NAME'
)
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        1      0.00       0.00          0          0          0           0
Execute      1      0.00       0.00          0          0          0           0
Fetch        2      0.01       0.01          0       3183          0           1
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        4      0.01       0.01          0       3183          0           1
Misses in library cache during parse: 1
Optimizer goal: CHOOSE
Parsing user id: 85
Rows     Row Source Operation
-------  ---------------------------------------------------
1  SORT AGGREGATE
2288   TABLE ACCESS BY INDEX ROWID T1
2575    NESTED LOOPS
286     INDEX FAST FULL SCAN PK_T3 (object id 37136)
2288     INDEX RANGE SCAN IX_T1 (object id 37132)
********************************************************************************
OVERALL TOTALS FOR ALL NON-RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse       11      0.01       0.00          0          0          0           0
Execute     13      0.01       0.00          0          0          0           0
Fetch       18      2.09      10.78      26837     554341          0           9
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total       42      2.12      10.78      26837     554341          0           9
Misses in library cache during parse: 7
OVERALL TOTALS FOR ALL RECURSIVE STATEMENTS
call     count       cpu    elapsed       disk      query    current        rows
------- ------  -------- ---------- ---------- ---------- ----------  ----------
Parse        0      0.00       0.00          0          0          0           0
Execute      0      0.00       0.00          0          0          0           0
Fetch        0      0.00       0.00          0          0          0           0
------- ------  -------- ---------- ---------- ---------- ----------  ----------
total        0      0.00       0.00          0          0          0           0
Misses in library cache during parse: 0
13  user  SQL statements in session.
0  internal SQL statements in session.
13  SQL statements in session.
********************************************************************************
Trace file: C:\oracle\admin\dongildb\udump\dongildb_ora_1588.trc
Trace file compatibility: 9.00.01
Sort options: default
2  sessions in tracefile.
17  user  SQL statements in trace file.
0  internal SQL statements in trace file.
13  SQL statements in trace file.
9  unique SQL statements in trace file.
255  lines in trace file.

PL/SQL 처리가 정상적으로 완료되었습니다.

