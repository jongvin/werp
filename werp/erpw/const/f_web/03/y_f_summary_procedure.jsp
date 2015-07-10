<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String as_l_tag = req.getParameter("as_l_tag");
     String as_q_tag = req.getParameter("as_q_tag");
     String as_s_tag = req.getParameter("as_s_tag");
     String as_m_tag = req.getParameter("as_m_tag");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call y_sp_f_request_summary(?,?,?,?,?,?)}");
      stmt.setString(1,arg_dept_code);
      stmt.setString(2,arg_date);
      stmt.setString(3,as_l_tag);
      stmt.setString(4,as_q_tag);
      stmt.setString(5,as_s_tag);
      stmt.setString(6,as_m_tag);
%><%@ 
include file="../../../comm_function/conn_procedure_end.jsp"%>