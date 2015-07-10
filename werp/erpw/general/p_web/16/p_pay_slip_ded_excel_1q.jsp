<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_work_yymm = req.getParameter("arg_work_yymm");
     String arg_ded_kind = req.getParameter("arg_ded_kind");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("paydate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ded_kind",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("self_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("real_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));     
    String query = "  SELECT  to_char(a.paydate,'yyyy.mm.dd') paydate  ," + 
					    "          a.ded_kind ," + 
					    "          a.comp_code ," + 
					    "          a.dept_code ," + 
					    "          a.self_amt ," + 
					    "          a.comp_amt ," + 
					    "          a.real_amt ," + 
					    "          a.invoice_num  " +
					    "      FROM p_pay_deduction   a " +
					    "      where a.paydate = '"+ arg_work_yymm +"'  " +
					    "			 and a.ded_kind = '"+ arg_ded_kind +"'  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>