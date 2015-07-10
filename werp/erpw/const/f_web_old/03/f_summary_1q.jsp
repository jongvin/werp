<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept = req.getParameter("arg_dept");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bonsa_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("cost_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("l_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("q_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("s_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("m_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("f_close",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("l_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("q_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("s_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("m_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bigo1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bigo2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("bigo3",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT DEPT_CODE,   " + 
     "         to_char(YYMM,'YYYY.MM.DD') YYMM,   " + 
     "         BONSA_CLOSE,   " + 
     "         COST_CLOSE,   " + 
     "         L_CLOSE,   " + 
     "         Q_CLOSE,   " + 
     "         S_CLOSE,   " + 
     "         M_CLOSE,   " + 
     "         F_CLOSE,   " + 
     "         decode(l_close,'Y','N','Y') L_TAG,   " + 
     "         decode(q_close,'Y','N','Y') Q_TAG,   " + 
     "         decode(s_close,'Y','N','Y') S_TAG,   " + 
     "         decode(m_close,'Y','N','Y') M_TAG,   " + 
     "         BIGO1,   " + 
     "         BIGO2,   " + 
     "         BIGO3  " + 
     "    FROM C_SPEC_CONST_CLOSING  " + 
     "   WHERE ( DEPT_CODE = " + "'" + arg_dept  + "'" + " ) AND  " + 
     "         ( YYMM = " + "'" + arg_date + "'" + " )   ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>