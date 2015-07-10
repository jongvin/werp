<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_apply_date = req.getParameter("arg_apply_date");
     String arg_tax_tag = req.getParameter("arg_tax_tag");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("apply_date",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("tax_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("degree",GauceDataColumn.TB_DECIMAL,18));
     dSet.addDataColumn(new GauceDataColumn("degree2",GauceDataColumn.TB_DECIMAL,18));
     dSet.addDataColumn(new GauceDataColumn("from_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("to_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("tax_amt",GauceDataColumn.TB_DECIMAL,13,0));

    String query = "select to_char(a.apply_date,'yyyymmdd')apply_date ," + 
     "               		a.tax_tag," + 
     "               		a.degree," + 
     "               		a.degree degree2," + 
	  "               		a.from_amt," + 
     "               		a.to_amt," + 
     "               		a.tax_amt" + 
	  "				from l_tax_degree a " +
	  "            where to_char(a.apply_date,'yyyymmdd') = '" +arg_apply_date + "'" + 
	  "				      and tax_tag = '"+ arg_tax_tag +"'" +
     "            order by a.degree asc" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>