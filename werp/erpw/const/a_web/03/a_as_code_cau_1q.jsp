<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_end_date = req.getParameter("arg_end_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("d1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("d2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("d3",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("d4",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("d5",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("av",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cou",GauceDataColumn.TB_STRING,50));
    String query = "select dp.dept_code, " +
            "              dp.long_name, " +
			   "              (select count(b.code_cau) " +
			   "                 from a_as_comm_code a, " +
				"                      a_as_req_master b " +
			   "                where a.code = 'D01' and " +
			   "                      a.code = b.code_cau and " +
			   "                      a.class = '4'	    and " +
				"                      b.dept_code(+) = dp.dept_code and " +
				"                 	  b.req_date    >= '" + arg_start_date + "' and " +
				"	                    b.req_date    <= '" + arg_end_date   + "' " +
			   "                group by dept_code, b.code_cau ) d1, " + 
			   
			   "              (select count(b.code_cau) " +
			   "                 from a_as_comm_code a, " +
				"                      a_as_req_master b " +
			   "                where a.code = 'D02' and " +
			   "                      a.code = b.code_cau and " +
			   "                      a.class = '4'	    and " +
				"                      b.dept_code(+) = dp.dept_code and " +
				"                 	  b.req_date    >= '" + arg_start_date + "' and " +
				"	                    b.req_date    <= '" + arg_end_date   + "' " +
			   "                group by dept_code, b.code_cau ) d2, " +
			   
			   "              (select count(b.code_cau) " +
			   "                 from a_as_comm_code a, " +
				"                      a_as_req_master b " +
			   "                where a.code = 'D03' and " +
			   "                      a.code = b.code_cau and " +
			   "                      a.class = '4'	    and " +
				"                      b.dept_code(+) = dp.dept_code and " +
				"                 	  b.req_date    >= '" + arg_start_date + "' and " +
				"	                    b.req_date    <= '" + arg_end_date   + "' " +
			   "                group by dept_code, b.code_cau ) d3, " +
			   
			   "              (select count(b.code_cau) " +
			   "                 from a_as_comm_code a, " +
				"                      a_as_req_master b " +
			   "                where a.code = 'D04' and " +
			   "                      a.code = b.code_cau and " +
			   "                      a.class = '4'	    and " +
				"                      b.dept_code(+) = dp.dept_code and " +
				"                 	  b.req_date    >= '" + arg_start_date + "'  and " +
				"	                    b.req_date    <= '" + arg_end_date   + "' " +
			   "                group by dept_code, b.code_cau ) d4, " +
			   
			   "              (select count(b.code_cau) " +
			   "                 from a_as_comm_code a, " +
				"                      a_as_req_master b " +
			   "                where a.code = 'D05' and " +
			   "                      a.code = b.code_cau and " +
			   "                      a.class = '4'	    and " +
				"                      b.dept_code(+) = dp.dept_code and " +
				"                 	  b.req_date    >= '" + arg_start_date + "' and " +
				"	                    b.req_date    <= '" + arg_end_date   + "' " +
			   "                group by dept_code, b.code_cau ) d5, " +
			   
			   "              (select sum(res_comp_date-req_date) avg_date " +
  		 		"	               from a_as_req_master " +
 				"           	  where prog_st = '3' and " +
 				"                      dept_code(+) = dp.dept_code and " +
				"	                    req_date    >= '" + arg_start_date + "' and " +
				"   	                 req_date    <= '" + arg_end_date   + "' ) av, " +
				
			   "              (select count(dept_code) cou_date " +
  		 		"	               from a_as_req_master " +
 				"		           where prog_st = '3' and " +
 				"                      dept_code(+) = dp.dept_code and " +
				"	                    req_date    >= '" + arg_start_date + "' and " +
				"   	                 req_date    <= '" + arg_end_date   + "' ) cou " +
				
            "         from (select distinct(a.dept_code) dept_code, " +
            "                      b.long_name " +
				"                 from a_as_req_master a, " +
				"			              z_code_dept b " +
				"                where a.dept_code = b.dept_code and " +
				"                      a.req_date >= '" + arg_start_date + "' and " +
				"		                 a.req_date <= '" + arg_end_date   + "' ) dp ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>