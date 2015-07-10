<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%>><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("c_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("url",GauceDataColumn.TB_STRING,255));
     dSet.addDataColumn(new GauceDataColumn("memo",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("cdir",GauceDataColumn.TB_URL,255));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("temp_url",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  c_prgs_picture.dept_code ," + 
     "          c_prgs_picture.c_unq_num ," + 
     "          to_char(c_prgs_picture.yymmdd,'yyyy.mm.dd') yymmdd," + 
     "          c_prgs_picture.spec_no_seq ," + 
     "          c_prgs_picture.url ," + 
     "          c_prgs_picture.memo, " + 
     "          c_prgs_picture.url cdir," + 
     "          '                                                                                                         '  name,  " + 
     "          '                                                                                                         '  temp_url " + 
     "        FROM c_prgs_picture    " + 
     "           WHERE ( c_prgs_picture.dept_code = " + "'" + arg_dept_code + "'" + " ) " + 
     "        ORDER BY c_prgs_picture.dept_code          ASC," + 
     "          c_prgs_picture.yymmdd          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>