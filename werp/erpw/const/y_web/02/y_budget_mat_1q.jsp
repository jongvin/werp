<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sum_code = req.getParameter("arg_sum_code");
     arg_sum_code = arg_sum_code + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("parent_name",GauceDataColumn.TB_STRING,4000));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("min_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("outside_yn",GauceDataColumn.TB_STRING,10));
    String query = " " + 
                "  select  F_PARENT_NAME(a.dept_code,a.sum_code,a.llevel + 1) parent_name,  " + 
                "          a.sum_code,                                                      " + 
                "          b.detail_code,                                                   " + 
                "          b.name,                                                          " + 
                "          b.ssize,                                                         " + 
                "          b.unit,                                                          " + 
                "          b.qty,                                                           " + 
                "          nvl(c.sub_qty,0) sub_qty,                                        " + 
                "          nvl(b.qty,0) - nvl(c.sub_qty,0) min_qty,                          " + 
                "          b.outside_yn                             " + 
                "        from y_budget_parent a,                                            " + 
                "             y_budget_detail b,                                            " + 
                "            (                                                              " + 
                "                select a.dept_code dept_code,                                        " +
                "                       b.spec_unq_num spec_unq_num,                                     " +
                "                       nvl(sum(b.qty),0) sub_qty                           " +
                "                  from m_request a,                                        " +
                "                       m_request_detail b                                  " +
                "                  where a.dept_code = b.dept_code                          " +
                "                   and  a.requestseq = b.requestseq                        " +
                "                   and  a.chg_cnt = b.chg_cnt                             " +
                "                   and  a.receipdate is not null                           " +
                "                   and  a.dept_code = '" + arg_dept_code + "'              " + 
                "                  group by a.dept_code,b.spec_unq_num   order by a.dept_code,b.spec_unq_num      " +
                "            ) c                                                            " + 
                "        where a.dept_code = b.dept_code                                    " + 
                "          and a.spec_no_seq = b.spec_no_seq                                " + 
                "          and b.dept_code = c.dept_code (+)                                " + 
                "          and b.spec_unq_num = c.spec_unq_num (+)                          " + 
                "          and b.dept_code = '" + arg_dept_code + "'                        " + 
                "          and a.invest_class = 'Y'                                         " + 
                "          and a.parent_sum_code like '" + arg_sum_code + "'                " + 
				"          and b.col_tag = 'M' "+
//                "          and (b.mat_amt > 0   )                      " + 
//                "          and b.qty > nvl(c.sub_qty,0)                                     " + 
                "     order by a.sum_code                                                   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>