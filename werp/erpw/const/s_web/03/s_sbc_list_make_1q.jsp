<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_user = req.getParameter("arg_user");
     String arg_long_name = req.getParameter("arg_long_name");
     String arg_sbcr_name = req.getParameter("arg_sbcr_name");
     arg_user = '%' + arg_user + '%';
     arg_long_name = '%' + arg_long_name + '%';
     arg_sbcr_name = '%' + arg_sbcr_name + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_degree",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("chg_resign",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("plan_start_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("plan_end_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("const_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("req_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bonsa_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbcr_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("corp_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("charge",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         b.LONG_NAME,   " + 
     "         a.APPROVE_CLASS,   " + 
     "         to_char(a.REQUEST_DT,'yyyy.mm.dd') request_dt, " + 
     "         to_char(a.APPROVE_DT,'yyyy.mm.dd') APPROVE_DT, " + 
     "	       a.order_number," + 
     "	       a.chg_degree," + 
     "	       a.order_name," + 
     "	       a.sbc_name," + 
     "	       a.chg_resign," + 
     "	       to_char(a.plan_start_dt,'yyyy.mm.dd') plan_start_dt, " + 
     "	       to_char(a.plan_end_dt,'yyyy.mm.dd') plan_end_dt, " + 
     "	       a.sbc_amt," + 
     "	       a.vat," + 
     "	       c.sbcr_name," + 
     "          a.const_no, " +
     "          to_char(a.sbc_dt,'yyyy.mm.dd') sbc_dt," +
     "          to_char(a.req_dt,'yyyy.mm.dd') req_dt," +
     "          CASE WHEN d.bonsa_yn Is Null THEN '' WHEN d.bonsa_yn = 0 THEN to_char(a.bonsa_dt,'yyyy.mm.dd') ELSE '' END bonsa_dt, " +
     "          to_char(a.sbcr_dt,'yyyy.mm.dd') sbcr_dt," +
	 "          CASE WHEN d.corp_yn Is Null THEN '' WHEN d.corp_yn = 0 THEN to_char(a.sbcr_dt,'yyyy.mm.dd') ELSE '' END corp_dt, " +
     "          a.charge, " +
     "          a.order_class " +
     "    FROM s_chg_cn_list a, " + 
     "         Z_CODE_DEPT b, " + 
     "	       s_sbcr c, " + 
			" ( " +
				" select" +
				" 	c.long_name," +
				" 	a.dept_code," +
				" 	a.order_number," +
				" 	a.chg_degree," +
				" 	a.order_name," +
				" 	a.bonsa_dt," +
				" 	SUM(CASE WHEN a.bonsa_dt Is Not Null AND (b.bonsa_sign_val = '' OR b.bonsa_sign_val Is Null) THEN 1 ELSE 0 END) bonsa_yn," +
				" 	a.sbcr_dt," +
				" 	SUM(CASE WHEN a.sbcr_dt Is Not Null AND (b.corp_sign_val = '' OR b.corp_sign_val Is Null) THEN 1 ELSE 0 END) corp_yn" +
				" from" +
				" 	s_chg_cn_list a," +
				" 	s_const_add_file b," +
				" 	z_code_dept c" +
				" where" +
				" 	a.dept_code = b.dept_code and a.order_number = b.cst_doc_no and a.chg_degree = b.mod_no" +
				" and a.dept_code = c.dept_code" +
				" group by" +
				" 	c.long_name,a.dept_code,a.order_number,a.chg_degree,a.order_name,a.bonsa_dt,a.sbcr_dt" +
			") d" +
     "   WHERE ( a.DEPT_CODE = b.DEPT_CODE ) and  " + 
     "         ( a.sbcr_code = c.sbcr_code ) and" + 
     "         ( a.approve_class > '2') and " +
     "         ( a.ebid_yn = '1')  and " +
     "         ( b.long_name like '" + arg_long_name + "' ) and " +
     "         ( c.sbcr_name like '" + arg_sbcr_name + "' ) " +
	 "       and a.dept_code = d.dept_code(+) and a.order_number = d.order_number(+) and a.chg_degree = d.chg_degree(+) ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>