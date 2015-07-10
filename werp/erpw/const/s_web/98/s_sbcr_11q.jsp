<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("imp_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,1000));
    String query = "  SELECT  sbcr_code ," + 
     					 "          mtrcode ," + 
     					 "          name ," + 
     					 "          imp_class ," + 
     					 "          remark " +
     					 "     FROM s_imp_material " +
     					 "    WHERE SBCR_CODE = '" + arg_sbcr_code + "'";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%> 