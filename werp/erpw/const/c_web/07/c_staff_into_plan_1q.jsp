<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("position",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jik_jong",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("in_plan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("out_plan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("man_month",GauceDataColumn.TB_DECIMAL,4,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,18));
    String query = "select a.dept_code,													" +
      "                    a.seq,															" +
		"	 						a.position,														" +
		"	 						a.jik_jong,														" +
		"	 						to_char(a.in_plan_date,'yyyy.mm.dd') in_plan_date,	" +
		"	 						to_char(a.out_plan_date,'yyyy.mm.dd') out_plan_date, " +
		"	 						a.man_month,													" +
		"							a.remark															" +
  		"					 from c_staff_in_plan a												" +
  		"              where a.dept_code = '" + arg_dept_code + "'					" +
  		"              order by a.dept_code, a.seq                              " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>