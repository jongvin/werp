<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
 String arg_dept_code = req.getParameter("arg_dept_code"); 
 String arg_sell_code = req.getParameter("arg_sell_code"); 
 String arg_fr_date  = req.getParameter("arg_fr_date");
 String arg_to_date = req.getParameter("arg_to_date");				 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("subs_no",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("subs_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("prize_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("prize_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("biz_status",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("biz_type",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("cur_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("cur_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cur_addr2",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("subs_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("work_no_subs",GauceDataColumn.TB_STRING,50));
    String query = "SELECT a.subs_no, 	"+
"             a.cust_code, "+
"             a.subs_date,	 "+
"             a.subs_amt,	  "+
"             a.prize_date,		"+
"             a.prize_dongho,	"+
"             c.cust_name,		  "+
"             c.cust_div,					  "+
"             c.biz_status,					 "+
"             c.biz_type,							"+
"             c.CUR_ZIP_CODE,			"+
"             c.CUR_ADDR1,						"+
"             c.CUR_ADDR2, a.work_no_subs 							"+
"        FROM H_SUBS_MASTER a,		"+
"             H_CODE_CUST c								"+
"       WHERE (LENGTH(trim(a.work_no_subs)) IS NULL OR             "+
"              a.work_no_subs IN (SELECT invoice_group_id FROM v_invoice_reject )  "+
"         )																																														  "+
"         AND a.dept_code = '"+arg_dept_code+"'"+
"         AND a.sell_code = '"+arg_sell_code+"'"+
"         AND a.subs_date  BETWEEN '"+arg_fr_date+"' AND '"+arg_to_date+"'"+
"         AND a.cust_code = c.cust_code (+)																									 "+
"      ORDER BY a.subs_no" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>