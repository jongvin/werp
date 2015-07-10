<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("plan_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("extablish_time",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("extablish_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("cash_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("bill_amt",GauceDataColumn.TB_DECIMAL,13,0));
     dSet.addDataColumn(new GauceDataColumn("collection_plan_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cash_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bill_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("collection_cond",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("key_plan_yymm",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("key_plan_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  a.dept_code ,                                      " +
             "						to_char(a.plan_date,'yyyy.mm.dd') plan_date ,      " +
             "                a.extablish_time ,  											" +
             "                a.extablish_tag , 											" +
				 "	               a.cash_amt,														" +
				 "	               a.bill_amt,														" +
             "                a.collection_plan_amt ,										" +
				 "	               to_char(a.cash_date,'yyyy.mm.dd') cash_date,			" +
				 "	               to_char(a.bill_date,'yyyy.mm.dd') bill_date, 		" +
             "                a.collection_cond , 											" +
             "                a.remark , 														" +
             "                b.long_name,    												" +
             "                to_char(a.plan_date ,'yyyy.mm') key_plan_yymm, 		" +
             "                to_char(a.plan_date ,'yyyy.mm.dd') key_plan_date 	" +
             "           FROM r_contract_collection_plan a, 							" +
             "                z_code_dept b    												" +
             "          WHERE a.dept_code = b.dept_code and     						" +
             "                a.dept_code = '" + arg_dept_code  +	"'             " +
             "       order by plan_date desc														";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>