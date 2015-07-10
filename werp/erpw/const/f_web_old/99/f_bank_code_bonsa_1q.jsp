<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_wbs_code = req.getParameter("arg_wbs_code");
	 String query = "";
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
	 dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("bank_account_id",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("bank_account_number",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("bank_branch_name",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("folder_id",GauceDataColumn.TB_STRING,10));
	 dSet.addDataColumn(new GauceDataColumn("as_name",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("as_class",GauceDataColumn.TB_STRING,1));

	if (arg_dept_code.equals("A05266"))	{
		query = "  SELECT  a.dept_code ," +
							 "    a.wbs_code," + 
							 "    to_char(a.bank_account_id) bank_account_id ," + 
							 "    a.bank_account_number ," + 
							 "    a.bank_branch_name ," + 
							 "    a.folder_id, " +
							 "    b.long_name as_name ," +
							 "    a.as_class " +
							 "     FROM f_dept_bonsa_account a left join  z_code_dept b on a.wbs_code = b.dept_code " +
							 "    WHERE a.DEPT_CODE = '" + arg_dept_code  + "'" ;
		if (!arg_wbs_code.equals("")) {
			 query = query + " And a.wbs_code = '" + arg_wbs_code + "' ";
		}
			 query = query + " ORDER BY b.long_name "; 
	} else {
		query = "  SELECT  a.dept_code ," +
							 "    a.wbs_code," + 
							 "    to_char(a.bank_account_id) bank_account_id ," + 
							 "    a.bank_account_number ," + 
							 "    a.bank_branch_name ," + 
							 "    a.folder_id, " +
							 "    ' ' as_name ," +
							 "    a.as_class " +
							 "     FROM f_dept_bonsa_account a " +
							 "    WHERE a.DEPT_CODE = '" + arg_dept_code  + "'" ;
		if (!arg_wbs_code.equals("")) {
			 query = query + " And a.wbs_code = '" + arg_wbs_code + "' ";
		}
			 query = query + " ORDER BY a.bank_account_id          ASC," + 
							 "          a.bank_account_number          ASC      ";
	}
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>