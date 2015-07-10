<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_part_code = req.getParameter("arg_part_code");
      String arg_name = req.getParameter("arg_name");
		arg_name = arg_name + "%" ;
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("PART_CODE",GauceDataColumn.TB_STRING,1));
	  dSet.addDataColumn(new GauceDataColumn("SECTION",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("COMM_NAME",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("COMM_CODE",GauceDataColumn.TB_STRING,4));


    String query = " select  PART_CODE , SECTION , COMM_NAME ,COMM_CODE " +
						"	from v_comm_code												" +			
						"	where section = '1'									      " + 
						"   and part_code = '"+arg_part_code+	"'					" + 
						"   and Comm_name like  '"+ arg_name+ "'					" ;

	
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>