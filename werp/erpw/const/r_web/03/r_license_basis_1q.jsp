<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
     String arg_kind = req.getParameter("arg_kind");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("license_class_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("license_kind_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("key_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("license_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("engineer_qty",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT LICENSE_CLASS_CODE,   " + 
     "         LICENSE_KIND_CODE,   " + 
     "         nvl(SEQ,0) seq,   " + 
     "         nvl(SEQ,0) key_seq,   " + 
     "         LICENSE_NAME,   " + 
     "         nvl(ENGINEER_QTY,0) engineer_qty  " + 
     "    FROM R_GENERAL_LICENSE_BASIS  " + 
     "   WHERE ( LICENSE_CLASS_CODE = " + "'" + arg_class + "'" + " ) AND  " + 
     "         ( LICENSE_KIND_CODE = " + "'" + arg_kind + "'" + " )         " +
     "   order by  nvl(SEQ,0) ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>