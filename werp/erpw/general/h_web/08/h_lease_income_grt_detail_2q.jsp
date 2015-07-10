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
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("f_pay_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("tot_amt",GauceDataColumn.TB_DECIMAL,18,0));
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
    String query = "select a.dept_code," + 
     "       a.sell_code," + 
     "		 to_char(a.cont_date,'yyyy.mm.dd') cont_date ," + 
     "		 a.cont_seq," + 
     "		 a.degree_code," + 
     "		 to_char(a.agree_date,'yyyy.mm.dd') agree_date," + 
     "		 a.amt," + 
     "		 a.f_pay_yn," + 
     "		 a.tot_amt," + 
     "		 i.degree_seq," + 
     "		 to_char(i.receipt_date,'yyyy.mm.dd') receipt_date ," + 
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
     "		 to_char(i.input_date,'yyyy.mm.dd') input_date," + 
     "		 i.modi_yn" + 
     "  from h_lease_grt_agree a," + 
     "       h_lease_grt_income i" + 
     " where a.dept_code = i.dept_code(+)" + 
     "   and a.sell_code = i.sell_code(+)" + 
     "	and a.cont_date = i.cont_date(+)" + 
     "	and a.cont_seq  = i.cont_seq(+)" + 
	  "	and a.degree_code  = i.degree_code(+)" +
    "    and a.dept_code = '"+arg_dept_code+"'" + 
     "   and a.sell_code = '"+arg_sell_code+"'" + 
     "	and a.cont_date = '"+arg_cont_date+"'" + 
     "	and a.cont_seq  = "+arg_cont_seq+
     "order by a.degree_code, i.degree_seq	     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>