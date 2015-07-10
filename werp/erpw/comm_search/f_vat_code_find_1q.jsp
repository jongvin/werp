<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 String arg_org_id = req.getParameter("arg_org_id");
 String arg_io_type = req.getParameter("arg_io_type");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("tax_id",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("tax_code_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("tax_desc",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  tax_id ," + 
     "         		      tax_code_name,  " + 
     "         		      tax_desc  " + 
     "         		 FROM efin_tax_codes_v  " +
     "               where org_code = '" + arg_org_id + "'" +
     "                 and io_type = '" + arg_io_type + "'";
if (!arg_io_type.equals("O"))
	query = query + "  and account_code in ('112411','112412','112414','112417','112421','112423','112418') ";
else
	query = query + "  and account_code in ('211714') ";
    query = query + "  order by tax_id asc       " ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>