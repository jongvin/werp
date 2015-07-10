<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_year = req.getParameter("arg_year");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
     String arg_seq_num = req.getParameter("arg_seq_num");


 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("year",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("seq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("d_seq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mtrcode",GauceDataColumn.TB_STRING,15));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("unitcode",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("rent_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_section",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("unitcost",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("standard_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("loss_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));

    String query = "  SELECT    " + 
     "         TO_CHAR(year,'YYYY.MM.DD') year , " + 
     "         sbcr_code,  " + 
     "         (select sbcr_name from s_sbcr where sbcr_code = a.sbcr_code) sbcr_name,  " + 
     "         seq_num,   " + 
     "         d_seq_num,   " + 
     "         mtrcode,   " + 
     "         name,   " + 
     "         ssize,   " + 
     "         unitcode,   " + 
     "         rent_section,   " + 
     "         input_section,   " + 
     "         unitcost,   " + 
	  "         standard_amt,   " + 
	  "         loss_amt,   " + 
	  "         remark   " + 
	  "         FROM M_PRICE_CONTRACT_DETAIL a   " + 
	  "         WHERE year = to_date('"+arg_year+"','yyyy.mm.dd') and " +
	  "                      sbcr_code = '"+arg_sbcr_code+"' and  " +
	  "                      seq_num = '"+arg_seq_num+"'  " +
     "			ORDER BY  mtrcode   ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>