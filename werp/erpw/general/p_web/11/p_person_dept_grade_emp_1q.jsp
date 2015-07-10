<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("dept_short_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("emp_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("emp_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,10,0));
 
 String query = "select   a.dept_code, d.short_name dept_short_name, d.short_name dept_name, a.grade_code, " +
     		    "         '(' || a.grade_code || ')' || c.grade_name grade_name,  a.emp_no,  a.emp_name,   1 cnt  " +
				"  from                                                                                             " +
				"	  p_pers_master a,                                                   " +
                "     p_code_grade c,                                                    " +
                "     z_code_dept  d                                                     " +
                " where                                                                   " +
                "      a.dept_code  = d.dept_code(+)                                      " +
                "     and a.grade_code = c.grade_code(+)                                   " +
                "     and a.comp_code like '"+ arg_comp_code +"'                          " +
                "     and a.service_div_code <> '3'                                        " +
                "     and not (a.comp_code = 'C0' and a.RESIDENT_NO = '700823-1055615' or  " +
                "        a.comp_code = 'B0' and a.RESIDENT_NO = '680823-1055615' or         " +
                " 		 a.comp_code = 'E0' and a.RESIDENT_NO = '680823-1055615')		    " ;


	
/*	String query = "select   a.dept_code, 														" +
    " 		 a.dept_short_name,  		                                            " +
    " 		 d.short_name dept_name,   	                                         " +
    " 		 a.grade_code,                                                       " +
    " 		 '(' || a.grade_code || ')' || c.grade_name grade_name,              " +
    "        a.emp_no,                                                           " +
    "        b.emp_name,                                                          " +
    "        1 cnt                                                            " +
    "   from (select a.comp_code,                                                " +
	 " 				 a.dept_code,                                                 " +
    " 				 a.dept_short_name,                                            " +
    " 				 a.grade_code,                                               " +
    " 				 a.emp_no,                                                 " +
    "                a.apply_order_date,                                       " +
    "                a.order_code,                                             " +
    " 				 RANK() OVER (PARTITION by a.emp_no                        " +
    " 				        	 ORDER BY a.emp_no asc, a.apply_order_date desc,   " +
    " 							 a.seq desc, a.spec_no_seq desc) rk_1        " +
    " 			  from p_order_master a                                           " +
    " 			  where a.comp_code like '"+ arg_comp_code +"'                    " +
    " 				 and a.apply_order_date <= '"+ arg_date +"'                    " +
    " 				 and a.confirm_tag = '1' " +
	"			  order by a.apply_order_date, a.emp_no" +
    " 		  ) a,                                                               " +
    " 		  p_pers_master b,                                                   " +
    " 		  p_code_grade c,                                                    " +
    " 		  z_code_dept  d,                                                    " +
    " 		  p_code_order e                                                    " +
    "   where (a.rk_1 = 1                                                        " +
    " 	 and a.emp_no = b.emp_no(+)                                                " +
	 " 	 and a.dept_code  = d.dept_code(+)                                      " +
    " 	 and a.grade_code = c.grade_code(+)                                     " +
	 " and a.order_code = e.order_code(+)                                         " +
    " 	 and a.comp_code like '"+ arg_comp_code  +"'                            " +
    "     and a.order_code = e.order_code (+))                                      " +
    "     and not (                                                              " +
    "      	       e.service_div =  '3'                                          " +
    "      	       and a.apply_order_date < '"+ arg_date +"' )                   " +
    "  order by a.comp_code, d.dept_proj_tag, d.short_name, a.grade_code,       " +
    " 			 b.emp_name ";                                                    

*/


%><%@ include file="../../../comm_function/conn_q_end.jsp"%>