<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%>
<%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
    dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("comp_yymm",GauceDataColumn.TB_STRING,6));
    String query = "  select dept_code,							   " + 
    			   "       to_char(yymm,'yyyy.mm.dd') yymm,		   " + 
				   "       seq,								       " + 
				   "       to_char(yymm,'yyyymm')  comp_yymm       " + 
				   "  from s_prgs_yymm							   " + 
				   "  where dept_code    = '" + arg_dept_code + "' " + 
				   "  order by dept_code asc,                      " + 
				   "         yymm desc,							   " + 
				   "         seq  desc							   " + 
				   "											   "; 
	

%>
<%@
include file="../../../comm_function/conn_q_end.jsp"%>