<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymmdd = req.getParameter("arg_yymmdd");
     String arg_tag = req.getParameter("arg_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymmdd",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize_1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize_2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("bef_cnt",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt",GauceDataColumn.TB_DECIMAL,18,3));
    String query = "  SELECT  a.dept_code,   " + 
     "         to_char(a.yymmdd,'yyyy.mm.dd') yymmdd,   " + 
     "         a.tag,   " + 
     "         a.spec_unq_num,   " + 
     "         a.no_seq,   " + 
     "         a.name,   " + 
     "         a.ssize_1,   " + 
     "         a.ssize_2,   " + 
     "         a.bef_cnt,   " + 
     "         a.cnt  " + 
     "    FROM c_daily_detail a " + 
     "   WHERE ( a.dept_code = '" + arg_dept_code+ "' ) AND  " + 
     "         ( a.yymmdd = '" + arg_yymmdd + "') AND  " + 
     "         ( a.tag = '" + arg_tag + "')   " + 
     "   order by a.no_seq               ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>