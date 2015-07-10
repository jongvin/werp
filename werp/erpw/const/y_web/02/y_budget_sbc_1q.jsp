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
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("min_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
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
                "          nvl(d.tot_prgs_qty,0) tot_prgs_qty,                                        " + 
                "          nvl(b.qty,0) - nvl(c.sub_qty,0) min_qty,                          " + 
                "          b.spec_unq_num,                          " + 
                "          b.outside_yn                             " + 
                "        from y_budget_parent a,                                            " + 
                "             y_budget_detail b,                                            " + 
                "            (                                                              " + 
                "             select a.dept_code,                                                                " + 
                "                    a.spec_unq_num,                                                             " + 
                "                     sum(decode(b.spec_unq_num,null,a.sub_qty,b.sub_qty)) sub_qty               " + 
                "                from (select a.dept_code,a.order_number,a.spec_unq_num,sum(a.sub_qty) sub_qty   " + 
                "                         from s_order_detail a , s_order_list b                                 " + 
                "                         where a.dept_code = '" + arg_dept_code + "'                            " + 
                "                           and a.dept_code = b.dept_code       " + 
                "                           and a.order_number = b.order_number " + 
                "                           and b.cancel_yn = 'N' " + 
                "                         group by a.dept_code,a.order_number,a.spec_unq_num ) a,                " + 
                "                     (select a.dept_code,a.order_number,a.spec_unq_num,sum(a.sub_qty) sub_qty   " + 
                "                         from s_cn_detail a                                                  " + 
                "                         where a.dept_code = '" + arg_dept_code + "'                            " + 
                "                         group by a.dept_code,a.order_number,a.spec_unq_num ) b                 " + 
                "                where a.dept_code = '" + arg_dept_code + "'                                     " + 
                "                  and a.dept_code = b.dept_code (+)                                             " + 
                "                  and a.order_number = b.order_number (+)                                       " + 
                "                  and a.spec_unq_num = b.spec_unq_num (+)                                       " + 
                "                group by a.dept_code,a.spec_unq_num order by a.dept_code,a.spec_unq_num ) c,    " + 
                "            (                                                                                   " + 
                "               select a.dept_code,c.spec_unq_num,sum(a.tot_prgs_qty) tot_prgs_qty               " + 
                "                 from s_prgs_detail a,                                                          " + 
                "                     (                                                                          " + 
                "                       select dept_code,order_number,max(yymm) yymm,max(seq) seq                " + 
                "                         from s_prgs_parent                                                     " + 
                "                         where dept_code = '" + arg_dept_code + "'                              " + 
                "                         group by dept_code,order_number) b,                                    " + 
                "                      s_cn_detail c                                                             " + 
                "                  where a.dept_code = b.dept_code                                               " + 
                "                    and a.order_number = b.order_number                                         " + 
                "                    and a.yymm = b.yymm                                                         " + 
                "                    and a.seq = b.seq                                                           " + 
                "                    and a.dept_code = c.dept_code                                               " + 
                "                    and a.order_number = c.order_number                                         " + 
                "                    and a.spec_no_seq = c.spec_no_seq                                           " + 
                "                    and a.detail_unq_num = c.detail_unq_num                                     " + 
                "                 group by a.dept_code,c.spec_unq_num ) d                                        " + 
                "        where a.dept_code = b.dept_code                                    " + 
                "          and a.spec_no_seq = b.spec_no_seq                                " + 
                "          and b.dept_code = c.dept_code (+)                                " + 
                "          and b.spec_unq_num = c.spec_unq_num (+)                          " + 
                "          and b.dept_code = d.dept_code (+)                                " + 
                "          and b.spec_unq_num = d.spec_unq_num (+)                          " + 
                "          and b.dept_code = '" + arg_dept_code + "'                        " + 
                "          and a.invest_class = 'Y'                                         " + 
                "          and a.parent_sum_code like '" + arg_sum_code + "'                " + 
				"          and b.col_tag = 'S' "+
//                "          and (b.sub_amt > 0   )                                               " + 
//                "          and b.qty > nvl(c.sub_qty,0)                                     " + 
                "     order by a.sum_code                                                   ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>