<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fax",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("union_members",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("union_div_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("old_union_code",GauceDataColumn.TB_STRING,13));
    String query = "  SELECT  h_unin_ledger.dept_code ," + 
     "          h_unin_ledger.sell_code ," + 
     "          h_unin_ledger.union_code ," + 
     "          h_unin_ledger.union_name ," + 
     "          h_unin_ledger.zip_code ," + 
     "          h_unin_ledger.addr1 ," + 
     "          h_unin_ledger.addr2 ," + 
     "          h_unin_ledger.fax ," + 
     "          h_unin_ledger.phone ," + 
     "          h_unin_ledger.union_members ," + 
     "          h_unin_ledger.union_div_code ," + 
     "          h_unin_ledger.remark,    " + 
     "          h_unin_ledger.union_code old_union_code" + 
     "         FROM h_unin_ledger    " + 
     "         WHERE ( h_unin_ledger.dept_code = '" + arg_dept_code + "') and    " + 
     "               ( h_unin_ledger.sell_code = '" + arg_sell_code + "')       " + 
     "         ORDER BY h_unin_ledger.union_code  ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>