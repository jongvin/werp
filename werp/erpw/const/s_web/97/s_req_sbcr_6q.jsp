<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_unq_num = req.getParameter("arg_unq_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("spec_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_spec_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("scholarship_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sch_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("subject_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("graduation_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT SBCR_UNQ_NUM,   " + 
     					 "         CLASS,   " + 
     					 "         SPEC_SEQ,   " + 
     					 "         SPEC_SEQ key_spec_seq,   " + 
     					 "         SCHOLARSHIP_CLASS,   " + 
     					 "         to_char(sch_date,'YYYY.MM.DD') sch_date," +
     					 "         NAME,   " + 
     					 "         SUBJECT_NAME,   " + 
     					 "         GRADUATION_CLASS,   " + 
     					 "         REMARK  " + 
     					 "    FROM S_REQ_SCHOLARSHIP  " + 
     					 "   WHERE SBCR_UNQ_NUM = " + arg_unq_num +
     					 "     AND CLASS = '2'    " + 
     					 " ORDER BY SPEC_SEQ ASC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>