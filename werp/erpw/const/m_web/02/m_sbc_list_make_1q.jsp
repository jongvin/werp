<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_user = req.getParameter("arg_user");
     String arg_long_name = req.getParameter("arg_long_name");
     String arg_sbcr_name = req.getParameter("arg_sbcr_name");
     String arg_fr_date = req.getParameter("arg_fr_date");
     String arg_to_date = req.getParameter("arg_to_date");
     arg_user = '%' + arg_user + '%';
     arg_long_name = '%' + arg_long_name + '%';
     arg_sbcr_name = '%' + arg_sbcr_name + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_tag",GauceDataColumn.TB_STRING,1));
	 dSet.addDataColumn(new GauceDataColumn("process_tag_new",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pa_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("temp_seq",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("const_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("const_no",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("const_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("req_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bonsa_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbcr_dt",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         b.LONG_NAME,   " + 
     "         a.process_tag,   " + 
 	 "         decode(a.const_class,'3',a.process_tag,'') process_tag_new, " +
     "         to_char(a.approym,'yyyy.mm.dd') approym, " + 
     "         to_char(a.approym,'yyyymmdd') pa_date, " + 
     "          a.approseq || '-' || a.chg_cnt temp_seq, " +
     "	       a.approseq," + 
     "	       a.chg_cnt," + 
     "	       a.approtitle," + 
     "	       c.sbcr_code," + 
     "	       c.sbcr_name," + 
     "          a.const_class, " +
     "          a.const_no, " +
     "          to_char(a.const_date,'yyyy.mm.dd') const_date," +
     "          to_char(a.req_dt,'yyyy.mm.dd') req_dt," +
	 "          CASE WHEN d.bonsa_yn Is Null THEN '' WHEN d.bonsa_yn = 0 THEN to_char(a.bonsa_dt,'yyyy.mm.dd') ELSE '' END bonsa_dt, " +
	 "          CASE WHEN d.corp_yn Is Null THEN '' WHEN d.corp_yn = 0 THEN to_char(a.sbcr_dt,'yyyy.mm.dd') ELSE '' END sbcr_dt " +
     "    FROM Z_CODE_DEPT b, " + 
     "	      ( select a.dept_code,a.approym,a.approseq,a.chg_cnt,a.approtitle,b.const_no,b.const_date,b.sbcr_code, " +
     "                  b.req_dt,b.bonsa_dt,b.sbcr_dt,b.process_tag,a.const_class " +
     "             from m_approval a, " + 
     "                  m_approval_sbcr b " +
     "            where a.dept_code = b.dept_code (+) " +
     "              and a.approym   = b.approym (+) " +
     "              and a.approseq  = b.approseq (+) " +
     "              and a.chg_cnt   = b.chg_cnt (+) " +
     "              and a.approym >= '" + arg_fr_date + "'" + 
     "              and a.approym <= '" + arg_to_date + "'" +
     "              and a.app_tag > '2' ) a," +
     "          s_sbcr c, " + 
	 "        (" +
	 "        SELECT" +
	 "        	a.dept_code, a.approym, a.approseq, a.chg_cnt, a.sbcr_code," +
	 "        	SUM(CASE WHEN a.bonsa_dt IS NOT NULL AND (b.bonsa_sign_val = '' OR b.bonsa_sign_val IS NULL) THEN 1 ELSE 0 END) bonsa_yn," +
	 "        	SUM(CASE WHEN a.sbcr_dt IS NOT NULL AND (b.corp_sign_val = '' OR b.corp_sign_val IS NULL) THEN 1 ELSE 0 END) corp_yn" +
	 "        FROM" +
	 "        	m_approval_sbcr a," +
	 "        	s_const_add_file b" +
	 "        WHERE" +
	 "        	a.dept_code = b.dept_code AND a.approym = b.cre_date AND a.approseq = b.cst_doc_no AND a.chg_cnt = b.mod_no AND a.sbcr_code = b.cre_by" +
	 "        GROUP BY" +
	 "        	a.dept_code, a.approym, a.approseq, a.chg_cnt, a.sbcr_code" +
	 "        ) d " +
     "   WHERE ( a.DEPT_CODE = b.DEPT_CODE ) and  " + 
     "         ( a.sbcr_code = c.sbcr_code ) and " + 
	 "         ( a.dept_code = d.dept_code(+) and a.approym = d.approym(+) and a.approseq = d.approseq(+) and a.chg_cnt = d.chg_cnt(+) and a.sbcr_code = d.sbcr_code(+)) and " +
     "         ( b.long_name like '" + arg_long_name + "' ) and " +
     "         ( c.sbcr_name like '" + arg_sbcr_name + "' )" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>