<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
     String arg_seq = req.getParameter("arg_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("rqst_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("actual_inv_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("company_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("division_rate",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         to_char(a.RQST_DATE,'YYYY.MM.DD')  RQST_DATE,  " + 
     "         a.SEQ,   " + 
     "         a.CUST_CODE,   " + 
     "			b.cust_name," + 
     "         a.AMT,   " + 
     "         a.VAT,   " + 
     "         a.ACTUAL_INV_TAG," + 
     "			e.company_tag," + 
     "			e.division_rate  " + 
     "    FROM F_JOINT_DISTRIBUTION  a," + 
     "			z_code_cust_code b," + 
     "			( select d.dept_code,d.customer_no,d.company_tag,d.division_rate" + 
     "			    from r_contract_register c," + 
     "				 r_contract_succesful_bid d" + 
     "			   where c.dept_code = d.dept_code (+)" + 
     "			     and c.cont_no   = d.cont_no (+)" + 
     "			     and c.chg_degree = d.chg_degree (+)" + 
     "			     and c.last_tag = 'Y' ) e" + 
     "   WHERE ( a.cust_code = b.cust_code ) and" + 
     "	       ( a.dept_code = e.dept_code (+) and" + 
     "		 a.cust_code = e.customer_no (+)) and" + 
     "	       ( a.DEPT_CODE = " + "'" + arg_dept_code + "'" + " AND  " + 
     "           a.RQST_DATE = " + "'" + arg_date + "'" + " AND  " + 
     "           a.SEQ = " + "'" + arg_seq + "'" + " )   " + 
     "ORDER BY e.division_rate DESC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>