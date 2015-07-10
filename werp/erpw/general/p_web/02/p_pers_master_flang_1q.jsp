<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("flang_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("reading",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("writing",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("talking",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  p_pers_flang.emp_no ," + 
     "          p_pers_flang.flang_code ," + 
     "          p_pers_flang.reading ," + 
     "          p_pers_flang.writing ," + 
     "          p_pers_flang.talking ," + 
     "          p_pers_flang.remark   " +
     "  FROM p_pers_flang        " +
     "   where p_pers_flang.emp_no = '" + arg_emp_no   + "'    " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>