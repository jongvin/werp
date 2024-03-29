<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_seq = req.getParameter("arg_seq");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  s_prgs_parent.dept_code ," + 
     "          to_char(s_prgs_parent.yymm,'yyyy.mm.dd') yymm ," + 
     "          s_prgs_parent.seq ," + 
     "          s_prgs_parent.order_number ," + 
     "          s_prgs_parent.spec_no_seq ," + 
     "          s_prgs_parent.pre_prgs_amt ," + 
     "          s_prgs_parent.pre_prgs_rt ," + 
     "          s_prgs_parent.tm_prgs_amt ," + 
     "          s_prgs_parent.tm_prgs_rt ," + 
     "          s_prgs_parent.tot_prgs_amt ," + 
     "          s_prgs_parent.tot_prgs_rt ," + 
     "          s_cn_parent.name ," + 
     "          s_cn_parent.sub_amt ," + 
     "          s_cn_parent.sum_code ," + 
     "          s_cn_parent.parent_sum_code ," + 
     "          s_cn_parent.seq no_seq, s_cn_parent.direct_class  FROM s_cn_parent ," + 
     "          s_prgs_parent     " + 
     "        WHERE ( s_prgs_parent.dept_code = s_cn_parent.dept_code ) and " + 
     "              ( s_prgs_parent.order_number = s_cn_parent.order_number ) and  " + 
     "              ( s_prgs_parent.spec_no_seq = s_cn_parent.spec_no_seq ) and  " + 
     "              ( ( s_prgs_parent.dept_code = '" + arg_dept_code + "') and  " + 
     "                ( s_prgs_parent.yymm = '" + arg_yymm + "') and  " + 
     "                ( s_prgs_parent.seq = " + arg_seq + ") and  " + 
     "                ( s_prgs_parent.order_number = " + arg_order_number + ") and  " + 
     "                ( s_cn_parent.parent_sum_code = '" + arg_parent_sum_code + "') ) " + 
     "        ORDER BY s_cn_parent.seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>