<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("spec_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_spec_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("scholarship_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sch_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("subject_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("graduation_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT sbcr_code,   " + 
     					 "         CLASS,   " + 
     					 "         SPEC_SEQ,   " + 
     					 "         SPEC_SEQ key_spec_seq,   " + 
     					 "         SCHOLARSHIP_CLASS,   " + 
     					 "         to_char(sch_date,'YYYY.MM.DD') sch_date, " +
     					 "         NAME,   " + 
     					 "         SUBJECT_NAME,   " + 
     					 "         GRADUATION_CLASS,   " + 
     					 "         REMARK  " + 
     					 "    FROM S_SCHOLARSHIP  " + 
     					 "   WHERE sbcr_code = '" + arg_sbcr_code + "'" + 
     					 "     AND CLASS = '1'    " + 
     					 " ORDER BY SPEC_SEQ ASC        ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>