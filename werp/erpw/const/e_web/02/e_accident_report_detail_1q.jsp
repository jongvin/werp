<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("zip_number",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("address1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("address2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("job_type",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("result_type",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("injure_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("injure_part_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("join_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sex",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.dept_code,   " + 
     "                       a.seq,   " + 
     "                       a.civil_register_number,   " + 
     "                       a.name,   " + 
     "                       a.zip_number,   " + 
     "                       a.address1,   " + 
     "                       a.address2,   " + 
     "                       a.sbcr_name,   " + 
     "                       a.job_type,   " + 
     "                       a.result_type,   " + 
     "                       a.injure_code,   " + 
     "                       a.injure_part_code,   " + 
     "                       to_char(a.join_date,'yyyy.mm.dd') join_date,   " + 
     "                       a.remark , " + 
     "                       a.sex  " + 
	  "                   FROM e_disaster_report_detail a " + 
     "                   WHERE a.dept_code ='" + arg_dept_code + "'  " + 
     "                         and a.seq ='" + arg_seq + "' " +
     "                   ORDER BY a.dept_code ASC,   " + 
     "                            a.seq ASC,   " + 
     "                            a.civil_register_number ASC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>