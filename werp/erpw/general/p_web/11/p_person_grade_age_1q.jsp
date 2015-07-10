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
     dSet.addDataColumn(new GauceDataColumn("age",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select master.grade_code," + 
     "		               c.grade_name, " + 
     "                     decode(substr(master.age,1,1),'2','20대','3','30대', " +
     "                                    '4','40대','5','50대','6','60대','7','70대','미입력') age, " + 
     "                     count(master.emp_no) cnt" + 
     "  from " + 
	  " 		  ( select a.emp_no, a.emp_name, a.resident_no,a.grade_code,a.comp_code,a.service_div_code,  " +
	  "		  	 		  	to_char(to_date('" + arg_date + "'),'yyyy') - decode(substr(a.resident_no,8,1), " +
	  "												'1', to_number('19' || substr(a.resident_no,1,2)),   " +
	  "												'2', to_number('19' || substr(a.resident_no,1,2)),   " +
	  "												'3', to_number('20' || substr(a.resident_no,1,2)),   " +
	  "												'4', to_number('20' || substr(a.resident_no,1,2)),   " +
	  "												to_char(to_date('" + arg_date + "'),'yyyy')) age     " +
	  "		   from p_pers_master a                                                            " +
	  " 			) master, " +
     "		  p_code_grade c " + 
     "  where master.grade_code like '" + arg_grade_code + "' " + 
     "	 and master.grade_code = c.grade_code" + 
     "	 and master.comp_code like '" + arg_comp_code + "' " + 
     "     and master.service_div_code <> '3' " + 
     "	 " + arg_div + " " + 
     "     and not (master.comp_code = 'C0' and master.RESIDENT_NO = '700823-1055615' or  " +
     "        master.comp_code = 'B0' and master.RESIDENT_NO = '680823-1055615' or         " +
     " 		 master.comp_code = 'E0' and master.RESIDENT_NO = '680823-1055615')		    "  + 
     " group by master.grade_code," + 
     "		 c.grade_name,  " +
     "   	 decode(substr(master.age,1,1),'2','20대','3','30대','4','40대','5','50대','6','60대','7','70대','미입력') " + 
     " order by master.grade_code, " +
     "       decode(substr(master.age,1,1),'2','20대','3','30대','4','40대','5','50대','6','60대','7','70대','미입력')  ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>