<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%>
<%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_code = req.getParameter("arg_order_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("yymm",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("unq_num",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("item_code",GauceDataColumn.TB_STRING,2));   
	 dSet.addDataColumn(new GauceDataColumn("usememo",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("sum",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("old_amt",GauceDataColumn.TB_DECIMAL,13,0));
 

	String query = " select dept_code,									" +						 
    			   "   	   yymm,												" +						 
    			   "	   seq,													" +						 
    			   "	   order_number,										" +					 
    			   "	   unq_num,												" +	 
				   "       item_code,										" +
				   "	   usememo,												" +	 
    			   "	   amt,													" +	 
    			   "	   vat,													" +	 
					"     ( amt + vat ) sum ,								" +
					"	   remark,												" +
    			   "     amt old_amt											" +
   	    		   " from e_safty_cost  								" +
    			   " where dept_code = '" + arg_dept_code + "' and		" +
    			   " 	  order_number = '" + arg_order_code + "' and	" +
				   "      yymm = '" + arg_yymm + "'							" +
				   " order by													" +
				   "	   item_code asc										" ;

%>
<%@
include file="../../../comm_function/conn_q_end.jsp"%>