<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invest_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  s_chg_cn_parent.dept_code ," + 
     "          s_chg_cn_parent.order_number ," + 
     "          s_chg_cn_parent.chg_degree ," + 
     "          s_chg_cn_parent.sum_code ," + 
     "          s_chg_cn_parent.parent_sum_code ," + 
     "          s_chg_cn_parent.spec_no_seq ," + 
     "          s_chg_cn_parent.seq ," + 
     "          s_chg_cn_parent.direct_class ," + 
     "          s_chg_cn_parent.llevel ," + 
     "          s_chg_cn_parent.invest_class ," + 
     "          s_chg_cn_parent.name ," + 
     "          s_chg_cn_parent.cnt_amt ," + 
     "          s_chg_cn_parent.exe_amt ," + 
     "          s_chg_cn_parent.sub_amt ," + 
     "          s_chg_cn_parent.mat_amt ," + 
     "          s_chg_cn_parent.lab_amt ," + 
     "          s_chg_cn_parent.exp_amt     FROM s_chg_cn_parent  " + 
     "        WHERE ( s_chg_cn_parent.dept_code = '" + arg_dept_code + "') and  " + 
     "              ( s_chg_cn_parent.order_number = " + arg_order_number + ") and " + 
     "              ( s_chg_cn_parent.chg_degree = " + arg_chg_degree + ") and  " + 
     "              ( s_chg_cn_parent.parent_sum_code = '" + arg_parent_sum_code + "')  " + 
     "             ORDER BY s_chg_cn_parent.seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>