<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,53));
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("plan_per",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("plan_amt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("plan_mm_per",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("plan_mm_amt",GauceDataColumn.TB_STRING,18));
    String query = "  " + 
                   "  select a.tag,                                                                            " + 
                   "         a.seq,                                                                            " + 
                   "         a.name,                                                                           " + 
                   "         to_char(a.year,'yyyy.mm') year,                                                   " + 
                   "         DECODE(a.plan_per,0,'',to_char(a.plan_per,'990.99')) plan_per,                    " + 
                   "         DECODE(a.plan_amt,0,'',to_char(a.plan_amt,'9,999,999,999,999')) plan_amt,             " + 
                   "         DECODE(a.plan_mm_per,0,'',to_char(a.plan_mm_per,'990.99')) plan_mm_per,           " + 
                   "         DECODE(a.plan_mm_amt,0,'',to_char(a.plan_mm_amt,'9,999,999,999,999')) plan_mm_amt     " + 
                   "     from (                                                                                " + 
                   "          select '1' tag,                                                                  " + 
                   "                 a.seq,                                                                    " + 
                   "                 decode(length(a.wbs_code),1,c.name,'   ' || c.name) name,                 " + 
                   "                 b.year,                                                                   " + 
                   "                 a.plan_per,                                                               " + 
                   "                 a.plan_amt,                                                               " + 
                   "                 b.plan_mm_per,                                                            " + 
                   "                 b.plan_mm_amt                                                             " + 
                   "             from c_progress_parent a,                                                     " + 
                   "                   c_progress_detail b,                                                    " + 
                   "                   y_wbs_code c                                                            " + 
                   "             where a.dept_code = b.dept_code                                               " + 
                   "               and a.chg_no_seq = b.chg_no_seq                                             " + 
                   "               and a.wbs_code = b.wbs_code                                                 " + 
                   "               and a.wbs_code = c.wbs_code                                                 " + 
                   "               and a.dept_code = '" + arg_dept_code + "'                                   " + 
                   "               and a.chg_no_seq = " + arg_chg_no_seq + "                                   " + 
                   "           union all                                                                       " + 
                   "          select '1',                                                                      " + 
                   "                 9998,                                                                     " + 
                   "                 '   합 계' name,                                                              " + 
                   "                 b.year,                                                                   " + 
                   "                 a.s_plan_per,                                                             " + 
                   "                 a.s_plan_amt,                                                             " + 
                   "                 b.s_plan_mm_per,                                                          " + 
                   "                 b.s_plan_mm_amt                                                           " + 
                   "             from (                                                                        " + 
                   "                 select '   합 계' wbs_code,                                                   " + 
                   "                     sum(a.plan_per) s_plan_per,                                           " + 
                   "                     sum(a.plan_amt) s_plan_amt                                            " + 
                   "                   from c_progress_parent a                                                " + 
                   "                   where dept_code = '" + arg_dept_code + "'                               " + 
                   "                     and chg_no_seq = " + arg_chg_no_seq + "                             " + 
                   "                     and wbs_code <> 'A' ) a,                           " + 
                   "                 (select '   합 계' wbs_code,                                                  " + 
                   "                      a.year,                                                              " + 
                   "                      sum(a.plan_mm_per) s_plan_mm_per,                                    " + 
                   "                      sum(a.plan_mm_amt) s_plan_mm_amt                                     " + 
                   "                 from c_progress_detail a                                                  " + 
                   "                 where a.dept_code = '" + arg_dept_code + "'                               " + 
                   "                   and a.chg_no_seq = " + arg_chg_no_seq + "                               " + 
                   "                     and wbs_code <> 'A'                                                   " + 
                   "                 group by a.year) b                                                        " + 
                   "            where a.wbs_code = b.wbs_code                                                  " + 
                   "          union all                                                                        " + 
                   "          select '1',                                                                      " + 
                   "                 9999,                                                                     " + 
                   "                 '   누 계',                                                                   " + 
                   "                 a.year,                                                                   " + 
                   "                 0,                                                                        " + 
                   "                 0,                                                                        " + 
                   "                 sum(a.s_plan_mm_per) over (partition by a.dept_code order by a.year       " + 
                   "                     range unbounded preceding) sum_plan_mm_per,                           " + 
                   "                 sum(a.s_plan_mm_amt) over (partition by a.dept_code order by a.year       " + 
                   "                     range unbounded preceding) sum_plan_mm_amt                            " + 
                   "            from (                                                                         " + 
                   "               select a.dept_code,                                                         " + 
                   "                      a.year,                                                              " + 
                   "                      sum(a.plan_mm_per) s_plan_mm_per,                                    " + 
                   "                      sum(a.plan_mm_amt) s_plan_mm_amt                                     " + 
                   "                 from c_progress_detail a                                                  " + 
                   "                 where a.dept_code = '" + arg_dept_code + "'                               " + 
                   "                   and a.chg_no_seq = " + arg_chg_no_seq + "                               " + 
                   "                   and a.wbs_code <> 'A'                                                  " + 
                   "                 group by a.dept_code,a.year ) a                                           " + 
                   "           union all                                                                       " + 
                   "          select '2',                                                                      " + 
                   "                 a.seq,                                                                    " + 
                   "                 decode(length(a.wbs_code),1,c.name,'   ' || c.name) name,                 " + 
                   "                 b.year,                                                                   " + 
                   "                 a.real_per,                                                               " + 
                   "                 a.real_amt,                                                               " + 
                   "                 b.real_mm_per,                                                            " + 
                   "                 b.real_mm_amt                                                             " + 
                   "             from c_progress_parent a,                                                     " + 
                   "                   c_progress_detail b,                                                    " + 
                   "                   y_wbs_code c                                                            " + 
                   "             where a.dept_code = b.dept_code                                               " + 
                   "               and a.chg_no_seq = b.chg_no_seq                                             " + 
                   "               and a.wbs_code = b.wbs_code                                                 " + 
                   "               and a.wbs_code = c.wbs_code                                                 " + 
                   "               and a.dept_code = '" + arg_dept_code + "'                                   " + 
                   "               and a.chg_no_seq = " + arg_chg_no_seq + "                                   " + 
                   "           union all                                                                       " + 
                   "          select '2',                                                                      " + 
                   "                 9998,                                                                     " + 
                   "                 '   합 계' name,                                                              " + 
                   "                 b.year,                                                                   " + 
                   "                 a.s_real_per,                                                             " + 
                   "                 a.s_real_amt,                                                             " + 
                   "                 b.s_real_mm_per,                                                          " + 
                   "                 b.s_real_mm_amt                                                           " + 
                   "             from (                                                                        " + 
                   "                 select '   합 계' wbs_code,                                                   " + 
                   "                     sum(a.real_per) s_real_per,                                           " + 
                   "                     sum(a.real_amt) s_real_amt                                            " + 
                   "                   from c_progress_parent a                                                " + 
                   "                   where dept_code = '" + arg_dept_code + "'                               " + 
                   "                     and chg_no_seq = " + arg_chg_no_seq + "                              " + 
                   "                     and wbs_code <> 'A' ) a,                           " + 
                   "                 (select '   합 계' wbs_code,                                                  " + 
                   "                      a.year,                                                              " + 
                   "                      sum(a.real_mm_per) s_real_mm_per,                                    " + 
                   "                      sum(a.real_mm_amt) s_real_mm_amt                                     " + 
                   "                 from c_progress_detail a                                                  " + 
                   "                 where a.dept_code = '" + arg_dept_code + "'                               " + 
                   "                   and a.chg_no_seq = " + arg_chg_no_seq + "                               " + 
                   "                   and a.wbs_code <> 'A'                                                  " + 
                   "                 group by a.year) b                                                        " + 
                   "            where a.wbs_code = b.wbs_code                                                  " + 
                   "          union all                                                                        " + 
                   "          select '2',                                                                      " + 
                   "                 9999,                                                                     " + 
                   "                 '   누 계',                                                                   " + 
                   "                 a.year,                                                                   " + 
                   "                 0,                                                                        " + 
                   "                 0,                                                                        " + 
                   "                 sum(a.s_real_mm_per) over (partition by a.dept_code order by a.year       " + 
                   "                     range unbounded preceding) sum_real_mm_per,                           " + 
                   "                 sum(a.s_real_mm_amt) over (partition by a.dept_code order by a.year       " + 
                   "                     range unbounded preceding) sum_real_mm_amt                            " + 
                   "            from (                                                                         " + 
                   "               select a.dept_code,                                                         " + 
                   "                      a.year,                                                              " + 
                   "                      sum(a.real_mm_per) s_real_mm_per,                                    " + 
                   "                      sum(a.real_mm_amt) s_real_mm_amt                                     " + 
                   "                 from c_progress_detail a                                                  " + 
                   "                 where a.dept_code = '" + arg_dept_code + "'                               " + 
                   "                   and a.chg_no_seq = " + arg_chg_no_seq + "                               " + 
                   "                   and a.wbs_code <> 'A'                            " + 
                   "                 group by a.dept_code,a.year ) a                                           " + 
                   "                                                                                           " + 
                   "          ) a                                                                              " + 
                   "     order by a.seq,a.tag,a.year                                                           "; 
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>