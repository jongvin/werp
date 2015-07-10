<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_sell_code = req.getParameter("arg_sell_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("subs_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("spouse_rrn",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("spouse_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("style",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("classify",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("subs_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("subs_order",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("prize_dongho",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("subs_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bank_head_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("bank_head_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("refund_deposit_no",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("pay_tag",GauceDataColumn.TB_STRING,2));  
     dSet.addDataColumn(new GauceDataColumn("prize_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cust_div",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("preparation_order",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("new_tag",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  a.dept_code ," + 
     "					         a.sell_code ," + 
     "					         a.subs_no ," + 
     "					         a.cust_code ," + 
     "					         a.spouse_rrn ," + 
     "					         a.spouse_name ," + 
     "					         a.pyong ," + 
     "					         a.style ," + 
     "					         a.classify ," + 
     "					         a.class," + 
     "					         to_char(a.subs_date,'YYYY.MM.DD') subs_date," + 
     "					         a.subs_order ," + 
     "					         a.deposit_no ," + 
     "					         a.prize_dongho ," + 
     "					         a.subs_amt ," + 
     "					         a.bank_head_code ," + 
     "					         a.bank_head_name ," + 
     "					         a.refund_deposit_no ," + 
     "					         a.remark ," + 
     "					         a.pay_tag ," + 
     "                        to_char(a.prize_date,'YYYY.MM.DD') prize_date, " +
     "					         b.cust_name,    " + 
     "					         b.cust_div     ," + 
     "					         nvl(a.preparation_order,0) preparation_order, " +
     "					         'N'  new_tag  " +
     " 				       FROM h_subs_master a," + 
     " 				            h_code_cust  b   " + 
     "			        WHERE ( b.cust_code(+) = a.cust_code ) and  " + 
     "			              ( ( a.dept_code = '" + arg_dept_code + "') and   " + 
     "			                ( a.sell_code = '" + arg_sell_code + "') )      " + 
     "			        ORDER BY a.subs_no ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>