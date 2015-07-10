<%@ page session="true"		  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_mssql_portal_q.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_cust_code = req.getParameter("arg_cust_code");
	 
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("kind",GauceDataColumn.TB_STRING,20));
		dSet.addDataColumn(new GauceDataColumn("receipt_no",GauceDataColumn.TB_STRING,20));
		dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_STRING,20));
		dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
		dSet.addDataColumn(new GauceDataColumn("subject",GauceDataColumn.TB_STRING,255));
      dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,1000));
		dSet.addDataColumn(new GauceDataColumn("create_date",GauceDataColumn.TB_STRING,20));
     
	  String query = " SELECT	USER_ID, KIND,RECEIPT_NO,SEQ,NAME,SUBJECT, MEMO, CREATE_DATE "+
     "                               FROM ( SELECT user_id, KIND,RECEIPT_NO,-1 SEQ,NAME,SUBJECT,MEMO,CONVERT(char(10),CREATE_DATE,121) CREATE_DATE  "+
     "                    FROM COUNSELING "+
     "                    WHERE user_id = '"+arg_cust_code+"'"+
     "         UNION ALL "+
     "         SELECT b.user_id, a.KIND,a.RECEIPT_NO,a.SEQ,a.processor_name, '  '+a.SUBJECT,a.process_MEMO,CONVERT(char(10),a.CREATE_DATE,121) "+
     "                      FROM COUNSELING_REPLY a, COUNSELING b	 "+
     "                      WHERE b.user_id = '"+arg_cust_code+"' and a.receipt_no = b.receipt_no) AS A "+
     "  WHERE user_id = '"+arg_cust_code+"'"+
     "  ORDER BY  A.RECEIPT_NO DESC,A.SEQ";
     //"  ORDER BY  a.kind,A.RECEIPT_NO DESC,A.SEQ";

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>