<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String a_dept_code = req.getParameter("a_dept_code");
     String b_chg_no_seq = req.getParameter("b_chg_no_seq");
	 String c_chg_no_seq = req.getParameter("c_chg_no_seq");
     String d_parent_sum_code = req.getParameter("d_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("parent_name",GauceDataColumn.TB_STRING,250));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,10,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,11,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("qty1",GauceDataColumn.TB_DECIMAL,10,3));
     dSet.addDataColumn(new GauceDataColumn("price1",GauceDataColumn.TB_DECIMAL,11,0));
     dSet.addDataColumn(new GauceDataColumn("amt1",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("amt_incre",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("qty_incre",GauceDataColumn.TB_DECIMAL,10,3));
     String query = " SELECT   b.long_name,"   +
"          e.comp_name,"   +
"          a.dept_code,"   +
"          a.chg_no_seq,"   +
"          a.spec_no_seq,"   +
"          f_parent_name (a.dept_code, a.sum_code, a.llevel) parent_name,"   +
"          a.no_seq,"   +
"          a.llevel,"   +
"          a.sum_code,"   +
"          a.parent_sum_code,"   +
"          a.direct_class,"   +
"          a.NAME,"   +
"          a.ssize,"   +
"          a.unit,"   +
"          a.cnt_qty,"   +
"          a.cnt_price,"   +
"          a.cnt_amt,"   +
"          a.qty,"   +
"          a.price,"   +
"          a.amt,"   +
"          a.cnt_qty1,"   +
"          a.cnt_price1,"   +
"          a.cnt_amt1,"   +
"          a.qty1,"   +
"          a.price1,"   +
"          a.amt1,"   +
"          a.tag,"   +
"          NVL (a.amt, 0) - NVL (a.amt1, 0) amt_incre,"   +
"          NVL (a.qty, 0) - NVL (a.qty1, 0) qty_incre,"   +
"          SYSDATE"   +
"     FROM (SELECT b.dept_code,"   +
"                  b.chg_no_seq,"   +
"                  b.spec_no_seq,"   +
"                  b.no_seq * 1000 no_seq,"   +
"                  TO_NUMBER (b.llevel) llevel,"   +
"                  b.sum_code,"   +
"                  b.parent_sum_code,"   +
"                  b.direct_class direct_class,"   +
"                  b.NAME,"   +
"                  b.ssize,"   +
"                  b.unit,"   +
"                  0 cnt_qty,"   +
"                  0 cnt_price,"   +
"                  b.cnt_amt cnt_amt,"   +
"                  0 qty,"   +
"                  0 price,"   +
"                  b.amt amt,"   +
"                  0 cnt_qty1,"   +
"                  0 cnt_price1,"   +
"                  a.cnt_amt cnt_amt1,"   +
"                  0 qty1,"   +
"                  0 price1,"   +
"                  a.amt amt1,"   +
"                  1 tag"   +
"             FROM y_chg_budget_parent a, y_chg_budget_parent b"   +
"            WHERE (a.dept_code(+) = b.dept_code)"   +
"              AND (a.spec_no_seq(+) = b.spec_no_seq)"   +
"              AND (a.llevel(+) > 1)"   +
"              AND (b.llevel > 1)"   +
"              AND (    b.dept_code = '"+a_dept_code+"'"   +
"                   AND b.chg_no_seq = "+c_chg_no_seq+
"                   AND a.chg_no_seq(+) = "+b_chg_no_seq+
"                   AND b.parent_sum_code LIKE '"+d_parent_sum_code+"' || '%'"   +
"                  and 1=2 )"   +
"           UNION ALL"   +
"           SELECT b.dept_code,"   +
"                  b.chg_no_seq,"   +
"                  b.spec_no_seq,"   +
"                  x.no_seq * 1000 + b.no_seq no_seq,"   +
"                  TO_NUMBER (x.llevel) + 1 llevel,"   +
"                  x.sum_code,"   +
"                  x.sum_code,"   +
"                  ' ' direct_class,"   +
"                  b.NAME,"   +
"                  b.ssize,"   +
"                  b.unit,"   +
"                  b.cnt_qty,"   +
"                  b.cnt_price,"   +
"                  b.cnt_amt,"   +
"                  b.qty,"   +
"                  b.price,"   +
"                  b.amt,"   +
"                  a.cnt_qty cnt_qty1,"   +
"                  a.cnt_price cnt_price1,"   +
"                  b.cnt_amt cnt_amt1,"   +
"                  a.qty qty1,"   +
"                  a.price price1,"   +
"                  a.amt amt1,"   +
"                  2 tag"   +
"             FROM y_chg_budget_detail a,"   +
"                  y_chg_budget_detail b,"   +
"                  y_chg_budget_parent x"   +
"            WHERE (a.dept_code(+) = b.dept_code)"   +
"              AND (a.spec_no_seq(+) = b.spec_no_seq)"   +
"              AND (a.spec_unq_num(+) = b.spec_unq_num)"   +
"              AND (x.dept_code = b.dept_code)"   +
"              AND (x.chg_no_seq = b.chg_no_seq)"   +
"              AND (x.spec_no_seq = b.spec_no_seq)"   +
"              AND (x.sum_code LIKE '"+d_parent_sum_code+"' || '%')"   +
"              AND (    b.dept_code = '"+a_dept_code+"'"   +
"                   AND b.chg_no_seq = "+c_chg_no_seq+
"                   AND a.chg_no_seq(+) = "+b_chg_no_seq+
"                  )) a,"   +
"          z_code_dept b,"   +
"          z_code_comp e"   +
"    WHERE b.dept_code(+) = a.dept_code AND b.comp_code = e.comp_code(+)"   +
"          and (nvl(a.amt,0) - nvl(a.amt1,0) <> 0  )"+

" ORDER BY a.parent_sum_code ASC, a.no_seq"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>