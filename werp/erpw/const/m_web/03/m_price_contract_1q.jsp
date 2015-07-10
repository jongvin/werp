<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("seq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("from_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("to_dt",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT    " + 
     "         TO_CHAR(year,'YYYY.MM.DD') year  ," + 
     "         sbcr_code,  " + 
     "         (select sbcr_name from s_sbcr where sbcr_code = a.sbcr_code) sbcr_name,  " + 
     "         seq_num,   " + 
     "         to_char(from_dt,'yyyy.mm.dd') from_dt,   " + 
     "         to_char(to_dt,'yyyy.mm.dd') to_dt,   " + 
     "         remark   " + 
	  "         FROM M_PRICE_CONTRACT a   " + 
	  "         WHERE year = to_date('"+arg_year+"','yyyy.mm.dd') " + 
     "			ORDER BY  sbcr_name   ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>