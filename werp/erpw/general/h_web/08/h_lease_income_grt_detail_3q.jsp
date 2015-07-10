<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_cont_date = req.getParameter("arg_cont_date");
     String arg_cont_seq = req.getParameter("arg_cont_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cont_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cont_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("degree_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("receipt_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("daily_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("r_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("delay_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_days",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("discount_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("work_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("modi_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bank_name",GauceDataColumn.TB_STRING,40));
    String query = "select i.dept_code," + 
     "       i.sell_code," + 
     "		 to_char(i.cont_date,'yyyy.mm.dd') cont_date," + 
     "		 i.cont_seq," + 
     "		 i.degree_code," + 
     "		 i.degree_seq," + 
     "		 to_char(i.receipt_date,'yyyy.mm.dd') receipt_date," + 
     "		 i.daily_seq," + 
     "		 i.deposit_no," + 
     "		 i.r_amt," + 
     "		 i.delay_days," + 
     "		 i.delay_amt," + 
     "		 i.discount_days," + 
     "		 i.discount_amt," + 
     "		 i.work_date," + 
     "		 i.work_no," + 
     "		 i.input_id," + 
     "		 i.input_date," + 
     "		 i.modi_yn," + 
     "		 d.bank_name" + 
     "  from h_code_deposit d," + 
     "       h_lease_grt_income i" + 
      "    where i.dept_code = '"+arg_dept_code+"'" + 
     "   and i.sell_code = '"+arg_sell_code+"'" + 
     "	and i.cont_date = '"+arg_cont_date+"'" + 
     "	and i.cont_seq  = '"+arg_cont_seq+"'" +
     "	and i.dept_code = d.dept_code(+)" + 
     "	and i.deposit_no = d.deposit_no(+)" + 
     " order by i.degree_code, i.degree_seq	     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>