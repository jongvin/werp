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
     dSet.addDataColumn(new GauceDataColumn("process_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("approym",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("pa_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approseq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("approtitle",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("const_no",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("req_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("bonsa_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("sbcr_dt",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         b.LONG_NAME,   " + 
     "         a.process_tag,   " + 
     "         to_char(a.approym,'yyyy.mm.dd') approym, " + 
     "         to_char(a.approym,'yyyymmdd') pa_date, " + 
     "	       a.approseq," + 
     "	       a.chg_cnt," + 
     "	       a.approtitle," + 
     "	       c.sbcr_code," + 
     "	       c.sbcr_name," + 
     "          a.const_no, " +
     "          to_char(a.req_dt,'yyyy.mm.dd') req_dt," +
     "          to_char(a.bonsa_dt,'yyyy.mm.dd') bonsa_dt, " +
     "          to_char(a.sbcr_dt,'yyyy.mm.dd') sbcr_dt" +
     "    FROM Z_CODE_DEPT b, " + 
     "	      ( select a.dept_code,a.approym,a.approseq,a.chg_cnt,a.approtitle,b.const_no,b.const_date,b.sbcr_code, " +
     "                  b.req_dt,b.bonsa_dt,b.sbcr_dt,b.process_tag " +
     "             from m_approval a, " + 
     "                  m_approval_sbcr b " +
     "            where a.dept_code = b.dept_code (+) " +
     "              and a.approym   = b.approym (+) " +
     "              and a.approseq  = b.approseq (+) " +
     "              and a.chg_cnt   = b.chg_cnt (+) " +
     "              and a.const_class = '3' " +
     "              and a.app_tag > '1' ) a," +
     "          s_sbcr c " + 
     "   WHERE ( a.DEPT_CODE = b.DEPT_CODE ) and  " + 
     "         ( a.sbcr_code = c.sbcr_code ) and" + 
     "         ( b.long_name like '" + arg_long_name + "' ) and " +
     "         ( c.sbcr_name like '" + arg_sbcr_name + "' )" ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>