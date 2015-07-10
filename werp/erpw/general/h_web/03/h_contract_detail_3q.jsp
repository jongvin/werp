<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
     String arg_dongho = req.getParameter("arg_dongho");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("opt_name",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("opt_base",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("opt_finish",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("opt_ref",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("norm_prem_tag",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
    String query = "select s.dept_code," + 
     "       s.sell_code," + 
     "       s.dongho," + 
     "       s.seq," + 
     "		 s.pyong," + 
     "		 s.opt_name," + 
     "		 s.opt_base," + 
     "		 s.opt_finish," + 
     "		 s.opt_ref," + 
     "		 s.contract_date," + 
     "		 s.amt," + 
     "		 s.amt_vat," + 
     "		 s.NORM_PREM_TAG," + 
     "		 s.remark" + 
     "  from h_sale_ontime_master s" + 
     " where s.dept_code = " + "'" + arg_dept_code + "'" + 
     "   and s.sell_code = " + "'" + arg_sell_code + "'" + 
     "	and s.dongho    = '"+arg_dongho+"'"+
     "	and s.seq       = '"+arg_seq+"'"	     ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>