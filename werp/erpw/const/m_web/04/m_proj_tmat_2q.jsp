<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
     String arg_input = req.getParameter("arg_input");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("month",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("unitprice",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vatamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("invoice_num",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  a.dept_code ," + 
     					 "          a.yymmdd ," + 
     					 "          a.seq ," + 
     					 "          a.input_unq_num ," + 
     					 "          to_char(a.month,'YYYY.MM') month ," + 
     					 "          a.degree ," + 
     					 "          a.qty ," + 
     					 "          a.unitprice ," + 
     					 "          a.amt ," + 
     					 "          a.vatamt ," + 
     					 "          a.spec_no_seq ," + 
     					 "          F_PARENT_DETAIL_NAME(a.dept_code,a.spec_unq_num) spec_name ," + 
     					 "          a.invoice_num " +
     					 "     FROM m_tmat_proj_rent a " +
     					 "    WHERE a.DEPT_CODE = '" + arg_dept_code + "'" +
     					 "      and a.YYMMDD = '" + arg_date + "'" +
     					 "      and a.SEQ = " + arg_seq +
     					 "      And a.INPUT_UNQ_NUM = " + arg_input +
     					 " order by a.month,a.degree      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>