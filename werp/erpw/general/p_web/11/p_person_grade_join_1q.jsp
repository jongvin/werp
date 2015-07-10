<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_div = req.getParameter("arg_div");
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("mm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("mon",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "   select a.grade_code, " +
		"		     		 '('|| a.grade_code ||')'|| b.grade_name grade_name,         " +
		"					 to_char(a.join_date,'mm') mm," +
		"		          decode(to_char(a.join_date,'mm'),'01','01월','02','02월','03','03월',        " +
		"																 '04','04월','05','05월','06','06월',        " +
		"																 '07','07월','08','08월','09','09월',        " +
		"																 '10','10월','11','11월','12','12월','미입력') mon," +
		"		            count(a.emp_no) cnt " +
		"		       from p_pers_master a,    " +                                                        
		"			   	   p_code_grade b      " +
		"		       where a.grade_code = b.grade_code             " +
		"		  		   and a.comp_code  like '" + arg_comp_code	+ "'	     " +
		"		  		   and to_char(a.join_date,'yyyy') = to_char(to_date('" + arg_date + "'),'yyyy') " +
		"	 			   " + arg_div + " " + 
		"		    group by a.grade_code,                           " +
		"		     		 	 b.grade_name,                           " +
		"		   			 to_char(a.join_date,'mm')               " +
		"		      order by to_char(a.join_date,'mm') " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>