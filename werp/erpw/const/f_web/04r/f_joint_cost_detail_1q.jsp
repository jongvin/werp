<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_date = req.getParameter("arg_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("rqst_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("res_type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rqst_detail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("t_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("t_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("actual_inv_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("band_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sysdate",GauceDataColumn.TB_STRING,19));
    String query = "  SELECT LONG_NAME,   " + 
     "         to_char(RQST_DATE,'YYYY.MM.DD')  RQST_DATE,  " + 
     "         SEQ,   " + 
     "         RES_TYPE,   " + 
     "         RQST_DETAIL,   " + 
     "         nvl(AMT,0) amt,   " + 
     "         nvl(VAT,0) vat,   " + 
     "         decode(company_tag,'Y', ' ' || CUST_NAME,cust_name) cust_name,   " + 
     "         nvl(T_AMT,0) t_amt,   " + 
     "         nvl(T_VAT,0) t_vat,   " + 
     "         decode(ACTUAL_INV_TAG,'Y','*','') ACTUAL_INV_TAG," + 
     "	       BAND_TAG," + 
     "	       decode(company_tag,'Y',0,1) comp_seq," +
     "	       sysdate" + 
     "    FROM ( SELECT c.LONG_NAME,   " + 
     "			a.RQST_DATE,   " + 
     "			a.SEQ,   " + 
     "			a.RES_TYPE,   " + 
     "			a.RQST_DETAIL,   " + 
     "			a.AMT,   " + 
     "			a.VAT,   " + 
     "			d.CUST_NAME,   " + 
     "			b.AMT T_AMT,   " + 
     "			b.VAT T_VAT,   " + 
     "			b.ACTUAL_INV_TAG," + 
     "			'1'  BAND_TAG ," + 
     "			e.company_tag" +
     "		 FROM F_REQUEST a,   " + 
     "			F_JOINT_DISTRIBUTION b,   " + 
     "			Z_CODE_DEPT c,   " + 
     "			Z_CODE_CUST_CODE d, " + 
     "                  ( select b.customer_no,b.company_tag " +
     "			    from r_contract_register a, r_contract_succesful_bid b " +
     "     		   where a.dept_code = b.dept_code " +
     "			     and a.cont_no   = b.cont_no " +
     "			     and a.chg_degree = b.chg_degree " +
     "			     and a.dept_code = " + "'" + arg_dept_code + "'" + 
     " 			     and a.last_tag = 'Y' ) e " +
     "		WHERE ( a.DEPT_CODE = C.DEPT_CODE ) and  " + 
     "			( b.cust_code = e.customer_no (+)) and " +
     "			( a.dept_code = b.dept_code(+)) and  " + 
     "			( a.rqst_date = b.rqst_date(+)) and  " + 
     "			( a.seq       = b.seq(+)) and  " + 
     "			( b.CUST_CODE = d.CUST_CODE (+)) and" + 
     "			( a.dept_code = " + "'" + arg_dept_code + "'" + " ) and" + 
     "                  (substr(to_char(a.rqst_date,'YYYY.MM.DD'),1,7) = substr(" + "'" + arg_date + "'" +  ",1,7)) " +
     "		union all" + 
     "		  SELECT c.LONG_NAME,   " + 
     "			MAX(a.RQST_DATE) RQST_DATE,   " + 
     "			MAX(a.SEQ) SEQ,   " + 
     "			MAX(a.RES_TYPE) RES_TYPE,   " + 
     "			MAX(a.RQST_DETAIL) RQST_DETAIL,   " + 
     "			NVL(SUM(a.AMT),0) AMT," + 
     "			NVL(SUM(a.VAT),0) VAT,   " + 
     "			d.CUST_NAME,   " + 
     "			NVL(SUM(b.AMT),0) T_AMT,   " + 
     "			NVL(SUM(b.VAT),0) T_VAT,   " + 
     "			MAX(b.ACTUAL_INV_TAG) ACTUAL_INV_TAG," + 
     "			MAX('2')  BAND_TAG ," + 
     "			e.company_tag " +
     "		 FROM F_REQUEST a,   " + 
     "			F_JOINT_DISTRIBUTION b,   " + 
     "			Z_CODE_DEPT c,   " + 
     "			Z_CODE_CUST_CODE d, " + 
     "                  ( select b.customer_no,b.company_tag " +
     "			    from r_contract_register a, r_contract_succesful_bid b " +
     "     		   where a.dept_code = b.dept_code " +
     "			     and a.cont_no   = b.cont_no " +
     "			     and a.chg_degree = b.chg_degree " +
     "			     and a.dept_code = " + "'" + arg_dept_code + "'" + 
     " 			     and a.last_tag = 'Y' ) e " +
     "		WHERE ( a.DEPT_CODE = C.DEPT_CODE ) and  " + 
     "			( a.dept_code = b.dept_code(+)) and  " + 
     "			( a.rqst_date = b.rqst_date(+)) and  " + 
     "			( a.seq       = b.seq(+)) and  " + 
     "			( b.cust_code = e.customer_no (+)) and " +
     "			( b.CUST_CODE = d.CUST_CODE (+)) and" + 
     "			( a.dept_code = " + "'" + arg_dept_code + "'" + " ) and" + 
     "                  (substr(to_char(a.rqst_date,'YYYY.MM.DD'),1,7) = substr(" + "'" + arg_date + "'" +  ",1,7)) " +
     "		GROUP BY c.long_name,e.company_tag,d.cust_name )" + 
     " ORDER BY BAND_TAG,RQST_DATE,SEQ,comp_seq     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>