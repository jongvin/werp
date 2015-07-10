<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_seq_no = req.getParameter("arg_seq_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("english_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("const_start_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("const_end_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  z_code_dept.dept_code ," + 
     "          z_code_dept.comp_code ," + 
     "          z_code_dept.long_name ," + 
     "          z_code_dept.short_name ," + 
     "          z_code_dept.english_name ," + 
     "          z_code_dept.dept_seq_key ," + 
     "          z_code_dept.dept_proj_tag ," + 
     "          z_code_dept.use_tag,  " + 
     "          to_char(z_code_dept.const_start_date,'yyyy.mm.dd')  const_start_date, " + 
     "          to_char(z_code_dept.const_end_date,'yyyy.mm.dd')  const_end_date," + 
     "          to_char(z_code_dept.chg_const_start_date,'yyyy.mm.dd') chg_const_start_date, " + 
     "          to_char(z_code_dept.chg_const_end_date,'yyyy.mm.dd') chg_const_end_date, " + 
     "          nvl(z_code_dept.const_term,0) const_term,  " + 
     "          nvl(z_code_dept.chg_const_term,0) chg_const_term,  " + 
     "          z_code_dept.process_code process_code  " + 
     "          FROM z_code_dept      WHERE ( z_code_dept.dept_seq_key = " + arg_seq_no  + ")      ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>