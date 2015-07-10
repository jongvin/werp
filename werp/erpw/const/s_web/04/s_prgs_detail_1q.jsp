<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
     String arg_seq = req.getParameter("arg_seq");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pre_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("taxation_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code ," + 
     					 "          to_char(a.yymm,'yyyy.mm.dd') yymm ," + 
     					 "          a.seq ," + 
     					 "          a.order_number ," + 
     					 "          a.spec_no_seq ," + 
     					 "          a.detail_unq_num ," + 
     					 "          a.pre_prgs_qty ," + 
     					 "          a.pre_prgs_amt ," + 
     					 "          a.pre_prgs_rt ," + 
     					 "          a.tm_prgs_qty ," + 
     					 "          a.tm_prgs_amt ," + 
     					 "          a.tm_prgs_rt ," + 
     					 "          a.tot_prgs_qty ," + 
     					 "          a.tot_prgs_amt ," + 
     					 "          a.tot_prgs_rt ," + 
     					 "          b.seq no_seq ," + 
     					 "          b.res_class ," + 
     					 "          b.name ," + 
     					 "          b.ssize ," + 
     					 "          b.unit ," + 
     					 "          b.taxation_tag ," + 
     					 "          b.sub_qty ," + 
     					 "          b.sub_amt ," + 
     					 "          b.sub_price ," + 
     					 "          b.spec_unq_num  " +
     					 "     FROM s_cn_detail b ," + 
     					 "          s_prgs_detail  a " +
     					 "   WHERE ( a.dept_code = b.dept_code ) and  " + 
     					 "         ( a.order_number = b.order_number ) and  " + 
     					 "         ( a.spec_no_seq = b.spec_no_seq ) and     " + 
     					 "         ( a.detail_unq_num = b.detail_unq_num ) and  " + 
     					 "         ( ( a.dept_code = '" + arg_dept_code + "') and      " + 
     					 "           ( a.yymm = '" + arg_yymm + "') and     " + 
     					 "           ( a.seq = " + arg_seq + ") and     " + 
     					 "           ( a.order_number = " + arg_order_number + " ) and   " + 
     					 "           ( a.spec_no_seq = " + arg_spec_no_seq + " ) ) " + 
     					 " ORDER BY b.seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>