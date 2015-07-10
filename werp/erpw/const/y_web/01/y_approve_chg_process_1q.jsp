<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_title",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("work_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,32759));
     dSet.addDataColumn(new GauceDataColumn("charge_name",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("chg_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE," + 
     "             b.LONG_NAME," + 
     "             a.CHG_NO_SEQ," + 
     "             a.CHG_DEGREE," + 
     "             a.CHG_TITLE," + 
     "             a.APPROVE_CLASS," + 
     "             to_char(a.WORK_DT,'YYYY-MM-DD') work_dt," + 
     "             to_char(a.REQUEST_DT,'YYYY-MM-DD') request_dt," + 
     "             to_char(a.APPROVE_DT,'YYYY-MM-DD') approve_dt," + 
     "             a.CNT_AMT," + 
     "             a.AMT," + 
     "             a.REMARK," + 
     "             a.CHARGE_NAME, a.chg_class        FROM Y_CHG_DEGREE a," + 
     "             Z_CODE_DEPT b      WHERE  a.DEPT_CODE = b.DEPT_CODE  and  " +
     "           a.APPROVE_CLASS = '" + arg_class + "'  and " +
	 "           a.chg_class = '3'" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>