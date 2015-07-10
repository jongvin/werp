<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
          String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("degree_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("agree_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt_per",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT H_BASE_ONTIME_AGREE.DEPT_CODE,   " + 
     "         H_BASE_ONTIME_AGREE.DEGREE_CODE,   " + 
     "         to_char(H_BASE_ONTIME_AGREE.AGREE_DATE, 'yyyy.mm.dd') agree_date,   " + 
     "         H_BASE_ONTIME_AGREE.AMT_PER,   " + 
     "         H_BASE_ONTIME_AGREE.NOTE  " + 
     "    FROM H_BASE_ONTIME_AGREE" + 
     "   where H_BASE_ONTIME_AGREE.DEPT_CODE = '"+ arg_dept_code+"'"+
	 "  ORDER BY H_BASE_ONTIME_AGREE.DEGREE_CODE";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>