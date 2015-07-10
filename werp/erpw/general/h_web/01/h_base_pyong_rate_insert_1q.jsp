<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
 String arg_dept_code = req.getParameter("arg_dept_code");
 String arg_sell_code = req.getParameter("arg_sell_code");
 String arg_spec_unq_num = req.getParameter("arg_spec_unq_num");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("spec_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("apply_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("land_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("build_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sell_amt",GauceDataColumn.TB_DECIMAL,18,0));
	  dSet.addDataColumn(new GauceDataColumn("land_rate",GauceDataColumn.TB_DECIMAL,6,3));
	  dSet.addDataColumn(new GauceDataColumn("build_rate",GauceDataColumn.TB_DECIMAL,6,3));
	  dSet.addDataColumn(new GauceDataColumn("vat_rate",GauceDataColumn.TB_DECIMAL,6,3));
    String query = "  SELECT H_BASE_PYONG_RATE.DEPT_CODE,   " + 
     "         H_BASE_PYONG_RATE.SELL_CODE,   " + 
     "         H_BASE_PYONG_RATE.SPEC_UNQ_NUM,   " + 
     "         to_char(H_BASE_PYONG_RATE.APPLY_DATE,'yyyy.mm.dd') apply_date,   " + 
     "         H_BASE_PYONG_RATE.LAND_AMT,   " + 
     "         H_BASE_PYONG_RATE.BUILD_AMT,   " + 
     "         H_BASE_PYONG_RATE.VAT_AMT,   " + 
     "         H_BASE_PYONG_RATE.SELL_AMT,  " + 
	  "         H_BASE_PYONG_RATE.LAND_RATE,  " +
	  "         H_BASE_PYONG_RATE.BUILD_RATE,  " +
	  "         H_BASE_PYONG_RATE.VAT_RATE  " +
     "    FROM H_BASE_PYONG_RATE" + 
     "   where dept_code = '"+arg_dept_code+"'" + 
     "     and sell_code = '"+arg_sell_code+"'" + 
     "     and spec_unq_num = "+arg_spec_unq_num +
	  "    order by apply_date";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>