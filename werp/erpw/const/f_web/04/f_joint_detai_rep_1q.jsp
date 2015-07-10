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
     dSet.addDataColumn(new GauceDataColumn("actual_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cust_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("t_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("t_vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("actual_inv_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("band_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sysdate",GauceDataColumn.TB_STRING,19));
    String query =" SELECT   long_name,"   +
"          TO_CHAR (rqst_date, 'YYYY.MM.DD') rqst_date,"   +
"          seq,"   +
"          res_type,"   +
"          rqst_detail,"   +
"          actual_name,"   +
"          NVL (amt, 0) amt,"   +
"          NVL (vat, 0) vat,"   +
"          DECODE (company_tag, 'Y', ' ' || cust_name, cust_name) cust_name,"   +
"          NVL (t_amt, 0) t_amt,"   +
"          NVL (t_vat, 0) t_vat,"   +
"          DECODE (actual_inv_tag, 'Y', '*', '') actual_inv_tag,"   +
"          band_tag,"   +
"          DECODE (company_tag, 'Y', 0, 1) comp_seq,"   +
"          SYSDATE"   +
"     FROM (SELECT c.long_name,"   +
"                  a.rqst_date,"   +
"                  a.seq,"   +
"                  a.res_type,"   +
"                  a.rqst_detail,"   +
"                  a.amt,"   +
"                  a.vat,"   +
"                  d.membership_name cust_name,"   +
"                  b.amt t_amt,"   +
"                  b.vat t_vat,"   +
"                  b.actual_inv_tag,"   +
"                  '1' band_tag,"   +
"                  e.company_tag,"   +
"                  g.membership_name actual_name"   +
"             FROM f_request a,"   +
"                  f_joint_distribution b,"   +
"                  z_code_dept c,"   +
"                  r_code_membership d,"   +
"                  (SELECT b.customer_no,"   +
"                          b.company_tag"   +
"                     FROM r_contract_register a, r_contract_succesful_bid b"   +
"                    WHERE a.dept_code = b.dept_code"   +
"                      AND a.cont_no = b.cont_no"   +
"                      AND a.chg_degree = b.chg_degree"   +
"                      AND a.dept_code = '"+arg_dept_code+"'"   +
"                      AND a.last_tag = 'Y') e,"   +
"                  (SELECT a.dept_code,"   +
"                          a.rqst_date,"   +
"                          a.seq,"   +
"                          b.actual_inv_tag,"   +
"                          b.cust_code"   +
"                     FROM f_request a, f_joint_distribution b"   +
"                    WHERE a.dept_code = '"+arg_dept_code+"'"   +
"                      AND SUBSTR (TO_CHAR (a.rqst_date, 'YYYY.MM.DD'), 1, 7) ="   +
"                                                       SUBSTR ('"+arg_date+"', 1, 7)"   +
"                      AND a.dept_code = b.dept_code"   +
"                      AND a.rqst_date = b.rqst_date"   +
"                      AND a.seq = b.seq"   +
"                      AND b.actual_inv_tag = 'Y') f,"   +
"                  r_code_membership g"   +
"            WHERE (a.dept_code = c.dept_code)"   +
"              AND (b.cust_code = e.customer_no(+))"   +
"              AND (a.dept_code = b.dept_code(+))"   +
"              AND (a.rqst_date = b.rqst_date(+))"   +
"              AND (a.seq = b.seq(+))"   +
"              and (replace(b.cust_code,'-','') = d.customer_no)"   +
"              AND (a.dept_code = f.dept_code(+))"   +
"              AND (a.rqst_date = f.rqst_date(+))"   +
"              AND (a.seq = f.seq(+))"   +
"              and (replace(f.cust_code,'-','') = g.customer_no)"   +
"              AND (a.dept_code = '"+arg_dept_code+"')"   +
"              AND (SUBSTR (TO_CHAR (a.rqst_date, 'YYYY.MM.DD'), 1, 7) ="   +
"                                                       SUBSTR ('"+arg_date+"', 1, 7)"   +
"                  ))"   +
" ORDER BY band_tag, rqst_date, seq, comp_seq"  ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>