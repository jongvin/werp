<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_comp_code = req.getParameter("arg_comp_code");     
     String arg_emp_no = req.getParameter("arg_emp_no") + "%";
     String arg_service_div = req.getParameter("arg_service_div");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("service_div_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT  a.emp_no ," + 
     "  						      a.emp_name ," + 
     "  						      a.dept_code ," + 
     "  						      a.grade_code, " + 
     "  						      b.long_name dept_name ," + 
     "  		      				a.service_div_code, " + 
     "  						      c.grade_name " + 
     "  						FROM p_pers_master a, " +
     "							  z_code_dept b, " +
     "							  p_code_grade c " +
     "  					 where a.dept_code = b.dept_code(+) " +
     "  						and a.grade_code = c.grade_code(+) " +
     "  						and (a.emp_no like '" + arg_emp_no+ "' " +
     "  						 or a.emp_name like '" + arg_emp_no + "'   )  " ;
 		if(arg_service_div.equals("9")) {   //전체 해당사업체의 재직구분 관계없이 모두.
		   query += " and a.comp_code = '" + arg_comp_code + "' " ;
		}		
		else if(arg_service_div.equals("A")) {   //미발령
		   query += " and service_div_code is null ";
		}		
		else {   //검색조건으로 찾기 
		   query += " and a.comp_code = '" + arg_comp_code + "' " ;
		   query += " and service_div_code = '" + arg_service_div + "' ";
		}
		
     query += " order by a.service_div_code, a.emp_name " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>