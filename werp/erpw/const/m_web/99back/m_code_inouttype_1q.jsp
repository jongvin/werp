<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //    String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("inouttypecode",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("old_inouttypecode",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("inouttypename",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("usetag",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("typecode",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  m_code_inouttype.inouttypecode ," + 
     "          m_code_inouttype.inouttypecode old_inouttypecode," + 
     "          m_code_inouttype.inouttypename ," + 
     "          m_code_inouttype.usetag ," + 
     "          m_code_inouttype.typecode     FROM m_code_inouttype  order by inouttypecode       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>