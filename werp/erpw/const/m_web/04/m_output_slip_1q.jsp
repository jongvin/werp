<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("vat_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("acnt_code",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("yyyymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cont",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("work_process",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("slip_st",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  dept_code ," + 
     					 "          vat_unq_num ," + 
     					 "          to_char(work_dt,'YYYY.MM.DD') work_dt ," + 
     					 "          acnt_code ," + 
     					 "          vattag ," + 
     					 "          to_char(yyyymmdd,'YYYY.MM.DD') yyyymmdd ," + 
     					 "          amt ," + 
     					 "          vat_amt ," + 
     					 "          cont ," + 
     					 "          invoice_num ," + 
     					 "          work_process , " +
     					 "          decode(invoice_num,null,'A',F_T_SLIP_STAT(to_number(invoice_num))) slip_st " +
     					 "     FROM m_output_slip " +
     					 "    WHERE DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      And trunc(WORK_DT,'MM') = '" + arg_date + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>