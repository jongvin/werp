<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
     String arg_chg_degree = req.getParameter("arg_chg_degree");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("detail_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("res_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("copy_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("taxation_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("exe_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.dept_code ," + 
     					 "          a.order_number ," + 
     					 "          a.chg_degree ," + 
     					 "          a.spec_no_seq ," + 
     					 "          a.detail_unq_num ," + 
     					 "          a.seq ," + 
     					 "          a.res_class ," + 
     					 "          a.spec_unq_num ," + 
     					 "          a.name ," + 
     					 "          a.ssize ," + 
     					 "          a.unit ," + 
     					 "          a.copy_yn ," + 
     					 "          a.wbs_code ," + 
     					 "          a.taxation_tag ," + 
     					 "          a.cnt_qty ," + 
     					 "          a.cnt_price ," + 
     					 "          a.cnt_amt ," + 
     					 "          a.exe_qty ," + 
     					 "          a.exe_price ," + 
     					 "          a.exe_amt ," + 
     					 "          a.sub_qty ," + 
     					 "          a.sub_price ," + 
     					 "          a.sub_amt ," + 
     					 "          a.mat_price ," + 
     					 "          a.mat_amt ," + 
     					 "          a.lab_price ," + 
     					 "          a.lab_amt ," + 
     					 "          a.exp_price ," + 
     					 "          a.exp_amt " +
     					 "     FROM s_chg_cn_detail a,  " + 
     					 "				s_order_detail b " +
     					 "   WHERE  a.dept_code = b.dept_code (+) and " +
     					 "          a.order_number = b.order_number (+) and " +
     					 "          a.spec_no_seq  = b.spec_no_seq (+) and " +
     					 "          a.detail_unq_num = b.detail_unq_num (+) and " +
 //    					 "          b.sub_qty <> 0 and " +
     					 "         ( a.dept_code = '" + arg_dept_code + "') and  " + 
     					 "         ( a.order_number = " + arg_order_number + ") and   " + 
     					 "         ( a.chg_degree = " + arg_chg_degree + ") and    " + 
     					 "         ( a.spec_no_seq = " + arg_spec_no_seq + ")  " + 
     					 "    ORDER BY a.seq          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>