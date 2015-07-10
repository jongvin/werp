<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_mssql_portal_q.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 	  String arg_from_date = req.getParameter("arg_from_date");
 	  String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("sex",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("career_fresh",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("apply_field",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("apply_field2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("apply_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ok_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("close_tag",GauceDataColumn.TB_STRING,1));
    String query = "SELECT a.resident_no, 		" +
					    "  		a.name,   " +
					    "  		a.sex,   " +
					    "  		a.career_fresh,   " +
					    "  		b.apply_field,   " +
					    "  		b.apply_field2,   " +
					    "       b.apply_date, " +
					    "       'F' ok_tag, " +
					    "			a.close_tag " +
					    "  from recruit_resume a,		" +
					    "       recruit_apply b		" +
					    " where a.resident_no = b.resident_no " +
//					    "   and b.recruit_kind = '상시' "+
//						"   and b.rno = 1 " +
					    "   and convert(char(8),b.apply_date,112) between '"+ arg_from_date +"' and '"+ arg_to_date +"' " +
					    "   and a.close_tag = 'N' " +		//마감이 아닌것만 조회
					    " order by b.apply_field , a.name	";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>