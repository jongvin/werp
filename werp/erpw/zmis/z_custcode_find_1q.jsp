<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_name = req.getParameter("arg_name");
     arg_name = "%" + arg_name + "%";
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("address1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("vender_code",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT a.sbcr_code,   " + 
     "              	     a.sbcr_name,   " + 
     "         		     a.businessman_number  ," + 
     "			     a.address1 ," + 
     "                       b.vender_code " +
     "    FROM M_CODE_COLLABORATOR b, " + 
     "         s_sbcr a " +
     "   WHERE a.businessman_number = b.businessman_number " +
     "     and a.sbcr_name like " + "'" + arg_name + "'" + 
	 "   ORDER BY comp_code, dept_proj_tag, long_name";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>