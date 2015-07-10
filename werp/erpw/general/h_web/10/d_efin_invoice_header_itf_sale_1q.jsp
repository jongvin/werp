<%@ page session="true"	  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     //String arg_user_id = req.getParameter("arg_user_id");
    
	 String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_sell_code = req.getParameter("arg_sell_code");
	 String arg_from_date = req.getParameter("arg_from_date");
    String arg_to_date = req.getParameter("arg_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("invoice_group_id",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approval_name",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("complete_flag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("interface_flag",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("current_approval_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("account_dept_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("secretary_dept_code",GauceDataColumn.TB_STRING,20));
	  dSet.addDataColumn(new GauceDataColumn("approval_name_1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("creation_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("created_by",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("created_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("created_dept_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("last_update_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_update_login",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("last_updated_by",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("approval_num",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("source",GauceDataColumn.TB_STRING,25));
     dSet.addDataColumn(new GauceDataColumn("batch_date",GauceDataColumn.TB_STRING,18));
	  dSet.addDataColumn(new GauceDataColumn("chk_1",GauceDataColumn.TB_STRING,18));
     String query = "  SELECT a.invoice_group_id,   " + 
     "         a.approval_name,   " + 
     "         a.complete_flag,   " + 
     "         a.interface_flag,   " + 
     "         a.current_approval_id,   " + 
     "         a.account_dept_code,   " + 
     "         a.secretary_dept_code,   " + 
	  "         a.approval_name_1,   " + 
     "         to_char(a.creation_date,'yyyy.mm.dd') creation_date,   " + 
     "         a.created_by,   " + 
     "         to_char(a.last_update_date,'yyyy.mm.dd') last_update_date,   " + 
     "         a.created_dept_code,   " + 
     "         a.created_dept_name,   " + 
     "         a.last_update_login,   " + 
     "         a.last_updated_by,   " + 
     "         a.approval_num,  " + 
     "         a.source,  " + 
     "         to_char(a.batch_date,'yyyy.mm.dd') batch_date,  " + 
     "  DECODE(a.complete_flag,'1','결재중',DECODE(a.complete_flag,'3','반송',DECODE(a.complete_flag,'9',DECODE(a.relation_invoice_group_id,NULL,'결재완료','취소전표')))) chk_1 "+
     "       FROM efin_invoice_header_itf   a "+
     "        WHERE TO_CHAR(A.invoice_group_id) IN (SELECT DISTINCT sell_slip_no FROM H_SALE_master "+
	  "                                                                                                                                             where dept_code = '"+arg_dept_code +"'"+
	   "																																																	and sell_code = '"+arg_sell_code  +"' ) "+
		"     and a.batch_date >= '" + arg_from_date + "' " + 
     "     and a.batch_date <= '" + arg_to_date + "' " + 
	 /* "            and  a.created_dept_code = '"+arg_dept_code +"'"+*/
	  " order by a.batch_date desc";
     /*"     and a.current_approval_id = '" + arg_user_id + "' " + 
     "     and a.batch_date >= '" + arg_from_date + "' " + 
     "     and a.batch_date <= '" + arg_to_date + "' " + 
     "   ORDER BY  a.created_dept_name,a.batch_date desc,a.invoice_group_id " + 
     "                 ";																												 */
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>