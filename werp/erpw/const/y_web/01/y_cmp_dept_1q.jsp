<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_division = req.getParameter("arg_division");
     String arg_detail_code = req.getParameter("arg_detail_code");
     String arg_dept_detail = req.getParameter("arg_dept_detail");
     String arg_dept_mat = req.getParameter("arg_dept_mat");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("bud_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_qty",GauceDataColumn.TB_DECIMAL,18,3));
    String query = "select a.dept_code," + 
     "       max(c.no_seq) no_seq, " + 
     "       max(b.long_name) long_name, " + 
     "       sum(a.bud_price) bud_price," + 
     "       sum(a.sub_price) sub_price," + 
     "       sum(a.mat_price) mat_price," + 
     "       sum(a.bud_amt) bud_amt," + 
     "       sum(a.bud_qty) bud_qty," + 
     "       sum(a.sub_amt) sub_amt," + 
     "       sum(a.sub_qty) sub_qty," + 
     "       sum(a.mat_amt) mat_amt," + 
     "       sum(a.mat_qty) mat_qty" + 
     "       from (                   " + 
     "         select b.dept_code," + 
     "                trunc(SUM(b.amt) / SUM(b.qty),0) bud_price, " + 
     "                SUM(b.amt) bud_amt, " + 
     "                SUM(b.qty) bud_qty, " + 
     "                0 sub_price," + 
     "                0 sub_amt," + 
     "                0 sub_qty," + 
     "                0 mat_price," + 
     "                0 mat_amt," + 
     "                0 mat_qty " + 
     "            from y_chg_budget_parent a," + 
     "                 y_chg_budget_detail b" + 
     "            where a.dept_code = b.dept_code" + 
     "              and a.chg_no_seq = b.chg_no_seq" + 
     "              and a.spec_no_seq = b.spec_no_seq" + 
     "              and a.division = '" + arg_division + "' " + 
     "              and b.detail_code = '" + arg_detail_code + "'" + 
     "              and b.qty <> 0 " + 
     "              and ( " + arg_dept_detail + " " +   
     "                   )" + 
     "             group by b.dept_code      " + 
     "         union all" + 
     "         select a.dept_code," + 
     "                0 bud_price," + 
     "                0 bud_amt," + 
     "                0 bud_qty," + 
     "                trunc(sum(a.sub_amt) / sum(a.sub_qty),0) sub_price," + 
     "                sum(a.sub_amt) sub_amt," + 
     "                sum(a.sub_qty) sub_qty," + 
     "                0 mat_price," + 
     "                0 mat_amt," + 
     "                0 mat_qty " + 
     "             from s_cn_detail a,       " + 
     "                 (" + 
     "                   select b.dept_code," + 
     "                          b.spec_unq_num" + 
     "                      from y_chg_budget_parent a," + 
     "                           y_chg_budget_detail b" + 
     "                      where a.dept_code = b.dept_code" + 
     "                        and a.chg_no_seq = b.chg_no_seq" + 
     "                        and a.spec_no_seq = b.spec_no_seq" + 
     "                        and a.division = '" + arg_division + "' " + 
     "                        and b.detail_code = '" +  arg_detail_code + "'" + 
     "                        and ( " + arg_dept_detail + " " +   
     "                            )" + 
     "                   ) b" + 
     "              where a.dept_code = b.dept_code" + 
     "                and a.spec_unq_num = b.spec_unq_num" + 
     "                and a.sub_qty <> 0 " + 
     "             group by a.dept_code        " + 
     "          union all             " + 
     "           select a.dept_code," + 
     "                  0 bud_price," + 
     "                  0 bud_amt," + 
     "                  0 bud_qty," + 
     "                  0 sub_price," + 
     "                  0 sub_amt," + 
     "                  0 sub_qty," + 
     "                  trunc(sum(a.amt) / sum(a.qty),0)  mat_price," + 
     "                  sum(a.amt)  mat_amt," + 
     "                  sum(a.qty)  mat_qty " + 
     "             from (" + 
     "                   select a.dept_code," + 
     "                          a.approym," + 
     "                          a.approseq," + 
     "                          a.unitprice," + 
     "                          a.amt," + 
     "                          a.qty," + 
     "                          RANK() OVER (PARTITION BY a.dept_code " + 
     "                                             ORDER BY a.dept_code desc,a.approym desc ,a.approseq desc, a.chg_cnt,a.approval_unq_num  ) rk_1" + 
     "                      from m_approval_detail a" + 
     "                      where ( " + arg_dept_mat + " " +  
     "                             ) and a.amt <> 0 " + 
     "                     ) a" + 
     "             where a.rk_1 = 1 " +   
     "               and a.qty <> 0 " + 
     "              group by a.dept_code ) a," + 
     "           z_code_dept b," + 
     "           y_cmp_dept_code c" + 
     "        where a.dept_code = b.dept_code" + 
     "          and a.dept_code = c.cmp_dept_code " + 
     "          and c.dept_code = '" + arg_dept_code + "' " + 
     "    group by a.dept_code             " + 
     "   " + 
     "                                    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>