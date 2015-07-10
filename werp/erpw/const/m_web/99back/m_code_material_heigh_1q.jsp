<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("mtrgrand",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  m_code_material_high.mtrgrand ," + 
     "          m_code_material_high.seq ," + 
     "          m_code_material_high.llevel ," + 
     "          m_code_material_high.name ," + 
     "          m_code_material_high.note     FROM m_code_material_high  order by  m_code_material_high.mtrgrand     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>