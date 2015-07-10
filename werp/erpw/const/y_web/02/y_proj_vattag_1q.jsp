<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_process = req.getParameter("arg_process");
     String arg_dept_name = req.getParameter("arg_dept_name");
     arg_process = '%' + arg_process + '%';
     arg_dept_name = '%' + arg_dept_name + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("tax_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("free_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         a.COMP_CODE,   " + 
     "         a.LONG_NAME,   " + 
     "         a.process_code, " +
     "         nvl(a.TAX_RATE,0)  TAX_RATE, " + 
     "         nvl(a.FREE_RATE,0)  FREE_RATE, " + 
     "         to_char(a.CHG_CONST_START_DATE,'YYYY.MM.DD') CHG_CONST_START_DATE,   " + 
     "         to_char(a.CHG_CONST_END_DATE,'YYYY.MM.DD')   CHG_CONST_END_DATE,   " + 
     "         nvl(a.CHG_CONST_TERM,0) CHG_CONST_TERM,  " + 
     "         a.vattag " +
     "    FROM Z_CODE_DEPT a  " + 
     "   WHERE a.process_code like '" + arg_process  + "'" +
     "     and a.long_name like '" + arg_dept_name + "'" +
     "     and a.dept_proj_tag = 'P' " +
     " order by a.process_code,a.dept_code ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>