<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq_1 = req.getParameter("arg_chg_no_seq_1");
     String arg_chg_no_seq_2 = req.getParameter("arg_chg_no_seq_2");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_STRING,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_STRING,18,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty1",GauceDataColumn.TB_STRING,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty1",GauceDataColumn.TB_STRING,18,3));
     dSet.addDataColumn(new GauceDataColumn("price1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_DECIMAL,1));
     dSet.addDataColumn(new GauceDataColumn("amt_incre",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("gong_name",GauceDataColumn.TB_STRING,73));
     dSet.addDataColumn(new GauceDataColumn("page_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sysdate",GauceDataColumn.TB_STRING,19));
    String query = "      select     z_code_dept.long_name, " + 
     "     		         a.dept_code,   " + 
     "     		         a.chg_no_seq,   " + 
     "     		         a.spec_no_seq,   " + 
     "     	            a.no_seq," + 
     "     	            a.llevel,   " + 
     "     		         a.sum_code,   " + 
     "     		         a.parent_sum_code,   " + 
     "     		         a.name,   " + 
     "     		         a.ssize,   " + 
     "     		         a.unit,   " + 
     "     		         DECODE(a.tag,1,'',TO_CHAR(a.cnt_qty,'B999,9,999.99')) cnt_qty,   " + 
     "     		         DECODE(a.tag,1,'',TO_CHAR(a.cnt_price,'B999,999,999,999')) cnt_price,   " + 
     "     		         a.cnt_amt,   " + 
     "     		         DECODE(a.tag,1,'',TO_CHAR(a.qty,'B999,9,999.99'))  qty,   " + 
     "     		         DECODE(a.tag,1,'',TO_CHAR(a.price,'B999,999,999,999')) price,   " + 
     "     		         a.amt,   " + 
     "     		         DECODE(a.tag,1,'',TO_CHAR(a.cnt_qty1,'B999,9,999.99')) cnt_qty1,   " + 
     "     		         DECODE(a.tag,1,'',TO_CHAR(a.cnt_price1,'B999,999,999,999')) cnt_price1,   " + 
     "     		         a.cnt_amt1,   " + 
     "     		         DECODE(a.tag,1,'',TO_CHAR(a.qty1,'B999,9,999.99')) qty1,   " + 
     "     		         DECODE(a.tag,1,'',TO_CHAR(a.price1,'B999,999,999,999')) price1,   " + 
     "    		         a.amt1, " + 
     "    		         a.tag, " + 
     "                  nvl(a.amt,0) - nvl(a.amt1,0) amt_incre,   " + 
     "                    '                                                                         ' gong_name," + 
     "                    0 page_num   ," + 
     "                    sysdate " + 
     "                from  " + 
     "                   ( SELECT  b.dept_code,   " + 
     "     					         b.chg_no_seq,   " + 
     "     					         b.spec_no_seq,   " + 
     "                           b.no_seq * 1000000  no_seq, " + 
     "                           to_number(b.llevel) llevel,  " + 
     "     					         b.sum_code,   " + 
     "     					         b.parent_sum_code,   " + 
     "     					         b.name,   " + 
     "     					         b.ssize,   " + 
     "     					         b.unit,   " + 
     "     					         0 cnt_qty,   " + 
     "     					         0 cnt_price,   " + 
     "     					         b.cnt_amt,   " + 
     "     					         0 qty,   " + 
     "     					         0 price,   " + 
     "     					         b.amt," + 
     "     					         0 cnt_qty1,   " + 
     "     					         0 cnt_price1,   " + 
     "     					         a.cnt_amt cnt_amt1,   " + 
     "     					         0 qty1,   " + 
     "     					         0 price1,   " + 
     "     					         a.amt amt1," + 
     "     					         1 tag " + 
     "                       FROM y_chg_budget_parent a, y_chg_budget_parent b   " + 
     "                       WHERE (a.dept_code (+) = b.dept_code ) and    " + 
     "                             (a.spec_no_seq  (+) = b.spec_no_seq ) and    " + 
     "                             (b.dept_code = '" + arg_dept_code + "'   and   " + 
     "                              b.chg_no_seq = " + arg_chg_no_seq_2 + " and a.chg_no_seq = " + arg_chg_no_seq_1 + ")  " + 
     "                    union all " + 
     "     					 SELECT  b.dept_code,   " + 
     "     					         b.chg_no_seq,   " + 
     "     					         b.spec_no_seq,   " + 
     "                           x.no_seq  * 1000000 + b.no_seq no_seq,   " + 
     "                           to_number(x.llevel) + 1 llevel,   " + 
     "     					         x.sum_code,   " + 
     "     					         x.parent_sum_code,   " + 
     "     					         b.name,   " + 
     "     					         b.ssize,   " + 
     "     					         b.unit,   " + 
     "     					         b.cnt_qty,   " + 
     "     					         b.cnt_price,   " + 
     "     					         b.cnt_amt,   " + 
     "     					         b.qty,   " + 
     "     					         b.price,   " + 
     "     					         b.amt,   " + 
     "     					         a.cnt_qty cnt_qty1,   " + 
     "     					         a.cnt_price cnt_price1,   " + 
     "     					         a.cnt_amt cnt_amt1,   " + 
     "     					         a.qty qty1,   " + 
     "     					         a.price price1,   " + 
     "     					         a.amt amt1,   " + 
     "     					         2 tag   " + 
     "                     FROM y_chg_budget_detail a, y_chg_budget_detail b,    " + 
     "                          y_chg_budget_parent x " + 
     "                     WHERE ( a.dept_code (+) = b.dept_code ) and  " + 
     "                           ( a.spec_no_seq (+) = b.spec_no_seq ) and  " + 
     "                           ( a.spec_unq_num (+) = b.spec_unq_num ) and  " + 
     "                           ( x.dept_code = b.dept_code ) and  " + 
     "                           ( x.chg_no_seq = b.chg_no_seq ) and  " + 
     "                           ( x.spec_no_seq = b.spec_no_seq ) and  " + 
     "                             (b.dept_code = '" + arg_dept_code + "'  and   " + 
     "                              b.chg_no_seq = " + arg_chg_no_seq_2 + " and a.chg_no_seq = " + arg_chg_no_seq_1 + ")  " + 
     "                            ) A,  " + 
     "                      z_code_dept" + 
     "                  where z_code_dept.dept_code = a.dept_code" + 
     "            order by a.no_seq            ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>