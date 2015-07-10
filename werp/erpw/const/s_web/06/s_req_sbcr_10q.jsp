<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("year_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sale_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  sbcr_unq_num ," + 
     					 "          year_class ," + 
     					 "          seq ," + 
     					 "          sbcr_name ," + 
     					 "          sale_amt ," + 
     					 "          sale_rt ," + 
     					 "          remark  " +
     					 "     FROM s_req_sale " +
     					 "    WHERE SBCR_UNQ_NUM = " + arg_unq_num ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>