<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_mtrgrand = req.getParameter("arg_mtrgrand");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ditag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rentrate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("mtrgrand",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("account_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("years",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remainyear",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("repay_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("acctag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("key_mtrcode",GauceDataColumn.TB_STRING,15));
    String query = "  SELECT  m_code_material.mtrcode ," + 
     "          m_code_material.name ," + 
     "          m_code_material.ssize ," + 
     "          m_code_material.unitcode ," + 
     "          m_code_material.ditag ," + 
     "          nvl(m_code_material.rentrate,0) rentrate ," + 
     "          nvl(m_code_material.unitcost,0) unitcost ," + 
     "          m_code_material.mtrgrand ," + 
     "          m_code_material.account_code ," + 
     "          nvl(m_code_material.years,0) years ," + 
     "          nvl(m_code_material.remainyear,0) remainyear ," + 
     "          m_code_material.repay_tag ," + 
     "          m_code_material.acctag,m_code_material.mtrcode key_mtrcode      FROM m_code_material " + 
     "         WHERE ( m_code_material.mtrgrand = '" + arg_mtrgrand  + "') " + 
     "      ORDER BY m_code_material.mtrcode          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>