<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("create_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT SPEC_UNQ_NUM,   " + 
    					 "         APPROVE_CLASS,   " + 
    					 "         DEPT_CODE,   " + 
    					 "         LONG_NAME,   " + 
    					 "         SHORT_NAME,   " + 
    					 "         DEPT_PROJ_TAG,   " + 
    					 "         RECEIVE_CODE,   " + 
    					 "         to_char(REQUEST_DT,'yyyy.mm.dd') request_dt,   " + 
    					 "         to_char(CREATE_DT,'yyyy.mm.dd') create_dt,comp_code  " + 
    					 "    FROM Z_DEPT_APPROVE  " + 
    					 "   WHERE APPROVE_CLASS = '" + arg_class + "'" + 
    					 " order by SPEC_UNQ_NUM desc                ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>