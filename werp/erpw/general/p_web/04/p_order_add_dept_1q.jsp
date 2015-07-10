<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("add_dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,4,0));
     dSet.addDataColumn(new GauceDataColumn("start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("add_dept_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("cancel_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.emp_no,   " + 
     "         a.spec_no_seq,   " + 
     "         a.add_dept_code,   " + 
     "         a.seq,   " + 
     "         to_char(a.start_date,'yyyy.mm.dd') start_date,   " + 
     "         to_char(a.end_date,'yyyy.mm.dd') end_date," + 
     "			b.long_name add_dept_name, " + 
     "			a.cancel_tag " + 
     "    FROM p_order_add_dept   a," + 
     "			z_code_dept			 b" + 
     "	where a.add_dept_code = b.dept_code" + 
     "	  and a.emp_no  = '" + arg_emp_no + "' " +
     "	  and a.spec_no_seq = '" + arg_spec_no_seq + "' " +
     "	order by a.seq     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>