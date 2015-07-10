<%@ page session="true" contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_date = req.getParameter("arg_date");
     String arg_div = req.getParameter("arg_div");
     String arg_comp_code = req.getParameter("arg_comp_code") + "%";     
     String arg_grade_code = req.getParameter("arg_grade_code") + "%";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("grade_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("grade_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("school_car_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("school_car_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.grade_code," + 
     "		 c.grade_name, " + 
     "   	 decode(a.school_car_code,null,'99',a.school_car_code) school_car_code, " + 
     "   	 decode(d.school_car_name,null,'미입력','('|| a.school_car_code ||')'|| d.school_car_name) school_car_name, " + 
     "       count(a.emp_no) cnt" + 
     "  from " + 
     "		  p_pers_master a, " + 
     "		  p_code_grade c," + 
     "		  p_code_school_car  d " + 
     "  where a.grade_code like '" + arg_grade_code + "' " + 
     "	 and a.comp_code like '" + arg_comp_code + "' " + 
     "	 and a.grade_code = c.grade_code(+)" + 
     "	 and a.school_car_code  = d.school_car_code(+) " + 
     "     and a.service_div_code <> '3' " + 
     "	 " + arg_div + " " + 
     "     and not (a.comp_code = 'C0' and a.RESIDENT_NO = '700823-1055615' or  " +
     "        a.comp_code = 'B0' and a.RESIDENT_NO = '680823-1055615' or         " +
     " 		 a.comp_code = 'E0' and a.RESIDENT_NO = '680823-1055615')		    "  + 
     " group by a.grade_code," + 
     "		 c.grade_name,  " +
     "   	 a.school_car_code, " + 
     "   	 d.school_car_name  " + 
     " order by a.grade_code, a.school_car_code  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>