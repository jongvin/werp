<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_class = req.getParameter("arg_class");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("price_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("price1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price4",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price5",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price6",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price7",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price8",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price9",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price10",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT  a.price_class ," + 
     					 "          a.mtrcode ," + 
     					 "          a.price1 ," + 
     					 "          a.price2 ," + 
     					 "          a.price3 ," + 
     					 "          a.price4 ," + 
     					 "          a.price5 ," + 
     					 "          a.price6 ," + 
     					 "          a.price7 ," + 
     					 "          a.price8 ," + 
     					 "          a.price9 ," + 
     					 "          a.price10 ," + 
     					 "          a.remark ," + 
     					 "          b.name ," + 
     					 "          b.ssize ," + 
     					 "          b.unitcode  " +
     					 "     FROM m_mtr_price a," + 
     					 "          m_code_material b " +
     					 "    WHERE a.mtrcode = b.mtrcode " +
     					 "      and a.PRICE_CLASS = '" + arg_class + "'" +
     					 " ORDER BY a.price_class          ASC," + 
     					 "          a.mtrcode          ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>