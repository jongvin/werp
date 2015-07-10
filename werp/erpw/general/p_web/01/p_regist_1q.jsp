<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("table_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("code_pk_no",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("ds_name",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("ur_authority",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT p_code_regist.spec_no_seq ," + 
     "				 p_code_regist.code_name," + 
     "             p_code_regist.table_name," + 
     "             p_code_regist.code_pk_no," + 
     "             p_code_regist.ds_name," + 
     "             p_code_regist.ur_authority," + 
     "             p_code_regist.use_yn       " + 
     "		  FROM p_code_regist    " +
     "	 ORDER BY p_code_regist.code_name ASC         ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>