<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)
     String as_dept_code    = req.getParameter("as_dept_code");
	 String as_sell_code    = req.getParameter("as_sell_code");
     String as_finish    = req.getParameter("as_finish");
     String as_from_date = req.getParameter("as_from_date");
     String as_to_date   = req.getParameter("as_to_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("input_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("title",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("contents",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("record_duty_id",GauceDataColumn.TB_STRING,12));
     dSet.addDataColumn(new GauceDataColumn("identify_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("finish_yn",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("memo_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_1",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("key_2",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_3",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("key_4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_5",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_6",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "SELECT A.DEPT_CODE," + 
     "		 A.SELL_CODE," + 
     "       B.LONG_NAME," +
     "		 A.DONGHO," + 
     "		 NVL(A.SEQ, 0) SEQ," + 
     "		 TO_CHAR(A.INPUT_DATE, 'YYYY.MM.DD') INPUT_DATE," + 
     "		 NVL(A.INPUT_SEQ, 0) INPUT_SEQ," + 
     "		 A.TITLE," + 
     "		 A.CONTENTS," + 
     "		 A.RECORD_DUTY_ID," + 
     "       TO_CHAR(A.IDENTIFY_DATE, 'YYYY.MM.DD') IDENTIFY_DATE," + 
     "		 DECODE(A.FINISH_YN, 'Y', 'T', 'F') FINISH_YN," + 
	 "		 A.MEMO_CODE," + 
     "       A.DEPT_CODE   KEY_1," + 
     "		 A.SELL_CODE   KEY_2," + 
     "		 A.DONGHO      KEY_3," + 
     "		 NVL(A.SEQ, 0) KEY_4," + 
     "		 TO_CHAR(A.INPUT_DATE, 'YYYY.MM.DD') KEY_5," + 
     "		 NVL(A.INPUT_SEQ, 0) KEY_6" + 
     "  FROM H_SALE_MEMO A," + 
     "       H_CODE_DEPT B"  +
     " WHERE A.DEPT_CODE = B.DEPT_CODE " +
	 "   AND A.DEPT_CODE  LIKE '" + as_dept_code + "' || '%'" + 
	 "   AND A.SELL_CODE  LIKE '" + as_sell_code + "' || '%'" + 
     "   AND FINISH_YN LIKE '" + as_finish + "' || '%'" + 
     "   AND (INPUT_DATE IS NULL OR " + 
     "        INPUT_DATE  BETWEEN  '" + as_from_date + "' AND '" + as_to_date + "'  )      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>