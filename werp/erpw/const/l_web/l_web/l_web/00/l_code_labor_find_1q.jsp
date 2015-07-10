<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_name = req.getParameter("arg_name");
      arg_name =   arg_name + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("civil_register_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("labor_name",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("job_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,40));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         a.CIVIL_REGISTER_NUMBER,   " + 
     "         a.LABOR_NAME,   " + 
     "         a.UNITCOST  ," + 
     "         a.SPEC_NO_SEQ  ," + 
     "         a.SPEC_UNQ_NUM  ," + 
     "         b.job_name ," +
     "         c.name " +
     "    FROM L_LABOR_BASIC a, " + 
     "         l_code_job b, " +
     "         y_budget_detail c " +
     "   WHERE a.job_code = b.job_code and " +
     "         a.dept_code = c.dept_code(+) and " +
     "         a.spec_unq_num = c.spec_unq_num(+) and " +
     "         a.blacklist = 'N' and " +
     "         a.military = 'Y' and " +
     "         ( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + ") AND  " + 
     "         ( a.BLACKLIST = 'N' ) AND  " + 
     "         ( ( a.RESIGN_DATE >= " + "'" + arg_date + "'" + ") OR" + 
     "           ( a.RESIGN_DATE is null)) AND (a.labor_name like " + "'" + arg_name + "'" + ")  " +  
     "   ORDER BY a.labor_name     "    ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>