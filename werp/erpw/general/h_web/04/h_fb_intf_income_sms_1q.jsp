<%@ page session="true"	  contentType="text/html;charset=EUC_KR"   import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
  
 String arg_work_seq = req.getParameter("arg_work_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("fb_seq",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("sender_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tran_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("tran_phone",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("tran_callback",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("tran_msg",GauceDataColumn.TB_STRING,255));
    String query = " SELECT a.fb_seq , "+ 
	                           "                 comp.comp_name  sender_id, "+ 
	                           "                 '02-3779-0300'  tran_callback,  "+
										"						c.cust_name  tran_id, 			"+
										"						c.cell_phone  tran_phone,				 "+
										"						c.cust_name||'고객님'||CHR(13)||        "+
										"						SUBSTR(a.fb_recv_date,5,2)||'/'||SUBSTR(a.fb_recv_date,7,2)||'일 입금하신'||CHR(13)|| "+
										"						trim(TO_CHAR(a.fb_recv_amt, '999,999,999,999'))||'원 입금 처리 되었습니다.'||CHR(13)||CHR(13)|| "+
										"						comp.comp_name  	 tran_msg "+
										"				  FROM H_FB_INTF_INCOME a ,	  "+
										"						 H_SALE_MASTER m,							"+
										"						 H_CODE_CUST c	,									 "+
										"                  z_code_comp comp			 "+
										"				 WHERE NVL(a.EX_COL1, 'N') = 'Y'			 "+
										"					AND work_seq = '"+arg_work_seq+"'"+
										"					AND a.dept_code = m.dept_code					  "+
										"					AND a.sell_code = m.sell_code								"+
										"					AND a.dongho    = m.dongho											 "+
										"					AND a.seq       = m.seq																  "+
										"					AND m.cust_code = c.cust_code											"+
										"              and SUBSTR(a.dept_code, 1,2) = comp.comp_code (+)";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>